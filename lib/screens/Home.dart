// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:provider/provider.dart';
// import '../Auth/auth_service.dart';
//
// class HomeScreen extends StatefulWidget {
//   final Function(String, String, String) navigateToLessons;
//
//   const HomeScreen({Key? key, required this.navigateToLessons}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final Connectivity _connectivity = Connectivity();
//
//   final Color _primaryBlue = const Color(0xFF1E88E5);
//   final Color _secondaryColor = const Color(0xFFF5F9FF);
//   final Color _accentColor = const Color(0xFFFFA726);
//   final Color _textPrimary = const Color(0xFF2D3748);
//   final Color _textSecondary = const Color(0xFF718096);
//
//   List<Map<String, dynamic>> _courses = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//   bool _hasNetworkError = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCourses();
//   }
//
//   Future<void> _loadCourses() async {
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final connectivityResult = await _connectivity.checkConnectivity();
//       if (connectivityResult == ConnectivityResult.none) {
//         setState(() {
//           _hasNetworkError = true;
//           _isLoading = false;
//         });
//         return;
//       }
//
//       final authService = Provider.of<AuthService>(context, listen: false);
//
//       if (authService.selectedGrade == null) {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = 'لم يتم تحديد الصف الدراسي';
//         });
//         return;
//       }
//
//       final courses = await authService.getCoursesForCurrentGrade();
//
//       if (mounted) {
//         setState(() {
//           _courses = courses ?? [];
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _hasNetworkError = true;
//           _errorMessage = 'حدث خطأ في تحميل المواد';
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _showNetworkErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(
//           'مشكلة في الاتصال',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//         content: Text(
//           'يرجى التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى',
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('حسناً', style: TextStyle(fontFamily: 'Tajawal')),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _loadCourses();
//             },
//             child: Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Tajawal')),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _navigateToLessons(Map<String, dynamic> course) {
//     final String title = course['title'] ?? 'بدون عنوان';
//     final String imageUrl = course['image_url'] ?? '';
//     final String courseId = course['id'] ?? '';
//
//     widget.navigateToLessons(imageUrl, title, courseId);
//   }
//
//   String _getGradeText(int? gradeValue) {
//     if (gradeValue == null) return 'لم يتم الاختيار';
//
//     switch (gradeValue) {
//       case 1: return 'الصف الأول الابتدائي';
//       case 2: return 'الصف الثاني الابتدائي';
//       case 3: return 'الصف الثالث الابتدائي';
//       case 4: return 'الصف الرابع الابتدائي';
//       case 5: return 'الصف الخامس الابتدائي';
//       case 6: return 'الصف السادس الابتدائي';
//       case 7: return 'الصف الأول المتوسط';
//       case 8: return 'الصف الثاني المتوسط';
//       case 9: return 'الصف الثالث المتوسط';
//       case 10: return 'الصف الأول الثانوي';
//       case 11: return 'الصف الثاني الثانوي';
//       case 12: return 'الصف الثالث الثانوي';
//       default: return 'الصف $gradeValue';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: _secondaryColor,
//         body: RefreshIndicator(
//           onRefresh: _loadCourses,
//           color: _primaryBlue,
//           child: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 backgroundColor: _primaryBlue,
//                 expandedHeight: 180.h,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Image.asset(
//                     'assets/images/shater.png',
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: _primaryBlue,
//                         child: Icon(
//                           Icons.school_rounded,
//                           size: 60.sp,
//                           color: Colors.white,
//                         ),
//                       );
//                     },
//                   ),
//                   title: Text(
//                     'المواد الدراسية',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ),
//
//               SliverToBoxAdapter(
//                 child: _buildStudentInfo(authService),
//               ),
//
//               _isLoading
//                   ? SliverToBoxAdapter(child: _buildLoadingWidget())
//                   : _errorMessage.isNotEmpty && !_hasNetworkError
//                   ? SliverToBoxAdapter(child: _buildErrorWidget())
//                   : _courses.isEmpty
//                   ? SliverToBoxAdapter(child: _buildEmptyWidget())
//                   : _buildCoursesGrid(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStudentInfo(AuthService authService) {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8.r,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.school_rounded, color: _primaryBlue),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'المواد المخصصة لصفك',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.bold,
//                     color: _textPrimary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   _getGradeText(authService.selectedGrade),
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: _textSecondary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//             decoration: BoxDecoration(
//               color: _primaryBlue,
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Text(
//               '${_courses.length}',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Container(
//       height: 200.h,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: _primaryBlue),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تحميل المواد...',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: _textPrimary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Container(
//       height: 200.h,
//       padding: EdgeInsets.all(16.w),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 50.sp,
//               color: Colors.red,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               _errorMessage,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.red[700],
//                 fontFamily: 'Tajawal',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16.h),
//             ElevatedButton(
//               onPressed: _loadCourses,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _primaryBlue,
//                 foregroundColor: Colors.white,
//               ),
//               child: Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Tajawal')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyWidget() {
//     return Container(
//       height: 200.h,
//       padding: EdgeInsets.all(16.w),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.menu_book_rounded,
//               size: 50.sp,
//               color: _textSecondary,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               'لا توجد مواد متاحة حالياً',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: _textSecondary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'سيتم إضافة المواد قريباً',
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: _textSecondary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   SliverGrid _buildCoursesGrid() {
//     return SliverGrid(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12.w,
//         mainAxisSpacing: 12.h,
//         childAspectRatio: 0.8,
//       ),
//       delegate: SliverChildBuilderDelegate(
//             (context, index) {
//           return _buildCourseCard(_courses[index]);
//         },
//         childCount: _courses.length,
//       ),
//     );
//   }
//
//   Widget _buildCourseCard(Map<String, dynamic> course) {
//     final String title = course['title'] ?? 'بدون عنوان';
//     final String? imageUrl = course['image_url'];
//
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: InkWell(
//         onTap: () => _navigateToLessons(course),
//         borderRadius: BorderRadius.circular(12.r),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
//                 child: imageUrl != null && imageUrl.isNotEmpty
//                     ? Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return _buildPlaceholderImage();
//                   },
//                 )
//                     : _buildPlaceholderImage(),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(12.w),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.bold,
//                   color: _textPrimary,
//                   fontFamily: 'Tajawal',
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPlaceholderImage() {
//     return Container(
//       color: _primaryBlue.withOpacity(0.1),
//       child: Center(
//         child: Icon(
//           Icons.menu_book_rounded,
//           color: _primaryBlue,
//           size: 40.sp,
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:provider/provider.dart';
// import '../Auth/auth_service.dart';
//
// class HomeScreen extends StatefulWidget {
//   final Function(String, String, String) navigateToLessons;
//
//   const HomeScreen({Key? key, required this.navigateToLessons}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final Connectivity _connectivity = Connectivity();
//
//   final Color _primaryBlue = const Color(0xFF1E88E5);
//   final Color _secondaryColor = const Color(0xFFF5F9FF);
//   final Color _accentColor = const Color(0xFFFFA726);
//   final Color _textPrimary = const Color(0xFF2D3748);
//   final Color _textSecondary = const Color(0xFF718096);
//
//   List<Map<String, dynamic>> _courses = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//   bool _hasNetworkError = false;
//   bool _initialDataLoaded = false;
//   int? _lastLoadedGrade; // ✅ متغير لتتبع آخر صف تم تحميل مواده
//
//   @override
//   void initState() {
//     super.initState();
//     print('🏠 HomeScreen initState - بدء تحميل الصفحة');
//     _initializeData();
//   }
//
//   void _initializeData() {
//     // تأخير بسيط لضمان أن AuthService قد اكتمل تحميله
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await _loadCourses();
//     });
//   }
//
//   Future<void> _loadCourses() async {
//     if (!mounted) return;
//
//     print('🔄 بدء تحميل المواد الدراسية...');
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       // التحقق من الاتصال بالإنترنت
//       final connectivityResult = await _connectivity.checkConnectivity();
//       if (connectivityResult == ConnectivityResult.none) {
//         print('❌ لا يوجد اتصال بالإنترنت');
//         if (mounted) {
//           setState(() {
//             _hasNetworkError = true;
//             _isLoading = false;
//             _errorMessage = 'لا يوجد اتصال بالإنترنت';
//           });
//         }
//         return;
//       }
//
//       final authService = Provider.of<AuthService>(context, listen: false);
//
//       print('👤 حالة المستخدم: isLoggedIn=${authService.isLoggedIn}');
//       print('📧 البريد الإلكتروني: ${authService.studentEmail}');
//       print('🎯 الصف المحدد: ${authService.selectedGrade}');
//       print('🎯 آخر صف تم التحميل له: $_lastLoadedGrade');
//
//       // إذا لم يكن المستخدم مسجل الدخول
//       if (!authService.isLoggedIn) {
//         print('❌ المستخدم غير مسجل الدخول');
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//             _errorMessage = 'يجب تسجيل الدخول أولاً';
//           });
//         }
//         return;
//       }
//
//       // التحقق من وجود صف دراسي محدد
//       if (authService.selectedGrade == null) {
//         print('❌ لم يتم تحديد صف دراسي');
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//             _errorMessage = 'لم يتم تحديد الصف الدراسي. يرجى تحديد الصف من إعدادات الحساب.';
//             _lastLoadedGrade = null;
//           });
//         }
//         return;
//       }
//
//       // ✅ التحقق مما إذا كانت المواد محملة مسبقاً لنفس الصف
//       if (_lastLoadedGrade == authService.selectedGrade && _courses.isNotEmpty) {
//         print('✅ المواد محملة مسبقاً لنفس الصف، لا داعي لإعادة التحميل');
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//           });
//         }
//         return;
//       }
//
//       // انتظار تحميل بيانات المستخدم إذا لم تكن محملة
//       if (authService.userData == null) {
//         print('🔄 جاري تحميل بيانات المستخدم...');
//         await authService.refreshUserData();
//       }
//
//       print('📚 جاري جلب المواد للصف: ${authService.selectedGrade}');
//
//       // جلب المواد الدراسية
//       final courses = await authService.getCoursesForCurrentGrade();
//
//       print('✅ تم جلب ${courses?.length ?? 0} مادة دراسية');
//
//       if (mounted) {
//         setState(() {
//           _courses = courses ?? [];
//           _isLoading = false;
//           _initialDataLoaded = true;
//           _lastLoadedGrade = authService.selectedGrade; // ✅ حفظ آخر صف تم التحميل له
//         });
//       }
//
//     } catch (e) {
//       print('❌ خطأ في تحميل المواد: $e');
//       if (mounted) {
//         setState(() {
//           _hasNetworkError = true;
//           _isLoading = false;
//           _errorMessage = 'حدث خطأ في تحميل المواد: ${e.toString()}';
//           _initialDataLoaded = true;
//           _lastLoadedGrade = null;
//         });
//       }
//     }
//   }
//
//   // ✅ دالة محسنة لإعادة التحميل عند تغيير الصف فقط
//   void _onGradeUpdated(int? newGrade) {
//     if (newGrade != null && newGrade != _lastLoadedGrade) {
//       print('🔄 تم تغيير الصف الدراسي من $_lastLoadedGrade إلى $newGrade، إعادة تحميل المواد...');
//       _loadCourses();
//     } else {
//       print('✅ نفس الصف الدراسي، لا داعي لإعادة التحميل');
//     }
//   }
//
//   void _showNetworkErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(
//           'مشكلة في الاتصال',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//         content: Text(
//           'يرجى التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى',
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('حسناً', style: TextStyle(fontFamily: 'Tajawal')),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _loadCourses();
//             },
//             child: Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Tajawal')),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _navigateToLessons(Map<String, dynamic> course) {
//     final String title = course['title'] ?? 'بدون عنوان';
//     final String imageUrl = course['image_url'] ?? '';
//     final String courseId = course['id'] ?? '';
//
//     widget.navigateToLessons(imageUrl, title, courseId);
//   }
//
//   String _getGradeText(int? gradeValue) {
//     if (gradeValue == null) return 'لم يتم الاختيار';
//
//     switch (gradeValue) {
//       case 1: return 'الصف الأول الابتدائي';
//       case 2: return 'الصف الثاني الابتدائي';
//       case 3: return 'الصف الثالث الابتدائي';
//       case 4: return 'الصف الرابع الابتدائي';
//       case 5: return 'الصف الخامس الابتدائي';
//       case 6: return 'الصف السادس الابتدائي';
//       case 7: return 'الصف الأول المتوسط';
//       case 8: return 'الصف الثاني المتوسط';
//       case 9: return 'الصف الثالث المتوسط';
//       case 10: return 'الصف الأول الثانوي';
//       case 11: return 'الصف الثاني الثانوي';
//       case 12: return 'الصف الثالث الثانوي';
//       default: return 'الصف $gradeValue';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: _secondaryColor,
//         body: RefreshIndicator(
//           onRefresh: _loadCourses,
//           color: _primaryBlue,
//           child: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 backgroundColor: _primaryBlue,
//                 expandedHeight: 180.h,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Image.asset(
//                     'assets/images/shater.png',
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: _primaryBlue,
//                         child: Icon(
//                           Icons.school_rounded,
//                           size: 60.sp,
//                           color: Colors.white,
//                         ),
//                       );
//                     },
//                   ),
//                   title: Text(
//                     'المواد الدراسية',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ),
//
//               // ✅ التعديل هنا: استخدام Consumer بشكل صحيح
//               SliverToBoxAdapter(
//                 child: Consumer<AuthService>(
//                   builder: (context, authService, child) {
//                     // ✅ استخدام Effect للتحكم في إعادة التحميل
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       if (_initialDataLoaded) {
//                         _onGradeUpdated(authService.selectedGrade);
//                       }
//                     });
//
//                     return _buildStudentInfo(authService);
//                   },
//                 ),
//               ),
//
//               _isLoading
//                   ? SliverToBoxAdapter(child: _buildLoadingWidget())
//                   : _hasNetworkError
//                   ? SliverToBoxAdapter(child: _buildErrorWidget())
//                   : _courses.isEmpty
//                   ? SliverToBoxAdapter(child: _buildEmptyWidget())
//                   : _buildCoursesGrid(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStudentInfo(AuthService authService) {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8.r,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.school_rounded, color: _primaryBlue),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'المواد المخصصة لصفك',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.bold,
//                     color: _textPrimary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   _getGradeText(authService.selectedGrade),
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: _textSecondary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (_courses.isNotEmpty)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: _primaryBlue,
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Text(
//                 '${_courses.length}',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Container(
//       height: 200.h,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: _primaryBlue),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تحميل المواد...',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: _textPrimary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Container(
//       height: 200.h,
//       padding: EdgeInsets.all(16.w),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 50.sp,
//               color: Colors.red,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               _errorMessage,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.red[700],
//                 fontFamily: 'Tajawal',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16.h),
//             if (_hasNetworkError)
//               ElevatedButton(
//                 onPressed: _loadCourses,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _primaryBlue,
//                   foregroundColor: Colors.white,
//                 ),
//                 child: Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Tajawal')),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyWidget() {
//     return Container(
//       height: 200.h,
//       padding: EdgeInsets.all(16.w),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.menu_book_rounded,
//               size: 50.sp,
//               color: _textSecondary,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               'لا توجد مواد متاحة حالياً',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: _textSecondary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'سيتم إضافة المواد قريباً',
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: _textSecondary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             SizedBox(height: 16.h),
//             ElevatedButton(
//               onPressed: _loadCourses,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _primaryBlue,
//                 foregroundColor: Colors.white,
//               ),
//               child: Text('إعادة تحميل', style: TextStyle(fontFamily: 'Tajawal')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   SliverGrid _buildCoursesGrid() {
//     return SliverGrid(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12.w,
//         mainAxisSpacing: 12.h,
//         childAspectRatio: 0.8,
//       ),
//       delegate: SliverChildBuilderDelegate(
//             (context, index) {
//           return _buildCourseCard(_courses[index]);
//         },
//         childCount: _courses.length,
//       ),
//     );
//   }
//
//   Widget _buildCourseCard(Map<String, dynamic> course) {
//     final String title = course['title'] ?? 'بدون عنوان';
//     final String? imageUrl = course['image_url'];
//
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: InkWell(
//         onTap: () => _navigateToLessons(course),
//         borderRadius: BorderRadius.circular(12.r),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
//                 child: imageUrl != null && imageUrl.isNotEmpty
//                     ? Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return _buildPlaceholderImage();
//                   },
//                 )
//                     : _buildPlaceholderImage(),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(12.w),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.bold,
//                   color: _textPrimary,
//                   fontFamily: 'Tajawal',
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPlaceholderImage() {
//     return Container(
//       color: _primaryBlue.withOpacity(0.1),
//       child: Center(
//         child: Icon(
//           Icons.menu_book_rounded,
//           color: _primaryBlue,
//           size: 40.sp,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import '../Auth/auth_service.dart';

class HomeScreen extends StatefulWidget {
  final Function(String, String, String) navigateToLessons;

  const HomeScreen({Key? key, required this.navigateToLessons}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ------------------ المتغيرات المنطقية (من الكود الأصلي) ------------------
  final Connectivity _connectivity = Connectivity();
  List<Map<String, dynamic>> _courses = [];
  bool _isLoading = true;
  String _errorMessage = '';
  bool _hasNetworkError = false;
  bool _initialDataLoaded = false;
  int? _lastLoadedGrade;

  // ------------------ متغيرات التصميم والألوان (التصميم الجديد) ------------------
  final Color _headerBlue = const Color(0xFF3C6FEF);
  final Color _bgOffWhite = const Color(0xFFF8F9FD);
  final Color _orangeBtn = const Color(0xFFFDB933);
  final Color _textDark = const Color(0xFF1F2937);
  final Color _textGrey = const Color(0xFF9CA3AF);

  // ألوان المواد لتجميل العرض في حال عدم وجود صور
  final Color _mathBlue = const Color(0xFF448AFF);
  final Color _arabicGreen = const Color(0xFF00C853);
  final Color _englishRed = const Color(0xFFF44336);
  final Color _sciencePurple = const Color(0xFFAA00FF);

  @override
  void initState() {
    super.initState();
    print('🏠 HomeScreen initState - بدء تحميل الصفحة');
    _initializeData();
  }

  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadCourses();
    });
  }

  // ------------------ دالة جلب البيانات (مطابقة للكود الأصلي) ------------------
  Future<void> _loadCourses() async {
    if (!mounted) return;

    print('🔄 بدء تحميل المواد الدراسية...');

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _hasNetworkError = false; // تصفير حالة الخطأ عند إعادة المحاولة
    });

    try {
      // 1. التحقق من الاتصال بالإنترنت
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        print('❌ لا يوجد اتصال بالإنترنت');
        if (mounted) {
          setState(() {
            _hasNetworkError = true;
            _isLoading = false;
            _errorMessage = 'لا يوجد اتصال بالإنترنت';
          });
        }
        return;
      }

      final authService = Provider.of<AuthService>(context, listen: false);

      // 2. التحقق من تسجيل الدخول والصف الدراسي
      if (!authService.isLoggedIn) {
        if (mounted) setState(() { _isLoading = false; _errorMessage = 'يجب تسجيل الدخول أولاً'; });
        return;
      }

      if (authService.selectedGrade == null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'لم يتم تحديد الصف الدراسي';
            _lastLoadedGrade = null;
          });
        }
        return;
      }

      // 3. التحقق من الكاش (إذا كانت المواد محملة مسبقاً لنفس الصف)
      if (_lastLoadedGrade == authService.selectedGrade && _courses.isNotEmpty) {
        print('✅ المواد محملة مسبقاً لنفس الصف');
        if (mounted) setState(() { _isLoading = false; });
        return;
      }

      // 4. تحميل بيانات المستخدم إذا لزم الأمر
      if (authService.userData == null) {
        await authService.refreshUserData();
      }

      print('📚 جاري جلب المواد للصف: ${authService.selectedGrade}');

      // 5. جلب المواد الفعلية من Firebase عبر AuthService
      final courses = await authService.getCoursesForCurrentGrade();

      print('✅ تم جلب ${courses?.length ?? 0} مادة دراسية');

      if (mounted) {
        setState(() {
          _courses = courses ?? [];
          _isLoading = false;
          _initialDataLoaded = true;
          _lastLoadedGrade = authService.selectedGrade;
        });
      }

    } catch (e) {
      print('❌ خطأ في تحميل المواد: $e');
      if (mounted) {
        setState(() {
          _hasNetworkError = true;
          _isLoading = false;
          _errorMessage = 'حدث خطأ: ${e.toString()}';
          _initialDataLoaded = true;
          _lastLoadedGrade = null;
        });
      }
    }
  }

  void _onGradeUpdated(int? newGrade) {
    if (newGrade != null && newGrade != _lastLoadedGrade) {
      print('🔄 تم تغيير الصف، إعادة تحميل المواد...');
      _loadCourses();
    }
  }

  void _navigateToLessons(Map<String, dynamic> course) {
    // استخراج البيانات كما في الكود الأصلي
    final String title = course['title'] ?? 'بدون عنوان';
    final String imageUrl = course['image_url'] ?? '';
    final String courseId = course['id'] ?? '';

    widget.navigateToLessons(imageUrl, title, courseId);
  }

  // دالة مساعدة لتحديد الألوان بناءً على اسم المادة (لتحسين التصميم)
  Map<String, dynamic> _getSubjectTheme(String title) {
    if (title.contains('الرياضيات') || title.contains('حساب')) {
      return {'color': _mathBlue, 'icon': Icons.calculate_outlined};
    } else if (title.contains('العربية') || title.contains('لغتي')) {
      return {'color': _arabicGreen, 'icon': Icons.menu_book};
    } else if (title.contains('English') || title.contains('إنجليزي')) {
      return {'color': _englishRed, 'icon': Icons.font_download};
    } else if (title.contains('علوم') || title.contains('فيزياء')) {
      return {'color': _sciencePurple, 'icon': Icons.science};
    } else {
      return {'color': _headerBlue, 'icon': Icons.school};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _bgOffWhite,

        // شريط التنقل السفلي (تصميم جديد)
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: Colors.white,
          child: Container(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_filled, 'الرئيسية', true),
                SizedBox(width: 40.w),
                _buildNavItem(Icons.person_outline, 'حسابي', false),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: _headerBlue,
          elevation: 4,
          child: Icon(Icons.qr_code_scanner, size: 28.sp),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // الجسم الرئيسي
        body: Consumer<AuthService>(
          builder: (context, authService, child) {
            // مراقبة تغيير الصف الدراسي
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_initialDataLoaded) {
                _onGradeUpdated(authService.selectedGrade);
              }
            });

            return Stack(
              children: [
                // 1. الخلفية الزرقاء المقوسة (Header)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 300.h,
                  child: ClipPath(
                    clipper: HeaderCurveClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_headerBlue, Color(0xFF254EDB)],
                        ),
                      ),
                    ),
                  ),
                ),

                // 2. المحتوى القابل للتمرير
                RefreshIndicator(
                  onRefresh: _loadCourses,
                  color: _headerBlue,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(height: 50.h),
                            // الترويسة (الترحيب)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'مدرستي الذكية',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 16.sp,
                                          fontFamily: 'Tajawal',
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        'أهلاً بك يا بطل 👋',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: _orangeBtn,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.notifications, color: Colors.white, size: 24.sp),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 25.h),

                            // العنوان الكبير
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'ماذا ستدرس\nاليوم؟',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 25.h),

                            // بطاقة الواجبات العائمة
                            _buildHomeworkCard(),

                            SizedBox(height: 25.h),

                            // عنوان قسم المواد
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'المواد الدراسية',
                                    style: TextStyle(
                                      color: _textDark,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Tajawal',
                                    ),
                                  ),
                                  if (!_isLoading && _courses.isNotEmpty)
                                    Text(
                                      '${_courses.length} مواد',
                                      style: TextStyle(color: _textGrey, fontSize: 12.sp, fontFamily: 'Tajawal'),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),

                      // شبكة المواد (Grid)
                      if (_isLoading)
                        SliverToBoxAdapter(child: _buildLoadingWidget())
                      else if (_hasNetworkError)
                        SliverToBoxAdapter(child: _buildErrorWidget())
                      else if (_courses.isEmpty)
                          SliverToBoxAdapter(child: _buildEmptyWidget())
                        else
                          _buildCoursesGrid(),

                      SliverPadding(padding: EdgeInsets.only(bottom: 80.h)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // عنصر في شريط التنقل
  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isSelected ? _headerBlue : _textGrey, size: 26.sp),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? _headerBlue : _textGrey,
            fontSize: 12.sp,
            fontFamily: 'Tajawal',
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        )
      ],
    );
  }

  // بطاقة الواجبات
  Widget _buildHomeworkCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _orangeBtn,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              elevation: 0,
            ),
            child: Text('حل الآن', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Tajawal')),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('واجبات اليوم', style: TextStyle(color: _textDark, fontWeight: FontWeight.bold, fontSize: 16.sp, fontFamily: 'Tajawal')),
                SizedBox(height: 4.h),
                Text('لديك 3 واجبات معلقة', style: TextStyle(color: _textGrey, fontSize: 12.sp, fontFamily: 'Tajawal')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // شبكة عرض المواد
  SliverGrid _buildCoursesGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final course = _courses[index];
          final title = course['title'] ?? 'مادة';
          final imageUrl = course['image_url'];
          final theme = _getSubjectTheme(title); // الحصول على اللون والأيقونة المناسبة

          return GestureDetector(
            onTap: () => _navigateToLessons(course),
            child: Container(
              margin: index % 2 == 0 ? EdgeInsets.only(right: 20.w) : EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // دائرة الأيقونة أو الصورة
                  Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: theme['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: (imageUrl != null && imageUrl.toString().isNotEmpty)
                          ? ClipOval(
                        child: Image.network(
                          imageUrl,
                          width: 35.w,
                          height: 35.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_,__,___) => Icon(theme['icon'], color: theme['color'], size: 32.sp),
                        ),
                      )
                          : Icon(theme['icon'], color: theme['color'], size: 32.sp),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: _courses.length,
      ),
    );
  }

  // ويدجت التحميل
  Widget _buildLoadingWidget() {
    return Container(
      height: 200.h,
      child: Center(child: CircularProgressIndicator(color: _headerBlue)),
    );
  }

  // ويدجت الخطأ
  Widget _buildErrorWidget() {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off_rounded, size: 50.sp, color: Colors.red[300]),
          SizedBox(height: 10.h),
          Text(_errorMessage, style: TextStyle(fontFamily: 'Tajawal', color: _textGrey), textAlign: TextAlign.center),
          TextButton(
            onPressed: _loadCourses,
            child: Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Tajawal', color: _headerBlue)),
          )
        ],
      ),
    );
  }

  // ويدجت فارغ
  Widget _buildEmptyWidget() {
    return Container(
      height: 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.layers_clear, size: 50.sp, color: _textGrey),
            SizedBox(height: 10.h),
            Text('لا توجد مواد متاحة حالياً', style: TextStyle(fontFamily: 'Tajawal', color: _textGrey)),
            TextButton(
              onPressed: _loadCourses,
              child: Text('تحديث', style: TextStyle(fontFamily: 'Tajawal', color: _headerBlue)),
            )
          ],
        ),
      ),
    );
  }
}

// كلاس الرسم المنحني (Curved Header)
class HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 2, size.height + 20);
    var firstEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}