// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../Auth/auth_service.dart';
// import 'lesson_detail_screen.dart';
//
// class LessonsListScreen extends StatefulWidget {
//   final String subjectImageUrl;
//   final String subjectName;
//   final String courseId;
//
//   const LessonsListScreen({
//     Key? key,
//     required this.subjectImageUrl,
//     required this.subjectName,
//     required this.courseId,
//   }) : super(key: key);
//
//   @override
//   _LessonsListScreenState createState() => _LessonsListScreenState();
// }
//
// class _LessonsListScreenState extends State<LessonsListScreen> {
//   List<Map<String, dynamic>> _lessons = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLessons();
//   }
//
//   Future<void> _loadLessons() async {
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final authService = Provider.of<AuthService>(context, listen: false);
//       final lessonsData = await authService.getLessonsForCourse(widget.courseId);
//
//       if (mounted) {
//         setState(() {
//           _lessons = lessonsData ?? [];
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _errorMessage = 'حدث خطأ في تحميل الدروس';
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
//   void _navigateToLesson(Map<String, dynamic> lesson) {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => LessonDetailScreen(
//           lesson: lesson,
//           courseId: widget.courseId,
//           subjectName: widget.subjectName,
//         ),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.easeInOut;
//
//           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);
//
//           return SlideTransition(
//             position: offsetAnimation,
//             child: child,
//           );
//         },
//         transitionDuration: Duration(milliseconds: 300),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Color(0xFFF8FAFC),
//         body: _isLoading
//             ? _buildLoadingWidget()
//             : _errorMessage.isNotEmpty
//             ? _buildErrorWidget()
//             : _buildContent(),
//       ),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Column(
//       children: [
//         _buildAppBar(),
//         Expanded(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(
//                   color: Color(0xFF1E88E5),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'جاري تحميل الدروس...',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Color(0xFF64748B),
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
//         _buildAppBar(),
//         Expanded(
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.all(24.w),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.error_outline_rounded,
//                     size: 64.sp,
//                     color: Color(0xFFDC2626),
//                   ),
//                   SizedBox(height: 16.h),
//                   Text(
//                     'حدث خطأ',
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       color: Color(0xFF1E293B),
//                       fontFamily: 'Tajawal',
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     _errorMessage,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Color(0xFF64748B),
//                       fontFamily: 'Tajawal',
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 24.h),
//                   ElevatedButton(
//                     onPressed: _loadLessons,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF1E88E5),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 24.w,
//                         vertical: 12.h,
//                       ),
//                     ),
//                     child: Text(
//                       'إعادة المحاولة',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
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
//         SliverAppBar(
//           backgroundColor: Color(0xFF1E88E5),
//           elevation: 0,
//           pinned: true,
//           expandedHeight: 200.h,
//           flexibleSpace: FlexibleSpaceBar(
//             background: _buildHeaderImage(),
//             title: Text(
//               widget.subjectName,
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'دروس ${widget.subjectName}',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E293B),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1E88E5).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                   child: Text(
//                     '${_lessons.length} درس',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Color(0xFF1E88E5),
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         _lessons.isEmpty
//             ? SliverFillRemaining(
//           child: _buildEmptyState(),
//         )
//             : SliverList(
//           delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                 child: _LessonCard(
//                   lesson: _lessons[index],
//                   index: index,
//                   onTap: _navigateToLesson,
//                 ),
//               );
//             },
//             childCount: _lessons.length,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Color(0xFF1E88E5),
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//       title: Text(
//         'دروس ${widget.subjectName}',
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeaderImage() {
//     return widget.subjectImageUrl.isNotEmpty
//         ? Image.network(
//       widget.subjectImageUrl,
//       width: double.infinity,
//       height: double.infinity,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) {
//         return _buildPlaceholderHeader();
//       },
//     )
//         : _buildPlaceholderHeader();
//   }
//
//   Widget _buildPlaceholderHeader() {
//     return Container(
//       color: Color(0xFF1E88E5),
//       child: Center(
//         child: Icon(
//           Icons.menu_book_rounded,
//           color: Colors.white,
//           size: 50.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.menu_book_rounded,
//           size: 80.sp,
//           color: Color(0xFF94A3B8),
//         ),
//         SizedBox(height: 16.h),
//         Text(
//           'لا توجد دروس متاحة',
//           style: TextStyle(
//             fontSize: 18.sp,
//             color: Color(0xFF1E293B),
//             fontFamily: 'Tajawal',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           'سيتم إضافة الدروس قريباً',
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Color(0xFF64748B),
//             fontFamily: 'Tajawal',
//           ),
//         ),
//         SizedBox(height: 24.h),
//         ElevatedButton(
//           onPressed: _loadLessons,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFF1E88E5),
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.w),
//             ),
//           ),
//           child: Text('تحديث'),
//         ),
//       ],
//     );
//   }
// }
//
// class _LessonCard extends StatelessWidget {
//   final Map<String, dynamic> lesson;
//   final int index;
//   final Function(Map<String, dynamic>) onTap;
//
//   const _LessonCard({
//     Key? key,
//     required this.lesson,
//     required this.index,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final String lessonImage = lesson['lesson_image'] ?? '';
//     final String lessonTitle = lesson['lesson_title'] ?? 'بدون عنوان';
//     final int orderIndex = lesson['order_index'] ?? (index + 1);
//     final bool hasVideo = (lesson['video_url'] ?? '').isNotEmpty;
//     final bool isActive = lesson['is_active'] ?? true;
//
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.w),
//       ),
//       child: InkWell(
//         onTap: isActive ? () => onTap(lesson) : null,
//         borderRadius: BorderRadius.circular(12.w),
//         child: Container(
//           padding: EdgeInsets.all(16.w),
//           child: Row(
//             children: [
//               // صورة الدرس
//               Container(
//                 width: 80.w,
//                 height: 80.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.w),
//                   color: Color(0xFFF1F5F9),
//                 ),
//                 child: lessonImage.isNotEmpty
//                     ? ClipRRect(
//                   borderRadius: BorderRadius.circular(8.w),
//                   child: Image.network(
//                     lessonImage,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return _buildImagePlaceholder();
//                     },
//                   ),
//                 )
//                     : _buildImagePlaceholder(),
//               ),
//
//               SizedBox(width: 16.w),
//
//               // معلومات الدرس
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       lessonTitle,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1E293B),
//                         fontFamily: 'Tajawal',
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: 8.h),
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 8.w,
//                             vertical: 4.h,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Color(0xFF1E88E5).withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(6.r),
//                           ),
//                           child: Text(
//                             'الدرس $orderIndex',
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: Color(0xFF1E88E5),
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ),
//                         if (hasVideo && isActive) ...[
//                           SizedBox(width: 8.w),
//                           Icon(
//                             Icons.play_circle_fill_rounded,
//                             color: Color(0xFF10B981),
//                             size: 16.sp,
//                           ),
//                         ],
//                         if (!isActive) ...[
//                           SizedBox(width: 8.w),
//                           Icon(
//                             Icons.lock_rounded,
//                             color: Color(0xFF94A3B8),
//                             size: 16.sp,
//                           ),
//                         ],
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               // أيقونة التشغيل
//               Container(
//                 width: 40.w,
//                 height: 40.w,
//                 decoration: BoxDecoration(
//                   color: isActive ? Color(0xFF1E88E5) : Color(0xFF94A3B8),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   isActive ? Icons.play_arrow_rounded : Icons.lock_rounded,
//                   color: Colors.white,
//                   size: 20.sp,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImagePlaceholder() {
//     return Center(
//       child: Icon(
//         Icons.menu_book_rounded,
//         color: Color(0xFF94A3B8),
//         size: 24.sp,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Auth/auth_service.dart';
import 'lesson_detail_screen.dart';

