import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Auth/auth_service.dart';
import '../widget/NavigationBar.dart';
import '../Auth/login_screen.dart';
import '../widget/AnimatedBackground.dart';

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

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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

                  // المراحل العمودية الاحترافية
                  _buildStagesSection(),

                  SizedBox(height: 40.h),

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

  Widget _buildStagesSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 25.w,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'رحلة التفوق في 3 مراحل',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E88E5),
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'ابدأ رحلة التعلم الممتعة نحو التفوق',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 24.h),

          // المراحل العمودية
          _buildVerticalStages(),
        ],
      ),
    );
  }

  Widget _buildVerticalStages() {
    final List<Stage> stages = [
      Stage(
        number: 1,
        title: 'دروس بسيطة ومفهومة',
        description: 'تعلم بأسلوب مبسط وسهل الفهم',
        icon: Icons.menu_book_rounded,
        color: Color(0xFFFFA726),
      ),
      Stage(
        number: 2,
        title: 'تمارين تفاعلية',
        description: 'طبق ما تعلمته بتمارين ممتعة',
        icon: Icons.games_rounded,
        color: Color(0xFFFFA726),
      ),
      Stage(
        number: 3,
        title: 'مبروك أنت شاطر',
        description: 'احصل على شهادتك وتقدم للصف التالي',
        icon: Icons.celebration_rounded,
        color: Color(0xFFFFA726),
      ),
    ];

    return Column(
      children: stages.asMap().entries.map((entry) {
        final index = entry.key;
        final stage = entry.value;
        final isLast = index == stages.length - 1;

        return Column(
          children: [
            _buildStageItem(stage, index),
            if (!isLast) _buildConnectorLine(),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildStageItem(Stage stage, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الدائرة المرقمة
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: stage.color.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: stage.color,
                width: 2.5.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: stage.color.withOpacity(0.3),
                  blurRadius: 10.w,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // الرقم
                Text(
                  '${stage.number}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: stage.color,
                    fontFamily: 'Tajawal',
                  ),
                ),
                // تأثير دائري متحرك
                _buildPulseAnimation(stage.color),
              ],
            ),
          ),

          SizedBox(width: 16.w),

          // المحتوى
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8.w,
                    offset: Offset(0, 3.h),
                  ),
                ],
                border: Border.all(
                  color: stage.color.withOpacity(0.2),
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  // الأيقونة
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: stage.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      stage.icon,
                      color: stage.color,
                      size: 22.sp,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // النصوص
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stage.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          stage.description,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // سهم المؤشر
                  Icon(
                    Icons.arrow_left_rounded,
                    color: stage.color,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectorLine() {
    return Container(
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Row(
        children: [
          SizedBox(width: 30.w),
          Container(
            width: 2.w,
            height: 30.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFA726).withOpacity(0.6),
                  Color(0xFFFFA726).withOpacity(0.3),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildPulseAnimation(Color color) {
    return Stack(
      children: [
        // الدائرة الأساسية
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withOpacity(0.4),
              width: 2.w,
            ),
          ),
        ),
        // تأثير إشعاعي
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

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
              'ابدأ الرحلة الآن',
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
}

class Stage {
  final int number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  Stage({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
