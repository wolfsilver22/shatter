import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mody/screens/Home.dart';
import '../Auth/auth_service.dart';
import '../screens/ActivitiesScreen.dart';
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
          tableName: tableName, // ✅ تمرير اسم الجدول
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  // ✅ دالة لتحويل رقم الصف إلى نص عربي
  String _getGradeText(String? gradeValue) {
    if (gradeValue == null || gradeValue.isEmpty) {
      return 'لم يتم الاختيار';
    }

    // تحويل القيمة إلى رقم للتحقق منها
    final gradeNumber = int.tryParse(gradeValue);

    if (gradeNumber == null) {
      return gradeValue; // إذا لم يكن رقماً، نعيد القيمة كما هي
    }

    // تحويل رقم الصف إلى النص المقابل
    switch (gradeNumber) {
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
            insetPadding: const EdgeInsets.all(20),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _activeColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.profile_circle,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'معلومات الحساب',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              Text(
                                'تفاصيل حسابك الشخصي',
                                style: TextStyle(
                                  fontSize: 12,
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          icon: Iconsax.user,
                          title: 'رقم الحساب',
                          value: authService.studentNumber ?? 'غير متوفر',
                          iconColor: _activeColor,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Iconsax.book_1,
                          title: 'الصف الدراسي',
                          value: _getGradeText(authService.selectedGrade), // ✅ استخدام الدالة المحولة
                          iconColor: const Color(0xFF10B981),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Iconsax.crown_1,
                          title: 'نوع الاشتراك',
                          value: 'مجاني',
                          iconColor: const Color(0xFFFFA726),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Iconsax.shield_tick,
                          title: 'حالة الحساب',
                          value: authService.isAccountActive() ? 'نشط' : 'غير مفعل',
                          iconColor: authService.isAccountActive() ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _inactiveColor,
                              side: BorderSide(color: _inactiveColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'إغلاق',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
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
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'الملف الشخصي',
                              style: TextStyle(
                                fontSize: 14,
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

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: _inactiveColor,
                    fontFamily: 'Tajawal',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
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

  // دالة لبناء محتوى الشاشة الحالية
  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(navigateToLessons: navigateToLessons);
      case 1:
        return ActivitiesScreen();
      case 2:
        return ActivitiesScreen();
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Iconsax.book_1,
                          color: _activeColor,
                          size: 24,
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
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: _showUserInfoPopup,
              child: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.all(8),
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
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
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
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, -4),
              ),
            ],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: _cardColor,
              selectedItemColor: _activeColor,
              unselectedItemColor: _inactiveColor,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: 'Tajawal',
                height: 1.5,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 11,
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
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? _activeColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: isActive
              ? Border.all(
            color: _activeColor.withOpacity(0.3),
            width: 1.5,
          )
              : null,
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          size: 24,
          color: isActive ? _activeColor : _inactiveColor,
        ),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _activeColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _activeColor.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _activeColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          activeIcon,
          size: 24,
          color: _activeColor,
        ),
      ),
      label: label,
    );
  }
}