class LessonsListScreen extends StatefulWidget {
  final String subjectImageUrl;
  final String subjectName;
  final String courseId;

  const LessonsListScreen({
    Key? key,
    required this.subjectImageUrl,
    required this.subjectName,
    required this.courseId,
  }) : super(key: key);

  @override
  _LessonsListScreenState createState() => _LessonsListScreenState();
}

class _LessonsListScreenState extends State<LessonsListScreen> {
  List<Map<String, dynamic>> _lessons = [];
  bool _isLoading = true;
  String _errorMessage = '';
  final Color _primaryBlue = const Color(0xFF1E88E5);
  final Color _accentColor = const Color(0xFFFFA726);

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final lessonsData = await authService.getLessonsForCourse(widget.courseId);

      if (mounted) {
        setState(() {
          _lessons = lessonsData ?? [];
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'حدث خطأ في تحميل الدروس';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
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
          courseId: widget.courseId,
          subjectName: widget.subjectName,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        body: _isLoading
            ? _buildLoadingWidget()
            : _errorMessage.isNotEmpty
            ? _buildErrorWidget()
            : _buildContent(),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Column(
      children: [
        _buildAppBar(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: _primaryBlue,
                ),
                SizedBox(height: 16.h),
                Text(
                  'جاري تحميل الدروس...',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF64748B),
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
        _buildAppBar(),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 64.sp,
                    color: Color(0xFFDC2626),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'حدث خطأ',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Color(0xFF1E293B),
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _errorMessage,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xFF64748B),
                      fontFamily: 'Tajawal',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: _loadLessons,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      'إعادة المحاولة',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                ],
              ),
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
        // AppBar ثابت بالأزرق الأساسي
        SliverAppBar(
          backgroundColor: _primaryBlue,
          elevation: 0,
          pinned: true,
          expandedHeight: 0, // إزالة المساحة الممتدة
          toolbarHeight: 80.h, // ارتفاع مناسب للأب بار
          title: Text(
            widget.subjectName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: Colors.white,
            ),
          ),
          centerTitle: true, // جعل العنوان في المنتصف
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        // صورة المادة
        SliverToBoxAdapter(
          child: Container(
            height: 180.h,
            width: double.infinity,
            child: widget.subjectImageUrl.isNotEmpty
                ? Image.network(
              widget.subjectImageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholderHeader();
              },
            )
                : _buildPlaceholderHeader(),
          ),
        ),

        // معلومات عدد الدروس
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'دروس ${widget.subjectName}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    fontFamily: 'Tajawal',
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: _primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${_lessons.length} درس',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: _primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // قائمة الدروس
        _lessons.isEmpty
            ? SliverFillRemaining(
          child: _buildEmptyState(),
        )
            : SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: _LessonCard(
                  lesson: _lessons[index],
                  index: index,
                  onTap: _navigateToLesson,
                  primaryBlue: _primaryBlue,
                  accentColor: _accentColor,
                ),
              );
            },
            childCount: _lessons.length,
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: _primaryBlue,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        widget.subjectName,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal',
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildPlaceholderHeader() {
    return Container(
      color: _primaryBlue.withOpacity(0.1),
      child: Center(
        child: Icon(
          Icons.menu_book_rounded,
          color: _primaryBlue,
          size: 50.sp,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu_book_rounded,
          size: 80.sp,
          color: Color(0xFF94A3B8),
        ),
        SizedBox(height: 16.h),
        Text(
          'لا توجد دروس متاحة',
          style: TextStyle(
            fontSize: 18.sp,
            color: Color(0xFF1E293B),
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'سيتم إضافة الدروس قريباً',
          style: TextStyle(
            fontSize: 14.sp,
            color: Color(0xFF64748B),
            fontFamily: 'Tajawal',
          ),
        ),
        SizedBox(height: 24.h),
        ElevatedButton(
          onPressed: _loadLessons,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.w),
            ),
          ),
          child: Text('تحديث'),
        ),
      ],
    );
  }
}

