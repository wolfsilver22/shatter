// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../screens/SecondScreen/lessons_list_screen.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
//       setState(() {
//         _errorMessage = 'يرجى ملء جميع الحقول';
//       });
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       // هنا يمكنك إضافة منطق تسجيل الدخول مع Supabase
//       // مثال:
//       // final response = await _supabase.auth.signInWithPassword(
//       //   phone: _phoneController.text,
//       //   password: _passwordController.text,
//       // );
//
//       // لمثالنا سنستخدم الانتقال المباشر
//       await Future.delayed(Duration(seconds: 1)); // محاكاة اتصال الشبكة
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LessonsListScreen()),
//       );
//
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'خطأ في تسجيل الدخول: $e';
//       });
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _backToIntro() {
//     Navigator.pop(context);
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
//                 // زر العودة
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_forward, color: Color(0xFF1E88E5)),
//                     onPressed: _backToIntro,
//                   ),
//                 ),
//
//                 SizedBox(height: 20.h),
//
//                 // العنوان
//                 Text(
//                   'تسجيل الدخول',
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E88E5),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // حقل رقم الهاتف
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 40.w),
//                   child: TextFormField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       labelText: 'رقم الهاتف',
//                       prefixIcon: Icon(Icons.phone, color: Color(0xFF1E88E5)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.w),
//                         borderSide: BorderSide(color: Color(0xFF1E88E5), width: 2),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20.h),
//
//                 // حقل كلمة المرور
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 40.w),
//                   child: TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'كلمة المرور',
//                       prefixIcon: Icon(Icons.lock, color: Color(0xFF1E88E5)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.w),
//                         borderSide: BorderSide(color: Color(0xFF1E88E5), width: 2),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 30.h),
//
//                 // رسالة الخطأ
//                 if (_errorMessage.isNotEmpty)
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 40.w),
//                     padding: EdgeInsets.all(12.w),
//                     decoration: BoxDecoration(
//                       color: Colors.red[50],
//                       borderRadius: BorderRadius.circular(8.w),
//                       border: Border.all(color: Colors.red),
//                     ),
//                     child: Text(
//                       _errorMessage,
//                       style: TextStyle(
//                         color: Colors.red[700],
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//
//                 SizedBox(height: 20.h),
//
//                 // زر تسجيل الدخول
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 40.w),
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _signIn,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF1E88E5),
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(vertical: 16.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.w),
//                       ),
//                       elevation: 4,
//                     ),
//                     child: _isLoading
//                         ? SizedBox(
//                       width: 20.w,
//                       height: 20.h,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: Colors.white,
//                       ),
//                     )
//                         : Text(
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
//                 SizedBox(height: 16.h),
//
//                 // رابط نسيت كلمة المرور
//                 TextButton(
//                   onPressed: () {
//                     // يمكن إضافة شاشة استعادة كلمة المرور لاحقاً
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('سيتم إضافة هذه الميزة قريباً'),
//                         backgroundColor: Color(0xFF1E88E5),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'نسيت كلمة المرور؟',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Color(0xFF1E88E5),
//                       fontFamily: 'Tajawal',
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
// import '../screens/SecondScreen/lessons_list_screen.dart';
// import '../widget/GradeSelectionScreen.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
//       setState(() {
//         _errorMessage = 'يرجى ملء جميع الحقول';
//       });
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     try {
//       // هنا يمكنك إضافة منطق تسجيل الدخول مع Supabase
//       // مثال:
//       // final response = await _supabase.auth.signInWithPassword(
//       //   phone: _phoneController.text,
//       //   password: _passwordController.text,
//       // );
//
//       // لمثالنا سنستخدم الانتقال المباشر
//       await Future.delayed(Duration(seconds: 1)); // محاكاة اتصال الشبكة
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => GradeSelectionScreen()),
//       );
//
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'خطأ في تسجيل الدخول: $e';
//       });
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _backToIntro() {
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1E88E5),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // زر العودة
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_forward, color: Colors.white),
//                       onPressed: _backToIntro,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // أيقونة الدخول
//                 Container(
//                   width: 100.w,
//                   height: 100.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 15.w,
//                         offset: Offset(0, 5.h),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.person,
//                     color: Color(0xFF1E88E5),
//                     size: 50.sp,
//                   ),
//                 ),
//
//                 SizedBox(height: 30.h),
//
//                 // العنوان
//                 Text(
//                   'تسجيل الدخول',
//                   style: TextStyle(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//
//                 SizedBox(height: 8.h),
//
//                 // الوصف
//                 Text(
//                   'أدخل بياناتك للمتابعة',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.white.withOpacity(0.8),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//
//                 SizedBox(height: 50.h),
//
//                 // حقل رقم الهاتف
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: TextFormField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontFamily: 'Tajawal',
//                       fontSize: 16.sp,
//                     ),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       labelText: 'رقم الهاتف',
//                       labelStyle: TextStyle(
//                         color: Colors.grey[600],
//                         fontFamily: 'Tajawal',
//                       ),
//                       prefixIcon: Icon(Icons.phone, color: Color(0xFF1E88E5)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.w),
//                         borderSide: BorderSide.none,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.w),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.w),
//                         borderSide: BorderSide(
//                           color: Color(0xFFFFA726),
//                           width: 2.w,
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 20.w,
//                         vertical: 16.h,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20.h),
//
//                 // حقل كلمة المرور
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontFamily: 'Tajawal',
//                       fontSize: 16.sp,
//                     ),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       labelText: 'كلمة المرور',
//                       labelStyle: TextStyle(
//                         color: Colors.grey[600],
//                         fontFamily: 'Tajawal',
//                       ),
//                       prefixIcon: Icon(Icons.lock, color: Color(0xFF1E88E5)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.w),
//                         borderSide: BorderSide.none,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.w),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.w),
//                         borderSide: BorderSide(
//                           color: Color(0xFFFFA726),
//                           width: 2.w,
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 20.w,
//                         vertical: 16.h,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 30.h),
//
//                 // رسالة الخطأ
//                 if (_errorMessage.isNotEmpty)
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 30.w),
//                     padding: EdgeInsets.all(16.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12.w),
//                       border: Border.all(color: Colors.red),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 8.w,
//                           offset: Offset(0, 3.h),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.error_outline, color: Colors.red),
//                         SizedBox(width: 10.w),
//                         Expanded(
//                           child: Text(
//                             _errorMessage,
//                             style: TextStyle(
//                               color: Colors.red[700],
//                               fontFamily: 'Tajawal',
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 SizedBox(height: 30.h),
//
//                 // زر تسجيل الدخول
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _signIn,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFFA726),
//                       foregroundColor: Colors.black,
//                       padding: EdgeInsets.symmetric(vertical: 18.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.w),
//                       ),
//                       elevation: 6,
//                       shadowColor: Colors.black.withOpacity(0.3),
//                     ),
//                     child: _isLoading
//                         ? SizedBox(
//                       width: 24.w,
//                       height: 24.h,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2.w,
//                         color: Colors.black,
//                       ),
//                     )
//                         : Text(
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
//                 SizedBox(height: 20.h),
//
//                 // رابط نسيت كلمة المرور
//                 TextButton(
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           'سيتم إضافة هذه الميزة قريباً',
//                           style: TextStyle(fontFamily: 'Tajawal'),
//                         ),
//                         backgroundColor: Color(0xFFFFA726),
//                         behavior: SnackBarBehavior.floating,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.w),
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'نسيت كلمة المرور؟',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.white,
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
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widget/GradeSelectionScreen.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   final TextEditingController _studentNumberController = TextEditingController();
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
//     _studentNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_studentNumberController.text.isEmpty || _passwordController.text.isEmpty) {
//       _showErrorDialog(
//         'بيانات ناقصة',
//         'يرجى ملء جميع الحقول المطلوبة للمتابعة',
//         Iconsax.warning_2,
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
//       // محاكاة اتصال الشبكة
//       await Future.delayed(Duration(seconds: 1));
//
//       final phone = _studentNumberController.text.trim();
//       final password = _passwordController.text.trim();
//
//       // محاكاة أخطاء مختلفة للاختبار
//       if (phone == '0000000000') {
//         _showErrorDialog(
//           'الحساب غير موجود',
//           'رقم الهاتف الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.',
//           Iconsax.profile_remove,
//           _errorRed,
//         );
//         return;
//       }
//
//       if (password == 'wrongpassword') {
//         _showErrorDialog(
//           'كلمة المرور غير صحيحة',
//           'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى أو استخدام خيار "نسيت كلمة المرور".',
//           Iconsax.lock_1,
//           _errorRed,
//         );
//         return;
//       }
//
//       if (phone == '1111111111') {
//         _showErrorDialog(
//           'مشكلة في الاتصال',
//           'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.',
//           Iconsax.wifi_square,
//           _warningOrange,
//         );
//         return;
//       }
//
//       if (phone == '2222222222') {
//         _showErrorDialog(
//           'طلبات كثيرة جداً',
//           'لقد قمت بمحاولات تسجيل دخول كثيرة. الرجاء الانتظار قليلاً ثم المحاولة مرة أخرى.',
//           Iconsax.timer_1,
//           _warningOrange,
//         );
//         return;
//       }
//
//       // إذا نجح التسجيل
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => GradeSelectionScreen()),
//       );
//
//     } catch (e) {
//       _showErrorDialog(
//         'حدث خطأ غير متوقع',
//         'حدث خطأ غير متوقع في النظام. الرجاء المحاولة مرة أخرى لاحقاً.',
//         Iconsax.close_circle,
//         _errorRed,
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
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
//                       // أيقونة الواتساب
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
//                       // العنوان
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
//                       // النص التوضيحي
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
//                       // أزرار التحكم
//                       Row(
//                         children: [
//                           // زر الإلغاء
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
//                           // زر فتح الواتساب
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
//     return Scaffold(
//       backgroundColor: _primaryBlue,
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // الجزء العلوي: زر العودة فقط
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: _backToIntro,
//                     iconSize: 22.sp,
//                   ),
//                 ),
//               ),
//
//               // الجزء الأوسط: محتوى النموذج
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: NeverScrollableScrollPhysics(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // أيقونة الدخول
//                       Container(
//                         width: 100.w,
//                         height: 100.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.95),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.15),
//                               blurRadius: 15.w,
//                               offset: Offset(0, 6.h),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Iconsax.profile_circle,
//                           color: _primaryBlue,
//                           size: 48.sp,
//                         ),
//                       ),
//
//                       SizedBox(height: 24.h),
//
//                       // العنوان
//                       Text(
//                         'تسجيل الدخول',
//                         style: TextStyle(
//                           fontSize: 28.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 6.h),
//
//                       // الوصف
//                       Text(
//                         'أدخل بياناتك للمتابعة',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 32.h),
//
//                       // حقل رقم الهاتف
//                       _buildPhoneField(),
//
//                       SizedBox(height: 16.h),
//
//                       // حقل كلمة المرور
//                       _buildPasswordField(),
//
//                       SizedBox(height: 12.h),
//
//                       // رسالة الخطأ
//                       if (_errorMessage.isNotEmpty) _buildErrorWidget(),
//
//                       SizedBox(height: _errorMessage.isNotEmpty ? 16.h : 0.h),
//
//                       // رابط نسيت كلمة المرور
//                       _buildForgotPasswordLink(),
//
//                       SizedBox(height: 20.h),
//
//                       // زر تسجيل الدخول
//                       _buildLoginButton(),
//
//                       SizedBox(height: 16.h),
//
//                       // رابط ليس لديك حساب
//                       _buildCreateAccountLink(),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // مسافة بسيطة في الأسفل للتوازن
//               SizedBox(height: 10.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPhoneField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _studentNumberController,
//         keyboardType: TextInputType.phone,
//         style: TextStyle(
//           color: _darkText,
//           fontFamily: 'Tajawal',
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'رقم الحساب',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           prefixIcon: Icon(Iconsax.user, color: _primaryBlue, size: 20.sp),
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
//               color: Colors.white,
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
//           color: Colors.white.withOpacity(0.12),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: Colors.white.withOpacity(0.3),
//             width: 1.2.w,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Iconsax.info_circle,
//               color: Colors.white.withOpacity(0.9),
//               size: 18.sp,
//             ),
//             SizedBox(width: 8.w),
//             Text(
//               'ليس لديك حساب؟',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.white.withOpacity(0.9),
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(width: 4.w),
//             Text(
//               'انقر هنا',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Color(0xFFFFD54F),
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
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widget/GradeSelectionScreen.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   final TextEditingController _studentNumberController = TextEditingController();
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
//     _studentNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_studentNumberController.text.isEmpty || _passwordController.text.isEmpty) {
//       _showErrorDialog(
//         'بيانات ناقصة',
//         'يرجى ملء جميع الحقول المطلوبة للمتابعة',
//         Iconsax.warning_2,
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
//       final studentNumber = _studentNumberController.text.trim();
//       final password = _passwordController.text.trim();
//
//       // البحث عن المستخدم في قاعدة البيانات
//       final response = await _supabase
//           .from('users')
//           .select()
//           .eq('student_number', studentNumber)
//           .single();
//
//       // التحقق من حالة الحساب
//       if (!response['is_active']) {
//         _showErrorDialog(
//           'الحساب غير مفعل',
//           'حسابك غير مفعل حالياً. يرجى التواصل مع الدعم الفني.',
//           Iconsax.profile_remove,
//           _errorRed,
//         );
//         return;
//       }
//
//       // التحقق من كلمة المرور
//       if (response['password'] != password) {
//         _showErrorDialog(
//           'كلمة المرور غير صحيحة',
//           'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى.',
//           Iconsax.lock_1,
//           _errorRed,
//         );
//         return;
//       }
//
//       // إذا نجح التسجيل
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => GradeSelectionDialog()),
//       );
//
//     } on PostgrestException catch (e) {
//       if (e.code == 'PGRST116') {
//         // الحساب غير موجود
//         _showErrorDialog(
//           'الحساب غير موجود',
//           'رقم الحساب الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.',
//           Iconsax.profile_remove,
//           _errorRed,
//         );
//       } else {
//         _showErrorDialog(
//           'خطأ في النظام',
//           'حدث خطأ غير متوقع في النظام. الرجاء المحاولة مرة أخرى لاحقاً.',
//           Iconsax.close_circle,
//           _errorRed,
//         );
//       }
//     } catch (e) {
//       _showErrorDialog(
//         'مشكلة في الاتصال',
//         'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.',
//         Iconsax.wifi_square,
//         _warningOrange,
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
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
//                       // أيقونة الواتساب
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
//                       // العنوان
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
//                       // النص التوضيحي
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
//                       // أزرار التحكم
//                       Row(
//                         children: [
//                           // زر الإلغاء
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
//                           // زر فتح الواتساب
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
//     return Scaffold(
//       backgroundColor: _primaryBlue,
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // الجزء العلوي: زر العودة فقط
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: _backToIntro,
//                     iconSize: 22.sp,
//                   ),
//                 ),
//               ),
//
//               // الجزء الأوسط: محتوى النموذج
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: NeverScrollableScrollPhysics(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // أيقونة الدخول
//                       Container(
//                         width: 100.w,
//                         height: 100.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.95),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.15),
//                               blurRadius: 15.w,
//                               offset: Offset(0, 6.h),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Iconsax.profile_circle,
//                           color: _primaryBlue,
//                           size: 48.sp,
//                         ),
//                       ),
//
//                       SizedBox(height: 24.h),
//
//                       // العنوان
//                       Text(
//                         'تسجيل الدخول',
//                         style: TextStyle(
//                           fontSize: 28.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 6.h),
//
//                       // الوصف
//                       Text(
//                         'أدخل بياناتك للمتابعة',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 32.h),
//
//                       // حقل رقم الحساب
//                       _buildStudentNumberField(),
//
//                       SizedBox(height: 16.h),
//
//                       // حقل كلمة المرور
//                       _buildPasswordField(),
//
//                       SizedBox(height: 12.h),
//
//                       // رسالة الخطأ
//                       if (_errorMessage.isNotEmpty) _buildErrorWidget(),
//
//                       SizedBox(height: _errorMessage.isNotEmpty ? 16.h : 0.h),
//
//                       // رابط نسيت كلمة المرور
//                       _buildForgotPasswordLink(),
//
//                       SizedBox(height: 20.h),
//
//                       // زر تسجيل الدخول
//                       _buildLoginButton(),
//
//                       SizedBox(height: 16.h),
//
//                       // رابط ليس لديك حساب
//                       _buildCreateAccountLink(),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // مسافة بسيطة في الأسفل للتوازن
//               SizedBox(height: 10.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStudentNumberField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _studentNumberController,
//         keyboardType: TextInputType.text,
//         style: TextStyle(
//           color: _darkText,
//           fontFamily: 'Tajawal',
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'رقم الحساب',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           prefixIcon: Icon(Iconsax.user, color: _primaryBlue, size: 20.sp),
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
//               color: Colors.white,
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
//           color: Colors.white.withOpacity(0.12),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: Colors.white.withOpacity(0.3),
//             width: 1.2.w,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Iconsax.info_circle,
//               color: Colors.white.withOpacity(0.9),
//               size: 18.sp,
//             ),
//             SizedBox(width: 8.w),
//             Text(
//               'ليس لديك حساب؟',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.white.withOpacity(0.9),
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(width: 4.w),
//             Text(
//               'انقر هنا',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Color(0xFFFFD54F),
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
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widget/GradeSelectionScreen.dart';
// import '../widget/NavigationBar.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   final TextEditingController _studentNumberController = TextEditingController();
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
//     _studentNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_studentNumberController.text.isEmpty || _passwordController.text.isEmpty) {
//       _showErrorDialog(
//         'بيانات ناقصة',
//         'يرجى ملء جميع الحقول المطلوبة للمتابعة',
//         Iconsax.warning_2,
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
//       final studentNumber = _studentNumberController.text.trim();
//       final password = _passwordController.text.trim();
//
//       // البحث عن المستخدم في قاعدة البيانات
//       final response = await _supabase
//           .from('users')
//           .select()
//           .eq('student_number', studentNumber)
//           .single();
//
//       // التحقق من حالة الحساب
//       if (!response['is_active']) {
//         _showErrorDialog(
//           'الحساب غير مفعل',
//           'حسابك غير مفعل حالياً. يرجى التواصل مع الدعم الفني.',
//           Iconsax.profile_remove,
//           _errorRed,
//         );
//         return;
//       }
//
//       // التحقق من كلمة المرور
//       if (response['password'] != password) {
//         _showErrorDialog(
//           'كلمة المرور غير صحيحة',
//           'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى.',
//           Iconsax.lock_1,
//           _errorRed,
//         );
//         return;
//       }
//
//       // إذا نجح التسجيل، عرض دايلوج اختيار الصف
//       _showGradeSelectionDialog();
//
//     } on PostgrestException catch (e) {
//       if (e.code == 'PGRST116') {
//         // الحساب غير موجود
//         _showErrorDialog(
//           'الحساب غير موجود',
//           'رقم الحساب الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.',
//           Iconsax.profile_remove,
//           _errorRed,
//         );
//       } else {
//         _showErrorDialog(
//           'خطأ في النظام',
//           'حدث خطأ غير متوقع في النظام. الرجاء المحاولة مرة أخرى لاحقاً.',
//           Iconsax.close_circle,
//           _errorRed,
//         );
//       }
//     } catch (e) {
//       _showErrorDialog(
//         'مشكلة في الاتصال',
//         'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.',
//         Iconsax.wifi_square,
//         _warningOrange,
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _showGradeSelectionDialog() {
//     GradeSelectionDialog.show(
//       context: context,
//       onGradeSelected: (selectedGrade) {
//         // معالجة الصف المختار هنا
//         print('تم اختيار الصف: $selectedGrade');
//
//         // يمكنك حفظ الصف المختار في SharedPreferences أو state management
//         _saveSelectedGrade(selectedGrade);
//
//         // الانتقال إلى الشاشة الرئيسية
//         _navigateToHome();
//       },
//     );
//   }
//
//   void _saveSelectedGrade(String grade) {
//     // هنا يمكنك حفظ الصف المختار في SharedPreferences أو قاعدة البيانات
//     print('حفظ الصف المختار: $grade');
//     // مثال:
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // await prefs.setString('selected_grade', grade);
//   }
//
//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => CustomBottomNav()),
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
//                       // أيقونة الواتساب
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
//                       // العنوان
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
//                       // النص التوضيحي
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
//                       // أزرار التحكم
//                       Row(
//                         children: [
//                           // زر الإلغاء
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
//                           // زر فتح الواتساب
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
//     return Scaffold(
//       backgroundColor: _primaryBlue,
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // الجزء العلوي: زر العودة فقط
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: _backToIntro,
//                     iconSize: 22.sp,
//                   ),
//                 ),
//               ),
//
//               // الجزء الأوسط: محتوى النموذج
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: NeverScrollableScrollPhysics(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // أيقونة الدخول
//                       Container(
//                         width: 100.w,
//                         height: 100.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.95),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.15),
//                               blurRadius: 15.w,
//                               offset: Offset(0, 6.h),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Iconsax.profile_circle,
//                           color: _primaryBlue,
//                           size: 48.sp,
//                         ),
//                       ),
//
//                       SizedBox(height: 24.h),
//
//                       // العنوان
//                       Text(
//                         'تسجيل الدخول',
//                         style: TextStyle(
//                           fontSize: 28.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 6.h),
//
//                       // الوصف
//                       Text(
//                         'أدخل بياناتك للمتابعة',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 32.h),
//
//                       // حقل رقم الحساب
//                       _buildStudentNumberField(),
//
//                       SizedBox(height: 16.h),
//
//                       // حقل كلمة المرور
//                       _buildPasswordField(),
//
//                       SizedBox(height: 12.h),
//
//                       // رسالة الخطأ
//                       if (_errorMessage.isNotEmpty) _buildErrorWidget(),
//
//                       SizedBox(height: _errorMessage.isNotEmpty ? 16.h : 0.h),
//
//                       // رابط نسيت كلمة المرور
//                       _buildForgotPasswordLink(),
//
//                       SizedBox(height: 20.h),
//
//                       // زر تسجيل الدخول
//                       _buildLoginButton(),
//
//                       SizedBox(height: 16.h),
//
//                       // رابط ليس لديك حساب
//                       _buildCreateAccountLink(),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // مسافة بسيطة في الأسفل للتوازن
//               SizedBox(height: 10.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStudentNumberField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _studentNumberController,
//         keyboardType: TextInputType.text,
//         style: TextStyle(
//           color: _darkText,
//           fontFamily: 'Tajawal',
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'رقم الحساب',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           prefixIcon: Icon(Iconsax.user, color: _primaryBlue, size: 20.sp),
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
//               color: Colors.white,
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
//           color: Colors.white.withOpacity(0.12),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: Colors.white.withOpacity(0.3),
//             width: 1.2.w,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Iconsax.info_circle,
//               color: Colors.white.withOpacity(0.9),
//               size: 18.sp,
//             ),
//             SizedBox(width: 8.w),
//             Text(
//               'ليس لديك حساب؟',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.white.withOpacity(0.9),
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(width: 4.w),
//             Text(
//               'انقر هنا',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Color(0xFFFFD54F),
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
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:provider/provider.dart';
// import '../widget/GradeSelectionScreen.dart';
// import '../widget/NavigationBar.dart';
// import 'auth_service.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _studentNumberController = TextEditingController();
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
//     _studentNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_studentNumberController.text.isEmpty || _passwordController.text.isEmpty) {
//       _showErrorDialog(
//         'بيانات ناقصة',
//         'يرجى ملء جميع الحقول المطلوبة للمتابعة',
//         Iconsax.warning_2,
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
//       final studentNumber = _studentNumberController.text.trim();
//       final password = _passwordController.text.trim();
//
//       await authService.login(studentNumber, password);
//
//       // إذا نجح التسجيل، عرض دايلوج اختيار الصف
//       _showGradeSelectionDialog();
//
//     } catch (e) {
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
//   void _handleLoginError(dynamic error) {
//     String title = 'خطأ في التسجيل';
//     String message = 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.';
//     IconData icon = Iconsax.close_circle;
//     Color iconColor = _errorRed;
//
//     if (error is PostgrestException) {
//       if (error.code == 'PGRST116') {
//         title = 'الحساب غير موجود';
//         message = 'رقم الحساب الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.';
//         icon = Iconsax.profile_remove;
//       } else {
//         title = 'خطأ في النظام';
//         message = 'حدث خطأ غير متوقع في النظام. الرجاء المحاولة مرة أخرى لاحقاً.';
//       }
//     } else if (error is Exception) {
//       final errorMessage = error.toString();
//       if (errorMessage.contains('الحساب غير مفعل')) {
//         title = 'الحساب غير مفعل';
//         message = 'حسابك غير مفعل حالياً. يرجى التواصل مع الدعم الفني.';
//         icon = Iconsax.profile_remove;
//       } else if (errorMessage.contains('كلمة المرور غير صحيحة')) {
//         title = 'كلمة المرور غير صحيحة';
//         message = 'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى.';
//         icon = Iconsax.lock_1;
//       } else if (errorMessage.contains('الاتصال')) {
//         title = 'مشكلة في الاتصال';
//         message = 'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.';
//         icon = Iconsax.wifi_square;
//         iconColor = _warningOrange;
//       }
//     }
//
//     _showErrorDialog(title, message, icon, iconColor);
//   }
//
//   void _showGradeSelectionDialog() {
//     GradeSelectionDialog.show(
//       context: context,
//       onGradeSelected: (selectedGrade) async {
//         final authService = Provider.of<AuthService>(context, listen: false);
//         await authService.setSelectedGrade(selectedGrade);
//
//         _navigateToHome();
//       },
//     );
//   }
//
//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => CustomBottomNav()),
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
//                       // أيقونة الواتساب
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
//                       // العنوان
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
//                       // النص التوضيحي
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
//                       // أزرار التحكم
//                       Row(
//                         children: [
//                           // زر الإلغاء
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
//                           // زر فتح الواتساب
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
//     return Scaffold(
//       backgroundColor: _primaryBlue,
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // الجزء العلوي: زر العودة فقط
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: _backToIntro,
//                     iconSize: 22.sp,
//                   ),
//                 ),
//               ),
//
//               // الجزء الأوسط: محتوى النموذج
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: NeverScrollableScrollPhysics(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // أيقونة الدخول
//                       Container(
//                         width: 100.w,
//                         height: 100.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.95),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.15),
//                               blurRadius: 15.w,
//                               offset: Offset(0, 6.h),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Iconsax.profile_circle,
//                           color: _primaryBlue,
//                           size: 48.sp,
//                         ),
//                       ),
//
//                       SizedBox(height: 24.h),
//
//                       // العنوان
//                       Text(
//                         'تسجيل الدخول',
//                         style: TextStyle(
//                           fontSize: 28.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 6.h),
//
//                       // الوصف
//                       Text(
//                         'أدخل بياناتك للمتابعة',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 32.h),
//
//                       // حقل رقم الحساب
//                       _buildStudentNumberField(),
//
//                       SizedBox(height: 16.h),
//
//                       // حقل كلمة المرور
//                       _buildPasswordField(),
//
//                       SizedBox(height: 12.h),
//
//                       // رسالة الخطأ
//                       if (_errorMessage.isNotEmpty) _buildErrorWidget(),
//
//                       SizedBox(height: _errorMessage.isNotEmpty ? 16.h : 0.h),
//
//                       // رابط نسيت كلمة المرور
//                       _buildForgotPasswordLink(),
//
//                       SizedBox(height: 20.h),
//
//                       // زر تسجيل الدخول
//                       _buildLoginButton(),
//
//                       SizedBox(height: 16.h),
//
//                       // رابط ليس لديك حساب
//                       _buildCreateAccountLink(),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // مسافة بسيطة في الأسفل للتوازن
//               SizedBox(height: 10.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStudentNumberField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _studentNumberController,
//         keyboardType: TextInputType.text,
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
//           labelText: 'رقم الحساب',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           hintText: 'أدخل رقم حسابك',
//           hintStyle: TextStyle(
//             color: _grayText.withOpacity(0.6),
//             fontFamily: 'Tajawal',
//           ),
//           prefixIcon: Icon(Iconsax.user, color: _primaryBlue, size: 20.sp),
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
//               color: Colors.white,
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
//           color: Colors.white.withOpacity(0.12),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: Colors.white.withOpacity(0.3),
//             width: 1.2.w,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Iconsax.info_circle,
//               color: Colors.white.withOpacity(0.9),
//               size: 18.sp,
//             ),
//             SizedBox(width: 8.w),
//             Text(
//               'ليس لديك حساب؟',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.white.withOpacity(0.9),
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(width: 4.w),
//             Text(
//               'انقر هنا',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Color(0xFFFFD54F),
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
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:provider/provider.dart';
// import '../widget/NavigationBar.dart';
// import 'auth_service.dart';
// import '../widget/AnimatedBackground.dart'; // أضف هذا الاستيراد
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _studentNumberController = TextEditingController();
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
//     _studentNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     if (_studentNumberController.text.isEmpty || _passwordController.text.isEmpty) {
//       _showErrorDialog(
//         'بيانات ناقصة',
//         'يرجى ملء جميع الحقول المطلوبة للمتابعة',
//         Iconsax.warning_2,
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
//       final studentNumber = _studentNumberController.text.trim();
//       final password = _passwordController.text.trim();
//
//       await authService.login(studentNumber, password);
//
//       // إذا نجح التسجيل، الانتقال مباشرة إلى الشاشة الرئيسية
//       _navigateToHome();
//
//     } catch (e) {
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
//   void _handleLoginError(dynamic error) {
//     String title = 'خطأ في التسجيل';
//     String message = 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.';
//     IconData icon = Iconsax.close_circle;
//     Color iconColor = _errorRed;
//
//     if (error is PostgrestException) {
//       if (error.code == 'PGRST116') {
//         title = 'الحساب غير موجود';
//         message = 'رقم الحساب الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.';
//         icon = Iconsax.profile_remove;
//       } else {
//         title = 'خطأ في النظام';
//         message = 'حدث خطأ غير متوقع في النظام. الرجاء المحاولة مرة أخرى لاحقاً.';
//       }
//     } else if (error is Exception) {
//       final errorMessage = error.toString();
//       if (errorMessage.contains('الحساب غير مفعل')) {
//         title = 'الحساب غير مفعل';
//         message = 'حسابك غير مفعل حالياً. يرجى التواصل مع الدعم الفني.';
//         icon = Iconsax.profile_remove;
//       } else if (errorMessage.contains('كلمة المرور غير صحيحة')) {
//         title = 'كلمة المرور غير صحيحة';
//         message = 'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى.';
//         icon = Iconsax.lock_1;
//       } else if (errorMessage.contains('الاتصال')) {
//         title = 'مشكلة في الاتصال';
//         message = 'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.';
//         icon = Iconsax.wifi_square;
//         iconColor = _warningOrange;
//       }
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
//                       // أيقونة الواتساب
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
//                       // العنوان
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
//                       // النص التوضيحي
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
//                       // أزرار التحكم
//                       Row(
//                         children: [
//                           // زر الإلغاء
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
//                           // زر فتح الواتساب
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
//         backgroundColor: Colors.transparent, // جعل الخلفية شفافة للأنيميشن
//         body: SafeArea(
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // الجزء العلوي: زر العودة فقط
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
//                 // الجزء الأوسط: محتوى النموذج مع خلفية شفافة
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
//                           // أيقونة الدخول
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
//                           // العنوان
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
//                           // الوصف
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
//                           // حقل رقم الحساب
//                           _buildStudentNumberField(),
//
//                           SizedBox(height: 16.h),
//
//                           // حقل كلمة المرور
//                           _buildPasswordField(),
//
//                           SizedBox(height: 12.h),
//
//                           // رسالة الخطأ
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
//                           // رابط ليس لديك حساب
//                           _buildCreateAccountLink(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // مسافة بسيطة في الأسفل للتوازن
//                 SizedBox(height: 10.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStudentNumberField() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w),
//       child: TextFormField(
//         controller: _studentNumberController,
//         keyboardType: TextInputType.text,
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
//           labelText: 'رقم الحساب',
//           labelStyle: TextStyle(
//             color: _grayText,
//             fontFamily: 'Tajawal',
//             fontSize: 14.sp,
//           ),
//           hintText: 'أدخل رقم حسابك',
//           hintStyle: TextStyle(
//             color: _grayText.withOpacity(0.6),
//             fontFamily: 'Tajawal',
//           ),
//           prefixIcon: Icon(Iconsax.user, color: _primaryBlue, size: 20.sp),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  final TextEditingController _studentNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  // ألوان متناسقة مع الهوية البصرية
  final Color _primaryBlue = Color(0xFF1E88E5);
  final Color _primaryOrange = Color(0xFFFFA726);
  final Color _errorRed = Color(0xFFEF4444);
  final Color _warningOrange = Color(0xFFFFA726);
  final Color _successGreen = Color(0xFF10B981);
  final Color _darkText = Color(0xFF1E293B);
  final Color _grayText = Color(0xFF64748B);
  final Color _lightGray = Color(0xFFF8FAFC);

  @override
  void dispose() {
    _studentNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_studentNumberController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog(
        'بيانات ناقصة',
        'يرجى ملء جميع الحقول المطلوبة للمتابعة',
        Iconsax.warning_2,
        _warningOrange,
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final studentNumber = _studentNumberController.text.trim();
      final password = _passwordController.text.trim();

      print('🔐 محاولة تسجيل الدخول برقم: $studentNumber');

      // التحقق من حالة isLogin أولاً
      final isAlreadyLoggedIn = await authService.checkLoginStatus(studentNumber);
      print('📊 حالة isLogin: $isAlreadyLoggedIn');

      if (isAlreadyLoggedIn) {
        _showErrorDialog(
          'الحساب قيد الاستخدام',
          'هذا الحساب مسجل حالياً في جهاز آخر. يرجى الخروج منه أولاً ثم المحاولة مرة أخرى.',
          Iconsax.profile_remove,
          _warningOrange,
        );
        return;
      }

      // إجراء تسجيل الدخول
      await authService.login(studentNumber, password);
      print('✅ تسجيل الدخول ناجح');

      // الانتقال إلى الشاشة الرئيسية
      _navigateToHome();

    } catch (e) {
      print('❌ خطأ في تسجيل الدخول: $e');
      print('❌ نوع الخطأ: ${e.runtimeType}');
      _handleLoginError(e);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleLoginError(dynamic error) {
    String title = 'خطأ في التسجيل';
    String message = 'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى.';
    IconData icon = Iconsax.close_circle;
    Color iconColor = _errorRed;

    if (error is PostgrestException) {
      print('🗄️ خطأ قاعدة بيانات: ${error.code} - ${error.message}');
      if (error.code == 'PGRST116') {
        title = 'الحساب غير موجود';
        message = 'رقم الحساب الذي أدخلته غير مسجل في نظامنا. الرجاء التأكد أو إنشاء حساب جديد.';
        icon = Iconsax.profile_remove;
      } else {
        title = 'خطأ في النظام';
        message = 'حدث خطأ غير متوقع في النظام. الرجاء المحاولة مرة أخرى لاحقاً.';
      }
    } else if (error is Exception) {
      final errorMessage = error.toString();
      print('⚠️ رسالة الخطأ: $errorMessage');

      if (errorMessage.contains('الحساب غير مفعل')) {
        title = 'الحساب غير مفعل';
        message = 'حسابك غير مفعل حالياً. يرجى التواصل مع الدعم الفني.';
        icon = Iconsax.profile_remove;
      } else if (errorMessage.contains('كلمة المرور غير صحيحة')) {
        title = 'كلمة المرور غير صحيحة';
        message = 'كلمة المرور التي أدخلتها لا تتطابق مع سجلاتنا. الرجاء المحاولة مرة أخرى.';
        icon = Iconsax.lock_1;
      } else if (errorMessage.contains('الاتصال') || errorMessage.contains('فشل في التحقق')) {
        title = 'مشكلة في الاتصال';
        message = 'لا يمكن الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت والمحاولة مرة أخرى.';
        icon = Iconsax.wifi_square;
        iconColor = _warningOrange;
      } else if (errorMessage.contains('مسجل حالياً') || errorMessage.contains('قيد الاستخدام')) {
        title = 'الحساب قيد الاستخدام';
        message = 'هذا الحساب مسجل حالياً في جهاز آخر. يرجى الخروج منه أولاً ثم المحاولة مرة أخرى.';
        icon = Iconsax.profile_remove;
        iconColor = _warningOrange;
      } else if (errorMessage.contains('PGRST')) {
        title = 'خطأ في قاعدة البيانات';
        message = 'حدث خطأ في الاتصال بقاعدة البيانات. الرجاء المحاولة مرة أخرى.';
        icon = Iconsax.data;
      }
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

                Expanded(
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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

                          Text(
                            'أدخل بياناتك للمتابعة',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: _grayText,
                              fontFamily: 'Tajawal',
                            ),
                          ),

                          SizedBox(height: 32.h),

                          _buildStudentNumberField(),

                          SizedBox(height: 16.h),

                          _buildPasswordField(),

                          SizedBox(height: 12.h),

                          if (_errorMessage.isNotEmpty) _buildErrorWidget(),

                          SizedBox(height: _errorMessage.isNotEmpty ? 16.h : 0.h),

                          _buildForgotPasswordLink(),

                          SizedBox(height: 20.h),

                          _buildLoginButton(),

                          SizedBox(height: 16.h),

                          _buildCreateAccountLink(),
                        ],
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

  Widget _buildStudentNumberField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextFormField(
        controller: _studentNumberController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: _darkText,
          fontFamily: 'Tajawal',
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'رقم الحساب',
          labelStyle: TextStyle(
            color: _grayText,
            fontFamily: 'Tajawal',
            fontSize: 14.sp,
          ),
          hintText: 'أدخل رقم حسابك',
          hintStyle: TextStyle(
            color: _grayText.withOpacity(0.6),
            fontFamily: 'Tajawal',
          ),
          prefixIcon: Icon(Iconsax.user, color: _primaryBlue, size: 20.sp),
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
        obscureText: true,
        textInputAction: TextInputAction.done,
        onEditingComplete: _signIn,
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFFECACA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8.w,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Color(0xFFFEF2F2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.info_circle,
              color: _errorRed,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تنبيه',
                  style: TextStyle(
                    color: _errorRed,
                    fontFamily: 'Tajawal',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Color(0xFF7F1D1D),
                    fontFamily: 'Tajawal',
                    fontSize: 12.sp,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
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
      child: ElevatedButton(
        onPressed: _isLoading ? null : _signIn,
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
    );
  }

  Widget _buildCreateAccountLink() {
    return GestureDetector(
      onTap: _showWhatsAppDialog,
      child: Container(
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
    );
  }
}