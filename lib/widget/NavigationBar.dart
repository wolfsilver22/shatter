// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:mody/screens/Home.dart';
// import '../Auth/auth_service.dart';
// import '../screens/ExercisesScreen.dart';
// import '../screens/LibraryScreen.dart';
// import '../screens/SecondScreen/lessons_list_screen.dart';
// import '../screens/profile_screen.dart';
//
// class MainNavigation extends StatefulWidget {
//   const MainNavigation({super.key});
//
//   @override
//   State<MainNavigation> createState() => _MainNavigationState();
// }
//
// class _MainNavigationState extends State<MainNavigation> {
//   int _currentIndex = 0;
//
//   // ✅ الألوان المحدثة المتناسقة مع التصميم
//   final Color _activeColor = const Color(0xFF1E88E5);
//   final Color _inactiveColor = const Color(0xFF718096);
//   final Color _backgroundColor = const Color(0xFFF5F9FF);
//   final Color _cardColor = Colors.white;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void navigateToLessons(String imageUrl, String subjectName, String courseId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonsListScreen(
//           subjectImageUrl: imageUrl,
//           subjectName: subjectName,
//           courseId: courseId,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeUserData();
//   }
//
//   Future<void> _initializeUserData() async {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     if (authService.isLoggedIn) {
//       final isValid = await authService.checkCurrentSessionValidity();
//
//       if (!isValid && mounted) {
//         _showSessionExpiredDialog();
//         return;
//       }
//
//       if (authService.userData == null) {
//         await authService.refreshUserData();
//       }
//     }
//   }
//
//   // ✅ دالة لتحويل رقم الصف إلى نص عربي
//   String _getGradeText(int? gradeValue) {
//     if (gradeValue == null) {
//       return 'لم يتم الاختيار';
//     }
//
//     switch (gradeValue) {
//       case 1:
//         return 'الصف الأول الابتدائي';
//       case 2:
//         return 'الصف الثاني الابتدائي';
//       case 3:
//         return 'الصف الثالث الابتدائي';
//       case 4:
//         return 'الصف الرابع الابتدائي';
//       case 5:
//         return 'الصف الخامس الابتدائي';
//       case 6:
//         return 'الصف السادس الابتدائي';
//       case 7:
//         return 'الصف الأول المتوسط';
//       case 8:
//         return 'الصف الثاني المتوسط';
//       case 9:
//         return 'الصف الثالث المتوسط';
//       case 10:
//         return 'الصف الأول الثانوي';
//       case 11:
//         return 'الصف الثاني الثانوي';
//       case 12:
//         return 'الصف الثالث الثانوي';
//       default:
//         return 'الصف $gradeValue';
//     }
//   }
//
//   void _showUserInfoPopup() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.all(20.w),
//             child: Container(
//               width: 300.w,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.25),
//                     blurRadius: 25.r,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // ✅ رأس البوب أب
//                   Container(
//                     padding: EdgeInsets.all(20.w),
//                     decoration: BoxDecoration(
//                       color: _activeColor,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.r),
//                         topRight: Radius.circular(20.r),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50.w,
//                           height: 50.h,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Iconsax.profile_circle,
//                             color: Colors.white,
//                             size: 24.sp,
//                           ),
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'معلومات الحساب',
//                                 style: TextStyle(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                               Text(
//                                 'تفاصيل حسابك الشخصي',
//                                 style: TextStyle(
//                                   fontSize: 12.sp,
//                                   color: Colors.white.withOpacity(0.9),
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // ✅ محتوى المعلومات
//                   Padding(
//                     padding: EdgeInsets.all(20.w),
//                     child: Column(
//                       children: [
//                         _buildInfoRow(
//                           icon: Iconsax.sms,
//                           title: 'البريد الإلكتروني',
//                           value: authService.studentEmail ?? 'غير متوفر',
//                           iconColor: _activeColor,
//                         ),
//                         SizedBox(height: 12.h),
//                         _buildInfoRow(
//                           icon: Iconsax.book_1,
//                           title: 'الصف الدراسي',
//                           value: _getGradeText(authService.selectedGrade),
//                           iconColor: const Color(0xFF10B981),
//                         ),
//                         SizedBox(height: 12.h),
//                         _buildInfoRow(
//                           icon: Iconsax.crown_1,
//                           title: 'نوع الاشتراك',
//                           value: 'مجاني',
//                           iconColor: const Color(0xFFFFA726),
//                         ),
//                         SizedBox(height: 12.h),
//                         _buildInfoRow(
//                           icon: Iconsax.shield_tick,
//                           title: 'حالة الحساب',
//                           value: authService.isAccountActive() ? 'نشط' : 'غير نشط',
//                           iconColor: authService.isAccountActive()
//                               ? const Color(0xFF10B981)
//                               : const Color(0xFFEF4444),
//                         ),
//                         SizedBox(height: 12.h),
//                       ],
//                     ),
//                   ),
//
//                   // ✅ أزرار التحكم
//                   Container(
//                     padding: EdgeInsets.all(16.w),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: _inactiveColor,
//                               side: BorderSide(color: _inactiveColor),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.r),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 12.h),
//                             ),
//                             child: Text(
//                               'إغلاق',
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               _onItemTapped(3);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: _activeColor,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.r),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 12.h),
//                             ),
//                             child: Text(
//                               'الملف الشخصي',
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _showSessionExpiredDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           title: Row(
//             children: [
//               Icon(Iconsax.info_circle, color: const Color(0xFFFFA726)),
//               SizedBox(width: 12.w),
//               Text(
//                 'انتهت الجلسة',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             'انتهت صلاحية جلسة التسجيل. يرجى تسجيل الدخول مرة أخرى.',
//             style: TextStyle(fontSize: 14.sp, fontFamily: 'Tajawal'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).popUntil((route) => route.isFirst);
//               },
//               child: Text(
//                 'موافق',
//                 style: TextStyle(fontSize: 14.sp, fontFamily: 'Tajawal'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color iconColor,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: _backgroundColor,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 36.w,
//             height: 36.h,
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: iconColor,
//               size: 18.sp,
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: _inactiveColor,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.bold,
//                     color: _activeColor,
//                     fontFamily: 'Tajawal',
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
//   Widget _buildCurrentScreen() {
//     return Consumer<AuthService>(
//       builder: (context, authService, child) {
//         switch (_currentIndex) {
//           case 0:
//             return HomeScreen(navigateToLessons: navigateToLessons);
//           case 1:
//             return HomeworkSolverScreen();
//           case 2:
//             return LibraryScreen();
//           case 3:
//             return ProfileScreen();
//           default:
//             return HomeScreen(navigateToLessons: navigateToLessons);
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthService>(
//       builder: (context, authService, child) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Scaffold(
//             backgroundColor: _backgroundColor,
//             appBar: AppBar(
//               backgroundColor: _activeColor,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: 40.w,
//                     height: 40.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.15),
//                           blurRadius: 10.r,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10.r),
//                       child: Image.asset(
//                         'assets/images/logo.png',
//                         width: 40.w,
//                         height: 40.h,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10.r),
//                             ),
//                             child: Icon(
//                               Iconsax.book_1,
//                               color: _activeColor,
//                               size: 24.sp,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               centerTitle: true,
//               elevation: 0,
//               leading: authService.isLoggedIn
//                   ? Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: GestureDetector(
//                   onTap: _showUserInfoPopup,
//                   child: Container(
//                     width: 36.w,
//                     height: 36.h,
//                     margin: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.white.withOpacity(0.25),
//                           Colors.white.withOpacity(0.15),
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.4),
//                         width: 2,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.15),
//                           blurRadius: 12.r,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Iconsax.profile_circle,
//                       color: Colors.white,
//                       size: 22.sp,
//                     ),
//                   ),
//                 ),
//               )
//                   : null,
//               actions: const [],
//             ),
//             body: _buildCurrentScreen(),
//             bottomNavigationBar: Container(
//               decoration: BoxDecoration(
//                 color: _cardColor,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.15),
//                     blurRadius: 20.r,
//                     spreadRadius: 2,
//                     offset: const Offset(0, -4),
//                   ),
//                 ],
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(25.r),
//                 ),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
//                 child: BottomNavigationBar(
//                   currentIndex: _currentIndex,
//                   onTap: _onItemTapped,
//                   type: BottomNavigationBarType.fixed,
//                   backgroundColor: _cardColor,
//                   selectedItemColor: _activeColor,
//                   unselectedItemColor: _inactiveColor,
//                   selectedLabelStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12.sp,
//                     fontFamily: 'Tajawal',
//                     height: 1.5,
//                   ),
//                   unselectedLabelStyle: TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 11.sp,
//                     fontFamily: 'Tajawal',
//                     height: 1.5,
//                   ),
//                   showSelectedLabels: true,
//                   showUnselectedLabels: true,
//                   elevation: 0,
//                   items: [
//                     _buildNavItem(
//                       icon: Iconsax.home,
//                       activeIcon: Iconsax.home_1,
//                       label: 'الرئيسية',
//                       isActive: _currentIndex == 0,
//                     ),
//                     _buildNavItem(
//                       icon: Iconsax.activity,
//                       activeIcon: Iconsax.activity,
//                       label: 'النشاطات',
//                       isActive: _currentIndex == 1,
//                     ),
//                     _buildNavItem(
//                       icon: Iconsax.book_1,
//                       activeIcon: Iconsax.book_1,
//                       label: 'المكتبة',
//                       isActive: _currentIndex == 2,
//                     ),
//                     _buildNavItem(
//                       icon: Iconsax.profile_circle,
//                       activeIcon: Iconsax.profile_circle,
//                       label: 'حسابي',
//                       isActive: _currentIndex == 3,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   BottomNavigationBarItem _buildNavItem({
//     required IconData icon,
//     required IconData activeIcon,
//     required String label,
//     required bool isActive,
//   }) {
//     return BottomNavigationBarItem(
//       icon: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: EdgeInsets.all(10.w),
//         decoration: BoxDecoration(
//           color: isActive ? _activeColor.withOpacity(0.15) : Colors.transparent,
//           borderRadius: BorderRadius.circular(14.r),
//           border: isActive
//               ? Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1.5,
//           )
//               : null,
//         ),
//         child: Icon(
//           isActive ? activeIcon : icon,
//           size: 24.sp,
//           color: isActive ? _activeColor : _inactiveColor,
//         ),
//       ),
//       activeIcon: Container(
//         padding: EdgeInsets.all(10.w),
//         decoration: BoxDecoration(
//           color: _activeColor.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(14.r),
//           border: Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: _activeColor.withOpacity(0.1),
//               blurRadius: 8.r,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(
//           activeIcon,
//           size: 24.sp,
//           color: _activeColor,
//         ),
//       ),
//       label: label,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:mody/screens/Home.dart';
// import '../Auth/auth_service.dart';
// import '../screens/ExercisesScreen.dart';
// import '../screens/LibraryScreen.dart';
// import '../screens/SecondScreen/lessons_list_screen.dart';
// import '../screens/profile_screen.dart';
//
// class MainNavigation extends StatefulWidget {
//   const MainNavigation({super.key});
//
//   @override
//   State<MainNavigation> createState() => _MainNavigationState();
// }
//
// class _MainNavigationState extends State<MainNavigation> {
//   int _currentIndex = 0;
//   bool _isInitializing = true;
//
//   // ✅ الألوان المحدثة المتناسقة مع التصميم
//   final Color _activeColor = const Color(0xFF1E88E5);
//   final Color _inactiveColor = const Color(0xFF718096);
//   final Color _backgroundColor = const Color(0xFFF5F9FF);
//   final Color _cardColor = Colors.white;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void navigateToLessons(String imageUrl, String subjectName, String courseId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonsListScreen(
//           subjectImageUrl: imageUrl,
//           subjectName: subjectName,
//           courseId: courseId,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     print('🚀 MainNavigation - بدء التهيئة');
//     _initializeUserData();
//   }
//
//   Future<void> _initializeUserData() async {
//     try {
//       final authService = Provider.of<AuthService>(context, listen: false);
//
//       if (authService.isLoggedIn) {
//         print('👤 المستخدم مسجل الدخول، جاري تحميل البيانات...');
//
//         final isValid = await authService.checkCurrentSessionValidity();
//
//         if (!isValid && mounted) {
//           print('❌ الجلسة غير صالحة');
//           _showSessionExpiredDialog();
//           return;
//         }
//
//         // تحميل بيانات المستخدم أولاً
//         if (authService.userData == null) {
//           print('🔄 جاري تحديث بيانات المستخدم...');
//           await authService.refreshUserData();
//         }
//
//         // التأكد من وجود صف دراسي محدد
//         if (authService.selectedGrade == null) {
//           print('⚠️ لم يتم تحديد صف دراسي للمستخدم');
//         } else {
//           print('✅ الصف الدراسي المحدد: ${authService.selectedGrade}');
//         }
//       } else {
//         print('👤 المستخدم غير مسجل الدخول');
//       }
//     } catch (e) {
//       print('❌ خطأ في تهيئة بيانات المستخدم: $e');
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isInitializing = false;
//         });
//       }
//       print('✅ انتهت تهيئة MainNavigation');
//     }
//   }
//
//   // ✅ دالة لتحويل رقم الصف إلى نص عربي
//   String _getGradeText(int? gradeValue) {
//     if (gradeValue == null) {
//       return 'لم يتم الاختيار';
//     }
//
//     switch (gradeValue) {
//       case 1:
//         return 'الصف الأول الابتدائي';
//       case 2:
//         return 'الصف الثاني الابتدائي';
//       case 3:
//         return 'الصف الثالث الابتدائي';
//       case 4:
//         return 'الصف الرابع الابتدائي';
//       case 5:
//         return 'الصف الخامس الابتدائي';
//       case 6:
//         return 'الصف السادس الابتدائي';
//       case 7:
//         return 'الصف الأول المتوسط';
//       case 8:
//         return 'الصف الثاني المتوسط';
//       case 9:
//         return 'الصف الثالث المتوسط';
//       case 10:
//         return 'الصف الأول الثانوي';
//       case 11:
//         return 'الصف الثاني الثانوي';
//       case 12:
//         return 'الصف الثالث الثانوي';
//       default:
//         return 'الصف $gradeValue';
//     }
//   }
//
//   void _showUserInfoPopup() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.all(20.w),
//             child: Container(
//               width: 300.w,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.25),
//                     blurRadius: 25.r,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // ✅ رأس البوب أب
//                   Container(
//                     padding: EdgeInsets.all(20.w),
//                     decoration: BoxDecoration(
//                       color: _activeColor,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.r),
//                         topRight: Radius.circular(20.r),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50.w,
//                           height: 50.h,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Iconsax.profile_circle,
//                             color: Colors.white,
//                             size: 24.sp,
//                           ),
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'معلومات الحساب',
//                                 style: TextStyle(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                               Text(
//                                 'تفاصيل حسابك الشخصي',
//                                 style: TextStyle(
//                                   fontSize: 12.sp,
//                                   color: Colors.white.withOpacity(0.9),
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // ✅ محتوى المعلومات
//                   Padding(
//                     padding: EdgeInsets.all(20.w),
//                     child: Column(
//                       children: [
//                         _buildInfoRow(
//                           icon: Iconsax.sms,
//                           title: 'البريد الإلكتروني',
//                           value: authService.studentEmail ?? 'غير متوفر',
//                           iconColor: _activeColor,
//                         ),
//                         SizedBox(height: 12.h),
//                         _buildInfoRow(
//                           icon: Iconsax.book_1,
//                           title: 'الصف الدراسي',
//                           value: _getGradeText(authService.selectedGrade),
//                           iconColor: const Color(0xFF10B981),
//                         ),
//                         SizedBox(height: 12.h),
//                         _buildInfoRow(
//                           icon: Iconsax.crown_1,
//                           title: 'نوع الاشتراك',
//                           value: 'مجاني',
//                           iconColor: const Color(0xFFFFA726),
//                         ),
//                         SizedBox(height: 12.h),
//                         _buildInfoRow(
//                           icon: Iconsax.shield_tick,
//                           title: 'حالة الحساب',
//                           value: authService.isAccountActive() ? 'نشط' : 'غير نشط',
//                           iconColor: authService.isAccountActive()
//                               ? const Color(0xFF10B981)
//                               : const Color(0xFFEF4444),
//                         ),
//                         SizedBox(height: 12.h),
//                       ],
//                     ),
//                   ),
//
//                   // ✅ أزرار التحكم
//                   Container(
//                     padding: EdgeInsets.all(16.w),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: _inactiveColor,
//                               side: BorderSide(color: _inactiveColor),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.r),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 12.h),
//                             ),
//                             child: Text(
//                               'إغلاق',
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               _onItemTapped(3);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: _activeColor,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.r),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 12.h),
//                             ),
//                             child: Text(
//                               'الملف الشخصي',
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _showSessionExpiredDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           title: Row(
//             children: [
//               Icon(Iconsax.info_circle, color: const Color(0xFFFFA726)),
//               SizedBox(width: 12.w),
//               Text(
//                 'انتهت الجلسة',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             'انتهت صلاحية جلسة التسجيل. يرجى تسجيل الدخول مرة أخرى.',
//             style: TextStyle(fontSize: 14.sp, fontFamily: 'Tajawal'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).popUntil((route) => route.isFirst);
//               },
//               child: Text(
//                 'موافق',
//                 style: TextStyle(fontSize: 14.sp, fontFamily: 'Tajawal'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color iconColor,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: _backgroundColor,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 36.w,
//             height: 36.h,
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: iconColor,
//               size: 18.sp,
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: _inactiveColor,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.bold,
//                     color: _activeColor,
//                     fontFamily: 'Tajawal',
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
//   Widget _buildCurrentScreen() {
//     if (_isInitializing) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: _activeColor),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تحميل البيانات...',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.black,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return Consumer<AuthService>(
//       builder: (context, authService, child) {
//         switch (_currentIndex) {
//           case 0:
//             return HomeScreen(navigateToLessons: navigateToLessons);
//           case 1:
//             return HomeworkSolverScreen();
//           case 2:
//             return LibraryScreen();
//           case 3:
//             return ProfileScreen();
//           default:
//             return HomeScreen(navigateToLessons: navigateToLessons);
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthService>(
//       builder: (context, authService, child) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Scaffold(
//             backgroundColor: _backgroundColor,
//             appBar: AppBar(
//               backgroundColor: _activeColor,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: 40.w,
//                     height: 40.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.15),
//                           blurRadius: 10.r,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10.r),
//                       child: Image.asset(
//                         'assets/images/logo.png',
//                         width: 40.w,
//                         height: 40.h,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10.r),
//                             ),
//                             child: Icon(
//                               Iconsax.book_1,
//                               color: _activeColor,
//                               size: 24.sp,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               centerTitle: true,
//               elevation: 0,
//               leading: authService.isLoggedIn
//                   ? Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: GestureDetector(
//                   onTap: _showUserInfoPopup,
//                   child: Container(
//                     width: 36.w,
//                     height: 36.h,
//                     margin: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.white.withOpacity(0.25),
//                           Colors.white.withOpacity(0.15),
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.4),
//                         width: 2,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.15),
//                           blurRadius: 12.r,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Iconsax.profile_circle,
//                       color: Colors.white,
//                       size: 22.sp,
//                     ),
//                   ),
//                 ),
//               )
//                   : null,
//               actions: const [],
//             ),
//             body: _buildCurrentScreen(),
//             bottomNavigationBar: Container(
//               decoration: BoxDecoration(
//                 color: _cardColor,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.15),
//                     blurRadius: 20.r,
//                     spreadRadius: 2,
//                     offset: const Offset(0, -4),
//                   ),
//                 ],
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(25.r),
//                 ),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
//                 child: BottomNavigationBar(
//                   currentIndex: _currentIndex,
//                   onTap: _onItemTapped,
//                   type: BottomNavigationBarType.fixed,
//                   backgroundColor: _cardColor,
//                   selectedItemColor: _activeColor,
//                   unselectedItemColor: _inactiveColor,
//                   selectedLabelStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12.sp,
//                     fontFamily: 'Tajawal',
//                     height: 1.5,
//                   ),
//                   unselectedLabelStyle: TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 11.sp,
//                     fontFamily: 'Tajawal',
//                     height: 1.5,
//                   ),
//                   showSelectedLabels: true,
//                   showUnselectedLabels: true,
//                   elevation: 0,
//                   items: [
//                     _buildNavItem(
//                       icon: Iconsax.home,
//                       activeIcon: Iconsax.home_1,
//                       label: 'الرئيسية',
//                       isActive: _currentIndex == 0,
//                     ),
//                     _buildNavItem(
//                       icon: Iconsax.activity,
//                       activeIcon: Iconsax.activity,
//                       label: 'النشاطات',
//                       isActive: _currentIndex == 1,
//                     ),
//                     _buildNavItem(
//                       icon: Iconsax.book_1,
//                       activeIcon: Iconsax.book_1,
//                       label: 'المكتبة',
//                       isActive: _currentIndex == 2,
//                     ),
//                     _buildNavItem(
//                       icon: Iconsax.profile_circle,
//                       activeIcon: Iconsax.profile_circle,
//                       label: 'حسابي',
//                       isActive: _currentIndex == 3,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   BottomNavigationBarItem _buildNavItem({
//     required IconData icon,
//     required IconData activeIcon,
//     required String label,
//     required bool isActive,
//   }) {
//     return BottomNavigationBarItem(
//       icon: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: EdgeInsets.all(10.w),
//         decoration: BoxDecoration(
//           color: isActive ? _activeColor.withOpacity(0.15) : Colors.transparent,
//           borderRadius: BorderRadius.circular(14.r),
//           border: isActive
//               ? Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1.5,
//           )
//               : null,
//         ),
//         child: Icon(
//           isActive ? activeIcon : icon,
//           size: 24.sp,
//           color: isActive ? _activeColor : _inactiveColor,
//         ),
//       ),
//       activeIcon: Container(
//         padding: EdgeInsets.all(10.w),
//         decoration: BoxDecoration(
//           color: _activeColor.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(14.r),
//           border: Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: _activeColor.withOpacity(0.1),
//               blurRadius: 8.r,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(
//           activeIcon,
//           size: 24.sp,
//           color: _activeColor,
//         ),
//       ),
//       label: label,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mody/screens/Home.dart';
import '../Auth/auth_service.dart';
import '../screens/ExercisesScreen.dart';
import '../screens/LibraryScreen.dart';
import '../screens/SecondScreen/lessons_list_screen.dart';
import '../screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  bool _isInitializing = true;

  // ✅ الألوان المحدثة المتناسقة مع التصميم في الصورة
  final Color _activeColor = const Color(0xFF1E88E5);
  final Color _inactiveColor = const Color(0xFF718096);
  final Color _backgroundColor = const Color(0xFFF5F9FF);
  final Color _cardColor = Colors.white;
  final Color _appBarColor = const Color(0xFF1E88E5);

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void navigateToLessons(String imageUrl, String subjectName, String courseId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonsListScreen(
          subjectImageUrl: imageUrl,
          subjectName: subjectName,
          courseId: courseId,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('🚀 MainNavigation - بدء التهيئة');
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      if (authService.isLoggedIn) {
        print('👤 المستخدم مسجل الدخول، جاري تحميل البيانات...');

        final isValid = await authService.checkCurrentSessionValidity();

        if (!isValid && mounted) {
          print('❌ الجلسة غير صالحة');
          _showSessionExpiredDialog();
          return;
        }

        // تحميل بيانات المستخدم أولاً
        if (authService.userData == null) {
          print('🔄 جاري تحديث بيانات المستخدم...');
          await authService.refreshUserData();
        }

        // التأكد من وجود صف دراسي محدد
        if (authService.selectedGrade == null) {
          print('⚠️ لم يتم تحديد صف دراسي للمستخدم');
        } else {
          print('✅ الصف الدراسي المحدد: ${authService.selectedGrade}');
        }
      } else {
        print('👤 المستخدم غير مسجل الدخول');
      }
    } catch (e) {
      print('❌ خطأ في تهيئة بيانات المستخدم: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
      print('✅ انتهت تهيئة MainNavigation');
    }
  }

  // ✅ دالة لتحويل رقم الصف إلى نص عربي
  String _getGradeText(int? gradeValue) {
    if (gradeValue == null) {
      return 'لم يتم الاختيار';
    }

    switch (gradeValue) {
      case 1:
        return 'الصف الأول الابتدائي';
      case 2:
        return 'الصف الثاني الابتدائي';
      case 3:
        return 'الصف الثالث الابتدائي';
      case 4:
        return 'الصف الرابع الابتدائي';
      case 5:
        return 'الصف الخامس الابتدائي';
      case 6:
        return 'الصف السادس الابتدائي';
      case 7:
        return 'الصف الأول المتوسط';
      case 8:
        return 'الصف الثاني المتوسط';
      case 9:
        return 'الصف الثالث المتوسط';
      case 10:
        return 'الصف الأول الثانوي';
      case 11:
        return 'الصف الثاني الثانوي';
      case 12:
        return 'الصف الثالث الثانوي';
      default:
        return 'الصف $gradeValue';
    }
  }

  void _showUserInfoPopup() {
    final authService = Provider.of<AuthService>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(20.w),
            child: Container(
              width: 300.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 25.r,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ رأس البوب أب
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: _activeColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.profile_circle,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'معلومات الحساب',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              Text(
                                'تفاصيل حسابك الشخصي',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white.withOpacity(0.9),
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ✅ محتوى المعلومات
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          icon: Iconsax.sms,
                          title: 'البريد الإلكتروني',
                          value: authService.studentEmail ?? 'غير متوفر',
                          iconColor: _activeColor,
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.book_1,
                          title: 'الصف الدراسي',
                          value: _getGradeText(authService.selectedGrade),
                          iconColor: const Color(0xFF10B981),
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.crown_1,
                          title: 'نوع الاشتراك',
                          value: 'مجاني',
                          iconColor: const Color(0xFFFFA726),
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.shield_tick,
                          title: 'حالة الحساب',
                          value: authService.isAccountActive() ? 'نشط' : 'غير نشط',
                          iconColor: authService.isAccountActive()
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),

                  // ✅ أزرار التحكم
                  Container(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _inactiveColor,
                              side: BorderSide(color: _inactiveColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            child: Text(
                              'إغلاق',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _onItemTapped(3);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _activeColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            child: Text(
                              'الملف الشخصي',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSessionExpiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Row(
            children: [
              Icon(Iconsax.info_circle, color: const Color(0xFFFFA726)),
              SizedBox(width: 12.w),
              Text(
                'انتهت الجلسة',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
          content: Text(
            'انتهت صلاحية جلسة التسجيل. يرجى تسجيل الدخول مرة أخرى.',
            style: TextStyle(fontSize: 14.sp, fontFamily: 'Tajawal'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'موافق',
                style: TextStyle(fontSize: 14.sp, fontFamily: 'Tajawal'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _inactiveColor,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: _activeColor,
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

  Widget _buildCurrentScreen() {
    if (_isInitializing) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: _activeColor),
            SizedBox(height: 16.h),
            Text(
              'جاري تحميل البيانات...',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<AuthService>(
      builder: (context, authService, child) {
        switch (_currentIndex) {
          case 0:
            return HomeScreen(navigateToLessons: navigateToLessons);
          case 1:
            return HomeworkSolverScreen();
          case 2:
            return LibraryScreen();
          case 3:
            return ProfileScreen();
          default:
            return HomeScreen(navigateToLessons: navigateToLessons);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: _backgroundColor,

            // ✅ AppBar محدث ليتناسق مع التصميم
            appBar: AppBar(
              backgroundColor: _appBarColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ✅ أيقونة المستخدم على اليسار
                  if (authService.isLoggedIn)
                    GestureDetector(
                      onTap: _showUserInfoPopup,
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Iconsax.profile_circle,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    )
                  else
                    SizedBox(width: 40.w),

                  // ✅ العنوان في المنتصف
                  Text(
                    'منصة شاطر',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Tajawal',
                    ),
                  ),

                  // ✅ الشعار على اليمين
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 40.w,
                        height: 40.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Iconsax.book_1,
                              color: _activeColor,
                              size: 20.sp,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            body: _buildCurrentScreen(),

            // ✅ BottomNavigationBar محدث ومتناسق مع التصميم
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: _cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16.r,
                    spreadRadius: 1,
                    offset: const Offset(0, -4),
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              child: SafeArea(
                child: Container(
                  height: 70.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        icon: Iconsax.home,
                        activeIcon: Iconsax.home_1,
                        label: 'الرئيسية',
                        index: 0,
                      ),
                      _buildNavItem(
                        icon: Iconsax.activity,
                        activeIcon: Iconsax.activity,
                        label: 'النشاطات',
                        index: 1,
                      ),
                      _buildNavItem(
                        icon: Iconsax.book_1,
                        activeIcon: Iconsax.book,
                        label: 'المكتبة',
                        index: 2,
                      ),
                      _buildNavItem(
                        icon: Iconsax.profile_circle,
                        activeIcon: Iconsax.profile_circle,
                        label: 'حسابي',
                        index: 3,
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

  // ✅ دالة مبسطة لبناء عناصر التنقل
  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    bool isActive = _currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: isActive ? _activeColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: isActive
                ? Border.all(
              color: _activeColor.withOpacity(0.3),
              width: 1.5,
            )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                size: 24.sp,
                color: isActive ? _activeColor : _inactiveColor,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? _activeColor : _inactiveColor,
                  fontFamily: 'Tajawal',
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}