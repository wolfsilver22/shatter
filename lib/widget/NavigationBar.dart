// import 'package:flutter/material.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:mody/screens/Home.dart';
// import '../screens/ExercisesScreen.dart';
// import '../screens/profile_screen.dart';
//
//
// class CustomBottomNav extends StatefulWidget {
//
//   CustomBottomNav({super.key });
//
//   @override
//   State<CustomBottomNav> createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNav> {
//   int _currentIndex = 0;
//   final Color _activeColor = const Color(0xFF6C56F9);
//   final Color _inactiveColor = Colors.grey;
//
//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const ActivitiesScreen(),
//     const ActivitiesScreen(),
//     const ProfileScreen()
//     // const MyBookingsScreen(),
//     //const MyBookingsScreen(),
//     // ProfilePage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: _pages[_currentIndex],
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 spreadRadius: 2,
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//             child: BottomNavigationBar(
//               currentIndex: _currentIndex,
//               onTap: (index) {
//                 setState(() => _currentIndex = index);
//               },
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: Colors.white,
//               selectedItemColor: _activeColor,
//               unselectedItemColor: _inactiveColor,
//               selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//               showSelectedLabels: true,
//               showUnselectedLabels: true,
//               elevation: 0,
//               items: [
//                 _buildNavItem(
//                   icon: Iconsax.home,
//                   activeIcon: Iconsax.home_1,
//                   label: 'الرئيسية',
//                   isActive: _currentIndex == 0,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.tag,
//                   activeIcon: Iconsax.tag,
//                   label: 'العروض',
//                   isActive: _currentIndex == 1,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.calendar,
//                   activeIcon: Iconsax.calendar,
//                   label: 'حجوزاتي',
//                   isActive: _currentIndex == 2,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.profile_circle,
//                   activeIcon: Iconsax.profile_circle,
//                   label: 'حسابي',
//                   isActive: _currentIndex == 3,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
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
//       icon: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isActive ? _activeColor.withOpacity(0.1) : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(isActive ? activeIcon : icon, size: 24),
//       ),
//       activeIcon: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: _activeColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(activeIcon, size: 24),
//       ),
//       label: label,
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:mody/screens/Home.dart';
// import '../screens/ExercisesScreen.dart';
// import '../screens/profile_screen.dart';
//
// class CustomBottomNav extends StatefulWidget {
//   CustomBottomNav({super.key});
//
//   @override
//   State<CustomBottomNav> createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNav> {
//   int _currentIndex = 0;
//
//   // ✅ الألوان المحدثة المتناسقة مع التصميم
//   final Color _activeColor = const Color(0xFF1E88E5); // الأزرق الأساسي
//   final Color _inactiveColor = const Color(0xFF718096); // الرمادي الثانوي
//   final Color _backgroundColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
//   final Color _cardColor = Colors.white; // لون البطاقات
//
//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const ActivitiesScreen(),
//     const ActivitiesScreen(),
//     const ProfileScreen()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: _backgroundColor,
//         body: _pages[_currentIndex],
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: _cardColor,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 15,
//                 spreadRadius: 2,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//             borderRadius: const BorderRadius.vertical(
//               top: Radius.circular(20),
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//             child: BottomNavigationBar(
//               currentIndex: _currentIndex,
//               onTap: (index) {
//                 setState(() => _currentIndex = index);
//               },
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: _cardColor,
//               selectedItemColor: _activeColor,
//               unselectedItemColor: _inactiveColor,
//               selectedLabelStyle: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12,
//                 fontFamily: 'Tajawal',
//               ),
//               unselectedLabelStyle: TextStyle(
//                 fontWeight: FontWeight.normal,
//                 fontSize: 12,
//                 fontFamily: 'Tajawal',
//               ),
//               showSelectedLabels: true,
//               showUnselectedLabels: true,
//               elevation: 0,
//               items: [
//                 _buildNavItem(
//                   icon: Iconsax.home,
//                   activeIcon: Iconsax.home_1,
//                   label: 'الرئيسية',
//                   isActive: _currentIndex == 0,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.activity,
//                   activeIcon: Iconsax.activity,
//                   label: 'النشاطات',
//                   isActive: _currentIndex == 1,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.calendar,
//                   activeIcon: Iconsax.calendar_1,
//                   label: 'التقويم',
//                   isActive: _currentIndex == 2,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.profile_circle,
//                   activeIcon: Iconsax.profile_circle,
//                   label: 'حسابي',
//                   isActive: _currentIndex == 3,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
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
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isActive ? _activeColor.withOpacity(0.15) : Colors.transparent,
//           borderRadius: BorderRadius.circular(14),
//           border: isActive ? Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1,
//           ) : null,
//         ),
//         child: Icon(
//           isActive ? activeIcon : icon,
//           size: 24,
//           color: isActive ? _activeColor : _inactiveColor,
//         ),
//       ),
//       activeIcon: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: _activeColor.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1,
//           ),
//         ),
//         child: Icon(
//           activeIcon,
//           size: 24,
//           color: _activeColor,
//         ),
//       ),
//       label: label,
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:mody/screens/Home.dart';
// import '../Auth/auth_service.dart';
// import '../screens/ExercisesScreen.dart';
// import '../screens/profile_screen.dart';
//
// class CustomBottomNav extends StatefulWidget {
//   const CustomBottomNav({super.key});
//
//   @override
//   State<CustomBottomNav> createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNav> {
//   int _currentIndex = 0;
//
//   // ✅ الألوان المحدثة المتناسقة مع التصميم
//   final Color _activeColor = const Color(0xFF1E88E5); // الأزرق الأساسي
//   final Color _inactiveColor = const Color(0xFF718096); // الرمادي الثانوي
//   final Color _backgroundColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
//   final Color _cardColor = Colors.white; // لون البطاقات
//   final Color _errorRed = const Color(0xFFEF4444);
//
//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const ActivitiesScreen(),
//     const ActivitiesScreen(), // يمكن استبدالها بشاشة التقويم لاحقاً
//     const ProfileScreen()
//   ];
//
//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black54,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           child: Stack(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(28),
//                 margin: const EdgeInsets.only(top: 50),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.25),
//                       blurRadius: 25,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(height: 50),
//                     Text(
//                       'تسجيل الخروج',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: _activeColor,
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: _inactiveColor,
//                         fontFamily: 'Tajawal',
//                         height: 1.6,
//                       ),
//                     ),
//                     const SizedBox(height: 28),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: _inactiveColor,
//                               side: BorderSide(color: _inactiveColor),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                             ),
//                             child: Text(
//                               'إلغاء',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: _performLogout,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: _errorRed,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               elevation: 4,
//                             ),
//                             child: Text(
//                               'تسجيل الخروج',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
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
//                     width: 80,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       color: _errorRed,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white, width: 6),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 15,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     child: Icon(Iconsax.logout_1, size: 36, color: Colors.white),
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
//   Future<void> _performLogout() async {
//     Navigator.pop(context); // إغلاق الدايلوج
//
//     final authService = Provider.of<AuthService>(context, listen: false);
//     await authService.logout();
//
//     // العودة إلى شاشة تسجيل الدخول
//     Navigator.pushNamedAndRemoveUntil(
//         context,
//         '/login',
//             (route) => false
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: _backgroundColor,
//         appBar: AppBar(
//           backgroundColor: _activeColor,
//           title: Text(
//             'تعلم القراءة',
//             style: TextStyle(
//               fontFamily: 'Tajawal',
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontSize: 18,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 0,
//           actions: [
//             if (authService.isLoggedIn)
//               IconButton(
//                 icon: Icon(Iconsax.logout_1, color: Colors.white),
//                 onPressed: _showLogoutDialog,
//                 tooltip: 'تسجيل الخروج',
//               ),
//           ],
//         ),
//         body: _pages[_currentIndex],
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: _cardColor,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 15,
//                 spreadRadius: 2,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//             borderRadius: const BorderRadius.vertical(
//               top: Radius.circular(20),
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//             child: BottomNavigationBar(
//               currentIndex: _currentIndex,
//               onTap: (index) {
//                 setState(() => _currentIndex = index);
//               },
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: _cardColor,
//               selectedItemColor: _activeColor,
//               unselectedItemColor: _inactiveColor,
//               selectedLabelStyle: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12,
//                 fontFamily: 'Tajawal',
//               ),
//               unselectedLabelStyle: TextStyle(
//                 fontWeight: FontWeight.normal,
//                 fontSize: 12,
//                 fontFamily: 'Tajawal',
//               ),
//               showSelectedLabels: true,
//               showUnselectedLabels: true,
//               elevation: 0,
//               items: [
//                 _buildNavItem(
//                   icon: Iconsax.home,
//                   activeIcon: Iconsax.home_1,
//                   label: 'الرئيسية',
//                   isActive: _currentIndex == 0,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.activity,
//                   activeIcon: Iconsax.activity,
//                   label: 'النشاطات',
//                   isActive: _currentIndex == 1,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.calendar,
//                   activeIcon: Iconsax.calendar_1,
//                   label: 'التقويم',
//                   isActive: _currentIndex == 2,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.profile_circle,
//                   activeIcon: Iconsax.profile_circle,
//                   label: 'حسابي',
//                   isActive: _currentIndex == 3,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
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
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isActive ? _activeColor.withOpacity(0.15) : Colors.transparent,
//           borderRadius: BorderRadius.circular(14),
//           border: isActive ? Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1,
//           ) : null,
//         ),
//         child: Icon(
//           isActive ? activeIcon : icon,
//           size: 24,
//           color: isActive ? _activeColor : _inactiveColor,
//         ),
//       ),
//       activeIcon: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: _activeColor.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1,
//           ),
//         ),
//         child: Icon(
//           activeIcon,
//           size: 24,
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
//   bool _isInitialized = false;
//
//   // ✅ الألوان المحدثة المتناسقة مع التصميم
//   final Color _activeColor = const Color(0xFF1E88E5);
//   final Color _inactiveColor = const Color(0xFF718096);
//   final Color _backgroundColor = const Color(0xFFF5F9FF);
//   final Color _cardColor = Colors.white;
//   final Color _errorRed = const Color(0xFFEF4444);
//   final Color _successGreen = const Color(0xFF10B981);
//   final Color _warningOrange = const Color(0xFFFFA726);
//
//   // قائمة الصفوف المتاحة
//   final List<String> _grades = [
//     'الصف الأول الابتدائي',
//     'الصف الثاني الابتدائي',
//     'الصف الثالث الابتدائي',
//     'الصف الرابع الابتدائي',
//     'الصف الخامس الابتدائي',
//     'الصف السادس الابتدائي',
//   ];
//
//   // دالة للتنقل بين الشاشات
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   // دالة للتنقل إلى شاشة الدروس من أي مكان
//   void navigateToLessons(String subjectImageUrl, String subjectName) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => LessonsListScreen(
//           subjectImageUrl: subjectImageUrl,
//           subjectName: subjectName,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }
//
//   void _initializeApp() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkGradeSelection();
//     });
//   }
//
//   void _checkGradeSelection() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//     Future.delayed(const Duration(milliseconds: 800), () {
//       if (mounted && !_isInitialized) {
//         if (authService.selectedGrade == null || authService.selectedGrade!.isEmpty) {
//           _showGradeSelectionDialog();
//         }
//         _isInitialized = true;
//       }
//     });
//   }
//
//   void _showGradeSelectionDialog() {
//     if (!mounted) return;
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: const EdgeInsets.all(20),
//             child: Container(
//               width: double.infinity,
//               constraints: BoxConstraints(
//                 maxHeight: MediaQuery.of(context).size.height * 0.85,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.3),
//                     blurRadius: 30,
//                     offset: const Offset(0, 15),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // رأس الدايلوج
//                   Container(
//                     padding: const EdgeInsets.all(25),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [_activeColor, _activeColor],
//                         begin: Alignment.topRight,
//                         end: Alignment.bottomLeft,
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(25),
//                         topRight: Radius.circular(25),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.3),
//                               width: 2,
//                             ),
//                           ),
//                           child: Icon(
//                             Iconsax.book_1,
//                             color: Colors.white,
//                             size: 28,
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'اختيار الصف الدراسي',
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 'اختر صفك الدراسي لتجربة تعلم مخصصة',
//                                 style: TextStyle(
//                                   fontSize: 14,
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
//                   // محتوى الدايلوج
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(25),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'اختر صفك الدراسي من القائمة التالية:',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: _inactiveColor,
//                               fontFamily: 'Tajawal',
//                               fontWeight: FontWeight.w600,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 20),
//
//                           // شبكة اختيار الصفوف
//                           GridView.builder(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               crossAxisSpacing: 15,
//                               mainAxisSpacing: 15,
//                               childAspectRatio: 1.6,
//                             ),
//                             itemCount: _grades.length,
//                             itemBuilder: (context, index) {
//                               return _buildGradeCard(_grades[index], index);
//                             },
//                           ),
//
//                           const SizedBox(height: 25),
//                           Text(
//                             'يمكنك تغيير الصف لاحقاً من إعدادات الحساب',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: _inactiveColor.withOpacity(0.7),
//                               fontFamily: 'Tajawal',
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
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
//   Widget _buildGradeCard(String grade, int index) {
//     // اللون البرتقالي الموحد لجميع الكروت
//     final Color primaryOrange = const Color(0xFFFFA726);
//
//     final List<Color> backgroundColors = [
//       Color(0xFFFFF8E1),
//       Color(0xFFFFF8E1),
//       Color(0xFFFFF8E1),
//       Color(0xFFFFF8E1),
//       Color(0xFFFFF8E1),
//       Color(0xFFFFF8E1),
//     ];
//
//     final List<IconData> gradeIcons = [
//       Iconsax.teacher,
//       Iconsax.book,
//       Iconsax.pen_tool,
//       Iconsax.note_2,
//       Iconsax.cpu,
//       Iconsax.book_1,
//     ];
//
//     return GestureDetector(
//       onTap: () => _selectGrade(grade),
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         decoration: BoxDecoration(
//           color: backgroundColors[index],
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: primaryOrange.withOpacity(0.3),
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: primaryOrange.withOpacity(0.15),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 42,
//               height: 42,
//               decoration: BoxDecoration(
//                 color: primaryOrange,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: primaryOrange.withOpacity(0.3),
//                     blurRadius: 8,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 gradeIcons[index],
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6),
//               child: Text(
//                 grade,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: primaryOrange,
//                   fontFamily: 'Tajawal',
//                   height: 1.3,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               height: 3,
//               margin: const EdgeInsets.only(top: 6),
//               decoration: BoxDecoration(
//                 color: primaryOrange,
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(12),
//                   bottomRight: Radius.circular(12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectGrade(String grade) async {
//     final authService = Provider.of<AuthService>(context, listen: false);
//     await authService.setSelectedGrade(grade);
//
//     if (mounted) {
//       Navigator.of(context).pop();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: [
//               Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.tick_circle,
//                   color: _successGreen,
//                   size: 16,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   'تم اختيار $grade بنجاح',
//                   style: TextStyle(
//                     fontFamily: 'Tajawal',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           backgroundColor: _successGreen,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           duration: const Duration(seconds: 3),
//         ),
//       );
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
//             insetPadding: const EdgeInsets.all(20),
//             child: Container(
//               width: 300,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.25),
//                     blurRadius: 25,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: _activeColor,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Iconsax.profile_circle,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'معلومات الحساب',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                               Text(
//                                 'تفاصيل حسابك الشخصي',
//                                 style: TextStyle(
//                                   fontSize: 12,
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
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         _buildInfoRow(
//                           icon: Iconsax.user,
//                           title: 'رقم الحساب',
//                           value: authService.studentNumber ?? 'غير متوفر',
//                           iconColor: _activeColor,
//                         ),
//                         const SizedBox(height: 12),
//                         _buildInfoRow(
//                           icon: Iconsax.book_1,
//                           title: 'الصف الدراسي',
//                           value: authService.selectedGrade ?? 'لم يتم الاختيار',
//                           iconColor: _successGreen,
//                         ),
//                         const SizedBox(height: 12),
//                         _buildInfoRow(
//                           icon: Iconsax.crown_1,
//                           title: 'نوع الاشتراك',
//                           value: 'مجاني',
//                           iconColor: _warningOrange,
//                         ),
//                         const SizedBox(height: 12),
//                         _buildInfoRow(
//                           icon: Iconsax.shield_tick,
//                           title: 'حالة الحساب',
//                           value: authService.isAccountActive() ? 'نشط' : 'غير مفعل',
//                           iconColor: authService.isAccountActive() ? _successGreen : _errorRed,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: _inactiveColor,
//                               side: BorderSide(color: _inactiveColor),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             child: Text(
//                               'إغلاق',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
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
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             child: Text(
//                               'الملف الشخصي',
//                               style: TextStyle(
//                                 fontSize: 14,
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
//   Widget _buildInfoRow({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color iconColor,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: _backgroundColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: iconColor,
//               size: 18,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: _inactiveColor,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 14,
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
//   // دالة لبناء محتوى الشاشة الحالية
//   Widget _buildCurrentScreen() {
//     switch (_currentIndex) {
//       case 0:
//         return HomeScreen(navigateToLessons: navigateToLessons);
//       case 1:
//         return ActivitiesScreen();
//       case 2:
//         return ActivitiesScreen();
//       case 3:
//         return ProfileScreen();
//       default:
//         return HomeScreen(navigateToLessons: navigateToLessons);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: _backgroundColor,
//         appBar: AppBar(
//           backgroundColor: _activeColor,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.15),
//                       blurRadius: 10,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     width: 40,
//                     height: 40,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Icon(
//                           Iconsax.book_1,
//                           color: _activeColor,
//                           size: 24,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//
//             ],
//           ),
//           centerTitle: true,
//           elevation: 0,
//           leading: authService.isLoggedIn
//               ? Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: GestureDetector(
//               onTap: _showUserInfoPopup,
//               child: Container(
//                 width: 36,
//                 height: 36,
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white.withOpacity(0.25),
//                       Colors.white.withOpacity(0.15),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.4),
//                     width: 2,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.15),
//                       blurRadius: 12,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Iconsax.profile_circle,
//                   color: Colors.white,
//                   size: 22.sp,
//                 ),
//               ),
//             ),
//           )
//               : null,
//           actions: const [],
//         ),
//         body: _buildCurrentScreen(),
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: _cardColor,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.15),
//                 blurRadius: 20,
//                 spreadRadius: 2,
//                 offset: const Offset(0, -4),
//               ),
//             ],
//             borderRadius: const BorderRadius.vertical(
//               top: Radius.circular(25),
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
//             child: BottomNavigationBar(
//               currentIndex: _currentIndex,
//               onTap: _onItemTapped,
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: _cardColor,
//               selectedItemColor: _activeColor,
//               unselectedItemColor: _inactiveColor,
//               selectedLabelStyle: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12,
//                 fontFamily: 'Tajawal',
//                 height: 1.5,
//               ),
//               unselectedLabelStyle: TextStyle(
//                 fontWeight: FontWeight.normal,
//                 fontSize: 11,
//                 fontFamily: 'Tajawal',
//                 height: 1.5,
//               ),
//               showSelectedLabels: true,
//               showUnselectedLabels: true,
//               elevation: 0,
//               items: [
//                 _buildNavItem(
//                   icon: Iconsax.home,
//                   activeIcon: Iconsax.home_1,
//                   label: 'الرئيسية',
//                   isActive: _currentIndex == 0,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.activity,
//                   activeIcon: Iconsax.activity,
//                   label: 'النشاطات',
//                   isActive: _currentIndex == 1,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.calendar,
//                   activeIcon: Iconsax.calendar_1,
//                   label: 'التقويم',
//                   isActive: _currentIndex == 2,
//                 ),
//                 _buildNavItem(
//                   icon: Iconsax.profile_circle,
//                   activeIcon: Iconsax.profile_circle,
//                   label: 'حسابي',
//                   isActive: _currentIndex == 3,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
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
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isActive ? _activeColor.withOpacity(0.15) : Colors.transparent,
//           borderRadius: BorderRadius.circular(14),
//           border: isActive ? Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1.5,
//           ) : null,
//         ),
//         child: Icon(
//           isActive ? activeIcon : icon,
//           size: 24,
//           color: isActive ? _activeColor : _inactiveColor,
//         ),
//       ),
//       activeIcon: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: _activeColor.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             color: _activeColor.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: _activeColor.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(
//           activeIcon,
//           size: 24,
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

  // ✅ الألوان المحدثة المتناسقة مع التصميم
  final Color _activeColor = const Color(0xFF1E88E5);
  final Color _inactiveColor = const Color(0xFF718096);
  final Color _backgroundColor = const Color(0xFFF5F9FF);
  final Color _cardColor = Colors.white;

  // دالة للتنقل بين الشاشات
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void navigateToLessons(String imageUrl, String subjectName, String tableName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonsListScreen(
          subjectImageUrl: imageUrl,
          subjectName: subjectName,
          tableName: tableName,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  // ✅ تهيئة بيانات المستخدم عند بدء التشغيل
  Future<void> _initializeUserData() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    // إذا كان المستخدم مسجلاً ولكن بياناته غير محملة، نقوم بتحميلها
    if (authService.isLoggedIn && authService.userData == null) {
      await authService.refreshUserData();
    }
  }

  // ✅ دالة لتحويل رقم الصف إلى نص عربي
  String _getGradeText(String? gradeValue) {
    if (gradeValue == null || gradeValue.isEmpty) {
      return 'لم يتم الاختيار';
    }

    final gradeNumber = int.tryParse(gradeValue);
    if (gradeNumber == null) {
      return gradeValue;
    }

    switch (gradeNumber) {
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

  // ✅ دالة لعرض معلومات المستخدم مع التحقق من البيانات
  void _showUserInfoPopup() {
    final authService = Provider.of<AuthService>(context, listen: false);

    // ✅ التحقق من صحة الجلسة قبل عرض المعلومات
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isValid = await authService.checkCurrentSessionValidity();
      if (!isValid && mounted) {
        // إذا كانت الجلسة غير صالحة، نعود لشاشة التسجيل
        _showSessionExpiredDialog();
        return;
      }
    });

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
                    blurRadius: 25.w,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ رأس البوب آب
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
                          iconColor: Color(0xFF10B981),
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.crown_1,
                          title: 'نوع الاشتراك',
                          value: 'مجاني', // يمكن تعديله حسب بيانات المستخدم
                          iconColor: Color(0xFFFFA726),
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.shield_tick,
                          title: 'حالة الحساب',
                          value: _getAccountStatus(authService),
                          iconColor: _getAccountStatusColor(authService),
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.login_1,
                          title: 'حالة التسجيل',
                          value: authService.isLoggedIn ? 'مسجل الدخول' : 'غير مسجل',
                          iconColor: authService.isLoggedIn ? Color(0xFF10B981) : Color(0xFFEF4444),
                        ),
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
                              _onItemTapped(3); // الانتقال لشاشة الملف الشخصي
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

  // ✅ دالة مساعدة لعرض حالة الحساب
  String _getAccountStatus(AuthService authService) {
    if (!authService.isLoggedIn) return 'غير مسجل';
    if (authService.userData == null) return 'جاري التحميل...';

    final isActive = authService.userData?['is_active'] == true;
    return isActive ? 'نشط' : 'غير مفعل';
  }

  // ✅ دالة مساعدة لألوان حالة الحساب
  Color _getAccountStatusColor(AuthService authService) {
    if (!authService.isLoggedIn) return Color(0xFFEF4444);
    if (authService.userData == null) return Color(0xFFFFA726);

    final isActive = authService.userData?['is_active'] == true;
    return isActive ? Color(0xFF10B981) : Color(0xFFEF4444);
  }

  // ✅ دالة لعرض رسالة انتهاء الجلسة
  void _showSessionExpiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Row(
            children: [
              Icon(Iconsax.info_circle, color: _warningOrange),
              SizedBox(width: 8.w),
              Text('انتهت الجلسة', style: TextStyle(fontFamily: 'Tajawal')),
            ],
          ),
          content: Text(
            'انتهت صلاحية جلسة التسجيل. يرجى تسجيل الدخول مرة أخرى.',
            style: TextStyle(fontFamily: 'Tajawal'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('موافق', style: TextStyle(fontFamily: 'Tajawal')),
            ),
          ],
        ),
      ),
    );
  }

  final Color _warningOrange = Color(0xFFFFA726);

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

  // ✅ دالة لبناء محتوى الشاشة الحالية مع معالجة الأخطاء
  Widget _buildCurrentScreen() {
    final authService = Provider.of<AuthService>(context);

    // ✅ التحقق من صحة الجلسة قبل بناء الشاشة
    if (authService.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final isValid = await authService.checkCurrentSessionValidity();
        if (!isValid && mounted) {
          _showSessionExpiredDialog();
        }
      });
    }

    switch (_currentIndex) {
      case 0:
        return HomeScreen(navigateToLessons: navigateToLessons);
      case 1:
        return ExercisesScreen();
      case 2:
        return LibraryScreen();
      case 3:
        return ProfileScreen();
      default:
        return HomeScreen(navigateToLessons: navigateToLessons);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          backgroundColor: _activeColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10.w,
                      offset: Offset(0, 3.h),
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
                          size: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
          leading: authService.isLoggedIn
              ? Padding(
            padding: EdgeInsets.only(right: 8.0.w),
            child: GestureDetector(
              onTap: _showUserInfoPopup,
              child: Container(
                width: 36.w,
                height: 36.h,
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.25),
                      Colors.white.withOpacity(0.15),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 2.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12.w,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Icon(
                  Iconsax.profile_circle,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
          )
              : null,
          actions: const [],
        ),
        body: _buildCurrentScreen(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: _cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20.w,
                spreadRadius: 2.w,
                offset: Offset(0, -4.h),
              ),
            ],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.r),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: _cardColor,
              selectedItemColor: _activeColor,
              unselectedItemColor: _inactiveColor,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                fontFamily: 'Tajawal',
                height: 1.5,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 11.sp,
                fontFamily: 'Tajawal',
                height: 1.5,
              ),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              elevation: 0,
              items: [
                _buildNavItem(
                  icon: Iconsax.home,
                  activeIcon: Iconsax.home_1,
                  label: 'الرئيسية',
                  isActive: _currentIndex == 0,
                ),
                _buildNavItem(
                  icon: Iconsax.activity,
                  activeIcon: Iconsax.activity,
                  label: 'النشاطات',
                  isActive: _currentIndex == 1,
                ),
                _buildNavItem(
                  icon: Iconsax.calendar,
                  activeIcon: Iconsax.calendar_1,
                  label: 'التقويم',
                  isActive: _currentIndex == 2,
                ),
                _buildNavItem(
                  icon: Iconsax.profile_circle,
                  activeIcon: Iconsax.profile_circle,
                  label: 'حسابي',
                  isActive: _currentIndex == 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isActive ? _activeColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(14.r),
          border: isActive
              ? Border.all(
            color: _activeColor.withOpacity(0.3),
            width: 1.5.w,
          )
              : null,
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          size: 24.sp,
          color: isActive ? _activeColor : _inactiveColor,
        ),
      ),
      activeIcon: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: _activeColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: _activeColor.withOpacity(0.3),
            width: 1.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: _activeColor.withOpacity(0.1),
              blurRadius: 8.w,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Icon(
          activeIcon,
          size: 24.sp,
          color: _activeColor,
        ),
      ),
      label: label,
    );
  }
}