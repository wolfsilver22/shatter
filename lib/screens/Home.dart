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
//

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
  final Connectivity _connectivity = Connectivity();

  // الألوان المستخدمة في التصميم
  final Color _primaryBlue = const Color(0xFF1E88E5);
  final Color _secondaryColor = const Color(0xFFF5F9FF);
  final Color _accentColor = const Color(0xFFFFA726);
  final Color _textPrimary = const Color(0xFF2D3748);
  final Color _textSecondary = const Color(0xFF718096);
  final Color _cardColor = const Color(0xFFE3F2FD);
  final Color _overdueColor = const Color(0xFFFF5252);

  List<Map<String, dynamic>> _courses = [];
  bool _isLoading = true;
  String _errorMessage = '';
  bool _hasNetworkError = false;
  bool _initialDataLoaded = false;
  int? _lastLoadedGrade;

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

  Future<void> _loadCourses() async {
    if (!mounted) return;

    print('🔄 بدء تحميل المواد الدراسية...');

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
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

      print('👤 حالة المستخدم: isLoggedIn=${authService.isLoggedIn}');
      print('📧 البريد الإلكتروني: ${authService.studentEmail}');
      print('🎯 الصف المحدد: ${authService.selectedGrade}');
      print('🎯 آخر صف تم التحميل له: $_lastLoadedGrade');

      if (!authService.isLoggedIn) {
        print('❌ المستخدم غير مسجل الدخول');
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'يجب تسجيل الدخول أولاً';
          });
        }
        return;
      }

      if (authService.selectedGrade == null) {
        print('❌ لم يتم تحديد صف دراسي');
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'لم يتم تحديد الصف الدراسي. يرجى تحديد الصف من إعدادات الحساب.';
            _lastLoadedGrade = null;
          });
        }
        return;
      }

      if (_lastLoadedGrade == authService.selectedGrade && _courses.isNotEmpty) {
        print('✅ المواد محملة مسبقاً لنفس الصف، لا داعي لإعادة التحميل');
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      if (authService.userData == null) {
        print('🔄 جاري تحميل بيانات المستخدم...');
        await authService.refreshUserData();
      }

      print('📚 جاري جلب المواد للصف: ${authService.selectedGrade}');
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
          _errorMessage = 'حدث خطأ في تحميل المواد: ${e.toString()}';
          _initialDataLoaded = true;
          _lastLoadedGrade = null;
        });
      }
    }
  }

  void _onGradeUpdated(int? newGrade) {
    if (newGrade != null && newGrade != _lastLoadedGrade) {
      print('🔄 تم تغيير الصف الدراسي من $_lastLoadedGrade إلى $newGrade، إعادة تحميل المواد...');
      _loadCourses();
    } else {
      print('✅ نفس الصف الدراسي، لا داعي لإعادة التحميل');
    }
  }

  void _navigateToLessons(Map<String, dynamic> course) {
    final String title = course['title'] ?? 'بدون عنوان';
    final String imageUrl = course['image_url'] ?? '';
    final String courseId = course['id'] ?? '';

    widget.navigateToLessons(imageUrl, title, courseId);
  }

  String _getGradeText(int? gradeValue) {
    if (gradeValue == null) return 'لم يتم الاختيار';

    switch (gradeValue) {
      case 1: return 'الصف الأول الابتدائي';
      case 2: return 'الصف الثاني الابتدائي';
      case 3: return 'الصف الثالث الابتدائي';
      case 4: return 'الصف الرابع الابتدائي';
      case 5: return 'الصف الخامس الابتدائي';
      case 6: return 'الصف السادس الابتدائي';
      case 7: return 'الصف الأول المتوسط';
      case 8: return 'الصف الثاني المتوسط';
      case 9: return 'الصف الثالث المتوسط';
      case 10: return 'الصف الأول الثانوي';
      case 11: return 'الصف الثاني الثانوي';
      case 12: return 'الصف الثالث الثانوي';
      default: return 'الصف $gradeValue';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _secondaryColor,
        body: RefreshIndicator(
          onRefresh: _loadCourses,
          color: _primaryBlue,
          child: CustomScrollView(
            slivers: [
              // الهيدر العلوي
              SliverAppBar(
                backgroundColor: _primaryBlue,
                expandedHeight: 140.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [_primaryBlue, Color(0xFF64B5F6)],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h, right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مدرستي الذكية',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'أهلاً بك يا علّام',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white.withOpacity(0.9),
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // قسم الواجبات المتأخرة
              SliverToBoxAdapter(
                child: _buildOverdueAssignments(),
              ),

              // قسم ماذا ستدرس اليوم؟
              SliverToBoxAdapter(
                child: _buildTodayStudy(),
              ),

              // قسم المواد الدراسية
              SliverToBoxAdapter(
                child: Consumer<AuthService>(
                  builder: (context, authService, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_initialDataLoaded) {
                        _onGradeUpdated(authService.selectedGrade);
                      }
                    });
                    return _buildSubjectsSection(authService);
                  },
                ),
              ),

              // شبكة المواد الدراسية
              _isLoading
                  ? SliverToBoxAdapter(child: _buildLoadingWidget())
                  : _hasNetworkError
                  ? SliverToBoxAdapter(child: _buildErrorWidget())
                  : _courses.isEmpty
                  ? SliverToBoxAdapter(child: _buildEmptyWidget())
                  : _buildCoursesGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverdueAssignments() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: _overdueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.assignment_late_rounded,
              color: _overdueColor,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'واجبات اليوم',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'لديك 3 واجبات متأخرة',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: _overdueColor,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _overdueColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStudy() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ماذا ستدرس اليوم؟',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStudyOption('عرض الجدول', Icons.calendar_today_rounded, _primaryBlue),
              _buildStudyOption('المواد الدراسية', Icons.menu_book_rounded, _accentColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStudyOption(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: _textPrimary,
                fontWeight: FontWeight.w600,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectsSection(AuthService authService) {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المواد الدراسية',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _getGradeText(authService.selectedGrade),
            style: TextStyle(
              fontSize: 14.sp,
              color: _textSecondary,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      height: 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: _primaryBlue),
            SizedBox(height: 16.h),
            Text(
              'جاري تحميل المواد...',
              style: TextStyle(
                fontSize: 16.sp,
                color: _textPrimary,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(16.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 50.sp,
              color: Colors.red,
            ),
            SizedBox(height: 16.h),
            Text(
              _errorMessage,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red[700],
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            if (_hasNetworkError)
              ElevatedButton(
                onPressed: _loadCourses,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Tajawal')),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(16.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_rounded,
              size: 50.sp,
              color: _textSecondary,
            ),
            SizedBox(height: 16.h),
            Text(
              'لا توجد مواد متاحة حالياً',
              style: TextStyle(
                fontSize: 16.sp,
                color: _textSecondary,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'سيتم إضافة المواد قريباً',
              style: TextStyle(
                fontSize: 12.sp,
                color: _textSecondary,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverGrid _buildCoursesGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.1,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return _buildCourseCard(_courses[index]);
        },
        childCount: _courses.length,
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    final String title = course['title'] ?? 'بدون عنوان';
    final String? imageUrl = course['image_url'];

    // تحديد لون الخلفية بناءً على المادة
    Color cardColor = _getCourseColor(title);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: InkWell(
          onTap: () => _navigateToLessons(course),
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? ClipOval(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderIcon(title);
                      },
                    ),
                  )
                      : _buildPlaceholderIcon(title),
                ),
                SizedBox(height: 12.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                    fontFamily: 'Tajawal',
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon(String title) {
    IconData iconData;

    // تحديد الأيقونة المناسبة بناءً على اسم المادة
    if (title.contains('رياضيات') || title.contains('رياضيات')) {
      iconData = Icons.calculate_rounded;
    } else if (title.contains('عربي') || title.contains('لغة')) {
      iconData = Icons.language_rounded;
    } else if (title.contains('انجليزي') || title.contains('إنجليزي')) {
      iconData = Icons.translate_rounded;
    } else if (title.contains('علوم') || title.contains('علم')) {
      iconData = Icons.science_rounded;
    } else {
      iconData = Icons.menu_book_rounded;
    }

    return Icon(
      iconData,
      color: _primaryBlue,
      size: 30.sp,
    );
  }

  Color _getCourseColor(String title) {
    // تحديد لون الخلفية بناءً على اسم المادة
    if (title.contains('رياضيات')) {
      return Color(0xFFE8F5E8); // أخضر فاتح
    } else if (title.contains('عربي')) {
      return Color(0xFFE3F2FD); // أزرق فاتح
    } else if (title.contains('انجليزي') || title.contains('إنجليزي')) {
      return Color(0xFFFFF8E1); // أصفر فاتح
    } else if (title.contains('علوم')) {
      return Color(0xFFFCE4EC); // وردي فاتح
    } else {
      return _cardColor;
    }
  }
}