class _LessonCard extends StatelessWidget {
  final Map<String, dynamic> lesson;
  final int index;
  final Function(Map<String, dynamic>) onTap;
  final Color primaryBlue;
  final Color accentColor;

  const _LessonCard({
    Key? key,
    required this.lesson,
    required this.index,
    required this.onTap,
    required this.primaryBlue,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String lessonImage = lesson['lesson_image'] ?? '';
    final String lessonTitle = lesson['lesson_title'] ?? 'بدون عنوان';
    final int orderIndex = lesson['order_index'] ?? (index + 1);
    final bool hasVideo = (lesson['video_url'] ?? '').isNotEmpty;
    final bool isActive = lesson['is_active'] ?? true;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryBlue,
              Color(0xFF1565C0),
            ],
          ),
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: InkWell(
          onTap: isActive ? () => onTap(lesson) : null,
          borderRadius: BorderRadius.circular(12.w),
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // صورة الدرس مع خلفية بيضاء
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: lessonImage.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.w),
                    child: Image.network(
                      lessonImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildImagePlaceholder();
                      },
                    ),
                  )
                      : _buildImagePlaceholder(),
                ),

                SizedBox(width: 16.w),

                // معلومات الدرس
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lessonTitle,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // نص أبيض
                          fontFamily: 'Tajawal',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'الدرس $orderIndex',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white, // نص أبيض
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                          if (hasVideo && isActive) ...[
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.play_circle_fill_rounded,
                              color: accentColor, // استخدام اللون البرتقالي
                              size: 16.sp,
                            ),
                          ],
                          if (!isActive) ...[
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.lock_rounded,
                              color: Colors.white.withOpacity(0.7),
                              size: 16.sp,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // أيقونة التشغيل
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isActive ? Icons.play_arrow_rounded : Icons.lock_rounded,
                    color: isActive ? primaryBlue : Colors.grey,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Center(
      child: Icon(
        Icons.menu_book_rounded,
        color: primaryBlue,
        size: 24.sp,
      ),
    );
  }
}