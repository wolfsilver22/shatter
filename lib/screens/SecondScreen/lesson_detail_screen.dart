import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'lesson_detail_screen.dart';

class LessonsListScreen extends StatefulWidget {
  final String subjectImageUrl;
  final String subjectName;

  const LessonsListScreen({
    Key? key,
    required this.subjectImageUrl,
    required this.subjectName,
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

  Future<void> _loadLessonsFromSupabase() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await supabase
          .from('lessons')
          .select()
          .order('order_number');

      if (response != null && response.isNotEmpty) {
        if (mounted) {
          setState(() {
            lessons = List<Map<String, dynamic>>.from(response);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            errorMessage = 'لا توجد دروس متاحة';
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
        pageBuilder: (context, animation, secondaryAnimation) => LessonDetailScreen(lesson: lesson),
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
        _buildCustomHeader(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFF1E88E5)),
                SizedBox(height: 20.h),
                Text(
                  'جاري تحميل الدروس...',
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
        _buildCustomHeader(),
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
        // ✅ التعديل: استخدام SliverAppBar للرأس الثابت
        SliverAppBar(
          backgroundColor: Color(0xFF1E88E5),
          elevation: 0,
          pinned: true,
          expandedHeight: 200.h, // ارتفاع الصورة الممتد
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
            centerTitle: true,
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ),

        // ✅ التعديل: جعل كامل المحتوى قابل للسكرول
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

        // ✅ التعديل: قائمة الدروس كاملة بالسكرول
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

  // ✅ إزالة الرأس المخصص القديم
  Widget _buildCustomHeader() {
    return Container(); // لم يعد مستخدم
  }

  Widget _buildSubjectHeader() {
    return Container(
      width: double.infinity,
      height: 200.h,
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
            'لا توجد دروس متاحة',
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
    int orderNumber = widget.lesson['order_number'] ?? 1;
    String lessonImage = widget.lesson['image_url'] ?? '';
    bool hasVideo = widget.lesson['video_url'] != null &&
        widget.lesson['video_url'].isNotEmpty;

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
                      // ✅ التعديل: الجزء الأيمن (من جهة المستخدم) - صورة الدرس
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

                      // ✅ التعديل: الجزء الأوسط - عنوان الدرس
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              widget.lesson['title'] ?? 'بدون عنوان',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      // ✅ التعديل: الجزء الأيسر (من جهة التطبيق) - أيقونة التشغيل
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
