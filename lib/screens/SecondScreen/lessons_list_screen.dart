// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'lesson_detail_screen.dart';
//
// class LessonsListScreen extends StatefulWidget {
//   @override
//   _LessonsListScreenState createState() => _LessonsListScreenState();
// }
//
// class _LessonsListScreenState extends State<LessonsListScreen> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   List<Map<String, dynamic>> lessons = [];
//   bool isLoading = false;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLessonsFromSupabase();
//   }
//
//   Future<void> _loadLessonsFromSupabase() async {
//     if (!mounted) return;
//
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });
//
//     try {
//       final response = await supabase
//           .from('lessons')
//           .select()
//           .order('order_number');
//
//       if (response != null && response.isNotEmpty) {
//         if (mounted) {
//           setState(() {
//             lessons = List<Map<String, dynamic>>.from(response);
//           });
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             errorMessage = 'لا توجد دروس متاحة';
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           errorMessage = 'خطأ في تحميل الدروس: $e';
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _navigateToLesson(Map<String, dynamic> lesson) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonDetailScreen(lesson: lesson),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF1E88E5),
//         foregroundColor: Colors.white,
//         title: Text(
//           'مكتبة الدروس التعليمية',
//           style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadLessonsFromSupabase,
//             tooltip: 'تحديث الدروس',
//           ),
//         ],
//       ),
//       backgroundColor: Color(0xFFE3F2FD),
//       body: isLoading
//           ? _buildLoadingWidget()
//           : errorMessage.isNotEmpty
//           ? _buildErrorWidget()
//           : _buildLessonsList(),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(color: Color(0xFF1E88E5)),
//           SizedBox(height: 20.h),
//           Text(
//             'جاري تحميل الدروس...',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Color(0xFF1E88E5),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//           SizedBox(height: 16.h),
//           Text(
//             errorMessage,
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.red[700],
//               fontFamily: 'Tajawal',
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20.h),
//           ElevatedButton(
//             onPressed: _loadLessonsFromSupabase,
//             child: Text(
//               'إعادة المحاولة',
//               style: TextStyle(fontFamily: 'Tajawal'),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF1E88E5),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.w),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLessonsList() {
//     return lessons.isEmpty
//         ? Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.menu_book, size: 80.sp, color: Colors.grey),
//           SizedBox(height: 16.h),
//           Text(
//             'لا توجد دروس متاحة',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Colors.grey,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     )
//         : SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: EdgeInsets.all(16.w),
//       child: Column(
//         children: [
//           // عنوان القسم
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(vertical: 8.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'جميع الدروس',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E88E5),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1E88E5).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Text(
//                     '${lessons.length} درس',
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: Color(0xFF1E88E5),
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 16.h),
//
//           // قائمة الدروس
//           Column(
//             children: lessons.map((lesson) {
//               return _buildLessonCard(lesson);
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLessonCard(Map<String, dynamic> lesson) {
//     int orderNumber = lesson['order_number'] ?? 1;
//     bool hasVideo = lesson['video_url'] != null && lesson['video_url'].isNotEmpty;
//     String level = lesson['level'] ?? 'مبتدئ';
//     String description = lesson['description'] ?? '';
//
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.only(bottom: 16.h),
//       child: Card(
//         elevation: 4.w,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.w),
//         ),
//         child: InkWell(
//           onTap: () => _navigateToLesson(lesson),
//           borderRadius: BorderRadius.circular(16.w),
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
//               ),
//               borderRadius: BorderRadius.circular(16.w),
//             ),
//             child: Row(
//               children: [
//                 // الجزء الأيسر: الأيقونة والمعلومات الأساسية
//                 Expanded(
//                   flex: 3,
//                   child: Padding(
//                     padding: EdgeInsets.all(16.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // رقم الدرس والمستوى
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(12.w),
//                               ),
//                               child: Text(
//                                 'درس $orderNumber',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFFFA726),
//                                 borderRadius: BorderRadius.circular(12.w),
//                               ),
//                               child: Text(
//                                 level,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         SizedBox(height: 12.h),
//
//                         // عنوان الدرس
//                         Text(
//                           lesson['title'] ?? 'بدون عنوان',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//
//                         SizedBox(height: 8.h),
//
//                         // وصف الدرس
//                         if (description.isNotEmpty)
//                           Text(
//                             description,
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.9),
//                               fontSize: 12.sp,
//                               fontFamily: 'Tajawal',
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//
//                         SizedBox(height: 12.h),
//
//                         // أيقونة الفيديو إذا كان موجوداً
//                         if (hasVideo)
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.play_circle_fill,
//                                 color: Color(0xFFFFA726),
//                                 size: 16.sp,
//                               ),
//                               SizedBox(width: 6.w),
//                               Text(
//                                 'يحتوي على فيديو',
//                                 style: TextStyle(
//                                   color: Colors.white.withOpacity(0.9),
//                                   fontSize: 12.sp,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ],
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // الجزء الأيمن: الأيقونة الكبيرة
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     padding: EdgeInsets.all(16.w),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 60.w,
//                           height: 60.h,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             hasVideo ? Icons.video_library : Icons.menu_book,
//                             color: Colors.white,
//                             size: 28.sp,
//                           ),
//                         ),
//                         SizedBox(height: 8.h),
//                         Icon(
//                           Icons.arrow_back_ios_new,
//                           color: Colors.white.withOpacity(0.7),
//                           size: 16.sp,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'lesson_detail_screen.dart';
//
// class LessonsListScreen extends StatefulWidget {
//   final String subjectImageUrl;
//   final String subjectName;
//
//   const LessonsListScreen({
//     Key? key,
//     required this.subjectImageUrl,
//     required this.subjectName,
//   }) : super(key: key);
//
//   @override
//   _LessonsListScreenState createState() => _LessonsListScreenState();
// }
//
// class _LessonsListScreenState extends State<LessonsListScreen> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   List<Map<String, dynamic>> lessons = [];
//   bool isLoading = false;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLessonsFromSupabase();
//   }
//
//   Future<void> _loadLessonsFromSupabase() async {
//     if (!mounted) return;
//
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });
//
//     try {
//       final response = await supabase
//           .from('lessons')
//           .select()
//           .order('order_number');
//
//       if (response != null && response.isNotEmpty) {
//         if (mounted) {
//           setState(() {
//             lessons = List<Map<String, dynamic>>.from(response);
//           });
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             errorMessage = 'لا توجد دروس متاحة';
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           errorMessage = 'خطأ في تحميل الدروس: $e';
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _navigateToLesson(Map<String, dynamic> lesson) {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => LessonDetailScreen(lesson: lesson),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.easeInOutQuart;
//
//           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);
//
//           return SlideTransition(
//             position: offsetAnimation,
//             child: FadeTransition(
//               opacity: animation,
//               child: child,
//             ),
//           );
//         },
//         transitionDuration: Duration(milliseconds: 500),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         // ✅ التعديل: إضافة Scaffold مع body فقط (بدون AppBar)
//         body: Container(
//           color: Color(0xFFF8FAFC),
//           child: isLoading
//               ? _buildLoadingWidget()
//               : errorMessage.isNotEmpty
//               ? _buildErrorWidget()
//               : _buildContent(),
//         ),
//
//       ),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Column(
//       children: [
//         _buildCustomHeader(),
//         Expanded(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(color: Color(0xFF1E88E5)),
//                 SizedBox(height: 20.h),
//                 Text(
//                   'جاري تحميل الدروس...',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     color: Color(0xFF1E88E5),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Column(
//       children: [
//         _buildCustomHeader(),
//         Expanded(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//                 SizedBox(height: 16.h),
//                 Text(
//                   errorMessage,
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.red[700],
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20.h),
//                 ElevatedButton(
//                   onPressed: _loadLessonsFromSupabase,
//                   child: Text(
//                     'إعادة المحاولة',
//                     style: TextStyle(fontFamily: 'Tajawal'),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF1E88E5),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.w),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContent() {
//     return Column(
//       children: [
//         // الرأس المخصص
//         _buildCustomHeader(),
//
//         // كارت صورة المادة
//         _buildSubjectHeader(),
//
//         // قائمة الدروس
//         Expanded(
//           child: lessons.isEmpty
//               ? _buildEmptyState()
//               : _buildLessonsList(),
//         ),
//       ],
//     );
//   }
//
//   // ✅ التعديل: إضافة SafeArea للرأس المخصص
//   Widget _buildCustomHeader() {
//     return SafeArea(
//       bottom: false,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//         decoration: BoxDecoration(
//           color: Color(0xFF1E88E5),
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20.w),
//             bottomRight: Radius.circular(20.w),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10.w,
//               offset: Offset(0, 4.h),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // زر العودة
//             IconButton(
//               onPressed: () => Navigator.of(context).pop(),
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//                 size: 24.sp,
//               ),
//             ),
//             SizedBox(width: 12.w),
//             // عنوان المادة
//             Expanded(
//               child: Text(
//                 widget.subjectName,
//                 style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontFamily: 'Tajawal',
//                 ),
//                 textAlign: TextAlign.right,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSubjectHeader() {
//     return Container(
//       width: double.infinity,
//       height: 140.h,
//       margin: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 15.w,
//             offset: Offset(0, 6.h),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20.w),
//         child: Stack(
//           children: [
//             // صورة الخلفية
//             widget.subjectImageUrl.isNotEmpty
//                 ? Image.network(
//               widget.subjectImageUrl,
//               width: double.infinity,
//               height: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return _buildPlaceholderImage();
//               },
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) return child;
//                 return _buildImageLoader();
//               },
//             )
//                 : _buildPlaceholderImage(),
//
//             // طبقة تدرج لوني للأعلى للقراءة
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.6),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//             ),
//
//             // المحتوى النصي - باتجاه اليمين
//             Positioned(
//               bottom: 16.h,
//               right: 16.w,
//               left: 16.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.subjectName,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     '${lessons.length} درس تعليمي',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.9),
//                       fontSize: 14.sp,
//                       fontFamily: 'Tajawal',
//                     ),
//                     textAlign: TextAlign.right,
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
//   Widget _buildPlaceholderImage() {
//     return Container(
//       color: Color(0xFF1E88E5),
//       child: Center(
//         child: Icon(
//           Icons.menu_book,
//           color: Colors.white,
//           size: 40.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageLoader() {
//     return Container(
//       color: Colors.grey[200],
//       child: Center(
//         child: CircularProgressIndicator(
//           color: Color(0xFF1E88E5),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Column(
//       children: [
//         _buildCustomHeader(),
//         Expanded(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.menu_book, size: 80.sp, color: Colors.grey),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'لا توجد دروس متاحة',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     color: Colors.grey,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLessonsList() {
//     return Column(
//       children: [
//         // عنوان القسم - باتجاه اليمين
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // العداد
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF1E88E5).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Text(
//                   '${lessons.length} درس',
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: Color(0xFF1E88E5),
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ),
//
//               // العنوان
//               Text(
//                 'دروس ${widget.subjectName}',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1E293B),
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 8.h),
//
//         // قائمة الدروس
//         Expanded(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//             child: Column(
//               children: lessons.map((lesson) {
//                 return _AnimatedLessonCard(
//                   lesson: lesson,
//                   onTap: _navigateToLesson,
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _AnimatedLessonCard extends StatefulWidget {
//   final Map<String, dynamic> lesson;
//   final Function(Map<String, dynamic>) onTap;
//
//   const _AnimatedLessonCard({
//     Key? key,
//     required this.lesson,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   __AnimatedLessonCardState createState() => __AnimatedLessonCardState();
// }
//
// class __AnimatedLessonCardState extends State<_AnimatedLessonCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _shadowAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.95,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//
//     _shadowAnimation = Tween<double>(
//       begin: 2.0,
//       end: 8.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _handleTap() {
//     _animationController.forward().then((_) {
//       _animationController.reverse();
//       widget.onTap(widget.lesson);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int orderNumber = widget.lesson['order_number'] ?? 1;
//     String lessonImage = widget.lesson['image_url'] ?? '';
//     bool hasVideo = widget.lesson['video_url'] != null &&
//         widget.lesson['video_url'].isNotEmpty;
//
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _scaleAnimation.value,
//           child: Container(
//             width: double.infinity,
//             height: 80.h,
//             margin: EdgeInsets.only(bottom: 12.h),
//             child: Card(
//               elevation: _shadowAnimation.value,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.w),
//               ),
//               child: InkWell(
//                 onTap: _handleTap,
//                 borderRadius: BorderRadius.circular(16.w),
//                 highlightColor: Color(0xFF1E88E5).withOpacity(0.1),
//                 splashColor: Color(0xFF1E88E5).withOpacity(0.2),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16.w),
//                     border: Border.all(
//                       color: Colors.grey.withOpacity(0.2),
//                       width: 1.w,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//
//                       // صورة الدرس
//                       Container(
//                         width: 80.w,
//                         height: 80.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(16.w),
//                             bottomLeft: Radius.circular(16.w),
//                           ),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(16.w),
//                             bottomLeft: Radius.circular(16.w),
//                           ),
//                           child: lessonImage.isNotEmpty
//                               ? Image.network(
//                             lessonImage,
//                             width: double.infinity,
//                             height: double.infinity,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return _buildLessonPlaceholder();
//                             },
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return _buildLessonImageLoader();
//                             },
//                           )
//                               : _buildLessonPlaceholder(),
//                         ),
//                       ),
//
//                       // معلومات الدرس
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 12.w),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // عنوان الدرس
//                               Text(
//                                 widget.lesson['title'] ?? 'بدون عنوان',
//                                 style: TextStyle(
//                                   color: Color(0xFF1E293B),
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.right,
//                               ),
//
//                               SizedBox(height: 6.h),
//
//                               // رقم الدرس وأيقونة الفيديو
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//
//                                   // رقم الدرس
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 8.w,
//                                         vertical: 2.h
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFF1E88E5).withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(6.r),
//                                     ),
//                                     child: Text(
//                                       'درس $orderNumber',
//                                       style: TextStyle(
//                                         color: Color(0xFF1E88E5),
//                                         fontSize: 10.sp,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Tajawal',
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 8.w),
//                                   // أيقونة الفيديو إذا كان موجوداً
//                                   if (hasVideo)
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'فيديو',
//                                           style: TextStyle(
//                                             color: Color(0xFFFFA726),
//                                             fontSize: 10.sp,
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: 'Tajawal',
//                                           ),
//                                         ),
//                                         SizedBox(width: 4.w),
//                                         Icon(
//                                           Icons.play_circle_fill,
//                                           color: Color(0xFFFFA726),
//                                           size: 12.sp,
//                                         ),
//                                         SizedBox(width: 8.w),
//                                       ],
//                                     ),
//
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       // أيقونة السهم
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 12.w),
//                         child: Transform(
//                           transform: Matrix4.rotationY(3.14159),
//                           child: Icon(
//                             Icons.arrow_forward_ios,
//                             color: Color(0xFF1E88E5),
//                             size: 16.sp,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12.w),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildLessonPlaceholder() {
//     return Container(
//       color: Color(0xFFE3F2FD),
//       child: Center(
//         child: Icon(
//           Icons.menu_book,
//           color: Color(0xFF1E88E5),
//           size: 24.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLessonImageLoader() {
//     return Container(
//       color: Colors.grey[100],
//       child: Center(
//         child: SizedBox(
//           width: 20.w,
//           height: 20.h,
//           child: CircularProgressIndicator(
//             strokeWidth: 2.w,
//             color: Color(0xFF1E88E5),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'lesson_detail_screen.dart';
//
// class LessonsListScreen extends StatefulWidget {
//   final String subjectImageUrl;
//   final String subjectName;
//
//   const LessonsListScreen({
//     Key? key,
//     required this.subjectImageUrl,
//     required this.subjectName,
//   }) : super(key: key);
//
//   @override
//   _LessonsListScreenState createState() => _LessonsListScreenState();
// }
//
// class _LessonsListScreenState extends State<LessonsListScreen> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   List<Map<String, dynamic>> lessons = [];
//   bool isLoading = false;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLessonsFromSupabase();
//   }
//
//   Future<void> _loadLessonsFromSupabase() async {
//     if (!mounted) return;
//
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });
//
//     try {
//       final response = await supabase
//           .from('lessons')
//           .select()
//           .order('order_number');
//
//       if (response != null && response.isNotEmpty) {
//         if (mounted) {
//           setState(() {
//             lessons = List<Map<String, dynamic>>.from(response);
//           });
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             errorMessage = 'لا توجد دروس متاحة';
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           errorMessage = 'خطأ في تحميل الدروس: $e';
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _navigateToLesson(Map<String, dynamic> lesson) {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => LessonDetailScreen(lesson: lesson),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.easeInOutQuart;
//
//           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);
//
//           return SlideTransition(
//             position: offsetAnimation,
//             child: FadeTransition(
//               opacity: animation,
//               child: child,
//             ),
//           );
//         },
//         transitionDuration: Duration(milliseconds: 500),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//       appBar:AppBar(
//         backgroundColor: Color(0xFF1E88E5),
//         foregroundColor: Colors.white,
//         title: Text(
//           'مكتبة الدروس التعليمية',
//           style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//         centerTitle: true,
//
//       ),
//         body: Container(
//           color: Color(0xFFF8FAFC),
//           child: isLoading
//               ? _buildLoadingWidget()
//               : errorMessage.isNotEmpty
//               ? _buildErrorWidget()
//               : _buildContent(),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Column(
//       children: [
//         _buildCustomHeader(),
//         Expanded(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(color: Color(0xFF1E88E5)),
//                 SizedBox(height: 20.h),
//                 Text(
//                   'جاري تحميل الدروس...',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     color: Color(0xFF1E88E5),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Column(
//       children: [
//         _buildCustomHeader(),
//         Expanded(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//                 SizedBox(height: 16.h),
//                 Text(
//                   errorMessage,
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.red[700],
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20.h),
//                 ElevatedButton(
//                   onPressed: _loadLessonsFromSupabase,
//                   child: Text(
//                     'إعادة المحاولة',
//                     style: TextStyle(fontFamily: 'Tajawal'),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF1E88E5),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.w),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContent() {
//     return CustomScrollView(
//       physics: const BouncingScrollPhysics(),
//       slivers: [
//         // ✅ التعديل: استخدام SliverAppBar للرأس الثابت
//         SliverAppBar(
//           backgroundColor: Color(0xFF1E88E5),
//           elevation: 0,
//           pinned: true,
//           expandedHeight: 200.h, // ارتفاع الصورة الممتد
//           flexibleSpace: FlexibleSpaceBar(
//             background: _buildSubjectHeader(),
//             title: Text(
//               widget.subjectName,
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ),
//         ),
//
//         // ✅ التعديل: جعل كامل المحتوى قابل للسكرول
//         SliverToBoxAdapter(
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1E88E5).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Text(
//                     '${lessons.length} درس',
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: Color(0xFF1E88E5),
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//                 Text(
//                   'دروس ${widget.subjectName}',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E293B),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         // ✅ التعديل: قائمة الدروس كاملة بالسكرول
//         lessons.isEmpty
//             ? SliverFillRemaining(
//           child: _buildEmptyState(),
//         )
//             : SliverList(
//           delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                 child: _AnimatedLessonCard(
//                   lesson: lessons[index],
//                   onTap: _navigateToLesson,
//                 ),
//               );
//             },
//             childCount: lessons.length,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ✅ إزالة الرأس المخصص القديم
//   Widget _buildCustomHeader() {
//     return Container(); // لم يعد مستخدم
//   }
//
//   Widget _buildSubjectHeader() {
//     return Container(
//       width: double.infinity,
//       height: 200.h,
//       child: Stack(
//         children: [
//           // صورة الخلفية
//           widget.subjectImageUrl.isNotEmpty
//               ? Image.network(
//             widget.subjectImageUrl,
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return _buildPlaceholderImage();
//             },
//             loadingBuilder: (context, child, loadingProgress) {
//               if (loadingProgress == null) return child;
//               return _buildImageLoader();
//             },
//           )
//               : _buildPlaceholderImage(),
//
//           // طبقة تدرج لوني
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [
//                   Colors.black.withOpacity(0.6),
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlaceholderImage() {
//     return Container(
//       color: Color(0xFF1E88E5),
//       child: Center(
//         child: Icon(
//           Icons.menu_book,
//           color: Colors.white,
//           size: 40.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageLoader() {
//     return Container(
//       color: Colors.grey[200],
//       child: Center(
//         child: CircularProgressIndicator(
//           color: Color(0xFF1E88E5),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.menu_book, size: 80.sp, color: Colors.grey),
//           SizedBox(height: 16.h),
//           Text(
//             'لا توجد دروس متاحة',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Colors.grey,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _AnimatedLessonCard extends StatefulWidget {
//   final Map<String, dynamic> lesson;
//   final Function(Map<String, dynamic>) onTap;
//
//   const _AnimatedLessonCard({
//     Key? key,
//     required this.lesson,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   __AnimatedLessonCardState createState() => __AnimatedLessonCardState();
// }
//
// class __AnimatedLessonCardState extends State<_AnimatedLessonCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _shadowAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.95,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//
//     _shadowAnimation = Tween<double>(
//       begin: 2.0,
//       end: 8.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _handleTap() {
//     _animationController.forward().then((_) {
//       _animationController.reverse();
//       widget.onTap(widget.lesson);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int orderNumber = widget.lesson['order_number'] ?? 1;
//     String lessonImage = widget.lesson['image_url'] ?? '';
//     bool hasVideo = widget.lesson['video_url'] != null &&
//         widget.lesson['video_url'].isNotEmpty;
//
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _scaleAnimation.value,
//           child: Container(
//             width: double.infinity,
//             height: 100.h,
//             child: Card(
//               elevation: _shadowAnimation.value,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.w),
//               ),
//               child: InkWell(
//                 onTap: _handleTap,
//                 borderRadius: BorderRadius.circular(16.w),
//                 highlightColor: Color(0xFF1E88E5).withOpacity(0.1),
//                 splashColor: Color(0xFF1E88E5).withOpacity(0.2),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1E88E5),
//                     borderRadius: BorderRadius.circular(16.w),
//                     border: Border.all(
//                       color: Color(0xFF1E88E5).withOpacity(0.3),
//                       width: 1.w,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       // ✅ التعديل: الجزء الأيمن (من جهة المستخدم) - صورة الدرس
//                       Container(
//                         width: 70.w,
//                         height: 70.w,
//                         margin: EdgeInsets.all(12.w),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12.w),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 6.w,
//                               offset: Offset(0, 2.h),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(12.w),
//                           child: lessonImage.isNotEmpty
//                               ? Image.network(
//                             lessonImage,
//                             width: double.infinity,
//                             height: double.infinity,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return _buildLessonPlaceholder();
//                             },
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return _buildLessonImageLoader();
//                             },
//                           )
//                               : _buildLessonPlaceholder(),
//                         ),
//                       ),
//
//                       // ✅ التعديل: الجزء الأوسط - عنوان الدرس
//                       Expanded(
//                         child: Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8.w),
//                             child: Text(
//                               widget.lesson['title'] ?? 'بدون عنوان',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // ✅ التعديل: الجزء الأيسر (من جهة التطبيق) - أيقونة التشغيل
//                       Padding(
//                         padding: EdgeInsets.only(right: 16.w, left: 12.w),
//                         child: Container(
//                           width: 44.w,
//                           height: 44.w,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 8.w,
//                                 offset: Offset(0, 2.h),
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: Container(
//                               width: 36.w,
//                               height: 36.w,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFFFA726),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.play_arrow,
//                                 color: Colors.white,
//                                 size: 20.sp,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildLessonPlaceholder() {
//     return Container(
//       color: Colors.grey[100],
//       child: Center(
//         child: Icon(
//           Icons.menu_book,
//           color: Color(0xFF1E88E5),
//           size: 24.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLessonImageLoader() {
//     return Container(
//       color: Colors.grey[100],
//       child: Center(
//         child: SizedBox(
//           width: 20.w,
//           height: 20.h,
//           child: CircularProgressIndicator(
//             strokeWidth: 2.w,
//             color: Color(0xFF1E88E5),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'lesson_detail_screen.dart';

class LessonsListScreen extends StatefulWidget {
  final String subjectImageUrl;
  final String subjectName;
  final String tableName; // ✅ اسم الجدول المرتبط بالمادة

  const LessonsListScreen({
    Key? key,
    required this.subjectImageUrl,
    required this.subjectName,
    required this.tableName, // ✅ إضافة الجدول كمعامل
  }) : super(key: key);

  @override
  _LessonsListScreenState createState() => _LessonsListScreenState();
}

class _LessonsListScreenState extends State<LessonsListScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> lessons = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadLessonsFromSupabase();
  }

  // ✅ التعديل: جلب الدروس من الجدول المحدد
  Future<void> _loadLessonsFromSupabase() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // ✅ استخدام الجدول الممر من الشاشة السابقة
      final response = await supabase
          .from(widget.tableName) // ✅ استخدام الجدول الديناميكي
          .select()
          .order('student_level') // ✅ ترتيب حسب المستوى الدراسي
          .timeout(Duration(seconds: 10));

      if (response != null && response.isNotEmpty) {
        if (mounted) {
          setState(() {
            lessons = List<Map<String, dynamic>>.from(response);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            errorMessage = 'لا توجد دروس متاحة لهذه المادة';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'خطأ في تحميل الدروس: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _navigateToLesson(Map<String, dynamic> lesson) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LessonDetailScreen(
          lesson: lesson,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E88E5),
          foregroundColor: Colors.white,
          title: Text(
            'دروس ${widget.subjectName}', // ✅ عرض اسم المادة في العنوان
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xFFF8FAFC),
          child: isLoading
              ? _buildLoadingWidget()
              : errorMessage.isNotEmpty
              ? _buildErrorWidget()
              : _buildContent(),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Column(
      children: [
        _buildSubjectHeader(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFF1E88E5)),
                SizedBox(height: 20.h),
                Text(
                  'جاري تحميل دروس ${widget.subjectName}...',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xFF1E88E5),
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Column(
      children: [
        _buildSubjectHeader(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
                SizedBox(height: 16.h),
                Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red[700],
                    fontFamily: 'Tajawal',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: _loadLessonsFromSupabase,
                  child: Text(
                    'إعادة المحاولة',
                    style: TextStyle(fontFamily: 'Tajawal'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Color(0xFF1E88E5),
          elevation: 0,
          pinned: true,
          expandedHeight: 200.h,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildSubjectHeader(),
            title: Text(
              widget.subjectName,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E88E5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${lessons.length} درس',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xFF1E88E5),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
                Text(
                  'دروس ${widget.subjectName}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        ),

        lessons.isEmpty
            ? SliverFillRemaining(
          child: _buildEmptyState(),
        )
            : SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: _AnimatedLessonCard(
                  lesson: lessons[index],
                  onTap: _navigateToLesson,
                ),
              );
            },
            childCount: lessons.length,
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectHeader() {
    return Container(
      width: double.infinity,
      height: 200.h,
      child: Stack(
        children: [
          widget.subjectImageUrl.isNotEmpty
              ? Image.network(
            widget.subjectImageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholderImage();
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return _buildImageLoader();
            },
          )
              : _buildPlaceholderImage(),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Color(0xFF1E88E5),
      child: Center(
        child: Icon(
          Icons.menu_book,
          color: Colors.white,
          size: 40.sp,
        ),
      ),
    );
  }

  Widget _buildImageLoader() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1E88E5),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book, size: 80.sp, color: Colors.grey),
          SizedBox(height: 16.h),
          Text(
            'لا توجد دروس متاحة ل${widget.subjectName}',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedLessonCard extends StatefulWidget {
  final Map<String, dynamic> lesson;
  final Function(Map<String, dynamic>) onTap;

  const _AnimatedLessonCard({
    Key? key,
    required this.lesson,
    required this.onTap,
  }) : super(key: key);

  @override
  __AnimatedLessonCardState createState() => __AnimatedLessonCardState();
}

class __AnimatedLessonCardState extends State<_AnimatedLessonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _shadowAnimation = Tween<double>(
      begin: 2.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
      widget.onTap(widget.lesson);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ التعديل: استخدام الحقول المناسبة من الجدول الجديد
    String lessonImage = widget.lesson['lesson_image'] ?? '';
    String lessonTitle = widget.lesson['lesson_title'] ?? 'بدون عنوان';
    int studentLevel = widget.lesson['student_level'] ?? 1;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: double.infinity,
            height: 100.h,
            child: Card(
              elevation: _shadowAnimation.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: InkWell(
                onTap: _handleTap,
                borderRadius: BorderRadius.circular(16.w),
                highlightColor: Color(0xFF1E88E5).withOpacity(0.1),
                splashColor: Color(0xFF1E88E5).withOpacity(0.2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1E88E5),
                    borderRadius: BorderRadius.circular(16.w),
                    border: Border.all(
                      color: Color(0xFF1E88E5).withOpacity(0.3),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      // صورة الدرس
                      Container(
                        width: 70.w,
                        height: 70.w,
                        margin: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.w),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6.w,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.w),
                          child: lessonImage.isNotEmpty
                              ? Image.network(
                            lessonImage,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildLessonPlaceholder();
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return _buildLessonImageLoader();
                            },
                          )
                              : _buildLessonPlaceholder(),
                        ),
                      ),

                      // عنوان الدرس والمستوى
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lessonTitle,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Tajawal',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'المستوى: $studentLevel',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12.sp,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // أيقونة التشغيل
                      Padding(
                        padding: EdgeInsets.only(right: 16.w, left: 12.w),
                        child: Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8.w,
                                offset: Offset(0, 2.h),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFA726),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
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
      },
    );
  }

  Widget _buildLessonPlaceholder() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Icon(
          Icons.menu_book,
          color: Color(0xFF1E88E5),
          size: 24.sp,
        ),
      ),
    );
  }

  Widget _buildLessonImageLoader() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: SizedBox(
          width: 20.w,
          height: 20.h,
          child: CircularProgressIndicator(
            strokeWidth: 2.w,
            color: Color(0xFF1E88E5),
          ),
        ),
      ),
    );
  }
}