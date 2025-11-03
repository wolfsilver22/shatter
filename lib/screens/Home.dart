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

  final Color _primaryBlue = const Color(0xFF1E88E5);
  final Color _secondaryColor = const Color(0xFFF5F9FF);
  final Color _accentColor = const Color(0xFFFFA726);
  final Color _textPrimary = const Color(0xFF2D3748);
  final Color _textSecondary = const Color(0xFF718096);

  List<Map<String, dynamic>> _courses = [];
  bool _isLoading = true;
  String _errorMessage = '';
  bool _hasNetworkError = false;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          _hasNetworkError = true;
          _isLoading = false;
        });
        return;
      }

      final authService = Provider.of<AuthService>(context, listen: false);

      if (authService.selectedGrade == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'لم يتم تحديد الصف الدراسي';
        });
        return;
      }

      final courses = await authService.getCoursesForCurrentGrade();

      if (mounted) {
        setState(() {
          _courses = courses ?? [];
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasNetworkError = true;
          _errorMessage = 'حدث خطأ في تحميل المواد';
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

  void _showNetworkErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'مشكلة في الاتصال',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
          ),
        ),
        content: Text(
          'يرجى التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Tajawal',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('حسناً', style: TextStyle(fontFamily: 'Tajawal')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loadCourses();
            },
            child: Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Tajawal')),
          ),
        ],
      ),
    );
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
    final authService = Provider.of<AuthService>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _secondaryColor,
        body: RefreshIndicator(
          onRefresh: _loadCourses,
          color: _primaryBlue,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: _primaryBlue,
                expandedHeight: 180.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/images/shater.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: _primaryBlue,
                        child: Icon(
                          Icons.school_rounded,
                          size: 60.sp,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  title: Text(
                    'المواد الدراسية',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: _buildStudentInfo(authService),
              ),

              _isLoading
                  ? SliverToBoxAdapter(child: _buildLoadingWidget())
                  : _errorMessage.isNotEmpty && !_hasNetworkError
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

  Widget _buildStudentInfo(AuthService authService) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Icon(Icons.school_rounded, color: _primaryBlue),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المواد المخصصة لصفك',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _getGradeText(authService.selectedGrade),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _textSecondary,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _primaryBlue,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '${_courses.length}',
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
            ElevatedButton(
              onPressed: _loadCourses,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                foregroundColor: Colors.white,
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
        childAspectRatio: 0.8,
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

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () => _navigateToLessons(course),
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholderImage();
                  },
                )
                    : _buildPlaceholderImage(),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.w),
              child: Text(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: _primaryBlue.withOpacity(0.1),
      child: Center(
        child: Icon(
          Icons.menu_book_rounded,
          color: _primaryBlue,
          size: 40.sp,
        ),
      ),
    );
  }
}