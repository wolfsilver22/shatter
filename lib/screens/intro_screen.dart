import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Auth/auth_service.dart';
import '../widget/NavigationBar.dart';
import '../Auth/login_screen.dart';
import '../widget/AnimatedBackground.dart'; // أضف هذا الاستيراد

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _isImageLoaded = false;
  bool _imageError = false;
  bool _isCheckingAuth = true;

  @override
  void initState() {
    super.initState();
    _preloadImage();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    await Future.delayed(Duration(milliseconds: 800));

    if (mounted) {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (authService.isLoggedIn) {
        _navigateToHome();
        return;
      }
      setState(() {
        _isCheckingAuth = false;
      });
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _continueAsGuest(BuildContext context) {
    _navigateToHome();
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainNavigation()),
    );
  }

  void _preloadImage() {
    precacheImage(const AssetImage('assets/images/logo.png'), context)
        .then((_) {
      if (mounted) {
        setState(() {
          _isImageLoaded = true;
          _imageError = false;
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _isImageLoaded = true;
          _imageError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingAuth) {
      return _buildLoadingScreen();
    }

    // استخدم AnimatedBackground هنا
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // جعل الخلفية شفافة
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // صورة الشعار بشكل احترافي
                  _buildLogoSection(),

                  SizedBox(height: 40.h),

                  // العنوان مع خلفية شفافة
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20.w,
                          offset: Offset(0, 10.h),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'أبدأ رحلتك نحو التفوق الان',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E88E5),
                            fontFamily: 'Tajawal',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                      ],
                    ),
                  ),

                  SizedBox(height: 60.h),

                  // زر تسجيل الدخول مع خلفية شفافة
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15.w,
                          offset: Offset(0, 5.h),
                        ),
                      ],
                    ),
                    child: _buildLoginButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(30.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(25.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 25.w,
                  offset: Offset(0, 10.h),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1E88E5).withOpacity(0.1),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.w,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'جاري التحميل...',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF1E88E5),
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // باقي الدوال تبقى كما هي بدون تغيير
  Widget _buildLogoSection() {
    return Container(
      width: 200.w,
      height: 200.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 30.w,
            spreadRadius: 3.w,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          // خلفية دائرية متدرجة
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
              ),
            ),
          ),

          // صورة الشعار
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 160.w,
              height: 160.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 5.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15.w,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: ClipOval(
                child: _buildLogoImage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoImage() {
    if (!_isImageLoaded) {
      return _buildLoadingState();
    }

    if (_imageError) {
      return _buildErrorState();
    }

    return Image.asset(
      'assets/images/logo.png',
      width: 160.w,
      height: 160.h,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorState();
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
      ),
      child: Center(
        child: SizedBox(
          width: 35.w,
          height: 35.h,
          child: CircularProgressIndicator(
            strokeWidth: 2.5.w,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E88E5),
            Color(0xFF64B5F6),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.menu_book_rounded,
          color: Colors.white,
          size: 60.sp,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _navigateToLogin(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1E88E5),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.login_rounded,
              size: 22.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'تسجيل الدخول',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFeatureItem('دروس تفاعلية', Icons.play_lesson_rounded),
              _buildFeatureItem('تمارين ممتعة', Icons.games_rounded),
              _buildFeatureItem('تتبع التقدم', Icons.analytics_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFF1E88E5).withOpacity(0.3),
              width: 1.5.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.w,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Color(0xFF1E88E5),
            size: 28.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[700],
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
