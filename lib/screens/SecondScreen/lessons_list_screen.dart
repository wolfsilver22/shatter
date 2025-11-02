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
  bool _hasData = false;

  @override
  void initState() {
    super.initState();
    _loadLessonsFromFirebase();
  }

  // ✅ دالة محسنة لجلب الدروس من Firebase
  Future<void> _loadLessonsFromFirebase() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _hasData = false;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      print('🎯 بدء جلب الدروس للكورس: ${widget.courseId}');
      print('📝 اسم المادة: ${widget.subjectName}');

      // ✅ استخدام courseId لجلب الدروس من Subcollection
      final lessonsData = await authService.getLessonsForCourse(widget.courseId);

      if (lessonsData != null && lessonsData.isNotEmpty) {
        print('✅ تم تحميل ${lessonsData.length} درس بنجاح للكورس: ${widget.courseId}');

        if (mounted) {
          setState(() {
            _lessons = lessonsData;
            _hasData = true;
          });
        }

        // ✅ طباعة بيانات الدروس للتشخيص
        _debugLessonsData(lessonsData);
      } else {
        print('⚠️ لا توجد دروس للكورس: ${widget.courseId}');
        if (mounted) {
          setState(() {
            _errorMessage = 'لا توجد دروس متاحة لـ ${widget.subjectName} حالياً';
            _hasData = false;
          });
        }
      }
    } catch (e) {
      print('❌ خطأ في تحميل الدروس: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'خطأ في تحميل الدروس: ${e.toString()}';
          _hasData = false;
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

  // ✅ دالة تشخيصية لفحص بيانات الدروس
  void _debugLessonsData(List<Map<String, dynamic>> lessons) {
    print('🔍 فحص بيانات الدروس المستلمة:');
    for (int i = 0; i < lessons.length; i++) {
      final lesson = lessons[i];
      print('''
📖 درس ${i + 1}:
- ID: ${lesson['id']}
- العنوان: ${lesson['lesson_title']}
- الصورة: ${lesson['lesson_image']}
- الفيديو: ${lesson['video_url']?.isNotEmpty == true ? 'موجود' : 'غير موجود'}
- الترتيب: ${lesson['order_index']}
- نشط: ${lesson['is_active']}
---''');
    }
  }

  void _navigateToLesson(Map<String, dynamic> lesson) {
    print('🎯 الانتقال إلى درس: ${lesson['lesson_title']}');

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
        body: _isLoading
            ? _buildLoadingWidget()
            : _errorMessage.isNotEmpty && !_hasData
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
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF1E88E5),
                          strokeWidth: 3.w,
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.menu_book_rounded,
                          color: Color(0xFF1E88E5),
                          size: 30.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'جاري تحميل دروس ${widget.subjectName}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xFF1E293B),
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'يرجى الانتظار...',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF64748B),
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 16.h),
                LinearProgressIndicator(
                  backgroundColor: Color(0xFFE2E8F0),
                  color: Color(0xFF1E88E5),
                  minHeight: 4.h,
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
                    _errorMessage,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF64748B),
                      fontFamily: 'Tajawal',
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'الكورس ID: ${widget.courseId}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xFF94A3B8),
                      fontFamily: 'Tajawal',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            horizontal: 24.w,
                            vertical: 14.h,
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
                      SizedBox(width: 12.w),
                      OutlinedButton(
                        onPressed: () {
                          final authService = Provider.of<AuthService>(context, listen: false);
                          authService.debugDataTypes();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xFF64748B),
                          side: BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 14.h,
                          ),
                        ),
                        child: Text(
                          'تشخيص',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                    ],
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
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                widget.subjectName,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  color: Colors.white,
                ),
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24.sp),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(left: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${_lessons.length} درس',
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

        // ✅ قسم معلومات الدروس
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        '${_lessons.length}',
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
              ],
            ),
          ),
        ),

        // ✅ قائمة الدروس
        _lessons.isEmpty
            ? SliverFillRemaining(
          child: _buildEmptyState(),
        )
            : SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: _AnimatedLessonCard(
                  lesson: _lessons[index],
                  index: index,
                  onTap: _navigateToLesson,
                ),
              );
            },
            childCount: _lessons.length,
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
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                    SizedBox(height: 4.h),
                    Text(
                      '${_lessons.length} درس متاح',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
              if (_hasData)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${_lessons.length}',
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
                  '${_lessons.length} درس تعليمي متاح',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16.sp,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'الكورس ID: ${widget.courseId}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12.sp,
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
            SizedBox(height: 4.h),
            Text(
              '${_lessons.length} درس',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14.sp,
                fontFamily: 'Tajawal',
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
                    'سيتم إضافة الدروس قريباً لـ ${widget.subjectName}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF64748B),
                      fontFamily: 'Tajawal',
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'الكورس ID: ${widget.courseId}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xFF94A3B8),
                      fontFamily: 'Tajawal',
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
    bool isActive = widget.lesson['is_active'] ?? true;

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
                onTap: isActive ? _handleTap : null,
                borderRadius: BorderRadius.circular(16.w),
                highlightColor: Color(0xFF1E88E5).withOpacity(0.1),
                splashColor: Color(0xFF1E88E5).withOpacity(0.2),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.w),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isActive
                          ? [
                        _colorAnimation.value ?? Color(0xFF1E88E5),
                        Color(0xFF1565C0),
                      ]
                          : [
                        Color(0xFF94A3B8),
                        Color(0xFF64748B),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isActive ? Color(0xFF1E88E5) : Color(0xFF94A3B8)).withOpacity(0.3),
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
                                  if (hasVideo && isActive)
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

                                  // حالة النشاط
                                  if (!isActive)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.lock_rounded,
                                          color: Colors.white.withOpacity(0.7),
                                          size: 14.sp,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          'غير مفعل',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
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
                                color: isActive ? Color(0xFFFFA726) : Color(0xFF94A3B8),
                                shape: BoxShape.circle,
                                gradient: isActive
                                    ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFA726),
                                    Color(0xFFF57C00),
                                  ],
                                )
                                    : LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF94A3B8),
                                    Color(0xFF64748B),
                                  ],
                                ),
                              ),
                              child: Icon(
                                isActive ? Icons.play_arrow_rounded : Icons.lock_rounded,
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