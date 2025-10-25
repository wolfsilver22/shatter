// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'lesson_detail_screen.dart';
// import 'lessons_list_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   final SupabaseClient _supabase = Supabase.instance.client;
//
//   // ألوان التطبيق التعليمي
//   final Color primaryColor = const Color(0xFF1E88E5); // الأزرق الأساسي
//   final Color secondaryColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
//   final Color accentColor = const Color(0xFFFFA726); // البرتقالي
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//
//   // متحكمات الحركة
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   // بيانات الدروس (بدلاً من العيادات)
//   final List<Map<String, dynamic>> _lessons = [
//     {
//       'id': 1,
//       'title': 'تعلم الحروف العربية',
//       'level': 'مبتدئ',
//       'image': 'assets/letters.jpg',
//       'order_number': 1,
//       'description': 'تعلم نطق وكتابة الحروف العربية بشكل صحيح'
//     },
//     {
//       'id': 2,
//       'title': 'الكلمات الأساسية',
//       'level': 'مبتدئ',
//       'image': 'assets/words.jpg',
//       'order_number': 2,
//       'description': 'تعلم الكلمات العربية الأساسية والمفردات'
//     },
//     {
//       'id': 3,
//       'title': 'الجمل البسيطة',
//       'level': 'متوسط',
//       'image': 'assets/sentences.jpg',
//       'order_number': 3,
//       'description': 'تكوين الجمل البسيطة وفهم القواعد الأساسية'
//     },
//     {
//       'id': 4,
//       'title': 'القصص القصيرة',
//       'level': 'متقدم',
//       'image': 'assets/stories.jpg',
//       'order_number': 4,
//       'description': 'قراءة وفهم القصص القصيرة باللغة العربية'
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//   }
//
//   void _initAnimations() {
//     // تهيئة متحكمات الحركة
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//
//     // تعريف الحركات
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
//     );
//
//     // بدء الحركات
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _fadeController.forward();
//       _scaleController.forward();
//       _slideController.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _scaleController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   void _navigateToLesson(Map<String, dynamic> lesson) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonsListScreen(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: secondaryColor,
//         appBar: _buildAppBar(),
//         body: AnimatedBuilder(
//           animation: _fadeController,
//           builder: (context, child) {
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: ScaleTransition(
//                   scale: _scaleAnimation,
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Column(
//                       children: [
//                         _buildMainBanner(),
//                         _buildLessonsSection(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMainBanner() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, -0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
//         ),
//       ),
//       child: Container(
//         height: 180.h,
//         margin: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//           gradient: LinearGradient(
//             colors: [primaryColor, primaryColor.withOpacity(0.8)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: primaryColor.withOpacity(0.3),
//               blurRadius: 15.r,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // خلفية متدرجة
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.r),
//                 gradient: LinearGradient(
//                   colors: [
//                     primaryColor.withOpacity(0.9),
//                     primaryColor.withOpacity(0.7)
//                   ],
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                 ),
//               ),
//             ),
//
//             // المحتوى
//             Padding(
//               padding: EdgeInsets.all(24.w),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'مرحباً بك في',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: Colors.white.withOpacity(0.9),
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'تطبيق تعلم القراءة',
//                           style: TextStyle(
//                             fontSize: 22.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(height: 8.h),
//                         Text(
//                           'ابدأ رحلة التعلم مع دروس تفاعلية وشيقة',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.white.withOpacity(0.8),
//                             fontFamily: 'Tajawal',
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 80.w,
//                     height: 80.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.school,
//                       color: Colors.white,
//                       size: 40.w,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLessonsSection() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'الدروس المتاحة',
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       color: textPrimary,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Text(
//                       '${_lessons.length} درس',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.h),
//             _buildLessonsGrid(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLessonsGrid() {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.w,
//         mainAxisSpacing: 16.h,
//         childAspectRatio: 0.85,
//       ),
//       itemCount: _lessons.length,
//       itemBuilder: (context, index) {
//         final lesson = _lessons[index];
//         return _buildLessonCard(lesson, index);
//       },
//     );
//   }
//
//   Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
//     return AnimatedBuilder(
//       animation: _fadeController,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _fadeAnimation.value,
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - _fadeController.value)),
//             child: child,
//           ),
//         );
//       },
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Card(
//           elevation: 4.w,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.w),
//           ),
//           child: InkWell(
//             onTap: () => _navigateToLesson(lesson),
//             borderRadius: BorderRadius.circular(16.w),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
//                 ),
//                 borderRadius: BorderRadius.circular(16.w),
//               ),
//               child: Stack(
//                 children: [
//                   // رقم الدرس
//                   Positioned(
//                     top: 12.h,
//                     right: 12.w,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                       child: Text(
//                         'درس ${lesson['order_number']}',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // أيقونة الفيديو
//                   Positioned(
//                     top: 12.h,
//                     left: 12.w,
//                     child: Container(
//                       padding: EdgeInsets.all(6.w),
//                       decoration: BoxDecoration(
//                         color: accentColor,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.play_arrow,
//                         color: Colors.white,
//                         size: 16.sp,
//                       ),
//                     ),
//                   ),
//
//                   // محتوى البطاقة
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(16.w),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 60.w,
//                             height: 60.h,
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.2),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.menu_book,
//                               color: Colors.white,
//                               size: 30.sp,
//                             ),
//                           ),
//                           SizedBox(height: 16.h),
//                           Text(
//                             lesson['title'] ?? 'بدون عنوان',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Tajawal',
//                             ),
//                             textAlign: TextAlign.center,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(height: 8.h),
//                           Text(
//                             'المستوى: ${lesson['level'] ?? 'مبتدئ'}',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.9),
//                               fontSize: 12.sp,
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: primaryColor,
//       foregroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       title: Text(
//         'الرئيسية',
//         style: TextStyle(
//           fontSize: 20.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//         ),
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(24.r),
//           bottomRight: Radius.circular(24.r),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'SecondScreen/lessons_list_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   final SupabaseClient _supabase = Supabase.instance.client;
//
//   // ألوان التطبيق التعليمي
//   final Color primaryColor = const Color(0xFF1E88E5); // الأزرق الأساسي
//   final Color secondaryColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
//   final Color accentColor = const Color(0xFFFFA726); // البرتقالي
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//
//   // متحكمات الحركة
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   // بيانات الكورسات من قاعدة البيانات
//   List<Map<String, dynamic>> _courses = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//     _loadCoursesFromSupabase();
//   }
//
//   void _initAnimations() {
//     // تهيئة متحكمات الحركة
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//
//     // تعريف الحركات
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
//     );
//
//     // بدء الحركات
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _fadeController.forward();
//       _scaleController.forward();
//       _slideController.forward();
//     });
//   }
//
//   // ✅ جلب الكورسات من قاعدة البيانات
//   Future<void> _loadCoursesFromSupabase() async {
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final response = await _supabase
//           .from('courses')
//           .select()
//           .eq('is_active', true)
//           .order('order_number');
//
//       if (response != null && response.isNotEmpty) {
//         if (mounted) {
//           setState(() {
//             _courses = List<Map<String, dynamic>>.from(response);
//           });
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             _errorMessage = 'لا توجد مواد متاحة حالياً';
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _errorMessage = 'خطأ في تحميل المواد: $e';
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
//   // ✅ إعادة تحميل البيانات
//   Future<void> _refreshData() async {
//     await _loadCoursesFromSupabase();
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _scaleController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   void _navigateToLessons(Map<String, dynamic> course) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonsListScreen(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: secondaryColor,
//         appBar: _buildAppBar(),
//         body: AnimatedBuilder(
//           animation: _fadeController,
//           builder: (context, child) {
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: ScaleTransition(
//                   scale: _scaleAnimation,
//                   child: RefreshIndicator(
//                     onRefresh: _refreshData,
//                     color: primaryColor,
//                     backgroundColor: secondaryColor,
//                     child: SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       child: Column(
//                         children: [
//                           _buildMainBanner(),
//                           _isLoading
//                               ? _buildLoadingWidget()
//                               : _errorMessage.isNotEmpty
//                               ? _buildErrorWidget()
//                               : _buildCoursesSection(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   // ✅ واجهة التحميل
//   Widget _buildLoadingWidget() {
//     return Container(
//       height: 200.h,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: primaryColor),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تحميل المواد...',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: textPrimary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ واجهة الخطأ
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
//               size: 60.sp,
//               color: Colors.red,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               _errorMessage,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.red[700],
//                 fontFamily: 'Tajawal',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20.h),
//             ElevatedButton(
//               onPressed: _refreshData,
//               child: Text(
//                 'إعادة المحاولة',
//                 style: TextStyle(fontFamily: 'Tajawal'),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.w),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMainBanner() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, -0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
//         ),
//       ),
//       child: Container(
//         height: 180.h,
//         margin: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//           gradient: LinearGradient(
//             colors: [primaryColor, primaryColor.withOpacity(0.8)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: primaryColor.withOpacity(0.3),
//               blurRadius: 15.r,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // خلفية متدرجة
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.r),
//                 gradient: LinearGradient(
//                   colors: [
//                     primaryColor.withOpacity(0.9),
//                     primaryColor.withOpacity(0.7)
//                   ],
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                 ),
//               ),
//             ),
//
//             // المحتوى
//             Padding(
//               padding: EdgeInsets.all(24.w),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'مرحباً بك في',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: Colors.white.withOpacity(0.9),
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'تطبيق تعلم القراءة',
//                           style: TextStyle(
//                             fontSize: 22.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(height: 8.h),
//                         Text(
//                           'اختر المادة التعليمية لبدء رحلة التعلم',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.white.withOpacity(0.8),
//                             fontFamily: 'Tajawal',
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 80.w,
//                     height: 80.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.school,
//                       color: Colors.white,
//                       size: 40.w,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCoursesSection() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'المواد التعليمية',
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       color: textPrimary,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Text(
//                       '${_courses.length} مادة',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.h),
//             _buildCoursesGrid(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCoursesGrid() {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.w,
//         mainAxisSpacing: 16.h,
//         childAspectRatio: 0.85,
//       ),
//       itemCount: _courses.length,
//       itemBuilder: (context, index) {
//         final course = _courses[index];
//         return _buildCourseCard(course, index);
//       },
//     );
//   }
//
//   Widget _buildCourseCard(Map<String, dynamic> course, int index) {
//     final String title = course['title'] ?? 'بدون عنوان';
//     final String level = course['level'] ?? 'مبتدئ';
//     final String description = course['description'] ?? '';
//     final int orderNumber = course['order_number'] ?? (index + 1);
//     final String? imageUrl = course['image_url'];
//
//     return AnimatedBuilder(
//       animation: _fadeController,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _fadeAnimation.value,
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - _fadeController.value)),
//             child: child,
//           ),
//         );
//       },
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Card(
//           elevation: 4.w,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.w),
//           ),
//           child: InkWell(
//             onTap: () => _navigateToLessons(course),
//             borderRadius: BorderRadius.circular(16.w),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
//                 ),
//                 borderRadius: BorderRadius.circular(16.w),
//               ),
//               child: Stack(
//                 children: [
//                   // رقم المادة
//                   Positioned(
//                     top: 12.h,
//                     right: 12.w,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                       child: Text(
//                         'مادة $orderNumber',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // أيقونة المستوى
//                   Positioned(
//                     top: 12.h,
//                     left: 12.w,
//                     child: Container(
//                       padding: EdgeInsets.all(6.w),
//                       decoration: BoxDecoration(
//                         color: _getLevelColor(level),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         _getLevelIcon(level),
//                         color: Colors.white,
//                         size: 16.sp,
//                       ),
//                     ),
//                   ),
//
//                   // محتوى البطاقة
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(16.w),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // صورة المادة إذا كانت موجودة
//                           if (imageUrl != null && imageUrl.isNotEmpty)
//                             Container(
//                               width: 60.w,
//                               height: 60.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.2),
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                   image: NetworkImage(imageUrl),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             )
//                           else
//                             Container(
//                               width: 60.w,
//                               height: 60.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.2),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.menu_book,
//                                 color: Colors.white,
//                                 size: 30.sp,
//                               ),
//                             ),
//
//                           SizedBox(height: 16.h),
//
//                           Text(
//                             title,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Tajawal',
//                             ),
//                             textAlign: TextAlign.center,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//
//                           SizedBox(height: 8.h),
//
//                           Text(
//                             'المستوى: $level',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.9),
//                               fontSize: 12.sp,
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//
//                           if (description.isNotEmpty) ...[
//                             SizedBox(height: 4.h),
//                             Text(
//                               description,
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.8),
//                                 fontSize: 10.sp,
//                                 fontFamily: 'Tajawal',
//                               ),
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ✅ الحصول على لون المستوى
//   Color _getLevelColor(String level) {
//     switch (level) {
//       case 'مبتدئ':
//         return Colors.green;
//       case 'متوسط':
//         return Colors.orange;
//       case 'متقدم':
//         return Colors.red;
//       default:
//         return accentColor;
//     }
//   }
//
//   // ✅ الحصول على أيقونة المستوى
//   IconData _getLevelIcon(String level) {
//     switch (level) {
//       case 'مبتدئ':
//         return Icons.arrow_upward;
//       case 'متوسط':
//         return Icons.trending_up;
//       case 'متقدم':
//         return Icons.star;
//       default:
//         return Icons.school;
//     }
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: primaryColor,
//       foregroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       title: Text(
//         'الرئيسية',
//         style: TextStyle(
//           fontSize: 20.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.refresh),
//           onPressed: _refreshData,
//           tooltip: 'تحديث البيانات',
//         ),
//       ],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(24.r),
//           bottomRight: Radius.circular(24.r),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'SecondScreen/lessons_list_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   final SupabaseClient _supabase = Supabase.instance.client;
//
//   // ألوان التطبيق التعليمي
//   final Color primaryColor = const Color(0xFF1E88E5); // الأزرق الأساسي
//   final Color secondaryColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
//   final Color accentColor = const Color(0xFFFFA726); // البرتقالي
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//
//   // متحكمات الحركة
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   // بيانات الكورسات من قاعدة البيانات
//   List<Map<String, dynamic>> _courses = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//     _loadCoursesFromSupabase();
//   }
//
//   void _initAnimations() {
//     // تهيئة متحكمات الحركة
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//
//     // تعريف الحركات
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
//     );
//
//     // بدء الحركات
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _fadeController.forward();
//       _scaleController.forward();
//       _slideController.forward();
//     });
//   }
//
//   // ✅ جلب الكورسات من قاعدة البيانات
//   Future<void> _loadCoursesFromSupabase() async {
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final response = await _supabase
//           .from('courses')
//           .select()
//           .eq('is_active', true)
//           .order('order_number');
//
//       if (response != null && response.isNotEmpty) {
//         if (mounted) {
//           setState(() {
//             _courses = List<Map<String, dynamic>>.from(response);
//           });
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             _errorMessage = 'لا توجد مواد متاحة حالياً';
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _errorMessage = 'خطأ في تحميل المواد: $e';
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
//   // ✅ إعادة تحميل البيانات
//   Future<void> _refreshData() async {
//     await _loadCoursesFromSupabase();
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _scaleController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   void _navigateToLessons(Map<String, dynamic> course) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonsListScreen(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: secondaryColor,
//         appBar: _buildAppBar(),
//         body: AnimatedBuilder(
//           animation: _fadeController,
//           builder: (context, child) {
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: ScaleTransition(
//                   scale: _scaleAnimation,
//                   child: RefreshIndicator(
//                     onRefresh: _refreshData,
//                     color: primaryColor,
//                     backgroundColor: secondaryColor,
//                     child: SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       child: Column(
//                         children: [
//                           _buildMainBanner(),
//                           _isLoading
//                               ? _buildLoadingWidget()
//                               : _errorMessage.isNotEmpty
//                               ? _buildErrorWidget()
//                               : _buildCoursesSection(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   // ✅ واجهة التحميل
//   Widget _buildLoadingWidget() {
//     return Container(
//       height: 200.h,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: primaryColor),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تحميل المواد...',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: textPrimary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ واجهة الخطأ
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
//               size: 60.sp,
//               color: Colors.red,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               _errorMessage,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.red[700],
//                 fontFamily: 'Tajawal',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20.h),
//             ElevatedButton(
//               onPressed: _refreshData,
//               child: Text(
//                 'إعادة المحاولة',
//                 style: TextStyle(fontFamily: 'Tajawal'),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.w),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMainBanner() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, -0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
//         ),
//       ),
//       child: Container(
//         height: 200.h,
//         margin: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 15.r,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20.r),
//           child: Image.asset(
//             'assets/images/shater.png',
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [primaryColor, primaryColor.withOpacity(0.8)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.school,
//                         color: Colors.white,
//                         size: 50.w,
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         'تطبيق تعلم القراءة',
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCoursesSection() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'المواد التعليمية',
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       color: textPrimary,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Text(
//                       '${_courses.length} مادة',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.h),
//             _buildCoursesGrid(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCoursesGrid() {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.w,
//         mainAxisSpacing: 16.h,
//         childAspectRatio: 0.75, // نسبة أكثر احترافية للارتفاع
//       ),
//       itemCount: _courses.length,
//       itemBuilder: (context, index) {
//         final course = _courses[index];
//         return _buildCourseCard(course, index);
//       },
//     );
//   }
//
//   Widget _buildCourseCard(Map<String, dynamic> course, int index) {
//     final String title = course['title'] ?? 'بدون عنوان';
//     final String? imageUrl = course['image_url'];
//
//     return AnimatedBuilder(
//       animation: _fadeController,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _fadeAnimation.value,
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - _fadeController.value)),
//             child: child,
//           ),
//         );
//       },
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Card(
//           elevation: 8.w,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.w),
//           ),
//           child: InkWell(
//             onTap: () => _navigateToLessons(course),
//             borderRadius: BorderRadius.circular(16.w),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: primaryColor, // الخلفية الزرقاء
//                 borderRadius: BorderRadius.circular(16.w),
//                 boxShadow: [
//                   BoxShadow(
//                     color: primaryColor.withOpacity(0.3),
//                     blurRadius: 10.w,
//                     offset: Offset(0, 4.h),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   // الصورة تغطي الكارت بالكامل
//                   if (imageUrl != null && imageUrl.isNotEmpty)
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16.w),
//                       child: Image.network(
//                         imageUrl,
//                         width: double.infinity,
//                         height: double.infinity,
//                         fit: BoxFit.cover,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Container(
//                             color: primaryColor.withOpacity(0.7),
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 value: loadingProgress.expectedTotalBytes != null
//                                     ? loadingProgress.cumulativeBytesLoaded /
//                                     loadingProgress.expectedTotalBytes!
//                                     : null,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, error, stackTrace) {
//                           return _buildPlaceholderImage();
//                         },
//                       ),
//                     )
//                   else
//                     _buildPlaceholderImage(),
//
//                   // طبقة تدرج لوني فوق الصورة لتحسين قراءة النص
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.w),
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                         colors: [
//                           primaryColor.withOpacity(0.9),
//                           primaryColor.withOpacity(0.5),
//                           Colors.transparent,
//                         ],
//                         stops: [0.0, 0.3, 0.7],
//                       ),
//                     ),
//                   ),
//
//                   // العنوان في الأسفل
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 12.w,
//                         vertical: 16.h,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(16.w),
//                           bottomRight: Radius.circular(16.w),
//                         ),
//                         gradient: LinearGradient(
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                           colors: [
//                             primaryColor.withOpacity(0.95),
//                             primaryColor.withOpacity(0.7),
//                           ],
//                         ),
//                       ),
//                       child: Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                           height: 1.3,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//
//                   // تأثير لمعان عند الضغط
//                   Positioned.fill(
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16.w),
//                         onTap: () => _navigateToLessons(course),
//                         child: Container(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ✅ صورة بديلة عند عدم وجود صورة
//   Widget _buildPlaceholderImage() {
//     return Container(
//       decoration: BoxDecoration(
//         color: primaryColor.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(16.w),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.menu_book_rounded,
//               color: Colors.white.withOpacity(0.9),
//               size: 50.sp,
//             ),
//             SizedBox(height: 12.h),
//             Text(
//               'صورة المادة',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.white.withOpacity(0.9),
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: primaryColor,
//       foregroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       title: Text(
//         'الرئيسية',
//         style: TextStyle(
//           fontSize: 20.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.refresh),
//           onPressed: _refreshData,
//           tooltip: 'تحديث البيانات',
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'SecondScreen/lessons_list_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   final SupabaseClient _supabase = Supabase.instance.client;
//
//   // ألوان التطبيق التعليمي
//   final Color primaryColor = const Color(0xFF1E88E5); // الأزرق الأساسي
//   final Color secondaryColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
//   final Color accentColor = const Color(0xFFFFA726); // البرتقالي
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//
//   // متحكمات الحركة
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   // بيانات الكورسات من قاعدة البيانات
//   List<Map<String, dynamic>> _courses = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//     _loadCoursesFromSupabase();
//   }
//
//   void _initAnimations() {
//     // تهيئة متحكمات الحركة
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//
//     // تعريف الحركات
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
//     );
//
//     // بدء الحركات
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _fadeController.forward();
//       _scaleController.forward();
//       _slideController.forward();
//     });
//   }
//
//   // ✅ جلب الكورسات من قاعدة البيانات باستخدام id للترتيب
//   Future<void> _loadCoursesFromSupabase() async {
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final response = await _supabase
//           .from('courses')
//           .select()
//           .eq('is_active', true)
//           .order('id'); // استخدام id للترتيب بدلاً من order_number
//
//       if (response != null && response.isNotEmpty) {
//         if (mounted) {
//           setState(() {
//             _courses = List<Map<String, dynamic>>.from(response);
//           });
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             _errorMessage = 'لا توجد مواد متاحة حالياً';
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _errorMessage = 'خطأ في تحميل المواد: $e';
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
//   // ✅ إعادة تحميل البيانات
//   Future<void> _refreshData() async {
//     await _loadCoursesFromSupabase();
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _scaleController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   void _navigateToLessons(Map<String, dynamic> course) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonsListScreen(subjectImageUrl: imageUrl,subjectName: title,),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: secondaryColor,
//         appBar: _buildAppBar(),
//         body: AnimatedBuilder(
//           animation: _fadeController,
//           builder: (context, child) {
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: ScaleTransition(
//                   scale: _scaleAnimation,
//                   child: RefreshIndicator(
//                     onRefresh: _refreshData,
//                     color: primaryColor,
//                     backgroundColor: secondaryColor,
//                     child: SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       child: Column(
//                         children: [
//                           _buildMainBanner(),
//                           _isLoading
//                               ? _buildLoadingWidget()
//                               : _errorMessage.isNotEmpty
//                               ? _buildErrorWidget()
//                               : _buildCoursesSection(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   // ✅ واجهة التحميل
//   Widget _buildLoadingWidget() {
//     return Container(
//       height: 200.h,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: primaryColor),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تحميل المواد...',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: textPrimary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ واجهة الخطأ
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
//               size: 60.sp,
//               color: Colors.red,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               _errorMessage,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.red[700],
//                 fontFamily: 'Tajawal',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20.h),
//             ElevatedButton(
//               onPressed: _refreshData,
//               child: Text(
//                 'إعادة المحاولة',
//                 style: TextStyle(fontFamily: 'Tajawal'),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.w),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMainBanner() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, -0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
//         ),
//       ),
//       child: Container(
//         height: 200.h,
//         margin: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 15.r,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20.r),
//           child: Image.asset(
//             'assets/images/shater.png',
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [primaryColor, primaryColor.withOpacity(0.8)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.school,
//                         color: Colors.white,
//                         size: 50.w,
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         'تطبيق تعلم القراءة',
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCoursesSection() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'المواد التعليمية',
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       color: textPrimary,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Text(
//                       '${_courses.length} مادة',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.h),
//             _buildCoursesGrid(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCoursesGrid() {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.w,
//         mainAxisSpacing: 16.h,
//         childAspectRatio: 0.75,
//       ),
//       itemCount: _courses.length,
//       itemBuilder: (context, index) {
//         final course = _courses[index];
//         return _buildCourseCard(course, index);
//       },
//     );
//   }
//
//   Widget _buildCourseCard(Map<String, dynamic> course, int index) {
//     final String title = course['title'] ?? 'بدون عنوان';
//     final String? imageUrl = course['image_url'];
//     final int courseId = course['id'] ?? 0; // استخدام id بدلاً من order_number
//
//     return AnimatedBuilder(
//       animation: _fadeController,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _fadeAnimation.value,
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - _fadeController.value)),
//             child: child,
//           ),
//         );
//       },
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Card(
//           elevation: 8.w,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.w),
//           ),
//           child: InkWell(
//             onTap: () => _navigateToLessons(course),
//             borderRadius: BorderRadius.circular(16.w),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 borderRadius: BorderRadius.circular(16.w),
//                 boxShadow: [
//                   BoxShadow(
//                     color: primaryColor.withOpacity(0.3),
//                     blurRadius: 10.w,
//                     offset: Offset(0, 4.h),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   // الصورة تغطي الكارت بالكامل
//                   if (imageUrl != null && imageUrl.isNotEmpty)
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16.w),
//                       child: Image.network(
//                         imageUrl,
//                         width: double.infinity,
//                         height: double.infinity,
//                         fit: BoxFit.cover,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Container(
//                             color: primaryColor.withOpacity(0.7),
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 value: loadingProgress.expectedTotalBytes != null
//                                     ? loadingProgress.cumulativeBytesLoaded /
//                                     loadingProgress.expectedTotalBytes!
//                                     : null,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, error, stackTrace) {
//                           return _buildPlaceholderImage();
//                         },
//                       ),
//                     )
//                   else
//                     _buildPlaceholderImage(),
//
//                   // طبقة تدرج لوني فوق الصورة لتحسين قراءة النص
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.w),
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                         colors: [
//                           primaryColor.withOpacity(0.9),
//                           primaryColor.withOpacity(0.5),
//                           Colors.transparent,
//                         ],
//                         stops: [0.0, 0.3, 0.7],
//                       ),
//                     ),
//                   ),
//
//                   // رقم المادة (باستخدام id)
//                   Positioned(
//                     top: 12.h,
//                     right: 12.w,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                       child: Text(
//                         'مادة ${index + 1}', // استخدام الفهرس بدلاً من order_number
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // العنوان في الأسفل
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 12.w,
//                         vertical: 16.h,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(16.w),
//                           bottomRight: Radius.circular(16.w),
//                         ),
//                         gradient: LinearGradient(
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                           colors: [
//                             primaryColor.withOpacity(0.95),
//                             primaryColor.withOpacity(0.7),
//                           ],
//                         ),
//                       ),
//                       child: Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                           height: 1.3,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//
//                   // تأثير لمعان عند الضغط
//                   Positioned.fill(
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16.w),
//                         onTap: () => _navigateToLessons(course),
//                         child: Container(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ✅ صورة بديلة عند عدم وجود صورة
//   Widget _buildPlaceholderImage() {
//     return Container(
//       decoration: BoxDecoration(
//         color: primaryColor.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(16.w),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.menu_book_rounded,
//               color: Colors.white.withOpacity(0.9),
//               size: 50.sp,
//             ),
//             SizedBox(height: 12.h),
//             Text(
//               'صورة المادة',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.white.withOpacity(0.9),
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: primaryColor,
//       foregroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       title: Text(
//         'الرئيسية',
//         style: TextStyle(
//           fontSize: 20.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//         ),
//       ),
//       // actions: [
//       //   IconButton(
//       //     icon: Icon(Icons.refresh),
//       //     onPressed: _refreshData,
//       //     tooltip: 'تحديث البيانات',
//       //   ),
//       // ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'SecondScreen/lessons_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(String, String) navigateToLessons;

  const HomeScreen({Key? key, required this.navigateToLessons}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final SupabaseClient _supabase = Supabase.instance.client;
  final Connectivity _connectivity = Connectivity();

  // ألوان التطبيق التعليمي
  final Color _primaryBlue = const Color(0xFF1E88E5);
  final Color _secondaryColor = const Color(0xFFF5F9FF);
  final Color _accentColor = const Color(0xFFFFA726);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = const Color(0xFF2D3748);
  final Color _textSecondary = const Color(0xFF718096);
  final Color _errorRed = const Color(0xFFEF4444);
  final Color _warningOrange = const Color(0xFFFFA726);

  // متحكمات الحركة
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  // بيانات الكورسات من قاعدة البيانات
  List<Map<String, dynamic>> _courses = [];
  bool _isLoading = true;
  String _errorMessage = '';
  bool _hasNetworkError = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _checkConnectivityAndLoadData();
  }

  void _initAnimations() {
    // تهيئة متحكمات الحركة
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // تعريف الحركات
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
    );

    // بدء الحركات
    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeController.forward();
      _scaleController.forward();
      _slideController.forward();
    });
  }

  Future<void> _checkConnectivityAndLoadData() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        // لا يوجد اتصال بالإنترنت
        if (mounted) {
          setState(() {
            _hasNetworkError = true;
            _isLoading = false;
          });
        }
        _showNetworkErrorDialog();
        return;
      }

      // يوجد اتصال، جلب البيانات
      await _loadCoursesFromSupabase();

    } catch (e) {
      if (mounted) {
        setState(() {
          _hasNetworkError = true;
          _isLoading = false;
          _errorMessage = 'خطأ في التحقق من الاتصال: $e';
        });
      }
      _showNetworkErrorDialog();
    }
  }

  // ✅ جلب الكورسات من قاعدة البيانات
  Future<void> _loadCoursesFromSupabase() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _hasNetworkError = false;
    });

    try {
      final response = await _supabase
          .from('courses')
          .select()
          .eq('is_active', true)
          .order('id')
          .timeout(Duration(seconds: 10)); // إضافة timeout

      if (response != null && response.isNotEmpty) {
        if (mounted) {
          setState(() {
            _courses = List<Map<String, dynamic>>.from(response);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'لا توجد مواد متاحة حالياً';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasNetworkError = true;
          _errorMessage = 'خطأ في تحميل المواد: $e';
        });
      }
      _showNetworkErrorDialog();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ✅ دايلوج خطأ الاتصال بالإنترنت
  void _showNetworkErrorDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: false, // لا يمكن إغلاقه بالنقر خارج الدايلوج
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(28.w),
                margin: EdgeInsets.only(top: 50.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 25.w,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      'مشكلة في الاتصال',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'تعذر الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: _textSecondary,
                        fontFamily: 'Tajawal',
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'قد يكون السبب: اتصال إنترنت ضعيف أو مشكلة في الخادم',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: _warningOrange,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Row(
                      children: [
                        // زر المحاولة مرة أخرى
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _checkConnectivityAndLoadData();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              elevation: 4,
                              shadowColor: _primaryBlue.withOpacity(0.3),
                            ),
                            child: Text(
                              'إعادة المحاولة',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // زر الخروج
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _textSecondary,
                              side: BorderSide(color: Colors.grey[400]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                            ),
                            child: Text(
                              'حسناً',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                      color: _warningOrange,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15.w,
                          spreadRadius: 1.w,
                        ),
                      ],
                    ),
                    child: Icon(Icons.wifi_off, size: 42.w, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ دايلوج خطأ عام
  void _showErrorDialog(
      String title,
      String message,
      IconData icon,
      Color iconColor,
      ) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(28.w),
                margin: EdgeInsets.only(top: 50.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 25.w,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: _textSecondary,
                        fontFamily: 'Tajawal',
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          elevation: 4,
                          shadowColor: _primaryBlue.withOpacity(0.3),
                        ),
                        child: Text(
                          'حسناً',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15.w,
                          spreadRadius: 1.w,
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 42.w, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ إعادة تحميل البيانات
  Future<void> _refreshData() async {
    await _checkConnectivityAndLoadData();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  // ✅ التعديل: استخدام دالة التنقل من MainNavigation
  void _navigateToLessons(Map<String, dynamic> course) {
    final String title = course['title'] ?? 'بدون عنوان';
    final String imageUrl = course['image_url'] ?? '';

    widget.navigateToLessons(imageUrl, title);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        // ✅ التعديل: استخدام Container بدلاً من Scaffold
        color: _secondaryColor,
        child: AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    color: _primaryBlue,
                    backgroundColor: _secondaryColor,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          _buildMainBanner(),
                          _isLoading
                              ? _buildLoadingWidget()
                              : _errorMessage.isNotEmpty && !_hasNetworkError
                              ? _buildErrorWidget()
                              : _buildCoursesSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ✅ واجهة التحميل
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

  // ✅ واجهة الخطأ (لأخطاء غير متعلقة بالشبكة)
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
              size: 60.sp,
              color: Colors.red,
            ),
            SizedBox(height: 16.h),
            Text(
              _errorMessage,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.red[700],
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: _refreshData,
              child: Text(
                'إعادة المحاولة',
                style: TextStyle(fontFamily: 'Tajawal'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainBanner() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        ),
      ),
      child: Container(
        height: 200.h,
        margin: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15.r,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            'assets/images/shater.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryBlue, _primaryBlue.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCoursesSection() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المواد التعليمية',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: _textPrimary,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: _primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${_courses.length} مادة',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: _primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _buildCoursesGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.75,
      ),
      itemCount: _courses.length,
      itemBuilder: (context, index) {
        final course = _courses[index];
        return _buildCourseCard(course, index);
      },
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course, int index) {
    final String title = course['title'] ?? 'بدون عنوان';
    final String? imageUrl = course['image_url'];
    final int courseId = course['id'] ?? 0;

    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _fadeController.value)),
            child: child,
          ),
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 8.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: InkWell(
            onTap: () => _navigateToLessons(course),
            borderRadius: BorderRadius.circular(16.w),
            child: Container(
              decoration: BoxDecoration(
                color: _primaryBlue,
                borderRadius: BorderRadius.circular(16.w),
                boxShadow: [
                  BoxShadow(
                    color: _primaryBlue.withOpacity(0.3),
                    blurRadius: 10.w,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.w),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: _primaryBlue.withOpacity(0.7),
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderImage();
                        },
                      ),
                    )
                  else
                    _buildPlaceholderImage(),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          _primaryBlue.withOpacity(0.9),
                          _primaryBlue.withOpacity(0.5),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.3, 0.7],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Text(
                        'مادة ${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.w),
                          bottomRight: Radius.circular(16.w),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            _primaryBlue.withOpacity(0.95),
                            _primaryBlue.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16.w),
                        onTap: () => _navigateToLessons(course),
                        child: Container(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: _primaryBlue.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_rounded,
              color: Colors.white.withOpacity(0.9),
              size: 50.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'صورة المادة',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.9),
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}