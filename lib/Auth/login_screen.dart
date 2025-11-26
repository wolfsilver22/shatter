// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:provider/provider.dart';
// import '../widget/NavigationBar.dart';
// import 'auth_service.dart';
// import '../widget/AnimatedBackground.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   // ألوان متناسقة مع الهوية البصرية
//   final Color _primaryBlue = Color(0xFF1E88E5);
//   final Color _primaryOrange = Color(0xFFFFA726);
//   final Color _errorRed = Color(0xFFEF4444);
//   final Color _warningOrange = Color(0xFFFFA726);
//   final Color _successGreen = Color(0xFF10B981);
//   final Color _darkText = Color(0xFF1E293B);
//   final Color _grayText = Color(0xFF64748B);
//   final Color _lightGray = Color(0xFFF8FAFC);
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
//       _showErrorDialog(
//         'بيانات ناقصة',
//         'يرجى ملء جميع الحقول المطلوبة للمتابعة',
//         Iconsax.warning_2,
//         _warningOrange,
//       );
//       return;
//     }
//
//     // التحقق من صيغة البريد الإلكتروني
//     if (!_isValidEmail(_emailController.text)) {
//       _showErrorDialog(
//         'بريد إلكتروني غير صالح',
//         'يرجى إدخال بريد إلكتروني صحيح للمتابعة',
//         Icons.sms_failed,
//         _warningOrange,
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final authService = Provider.of<AuthService>(context, listen: false);
//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();
//
//       print('🔐 محاولة تسجيل الدخول بالبريد: $email');
//
//       // إجراء تسجيل الدخول عبر Firebase
//       await authService.signInWithEmailAndPassword(email, password);
//       print('✅ تسجيل الدخول ناجح');
//
//       // الانتقال إلى الشاشة الرئيسية
//       _navigateToHome();
//
//     } catch (e) {
//       print('❌ خطأ في تسجيل الدخول: $e');
//       _handleLoginError(e);
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   bool _isValidEmail(String email) {
//     final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//     return emailRegex.hasMatch(email);
//   }
//
//   void _handleLoginError(dynamic error) {
//     String title = 'خطأ في التسجيل';
//     String message = 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.';
//     IconData icon = Iconsax.close_circle;
//     Color iconColor = _errorRed;
//
//     String errorCode = error.toString();
//
//     if (errorCode.contains('user-not-found')) {
//       title = 'الحساب غير موجود';
//       message = 'البريد الإلكتروني الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.';
//       icon = Iconsax.profile_remove;
//     } else if (errorCode.contains('wrong-password')) {
//       title = 'كلمة المرور غير صحيحة';
//       message = 'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى.';
//       icon = Iconsax.lock_1;
//     } else if (errorCode.contains('invalid-email')) {
//       title = 'بريد إلكتروني غير صالح';
//       message = 'صيغة البريد الإلكتروني غير صحيحة. الرجاء التأكد من إدخال بريد إلكتروني صحيح.';
//       icon = Icons.sms_failed;
//     } else if (errorCode.contains('user-disabled')) {
//       title = 'الحساب معطل';
//       message = 'حسابك معطل حالياً. يرجى التواصل مع الدعم الفني.';
//       icon = Iconsax.profile_remove;
//     } else if (errorCode.contains('too-many-requests')) {
//       title = 'طلبات كثيرة جداً';
//       message = 'لقد قمت بمحاولات تسجيل دخول كثيرة. الرجاء الانتظار قليلاً ثم المحاولة مرة أخرى.';
//       icon = Iconsax.timer_1;
//       iconColor = _warningOrange;
//     } else if (errorCode.contains('network-request-failed')) {
//       title = 'مشكلة في الاتصال';
//       message = 'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.';
//       icon = Iconsax.wifi_square;
//       iconColor = _warningOrange;
//     } else if (errorCode.contains('email-already-in-use')) {
//       title = 'البريد الإلكتروني مستخدم مسبقاً';
//       message = 'هذا البريد الإلكتروني مسجل بالفعل في نظامنا. الرجاء استخدام بريد إلكتروني آخر.';
//       icon = Icons.sms_failed;
//     } else if (errorCode.contains('weak-password')) {
//       title = 'كلمة مرور ضعيفة';
//       message = 'كلمة المرور التي أدخلتها ضعيفة جداً. الرجاء اختيار كلمة مرور أقوى.';
//       icon = Iconsax.lock_1;
//     } else if (errorCode.contains('operation-not-allowed')) {
//       title = 'العملية غير مسموحة';
//       message = 'طريقة التسجيل هذه غير مفعلة حالياً. الرجاء التواصل مع الدعم الفني.';
//       icon = Iconsax.security;
//     }
//
//     _showErrorDialog(title, message, icon, iconColor);
//   }
//
//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => MainNavigation()),
//     );
//   }
//
//   void _showErrorDialog(
//       String title,
//       String message,
//       IconData icon,
//       Color iconColor,
//       ) {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black54,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24.r),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(28.w),
//                 margin: EdgeInsets.only(top: 50.h),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.25),
//                       blurRadius: 25.w,
//                       offset: Offset(0, 10.h),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(height: 50.h),
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.bold,
//                         color: _darkText,
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       message,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: _grayText,
//                         fontFamily: 'Tajawal',
//                         height: 1.6,
//                       ),
//                     ),
//                     SizedBox(height: 28.h),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _primaryBlue,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14.r),
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 16.h),
//                           elevation: 4,
//                           shadowColor: _primaryBlue.withOpacity(0.3),
//                         ),
//                         child: Text(
//                           'حسناً',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Container(
//                     width: 90.w,
//                     height: 90.w,
//                     decoration: BoxDecoration(
//                       color: iconColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white, width: 6.w),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 15.w,
//                           spreadRadius: 1.w,
//                         ),
//                       ],
//                     ),
//                     child: Icon(icon, size: 42.w, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _backToIntro() {
//     Navigator.pop(context);
//   }
//
//   void _showWhatsAppDialog() {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black54,
//       builder: (BuildContext context) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.all(24.w),
//             child: SingleChildScrollView(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.25),
//                       blurRadius: 25.w,
//                       offset: Offset(0, 10.h),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(28.w),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 90.w,
//                         height: 90.h,
//                         decoration: BoxDecoration(
//                           color: Color(0xFF25D366),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xFF25D366).withOpacity(0.3),
//                               blurRadius: 20.w,
//                               offset: Offset(0, 8.h),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Iconsax.message,
//                           color: Colors.white,
//                           size: 42.sp,
//                         ),
//                       ),
//
//                       SizedBox(height: 24.h),
//
//                       Text(
//                         'إنشاء حساب جديد',
//                         style: TextStyle(
//                           fontSize: 24.sp,
//                           fontWeight: FontWeight.bold,
//                           color: _primaryBlue,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 16.h),
//
//                       Text(
//                         'إذا كنت لا تملك حساباً، يرجى التواصل معنا مباشرة عبر الواتساب للاشتراك وفتح حساب الطالب',
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           color: _grayText,
//                           fontFamily: 'Tajawal',
//                           height: 1.6,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//
//                       SizedBox(height: 8.h),
//
//                       Text(
//                         'سيتم نقلك مباشرة إلى الواتساب لإكمال عملية الاشتراك',
//                         style: TextStyle(
//                           fontSize: 13.sp,
//                           color: _primaryOrange,
//                           fontFamily: 'Tajawal',
//                           fontWeight: FontWeight.w600,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//
//                       SizedBox(height: 32.h),
//
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: _grayText,
//                                 side: BorderSide(color: Colors.grey[400]!),
//                                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(14.r),
//                                 ),
//                                 backgroundColor: _lightGray,
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           SizedBox(width: 16.w),
//
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: _launchWhatsApp,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFF25D366),
//                                 foregroundColor: Colors.white,
//                                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(14.r),
//                                 ),
//                                 elevation: 4,
//                                 shadowColor: Color(0xFF25D366).withOpacity(0.3),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Iconsax.message,
//                                     size: 20.sp,
//                                   ),
//                                   SizedBox(width: 8.w),
//                                   Text(
//                                     'فتح الواتساب',
//                                     style: TextStyle(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Tajawal',
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
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
//   Future<void> _launchWhatsApp() async {
//     final String phoneNumber = '966123456789';
//     final String message = 'مرحباً، أريد الاشتراك في تطبيق تعلم القراءة وفتح حساب للطالب';
//
//     final String url = "https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}";
//
//     try {
//       if (await canLaunch(url)) {
//         await launch(url);
//         Navigator.of(context).pop();
//       } else {
//         _showErrorDialog(
//           'تعذر فتح الواتساب',
//           'لا يمكن فتح تطبيق الواتساب. الرجاء التأكد من تثبيت التطبيق على جهازك.',
//           Iconsax.message_remove,
//           _warningOrange,
//         );
//       }
//     } catch (e) {
//       _showErrorDialog(
//         'حدث خطأ',
//         'تعذر فتح الرابط: $e',
//         Iconsax.close_circle,
//         _errorRed,
//       );
//     }
//   }
//
//   void _showForgotPasswordSnackBar() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'سيتم إضافة هذه الميزة قريباً',
//           style: TextStyle(
//             fontFamily: 'Tajawal',
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         backgroundColor: _primaryOrange,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         margin: EdgeInsets.all(20.w),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBackground(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: _backToIntro,
//                       iconSize: 22.sp,
//                     ),
//                   ),
//                 ),
//
//                 Expanded(
//                   child: SingleChildScrollView(
//                     physics: NeverScrollableScrollPhysics(),
//                     child: Container(
//                       padding: EdgeInsets.all(24.w),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.92),
//                         borderRadius: BorderRadius.circular(24.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.15),
//                             blurRadius: 30.w,
//                             offset: Offset(0, 15.h),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 100.w,
//                             height: 100.h,
//                             decoration: BoxDecoration(
//                               color: _primaryBlue.withOpacity(0.95),
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: _primaryBlue.withOpacity(0.3),
//                                   blurRadius: 15.w,
//                                   offset: Offset(0, 6.h),
//                                 ),
//                               ],
//                             ),
//                             child: Icon(
//                               Iconsax.profile_circle,
//                               color: Colors.white,
//                               size: 48.sp,
//                             ),
//                           ),
//
//                           SizedBox(height: 24.h),
//
//                           Text(
//                             'تسجيل الدخول',
//                             style: TextStyle(
//                               fontSize: 28.sp,
//                               fontWeight: FontWeight.bold,
//                               color: _primaryBlue,
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//
//                           SizedBox(height: 6.h),
//
//                           Text(
//                             'أدخل بياناتك للمتابعة',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: _grayText,
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//
//                           SizedBox(height: 32.h),
//
//                           _buildEmailField(),
//
//                           SizedBox(height: 16.h),
//
//                           _buildPasswordField(),
//
//                           SizedBox(height: 12.h),
//
//                           if (_errorMessage.isNotEmpty) _buildErrorWidget(),
//
//                           SizedBox(height: _errorMessage.isNotEmpty ? 16.h : 0.h),
//
//                           _buildForgotPasswordLink(),
//
//                           SizedBox(height: 20.h),
//
//                           _buildLoginButton(),
//
//                           SizedBox(height: 16.h),
//
//                           _buildCreateAccountLink(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 10.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmailField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _emailController,
//         keyboardType: TextInputType.emailAddress,
//         textInputAction: TextInputAction.next,
//         style: TextStyle(
//           color: _darkText,
//           fontFamily: 'Tajawal',
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'حساب الطالب (البريد الإلكتروني)',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           hintText: 'أدخل بريدك الإلكتروني',
//           hintStyle: TextStyle(
//             color: _grayText.withOpacity(0.6),
//             fontFamily: 'Tajawal',
//           ),
//           prefixIcon: Icon(Iconsax.sms, color: _primaryBlue, size: 20.sp),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide(
//               color: _primaryOrange,
//               width: 2.w,
//             ),
//           ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: 18.w,
//             vertical: 16.h,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPasswordField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _passwordController,
//         obscureText: true,
//         textInputAction: TextInputAction.done,
//         onEditingComplete: _signIn,
//         style: TextStyle(
//           color: _darkText,
//           fontFamily: 'Tajawal',
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'كلمة المرور',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           hintText: 'أدخل كلمة المرور',
//           hintStyle: TextStyle(
//             color: _grayText.withOpacity(0.6),
//             fontFamily: 'Tajawal',
//           ),
//           prefixIcon: Icon(Iconsax.lock_1, color: _primaryBlue, size: 20.sp),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide(
//               color: _primaryOrange,
//               width: 2.w,
//             ),
//           ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: 18.w,
//             vertical: 16.h,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       padding: EdgeInsets.all(14.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Color(0xFFFECACA)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8.w,
//             offset: Offset(0, 3.h),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 36.w,
//             height: 36.w,
//             decoration: BoxDecoration(
//               color: Color(0xFFFEF2F2),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Iconsax.info_circle,
//               color: _errorRed,
//               size: 20.sp,
//             ),
//           ),
//           SizedBox(width: 10.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'تنبيه',
//                   style: TextStyle(
//                     color: _errorRed,
//                     fontFamily: 'Tajawal',
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(
//                     color: Color(0xFF7F1D1D),
//                     fontFamily: 'Tajawal',
//                     fontSize: 12.sp,
//                     height: 1.3,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildForgotPasswordLink() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: TextButton(
//           onPressed: _showForgotPasswordSnackBar,
//           style: TextButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
//           ),
//           child: Text(
//             'نسيت كلمة المرور؟',
//             style: TextStyle(
//               fontSize: 13.sp,
//               color: _primaryBlue,
//               fontFamily: 'Tajawal',
//               fontWeight: FontWeight.w500,
//               decoration: TextDecoration.underline,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoginButton() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: ElevatedButton(
//         onPressed: _isLoading ? null : _signIn,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _primaryOrange,
//           foregroundColor: Colors.black,
//           padding: EdgeInsets.symmetric(vertical: 16.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14.r),
//           ),
//           elevation: 4,
//           shadowColor: Colors.black.withOpacity(0.2),
//           disabledBackgroundColor: _primaryOrange.withOpacity(0.6),
//         ),
//         child: _isLoading
//             ? SizedBox(
//           width: 24.w,
//           height: 24.h,
//           child: CircularProgressIndicator(
//             strokeWidth: 2.2.w,
//             color: Colors.black,
//           ),
//         )
//             : Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Iconsax.login_1,
//               size: 20.sp,
//               color: Colors.black,
//             ),
//             SizedBox(width: 8.w),
//             Text(
//               'تسجيل الدخول',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCreateAccountLink() {
//     return GestureDetector(
//       onTap: _showWhatsAppDialog,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10.w),
//         padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
//         decoration: BoxDecoration(
//           color: _primaryBlue.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: _primaryBlue.withOpacity(0.3),
//             width: 1.2.w,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Iconsax.info_circle,
//               color: _primaryBlue,
//               size: 18.sp,
//             ),
//             SizedBox(width: 8.w),
//             Text(
//               'ليس لديك حساب؟',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: _primaryBlue,
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(width: 4.w),
//             Text(
//               'انقر هنا',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: _primaryOrange,
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:provider/provider.dart';
// import '../widget/NavigationBar.dart';
// import 'auth_service.dart';
// import '../widget/AnimatedBackground.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   // ألوان متناسقة مع الهوية البصرية
//   final Color _primaryBlue = Color(0xFF1E88E5);
//   final Color _primaryOrange = Color(0xFFFFA726);
//   final Color _errorRed = Color(0xFFEF4444);
//   final Color _warningOrange = Color(0xFFFFA726);
//   final Color _successGreen = Color(0xFF10B981);
//   final Color _darkText = Color(0xFF1E293B);
//   final Color _grayText = Color(0xFF64748B);
//   final Color _lightGray = Color(0xFFF8FAFC);
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
//       _showErrorDialog(
//         'بيانات ناقصة',
//         'يرجى ملء جميع الحقول المطلوبة للمتابعة',
//         Iconsax.warning_2,
//         _warningOrange,
//       );
//       return;
//     }
//
//     // التحقق من صيغة البريد الإلكتروني
//     if (!_isValidEmail(_emailController.text)) {
//       _showErrorDialog(
//         'بريد إلكتروني غير صالح',
//         'يرجى إدخال بريد إلكتروني صحيح للمتابعة',
//         Icons.sms_failed,
//         _warningOrange,
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final authService = Provider.of<AuthService>(context, listen: false);
//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();
//
//       print('🔐 محاولة تسجيل الدخول بالبريد: $email');
//
//       // إجراء تسجيل الدخول عبر Firebase
//       await authService.signInWithEmailAndPassword(email, password);
//
//       // طباعة حالة المصادقة للتشخيص
//       authService.printAuthState();
//
//       print('✅ تسجيل الدخول ناجح - الانتقال للشاشة الرئيسية');
//
//       // الانتقال إلى الشاشة الرئيسية
//       _navigateToHome();
//
//     } catch (e) {
//       print('❌ خطأ في تسجيل الدخول: $e');
//       _handleLoginError(e);
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   bool _isValidEmail(String email) {
//     final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//     return emailRegex.hasMatch(email);
//   }
//
//   void _handleLoginError(dynamic error) {
//     String title = 'خطأ في التسجيل';
//     String message = 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.';
//     IconData icon = Iconsax.close_circle;
//     Color iconColor = _errorRed;
//
//     String errorString = error.toString();
//
//     // معالجة الأخطاء المخصصة من AuthService
//     if (errorString.contains('هذا الحساب مسجل حالياً في جهاز آخر')) {
//       title = 'حساب مستخدم';
//       message = 'هذا الحساب مسجل حالياً في جهاز آخر. يرجى الخروج منه أولاً ثم المحاولة مرة أخرى.';
//       icon = Iconsax.profile_remove;
//       iconColor = _warningOrange;
//     } else if (errorString.contains('الحساب غير موجود في إعدادات المستخدم')) {
//       title = 'حساب غير مكتمل';
//       message = 'الحساب غير موجود في إعدادات المستخدم. يرجى التواصل مع الدعم الفني.';
//       icon = Iconsax.profile_remove;
//     } else if (errorString.contains('الحساب غير مفعل')) {
//       title = 'حساب غير مفعل';
//       message = 'حسابك غير مفعل حالياً. يرجى التواصل مع الدعم الفني.';
//       icon = Iconsax.profile_remove;
//     } else if (errorString.contains('فشل في التحقق من حالة الحساب')) {
//       title = 'مشكلة في الخادم';
//       message = 'تعذر التحقق من حالة الحساب. الرجاء المحاولة مرة أخرى.';
//       icon = Iconsax.cloud_remove;
//     } else if (errorString.contains('فشل في تحديث حالة الحساب')) {
//       title = 'مشكلة في الخادم';
//       message = 'تعذر تحديث حالة الحساب. الرجاء المحاولة مرة أخرى.';
//       icon = Iconsax.cloud_remove;
//     }
//     // معالجة أخطاء Firebase
//     else if (errorString.contains('user-not-found')) {
//       title = 'الحساب غير موجود';
//       message = 'البريد الإلكتروني الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.';
//       icon = Iconsax.profile_remove;
//     } else if (errorString.contains('wrong-password')) {
//       title = 'كلمة المرور غير صحيحة';
//       message = 'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى.';
//       icon = Iconsax.lock_1;
//     } else if (errorString.contains('invalid-email')) {
//       title = 'بريد إلكتروني غير صالح';
//       message = 'صيغة البريد الإلكتروني غير صحيحة. الرجاء التأكد من إدخال بريد إلكتروني صحيح.';
//       icon = Icons.sms_failed;
//     } else if (errorString.contains('user-disabled')) {
//       title = 'الحساب معطل';
//       message = 'حسابك معطل حالياً. يرجى التواصل مع الدعم الفني.';
//       icon = Iconsax.profile_remove;
//     } else if (errorString.contains('too-many-requests')) {
//       title = 'طلبات كثيرة جداً';
//       message = 'لقد قمت بمحاولات تسجيل دخول كثيرة. الرجاء الانتظار قليلاً ثم المحاولة مرة أخرى.';
//       icon = Iconsax.timer_1;
//       iconColor = _warningOrange;
//     } else if (errorString.contains('network-request-failed')) {
//       title = 'مشكلة في الاتصال';
//       message = 'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.';
//       icon = Iconsax.wifi_square;
//       iconColor = _warningOrange;
//     } else if (errorString.contains('email-already-in-use')) {
//       title = 'البريد الإلكتروني مستخدم مسبقاً';
//       message = 'هذا البريد الإلكتروني مسجل بالفعل في نظامنا. الرجاء استخدام بريد إلكتروني آخر.';
//       icon = Icons.sms_failed;
//     } else if (errorString.contains('weak-password')) {
//       title = 'كلمة مرور ضعيفة';
//       message = 'كلمة المرور التي أدخلتها ضعيفة جداً. الرجاء اختيار كلمة مرور أقوى.';
//       icon = Iconsax.lock_1;
//     } else if (errorString.contains('operation-not-allowed')) {
//       title = 'العملية غير مسموحة';
//       message = 'طريقة التسجيل هذه غير مفعلة حالياً. الرجاء التواصل مع الدعم الفني.';
//       icon = Iconsax.security;
//     }
//
//     _showErrorDialog(title, message, icon, iconColor);
//   }
//
//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => MainNavigation()),
//     );
//   }
//
//   void _showErrorDialog(
//       String title,
//       String message,
//       IconData icon,
//       Color iconColor,
//       ) {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black54,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24.r),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(28.w),
//                 margin: EdgeInsets.only(top: 50.h),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.25),
//                       blurRadius: 25.w,
//                       offset: Offset(0, 10.h),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(height: 50.h),
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.bold,
//                         color: _darkText,
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       message,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: _grayText,
//                         fontFamily: 'Tajawal',
//                         height: 1.6,
//                       ),
//                     ),
//                     SizedBox(height: 28.h),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _primaryBlue,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14.r),
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 16.h),
//                           elevation: 4,
//                           shadowColor: _primaryBlue.withOpacity(0.3),
//                         ),
//                         child: Text(
//                           'حسناً',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Container(
//                     width: 90.w,
//                     height: 90.w,
//                     decoration: BoxDecoration(
//                       color: iconColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white, width: 6.w),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 15.w,
//                           spreadRadius: 1.w,
//                         ),
//                       ],
//                     ),
//                     child: Icon(icon, size: 42.w, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _backToIntro() {
//     Navigator.pop(context);
//   }
//
//   void _showWhatsAppDialog() {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black54,
//       builder: (BuildContext context) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.all(24.w),
//             child: SingleChildScrollView(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.25),
//                       blurRadius: 25.w,
//                       offset: Offset(0, 10.h),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(28.w),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 90.w,
//                         height: 90.h,
//                         decoration: BoxDecoration(
//                           color: Color(0xFF25D366),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xFF25D366).withOpacity(0.3),
//                               blurRadius: 20.w,
//                               offset: Offset(0, 8.h),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Iconsax.message,
//                           color: Colors.white,
//                           size: 42.sp,
//                         ),
//                       ),
//
//                       SizedBox(height: 24.h),
//
//                       Text(
//                         'إنشاء حساب جديد',
//                         style: TextStyle(
//                           fontSize: 24.sp,
//                           fontWeight: FontWeight.bold,
//                           color: _primaryBlue,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 16.h),
//
//                       Text(
//                         'إذا كنت لا تملك حساباً، يرجى التواصل معنا مباشرة عبر الواتساب للاشتراك وفتح حساب الطالب',
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           color: _grayText,
//                           fontFamily: 'Tajawal',
//                           height: 1.6,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//
//                       SizedBox(height: 8.h),
//
//                       Text(
//                         'سيتم نقلك مباشرة إلى الواتساب لإكمال عملية الاشتراك',
//                         style: TextStyle(
//                           fontSize: 13.sp,
//                           color: _primaryOrange,
//                           fontFamily: 'Tajawal',
//                           fontWeight: FontWeight.w600,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//
//                       SizedBox(height: 32.h),
//
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: _grayText,
//                                 side: BorderSide(color: Colors.grey[400]!),
//                                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(14.r),
//                                 ),
//                                 backgroundColor: _lightGray,
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           SizedBox(width: 16.w),
//
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: _launchWhatsApp,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFF25D366),
//                                 foregroundColor: Colors.white,
//                                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(14.r),
//                                 ),
//                                 elevation: 4,
//                                 shadowColor: Color(0xFF25D366).withOpacity(0.3),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Iconsax.message,
//                                     size: 20.sp,
//                                   ),
//                                   SizedBox(width: 8.w),
//                                   Text(
//                                     'فتح الواتساب',
//                                     style: TextStyle(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Tajawal',
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
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
//   Future<void> _launchWhatsApp() async {
//     final String phoneNumber = '966123456789';
//     final String message = 'مرحباً، أريد الاشتراك في تطبيق تعلم القراءة وفتح حساب للطالب';
//
//     final String url = "https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}";
//
//     try {
//       if (await canLaunch(url)) {
//         await launch(url);
//         Navigator.of(context).pop();
//       } else {
//         _showErrorDialog(
//           'تعذر فتح الواتساب',
//           'لا يمكن فتح تطبيق الواتساب. الرجاء التأكد من تثبيت التطبيق على جهازك.',
//           Iconsax.message_remove,
//           _warningOrange,
//         );
//       }
//     } catch (e) {
//       _showErrorDialog(
//         'حدث خطأ',
//         'تعذر فتح الرابط: $e',
//         Iconsax.close_circle,
//         _errorRed,
//       );
//     }
//   }
//
//   void _showForgotPasswordSnackBar() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'سيتم إضافة هذه الميزة قريباً',
//           style: TextStyle(
//             fontFamily: 'Tajawal',
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         backgroundColor: _primaryOrange,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         margin: EdgeInsets.all(20.w),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBackground(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // زر الرجوع
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: _backToIntro,
//                       iconSize: 22.sp,
//                     ),
//                   ),
//                 ),
//
//                 // محتوى تسجيل الدخول
//                 Expanded(
//                   child: SingleChildScrollView(
//                     physics: BouncingScrollPhysics(),
//                     child: Container(
//                       padding: EdgeInsets.all(24.w),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.92),
//                         borderRadius: BorderRadius.circular(24.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.15),
//                             blurRadius: 30.w,
//                             offset: Offset(0, 15.h),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // أيقونة المستخدم
//                           Container(
//                             width: 100.w,
//                             height: 100.h,
//                             decoration: BoxDecoration(
//                               color: _primaryBlue.withOpacity(0.95),
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: _primaryBlue.withOpacity(0.3),
//                                   blurRadius: 15.w,
//                                   offset: Offset(0, 6.h),
//                                 ),
//                               ],
//                             ),
//                             child: Icon(
//                               Iconsax.profile_circle,
//                               color: Colors.white,
//                               size: 48.sp,
//                             ),
//                           ),
//
//                           SizedBox(height: 24.h),
//
//                           // عنوان الشاشة
//                           Text(
//                             'تسجيل الدخول',
//                             style: TextStyle(
//                               fontSize: 28.sp,
//                               fontWeight: FontWeight.bold,
//                               color: _primaryBlue,
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//
//                           SizedBox(height: 6.h),
//
//                           // وصف الشاشة
//                           Text(
//                             'أدخل بياناتك للمتابعة',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: _grayText,
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//
//                           SizedBox(height: 32.h),
//
//                           // حقل البريد الإلكتروني
//                           _buildEmailField(),
//
//                           SizedBox(height: 16.h),
//
//                           // حقل كلمة المرور
//                           _buildPasswordField(),
//
//                           SizedBox(height: 12.h),
//
//                           // عرض الخطأ إذا وجد
//                           if (_errorMessage.isNotEmpty) _buildErrorWidget(),
//
//                           SizedBox(height: _errorMessage.isNotEmpty ? 16.h : 0.h),
//
//                           // رابط نسيت كلمة المرور
//                           _buildForgotPasswordLink(),
//
//                           SizedBox(height: 20.h),
//
//                           // زر تسجيل الدخول
//                           _buildLoginButton(),
//
//                           SizedBox(height: 16.h),
//
//                           // رابط إنشاء حساب جديد
//                           _buildCreateAccountLink(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 10.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmailField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _emailController,
//         keyboardType: TextInputType.emailAddress,
//         textInputAction: TextInputAction.next,
//         style: TextStyle(
//           color: _darkText,
//           fontFamily: 'Tajawal',
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'حساب الطالب (البريد الإلكتروني)',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           hintText: 'أدخل بريدك الإلكتروني',
//           hintStyle: TextStyle(
//             color: _grayText.withOpacity(0.6),
//             fontFamily: 'Tajawal',
//           ),
//           prefixIcon: Icon(Iconsax.sms, color: _primaryBlue, size: 20.sp),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide(
//               color: _primaryOrange,
//               width: 2.w,
//             ),
//           ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: 18.w,
//             vertical: 16.h,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPasswordField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _passwordController,
//         obscureText: true,
//         textInputAction: TextInputAction.done,
//         onEditingComplete: _signIn,
//         style: TextStyle(
//           color: _darkText,
//           fontFamily: 'Tajawal',
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'كلمة المرور',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           hintText: 'أدخل كلمة المرور',
//           hintStyle: TextStyle(
//             color: _grayText.withOpacity(0.6),
//             fontFamily: 'Tajawal',
//           ),
//           prefixIcon: Icon(Iconsax.lock_1, color: _primaryBlue, size: 20.sp),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             borderSide: BorderSide(
//               color: _primaryOrange,
//               width: 2.w,
//             ),
//           ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: 18.w,
//             vertical: 16.h,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return AnimatedOpacity(
//       opacity: _errorMessage.isNotEmpty ? 1.0 : 0.0,
//       duration: Duration(milliseconds: 300),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10.w),
//         padding: EdgeInsets.all(14.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: Color(0xFFFECACA)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 8.w,
//               offset: Offset(0, 3.h),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 36.w,
//               height: 36.w,
//               decoration: BoxDecoration(
//                 color: Color(0xFFFEF2F2),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Iconsax.info_circle,
//                 color: _errorRed,
//                 size: 20.sp,
//               ),
//             ),
//             SizedBox(width: 10.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'تنبيه',
//                     style: TextStyle(
//                       color: _errorRed,
//                       fontFamily: 'Tajawal',
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 2.h),
//                   Text(
//                     _errorMessage,
//                     style: TextStyle(
//                       color: Color(0xFF7F1D1D),
//                       fontFamily: 'Tajawal',
//                       fontSize: 12.sp,
//                       height: 1.3,
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
//   Widget _buildForgotPasswordLink() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: TextButton(
//           onPressed: _showForgotPasswordSnackBar,
//           style: TextButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
//           ),
//           child: Text(
//             'نسيت كلمة المرور؟',
//             style: TextStyle(
//               fontSize: 13.sp,
//               color: _primaryBlue,
//               fontFamily: 'Tajawal',
//               fontWeight: FontWeight.w500,
//               decoration: TextDecoration.underline,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoginButton() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         child: ElevatedButton(
//           onPressed: _isLoading ? null : _signIn,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: _primaryOrange,
//             foregroundColor: Colors.black,
//             padding: EdgeInsets.symmetric(vertical: 16.h),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.r),
//             ),
//             elevation: 4,
//             shadowColor: Colors.black.withOpacity(0.2),
//             disabledBackgroundColor: _primaryOrange.withOpacity(0.6),
//           ),
//           child: _isLoading
//               ? SizedBox(
//             width: 24.w,
//             height: 24.h,
//             child: CircularProgressIndicator(
//               strokeWidth: 2.2.w,
//               color: Colors.black,
//             ),
//           )
//               : Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Iconsax.login_1,
//                 size: 20.sp,
//                 color: Colors.black,
//               ),
//               SizedBox(width: 8.w),
//               Text(
//                 'تسجيل الدخول',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCreateAccountLink() {
//     return GestureDetector(
//       onTap: _showWhatsAppDialog,
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 200),
//           margin: EdgeInsets.symmetric(horizontal: 10.w),
//           padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
//           decoration: BoxDecoration(
//             color: _primaryBlue.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(
//               color: _primaryBlue.withOpacity(0.3),
//               width: 1.2.w,
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Iconsax.info_circle,
//                 color: _primaryBlue,
//                 size: 18.sp,
//               ),
//               SizedBox(width: 8.w),
//               Text(
//                 'ليس لديك حساب؟',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: _primaryBlue,
//                   fontFamily: 'Tajawal',
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(width: 4.w),
//               Text(
//                 'انقر هنا',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: _primaryOrange,
//                   fontFamily: 'Tajawal',
//                   fontWeight: FontWeight.bold,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../widget/NavigationBar.dart';
import 'auth_service.dart';
import '../widget/AnimatedBackground.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  // ألوان متناسقة مع الهوية البصرية
  final Color _primaryBlue = Color(0xFF1E88E5);
  final Color _primaryOrange = Color(0xFFFFA726);
  final Color _errorRed = Color(0xFFEF4444);
  final Color _warningOrange = Color(0xFFFFA726);
  final Color _successGreen = Color(0xFF10B981);
  final Color _darkText = Color(0xFF1E293B);
  final Color _grayText = Color(0xFF64748B);
  final Color _lightGray = Color(0xFFF8FAFC);

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      print('🔐 محاولة تسجيل الدخول بالبريد: $email');

      // إجراء تسجيل الدخول عبر Firebase
      await authService.signInWithEmailAndPassword(email, password);

      // // طباعة حالة المصادقة للتشخيص
      // authService.printAuthState();

      print('✅ تسجيل الدخول ناجح - الانتقال للشاشة الرئيسية');

      // الانتقال إلى الشاشة الرئيسية
      _navigateToHome();

    } catch (e) {
      print('❌ خطأ في تسجيل الدخول: $e');
      _handleAuthError(e);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleAuthError(dynamic error) {
    String title = 'حدث خطأ';
    String message = 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.';
    IconData icon = Iconsax.close_circle;
    Color iconColor = _errorRed;

    String errorString = error.toString();

    // معالجة الأخطاء المخصصة من AuthService
    if (errorString.contains('هذا الحساب مسجل حالياً في جهاز آخر')) {
      title = 'حساب مستخدم';
      message = 'هذا الحساب مسجل حالياً في جهاز آخر. يرجى الخروج منه أولاً ثم المحاولة مرة أخرى.';
      icon = Iconsax.profile_remove;
      iconColor = _warningOrange;
    } else if (errorString.contains('الحساب غير موجود في إعدادات المستخدم')) {
      title = 'حساب غير مكتمل';
      message = 'الحساب غير موجود في إعدادات المستخدم. يرجى التواصل مع الدعم الفني.';
      icon = Iconsax.profile_remove;
    } else if (errorString.contains('الحساب غير مفعل')) {
      title = 'حساب غير مفعل';
      message = 'حسابك غير مفعل حالياً. يرجى التواصل مع الدعم الفني.';
      icon = Iconsax.profile_remove;
    } else if (errorString.contains('فشل في التحقق من حالة الحساب')) {
      title = 'مشكلة في الخادم';
      message = 'تعذر التحقق من حالة الحساب. الرجاء المحاولة مرة أخرى.';
      icon = Iconsax.cloud_remove;
    } else if (errorString.contains('فشل في تحديث حالة الحساب')) {
      title = 'مشكلة في الخادم';
      message = 'تعذر تحديث حالة الحساب. الرجاء المحاولة مرة أخرى.';
      icon = Iconsax.cloud_remove;
    }
    // معالجة أخطاء Firebase
    else if (errorString.contains('user-not-found')) {
      title = 'الحساب غير موجود';
      message = 'البريد الإلكتروني الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.';
      icon = Iconsax.profile_remove;
    } else if (errorString.contains('wrong-password')) {
      title = 'كلمة المرور غير صحيحة';
      message = 'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى.';
      icon = Iconsax.lock_1;
    } else if (errorString.contains('invalid-email')) {
      title = 'بريد إلكتروني غير صالح';
      message = 'صيغة البريد الإلكتروني غير صحيحة. الرجاء التأكد من إدخال بريد إلكتروني صحيح.';
      icon = Icons.sms_failed;
    } else if (errorString.contains('user-disabled')) {
      title = 'الحساب معطل';
      message = 'حسابك معطل حالياً. يرجى التواصل مع الدعم الفني.';
      icon = Iconsax.profile_remove;
    } else if (errorString.contains('too-many-requests')) {
      title = 'طلبات كثيرة جداً';
      message = 'لقد قمت بمحاولات تسجيل دخول كثيرة. الرجاء الانتظار قليلاً ثم المحاولة مرة أخرى.';
      icon = Iconsax.timer_1;
      iconColor = _warningOrange;
    } else if (errorString.contains('network-request-failed')) {
      title = 'مشكلة في الاتصال';
      message = 'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.';
      icon = Iconsax.wifi_square;
      iconColor = _warningOrange;
    } else if (errorString.contains('email-already-in-use')) {
      title = 'البريد الإلكتروني مستخدم مسبقاً';
      message = 'هذا البريد الإلكتروني مسجل بالفعل في نظامنا. الرجاء استخدام بريد إلكتروني آخر.';
      icon = Icons.sms_failed;
    } else if (errorString.contains('weak-password')) {
      title = 'كلمة مرور ضعيفة';
      message = 'كلمة المرور التي أدخلتها ضعيفة جداً. الرجاء اختيار كلمة مرور أقوى.';
      icon = Iconsax.lock_1;
    } else if (errorString.contains('operation-not-allowed')) {
      title = 'العملية غير مسموحة';
      message = 'طريقة التسجيل هذه غير مفعلة حالياً. الرجاء التواصل مع الدعم الفني.';
      icon = Iconsax.security;
    }

    _showErrorDialog(title, message, icon, iconColor);
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainNavigation()),
    );
  }

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
                        color: _darkText,
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
                        color: _grayText,
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

  void _backToIntro() {
    Navigator.pop(context);
  }

  void _showWhatsAppDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(24.w),
            child: SingleChildScrollView(
              child: Container(
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
                child: Padding(
                  padding: EdgeInsets.all(28.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 90.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF25D366),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF25D366).withOpacity(0.3),
                              blurRadius: 20.w,
                              offset: Offset(0, 8.h),
                            ),
                          ],
                        ),
                        child: Icon(
                          Iconsax.message,
                          color: Colors.white,
                          size: 42.sp,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Text(
                        'إنشاء حساب جديد',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: _primaryBlue,
                          fontFamily: 'Tajawal',
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Text(
                        'إذا كنت لا تملك حساباً، يرجى التواصل معنا مباشرة عبر الواتساب للاشتراك وفتح حساب الطالب',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: _grayText,
                          fontFamily: 'Tajawal',
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        'سيتم نقلك مباشرة إلى الواتساب لإكمال عملية الاشتراك',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: _primaryOrange,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 32.h),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: _grayText,
                                side: BorderSide(color: Colors.grey[400]!),
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                backgroundColor: _lightGray,
                              ),
                              child: Text(
                                'إلغاء',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 16.w),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: _launchWhatsApp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF25D366),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                elevation: 4,
                                shadowColor: Color(0xFF25D366).withOpacity(0.3),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.message,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'فتح الواتساب',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Tajawal',
                                    ),
                                  ),
                                ],
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
          ),
        );
      },
    );
  }

  Future<void> _launchWhatsApp() async {
    final String phoneNumber = '966123456789';
    final String message = 'مرحباً، أريد الاشتراك في تطبيق تعلم القراءة وفتح حساب للطالب';

    final String url = "https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}";

    try {
      if (await canLaunch(url)) {
        await launch(url);
        Navigator.of(context).pop();
      } else {
        _showErrorDialog(
          'تعذر فتح الواتساب',
          'لا يمكن فتح تطبيق الواتساب. الرجاء التأكد من تثبيت التطبيق على جهازك.',
          Iconsax.message_remove,
          _warningOrange,
        );
      }
    } catch (e) {
      _showErrorDialog(
        'حدث خطأ',
        'تعذر فتح الرابط: $e',
        Iconsax.close_circle,
        _errorRed,
      );
    }
  }

  void _showForgotPasswordSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'سيتم إضافة هذه الميزة قريباً',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: _primaryOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(20.w),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // زر الرجوع
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: _backToIntro,
                      iconSize: 22.sp,
                    ),
                  ),
                ),

                // محتوى تسجيل الدخول
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 30.w,
                            offset: Offset(0, 15.h),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // أيقونة المستخدم
                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                color: _primaryBlue.withOpacity(0.95),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _primaryBlue.withOpacity(0.3),
                                    blurRadius: 15.w,
                                    offset: Offset(0, 6.h),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Iconsax.profile_circle,
                                color: Colors.white,
                                size: 48.sp,
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // عنوان الشاشة
                            Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: _primaryBlue,
                                fontFamily: 'Tajawal',
                              ),
                            ),

                            SizedBox(height: 6.h),

                            // وصف الشاشة
                            Text(
                              'أدخل بياناتك للمتابعة',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: _grayText,
                                fontFamily: 'Tajawal',
                              ),
                            ),

                            SizedBox(height: 32.h),

                            // حقل البريد الإلكتروني
                            _buildEmailField(),

                            SizedBox(height: 16.h),

                            // حقل كلمة المرور
                            _buildPasswordField(),

                            SizedBox(height: 12.h),

                            // رابط نسيت كلمة المرور
                            _buildForgotPasswordLink(),

                            SizedBox(height: 20.h),

                            // زر تسجيل الدخول
                            _buildLoginButton(),

                            SizedBox(height: 16.h),

                            // رابط إنشاء حساب جديد
                            _buildCreateAccountLink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال البريد الإلكتروني';
          }
          if (!_isValidEmail(value)) {
            return 'البريد الإلكتروني غير صالح';
          }
          return null;
        },
        style: TextStyle(
          color: _darkText,
          fontFamily: 'Tajawal',
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'حساب الطالب (البريد الإلكتروني)',
          labelStyle: TextStyle(
            color: _grayText,
            fontFamily: 'Tajawal',
            fontSize: 14.sp,
          ),
          hintText: 'أدخل بريدك الإلكتروني',
          hintStyle: TextStyle(
            color: _grayText.withOpacity(0.6),
            fontFamily: 'Tajawal',
          ),
          prefixIcon: Icon(Iconsax.sms, color: _primaryBlue, size: 20.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: _primaryOrange,
              width: 2.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: _errorRed,
              width: 1.5.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: _errorRed,
              width: 2.w,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال كلمة المرور';
          }
          if (value.length < 6) {
            return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
          }
          return null;
        },
        style: TextStyle(
          color: _darkText,
          fontFamily: 'Tajawal',
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'كلمة المرور',
          labelStyle: TextStyle(
            color: _grayText,
            fontFamily: 'Tajawal',
            fontSize: 14.sp,
          ),
          hintText: 'أدخل كلمة المرور',
          hintStyle: TextStyle(
            color: _grayText.withOpacity(0.6),
            fontFamily: 'Tajawal',
          ),
          prefixIcon: Icon(Iconsax.lock_1, color: _primaryBlue, size: 20.sp),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
              color: Colors.grey,
              size: 20.sp,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: _primaryOrange,
              width: 2.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: _errorRed,
              width: 1.5.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: _errorRed,
              width: 2.w,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: _showForgotPasswordSnackBar,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          ),
          child: Text(
            'نسيت كلمة المرور؟',
            style: TextStyle(
              fontSize: 13.sp,
              color: _primaryBlue,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: _isLoading ? null : _handleAuth,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryOrange,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.2),
            disabledBackgroundColor: _primaryOrange.withOpacity(0.6),
          ),
          child: _isLoading
              ? SizedBox(
            width: 24.w,
            height: 24.h,
            child: CircularProgressIndicator(
              strokeWidth: 2.2.w,
              color: Colors.black,
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.login_1,
                size: 20.sp,
                color: Colors.black,
              ),
              SizedBox(width: 8.w),
              Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountLink() {
    return GestureDetector(
      onTap: _showWhatsAppDialog,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: _primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _primaryBlue.withOpacity(0.3),
              width: 1.2.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.info_circle,
                color: _primaryBlue,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'ليس لديك حساب؟',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: _primaryBlue,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                'انقر هنا',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: _primaryOrange,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}