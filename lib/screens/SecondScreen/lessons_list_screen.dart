import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Auth/auth_service.dart';
import 'lesson_detail_screen.dart';

class LessonsListScreen extends StatefulWidget {
  final String subjectImageUrl;
  final String subjectName;
  final String courseId; // ✅ التعديل: استخدام courseId بدلاً من tableName

  const LessonsListScreen({
    Key? key,
    required this.subjectImageUrl,
    required this.subjectName,
    required this.courseId, // ✅ التعديل: استخدام courseId
  }) : super(key: key);

  @override
  _LessonsListScreenState createState() => _LessonsListScreenState();
}

class _LessonsListScreenState extends State<LessonsListScreen> {
  List<Map<String, dynamic>> lessons = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadLessonsFromFirebase();
  }

  // ✅ التعديل: جلب الدروس من Firebase باستخدام courseId
  Future<void> _loadLessonsFromFirebase() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      // ✅ استخدام courseId لجلب الدروس من Subcollection
      final lessonsData = await authService.getLessonsForCourse(widget.courseId);

      if (lessonsData != null && lessonsData.isNotEmpty) {
        if (mounted) {
          setState(() {
            lessons = lessonsData;
          });
        }
        print('✅ تم تحميل ${lessons.length} درس بنجاح');
      } else {
        if (mounted) {
          setState(() {
            errorMessage = 'لا توجد دروس متاحة لهذه المادة حالياً';
          });
        }
        print('⚠️ لا توجد دروس للكورس: ${widget.courseId}');
      }
    } catch (e) {
      print('❌ خطأ في تحميل الدروس: $e');
      if (mounted) {
        setState(() {
          errorMessage = 'خطأ في تحميل الدروس: ${e.toString()}';
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
        backgroundColor: Color(0xFFF8FAFC),
        body: isLoading
            ? _buildLoadingWidget()
            : errorMessage.isNotEmpty
            ? _buildErrorWidget()
            : _buildContent(),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Column(
      children: [
        _buildCustomAppBar(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF1E88E5),
                  strokeWidth: 3.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  'جاري تحميل دروس ${widget.subjectName}...',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xFF1E88E5),
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'يرجى الانتظار',
                  style: TextStyle(
                    fontSize: 14.sp,
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
        _buildCustomAppBar(),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEF2F2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: 60.sp,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'حدث خطأ',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0xFF1E293B),
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF64748B),
                      fontFamily: 'Tajawal',
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton(
                    onPressed: _loadLessonsFromFirebase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 16.h,
                      ),
                    ),
                    child: Text(
                      'إعادة المحاولة',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
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
        // ✅ شريط التطبيق الممتد مع الصورة
        SliverAppBar(
          backgroundColor: Color(0xFF1E88E5),
          elevation: 0,
          pinned: true,
          expandedHeight: 220.h,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildSubjectHeader(),
            titlePadding: EdgeInsets.only(bottom: 16.h, right: 16.w),
            title: Text(
              widget.subjectName,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
                color: Colors.white,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        // ✅ قسم معلومات الدروس
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // عدد الدروس
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E88E5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color(0xFF1E88E5).withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        color: Color(0xFF1E88E5),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${lessons.length}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xFF1E88E5),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'درس',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFF1E88E5),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ],
                  ),
                ),

                // عنوان القسم
                Text(
                  'دروس ${widget.subjectName}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        ),

        // ✅ قائمة الدروس
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
                  index: index,
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

  Widget _buildCustomAppBar() {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: Color(0xFF1E88E5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.w),
          bottomRight: Radius.circular(20.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.w,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'دروس ${widget.subjectName}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Tajawal',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isLoading && errorMessage.isEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${lessons.length}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectHeader() {
    return Container(
      width: double.infinity,
      height: 220.h,
      child: Stack(
        children: [
          // صورة الخلفية
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

          // طبقة تدرج لوني
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // معلومات المادة
          Positioned(
            bottom: 20.h,
            right: 16.w,
            left: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.subjectName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '${lessons.length} درس تعليمي متاح',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16.sp,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 50.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              widget.subjectName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageLoader() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF1E88E5),
            ),
            SizedBox(height: 16.h),
            Text(
              'جاري تحميل الصورة...',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        _buildCustomAppBar(),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      size: 70.sp,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'لا توجد دروس متاحة',
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Color(0xFF1E293B),
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'سيتم إضافة الدروس قريباً ل${widget.subjectName}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF64748B),
                      fontFamily: 'Tajawal',
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton(
                    onPressed: _loadLessonsFromFirebase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 16.h,
                      ),
                    ),
                    child: Text(
                      'تحديث',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
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
}

class _AnimatedLessonCard extends StatefulWidget {
  final Map<String, dynamic> lesson;
  final int index;
  final Function(Map<String, dynamic>) onTap;

  const _AnimatedLessonCard({
    Key? key,
    required this.lesson,
    required this.index,
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
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
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

    _colorAnimation = ColorTween(
      begin: Color(0xFF1E88E5),
      end: Color(0xFF1565C0),
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
    // ✅ استخدام الحقول المناسبة من الهيكل الجديد
    String lessonImage = widget.lesson['lesson_image'] ?? '';
    String lessonTitle = widget.lesson['lesson_title'] ?? 'بدون عنوان';
    int orderIndex = widget.lesson['order_index'] ?? (widget.index + 1);
    bool hasVideo = (widget.lesson['video_url'] ?? '').isNotEmpty;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            height: 120.h,
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
                    borderRadius: BorderRadius.circular(16.w),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _colorAnimation.value ?? Color(0xFF1E88E5),
                        Color(0xFF1565C0),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF1E88E5).withOpacity(0.3),
                        blurRadius: 10.w,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // صورة الدرس
                      Container(
                        width: 100.w,
                        height: 100.w,
                        margin: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.w),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8.w,
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

                      // معلومات الدرس
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // عنوان الدرس
                              Text(
                                lessonTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.h),

                              // معلومات إضافية
                              Row(
                                children: [
                                  // رقم الدرس
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'الدرس ${orderIndex}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Tajawal',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),

                                  // أيقونة الفيديو
                                  if (hasVideo)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.play_circle_fill_rounded,
                                          color: Color(0xFFFFA726),
                                          size: 16.sp,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          'فيديو',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.9),
                                            fontSize: 12.sp,
                                            fontFamily: 'Tajawal',
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // أيقونة التشغيل
                      Padding(
                        padding: EdgeInsets.only(left: 12.w, right: 16.w),
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10.w,
                                offset: Offset(0, 4.h),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFA726),
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFA726),
                                    Color(0xFFF57C00),
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.play_arrow_rounded,
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
      color: Color(0xFFE3F2FD),
      child: Center(
        child: Icon(
          Icons.menu_book_rounded,
          color: Color(0xFF1E88E5),
          size: 32.sp,
        ),
      ),
    );
  }

  Widget _buildLessonImageLoader() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: SizedBox(
          width: 24.w,
          height: 24.h,
          child: CircularProgressIndicator(
            strokeWidth: 2.5.w,
            color: Color(0xFF1E88E5),
          ),
        ),
      ),
    );
  }
}