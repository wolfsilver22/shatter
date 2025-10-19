// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../widget/NavigationBar.dart';
// import 'Home.dart';
// import '../Auth/login_screen.dart';
// import '../Auth/signup_screen.dart';
// import 'SecondScreen/lessons_list_screen.dart';
//
// class IntroScreen extends StatelessWidget {
//   const IntroScreen({Key? key}) : super(key: key);
//
//   void _navigateToLogin(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//
//   void _navigateToSignup(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SignupScreen()),
//     );
//   }
//
//   void _continueAsGuest(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => CustomBottomNav()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // الشعار أو الصورة
//                 Container(
//                   width: 150.w,
//                   height: 150.h,
//                   decoration: BoxDecoration(
//                     color: Color(0xFF1E88E5),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xFF1E88E5).withOpacity(0.3),
//                         blurRadius: 20.w,
//                         offset: Offset(0, 10.h),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.school,
//                     color: Colors.white,
//                     size: 60.sp,
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // العنوان
//                 Text(
//                   'تطبيق تعلم القراءة',
//                   style: TextStyle(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E88E5),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//
//                 SizedBox(height: 8.h),
//
//                 // الوصف
//                 Text(
//                   'ابدأ رحلة التعلم معنا',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.grey[600],
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//
//                 SizedBox(height: 60.h),
//
//                 // زر إنشاء حساب جديد
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 40.w),
//                   child: ElevatedButton(
//                     onPressed: () => _navigateToSignup(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF1E88E5),
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(vertical: 16.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                       elevation: 4,
//                     ),
//                     child: Text(
//                       'إنشاء حساب جديد',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 16.h),
//
//                 // زر تسجيل الدخول
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 40.w),
//                   child: OutlinedButton(
//                     onPressed: () => _navigateToLogin(context),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Color(0xFF1E88E5),
//                       side: BorderSide(color: Color(0xFF1E88E5), width: 2),
//                       padding: EdgeInsets.symmetric(vertical: 16.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                     ),
//                     child: Text(
//                       'تسجيل الدخول',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 24.h),
//
//                 // زر التجربة كضيف
//                 TextButton(
//                   onPressed: () => _continueAsGuest(context),
//                   child: Text(
//                     'التجربة كضيف',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       color: Colors.grey[600],
//                       fontFamily: 'Tajawal',
//                       decoration: TextDecoration.underline,
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
// import '../widget/NavigationBar.dart';
// import '../Auth/login_screen.dart';
// import '../Auth/signup_screen.dart';
//
// class IntroScreen extends StatefulWidget {
//   const IntroScreen({Key? key}) : super(key: key);
//
//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }
//
// class _IntroScreenState extends State<IntroScreen> {
//   bool _isImageLoaded = false;
//   bool _imageError = false;
//
//   void _navigateToLogin(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//
//   void _navigateToSignup(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SignupScreen()),
//     );
//   }
//
//   void _continueAsGuest(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => CustomBottomNav()),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _preloadImage();
//   }
//
//   void _preloadImage() {
//     precacheImage(const AssetImage('assets/images/logo.png'), context)
//         .then((_) {
//       if (mounted) {
//         setState(() {
//           _isImageLoaded = true;
//           _imageError = false;
//         });
//       }
//     }).catchError((error) {
//       if (mounted) {
//         setState(() {
//           _isImageLoaded = true;
//           _imageError = true;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height -
//                 MediaQuery.of(context).padding.top,
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // صورة الشعار بشكل احترافي
//                 _buildLogoSection(),
//
//                 SizedBox(height: 40.h),
//
//                 // العنوان
//                 Text(
//                   'تطبيق تعلم القراءة',
//                   style: TextStyle(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E88E5),
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 8.h),
//
//                 // الوصف
//                 Text(
//                   'ابدأ رحلة التعلم معنا',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.grey[600],
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 60.h),
//
//                 // زر إنشاء حساب جديد
//                 _buildSignUpButton(),
//
//                 SizedBox(height: 16.h),
//
//                 // زر تسجيل الدخول
//                 _buildLoginButton(),
//
//                 SizedBox(height: 24.h),
//
//                 // زر التجربة كضيف
//                 _buildGuestButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLogoSection() {
//     return Container(
//       width: 180.w,
//       height: 180.h,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF1E88E5).withOpacity(0.2),
//             blurRadius: 25.w,
//             spreadRadius: 2.w,
//             offset: Offset(0, 8.h),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // خلفية دائرية متدرجة
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF1E88E5).withOpacity(0.1),
//                   Color(0xFF1E88E5).withOpacity(0.05),
//                 ],
//               ),
//             ),
//           ),
//
//           // صورة الشعار
//           Center(
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               width: 140.w,
//               height: 140.h,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 4.w,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10.w,
//                     offset: Offset(0, 4.h),
//                   ),
//                 ],
//               ),
//               child: ClipOval(
//                 child: _buildLogoImage(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLogoImage() {
//     if (!_isImageLoaded) {
//       return _buildLoadingState();
//     }
//
//     if (_imageError) {
//       return _buildErrorState();
//     }
//
//     return Image.asset(
//       'assets/images/logo.png',
//       width: 140.w,
//       height: 140.h,
//       fit: BoxFit.contain,
//       filterQuality: FilterQuality.high,
//     );
//   }
//
//   Widget _buildLoadingState() {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.grey[100],
//       ),
//       child: Center(
//         child: SizedBox(
//           width: 30.w,
//           height: 30.h,
//           child: CircularProgressIndicator(
//             strokeWidth: 2.w,
//             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorState() {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Color(0xFF1E88E5),
//       ),
//       child: Center(
//         child: Icon(
//           Icons.school,
//           color: Colors.white,
//           size: 50.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSignUpButton() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 40.w),
//       child: ElevatedButton(
//         onPressed: () => _navigateToSignup(context),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF1E88E5),
//           foregroundColor: Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 16.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.w),
//           ),
//           elevation: 4,
//           shadowColor: Color(0xFF1E88E5).withOpacity(0.3),
//         ),
//         child: Text(
//           'إنشاء حساب جديد',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoginButton() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 40.w),
//       child: OutlinedButton(
//         onPressed: () => _navigateToLogin(context),
//         style: OutlinedButton.styleFrom(
//           foregroundColor: Color(0xFF1E88E5),
//           side: BorderSide(color: Color(0xFF1E88E5), width: 2.w),
//           padding: EdgeInsets.symmetric(vertical: 16.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.w),
//           ),
//           backgroundColor: Colors.white,
//         ),
//         child: Text(
//           'تسجيل الدخول',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGuestButton() {
//     return TextButton(
//       onPressed: () => _continueAsGuest(context),
//       style: TextButton.styleFrom(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//       ),
//       child: Text(
//         'التجربة كضيف',
//         style: TextStyle(
//           fontSize: 16.sp,
//           color: Colors.grey[600],
//           fontFamily: 'Tajawal',
//           decoration: TextDecoration.underline,
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../widget/NavigationBar.dart';
// import '../Auth/login_screen.dart';
//
//
// class IntroScreen extends StatefulWidget {
//   const IntroScreen({Key? key}) : super(key: key);
//
//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }
//
// class _IntroScreenState extends State<IntroScreen> {
//   bool _isImageLoaded = false;
//   bool _imageError = false;
//
//   void _navigateToLogin(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//
//   void _continueAsGuest(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => CustomBottomNav()),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _preloadImage();
//   }
//
//   void _preloadImage() {
//     precacheImage(const AssetImage('assets/images/logo.png'), context)
//         .then((_) {
//       if (mounted) {
//         setState(() {
//           _isImageLoaded = true;
//           _imageError = false;
//         });
//       }
//     }).catchError((error) {
//       if (mounted) {
//         setState(() {
//           _isImageLoaded = true;
//           _imageError = true;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height -
//                 MediaQuery.of(context).padding.top,
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // صورة الشعار بشكل احترافي
//                 _buildLogoSection(),
//
//                 SizedBox(height: 40.h),
//
//                 // العنوان
//                 Text(
//                   'تطبيق تعلم القراءة',
//                   style: TextStyle(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E88E5),
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 8.h),
//
//                 // الوصف
//                 Text(
//                   'ابدأ رحلة التعلم معنا',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.grey[600],
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 60.h),
//
//                 // زر تسجيل الدخول
//                 _buildLoginButton(),
//
//                 SizedBox(height: 16.h),
//
//                 // زر تجربة التطبيق
//                 _buildGuestButton(),
//
//                 SizedBox(height: 24.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLogoSection() {
//     return Container(
//       width: 180.w,
//       height: 180.h,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF1E88E5).withOpacity(0.2),
//             blurRadius: 25.w,
//             spreadRadius: 2.w,
//             offset: Offset(0, 8.h),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // خلفية دائرية متدرجة
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF1E88E5).withOpacity(0.1),
//                   Color(0xFF1E88E5).withOpacity(0.05),
//                 ],
//               ),
//             ),
//           ),
//
//           // صورة الشعار
//           Center(
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               width: 140.w,
//               height: 140.h,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 4.w,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10.w,
//                     offset: Offset(0, 4.h),
//                   ),
//                 ],
//               ),
//               child: ClipOval(
//                 child: _buildLogoImage(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLogoImage() {
//     if (!_isImageLoaded) {
//       return _buildLoadingState();
//     }
//
//     if (_imageError) {
//       return _buildErrorState();
//     }
//
//     return Image.asset(
//       'assets/images/logo.png',
//       width: 140.w,
//       height: 140.h,
//       fit: BoxFit.contain,
//       filterQuality: FilterQuality.high,
//     );
//   }
//
//   Widget _buildLoadingState() {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.grey[100],
//       ),
//       child: Center(
//         child: SizedBox(
//           width: 30.w,
//           height: 30.h,
//           child: CircularProgressIndicator(
//             strokeWidth: 2.w,
//             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorState() {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Color(0xFF1E88E5),
//       ),
//       child: Center(
//         child: Icon(
//           Icons.school,
//           color: Colors.white,
//           size: 50.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoginButton() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 40.w),
//       child: ElevatedButton(
//         onPressed: () => _navigateToLogin(context),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF1E88E5), // خلفية زرقاء
//           foregroundColor: Colors.white, // نص أبيض
//           padding: EdgeInsets.symmetric(vertical: 18.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.w),
//           ),
//           elevation: 6,
//           shadowColor: Color(0xFF1E88E5).withOpacity(0.4),
//         ),
//         child: Text(
//           'تسجيل الدخول',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGuestButton() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 40.w),
//       child: OutlinedButton(
//         onPressed: () => _continueAsGuest(context),
//         style: OutlinedButton.styleFrom(
//           backgroundColor: Colors.white, // خلفية بيضاء
//           foregroundColor: Color(0xFF1E88E5), // نص أزرق
//           side: BorderSide(
//             color: Color(0xFF1E88E5), // إطار أزرق
//             width: 2.w,
//           ),
//           padding: EdgeInsets.symmetric(vertical: 18.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.w),
//           ),
//           elevation: 2,
//         ),
//         child: Text(
//           'تجربة التطبيق',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Auth/auth_service.dart';
import '../widget/NavigationBar.dart';
import '../Auth/login_screen.dart';


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
    // انتظر قليلاً لضمان تحميل حالة المصادقة
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
    // في الوضع الضيف، يمكنك تعيين بيانات افتراضية
    _navigateToHome();
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CustomBottomNav()),
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
    // إذا كان النظام يتحقق من حالة المصادقة، اعرض شاشة تحميل
    if (_isCheckingAuth) {
      return _buildLoadingScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
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

                // العنوان
                Text(
                  'تطبيق تعلم القراءة',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E88E5),
                    fontFamily: 'Tajawal',
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 8.h),

                // الوصف
                Text(
                  'ابدأ رحلة التعلم معنا نحو إتقان القراءة',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                    fontFamily: 'Tajawal',
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12.h),

                // وصف إضافي
                Text(
                  'منصة متكاملة لتعلم القراءة العربية بطرق تفاعلية ممتعة',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[500],
                    fontFamily: 'Tajawal',
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 60.h),

                // زر تسجيل الدخول
                _buildLoginButton(),

                SizedBox(height: 16.h),

                // زر تجربة التطبيق
                _buildGuestButton(),

                SizedBox(height: 24.h),

                // ميزات التطبيق
                _buildFeaturesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            color: Color(0xFF1E88E5).withOpacity(0.15),
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
                  Color(0xFF1E88E5).withOpacity(0.15),
                  Color(0xFF1E88E5).withOpacity(0.05),
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
                    color: Colors.black.withOpacity(0.1),
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
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: ElevatedButton(
        onPressed: () => _navigateToLogin(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1E88E5),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          elevation: 8,
          shadowColor: Color(0xFF1E88E5).withOpacity(0.4),
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

  Widget _buildGuestButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: OutlinedButton(
        onPressed: () => _continueAsGuest(context),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1E88E5),
          side: BorderSide(
            color: Color(0xFF1E88E5),
            width: 2.w,
          ),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.explore_rounded,
              size: 22.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'تجربة التطبيق',
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
          Text(
            'مميزات التطبيق',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E88E5),
              fontFamily: 'Tajawal',
            ),
          ),
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
            color: Color(0xFF1E88E5).withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFF1E88E5).withOpacity(0.3),
              width: 1.5.w,
            ),
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
            color: Colors.grey[600],
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}