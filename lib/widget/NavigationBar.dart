import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mody/screens/Home.dart';
import '../Auth/auth_service.dart';
import '../screens/ActivitiesScreen.dart';
import '../screens/profile_screen.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _currentIndex = 0;
  bool _isInitialized = false;

  // ✅ الألوان المحدثة المتناسقة مع التصميم
  final Color _activeColor = const Color(0xFF1E88E5); // الأزرق الأساسي
  final Color _inactiveColor = const Color(0xFF718096); // الرمادي الثانوي
  final Color _backgroundColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
  final Color _cardColor = Colors.white; // لون البطاقات
  final Color _errorRed = const Color(0xFFEF4444);
  final Color _successGreen = const Color(0xFF10B981);
  final Color _warningOrange = const Color(0xFFFFA726);

  final List<Widget> _pages = [
    const HomeScreen(),
    const ActivitiesScreen(),
    const ActivitiesScreen(), // يمكن استبدالها بشاشة التقويم لاحقاً
    const ProfileScreen()
  ];

  // قائمة الصفوف المتاحة
  final List<String> _grades = [
    'الصف الأول الابتدائي',
    'الصف الثاني الابتدائي',
    'الصف الثالث الابتدائي',
    'الصف الرابع الابتدائي',
    'الصف الخامس الابتدائي',
    'الصف السادس الابتدائي',
  ];

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    // انتظر حتى يصبح الـ context جاهزاً
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkGradeSelection();
    });
  }

  void _checkGradeSelection() {
    final authService = Provider.of<AuthService>(context, listen: false);

    // تأكد من أن التطبيق قد تم تهيئته بالكامل
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted && !_isInitialized) {
        // عرض دايلوج اختيار الصف فقط إذا لم يكن هناك صف محدد
        if (authService.selectedGrade == null || authService.selectedGrade!.isEmpty) {
          _showGradeSelectionDialog();
        }
        _isInitialized = true;
      }
    });
  }

  void _showGradeSelectionDialog() {
    // تأكد من أن الـ context لا يزال صالحاً
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false, // المستخدم لا يمكنه إغلاق الدايلوج بالنقر خارجها
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // رأس الدايلوج
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_activeColor, Color(0xFF64B5F6)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Iconsax.book_1,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'اختيار الصف الدراسي',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'اختر صفك الدراسي لتجربة تعلم مخصصة',
                                style: TextStyle(
                                  fontSize: 14,
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

                  // محتوى الدايلوج
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Text(
                          'اختر صفك الدراسي من القائمة التالية:',
                          style: TextStyle(
                            fontSize: 16,
                            color: _inactiveColor,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),

                        // شبكة اختيار الصفوف
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.8,
                          ),
                          itemCount: _grades.length,
                          itemBuilder: (context, index) {
                            return _buildGradeCard(_grades[index], index);
                          },
                        ),

                        const SizedBox(height: 25),
                        Text(
                          'يمكنك تغيير الصف لاحقاً من إعدادات الحساب',
                          style: TextStyle(
                            fontSize: 12,
                            color: _inactiveColor.withOpacity(0.7),
                            fontFamily: 'Tajawal',
                          ),
                          textAlign: TextAlign.center,
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

  Widget _buildGradeCard(String grade, int index) {
    // ألوان متدرجة منسجمة مع الهوية البصرية
    final List<Color> gradeColors = [
      // تدرجات زرقاء متناسقة مع اللون الأساسي
      Color(0xFF1E88E5), // الأزرق الأساسي
      Color(0xFF2196F3), // أزرق فاتح
      Color(0xFF42A5F5), // أزرق أفتح
      Color(0xFF64B5F6), // أزرق فاتح جداً
      Color(0xFF90CAF9), // أزرق فاتح ناعم
      Color(0xFFBBDEFB), // أزرق فاتح جداً ناعم
    ];

    // تدرجات ألوان الخلفية (أفتح)
    final List<Color> backgroundColors = [
      Color(0xFFE3F2FD), // أزرق فاتح جداً
      Color(0xFFE8F5FE), // أزرق فاتح ناعم
      Color(0xFFEDF7FF), // أزرق فاتح جداً ناعم
      Color(0xFFF2F9FF), // أزرق شبه أبيض
      Color(0xFFF7FBFF), // أزرق أبيض ناعم
      Color(0xFFFCFEFF), // أبيض مزرق
    ];

    final List<IconData> gradeIcons = [
      Iconsax.teacher,
      Iconsax.book,
      Iconsax.pen_tool,
      Iconsax.note_2,
      Iconsax.cpu,
      Iconsax.book_1,
    ];

    return GestureDetector(
      onTap: () => _selectGrade(grade),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              backgroundColors[index],
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: gradeColors[index].withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: gradeColors[index].withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // دائرة الأيقونة مع تأثير متدرج
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradeColors[index],
                    Color.alphaBlend(gradeColors[index].withOpacity(0.8), Colors.white),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: gradeColors[index].withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                gradeIcons[index],
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 10),
            
            // نص الصف
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                grade,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: gradeColors[index],
                  fontFamily: 'Tajawal',
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // شريط لوني صغير في الأسفل
            Container(
              width: double.infinity,
              height: 4,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradeColors[index],
                    gradeColors[index].withOpacity(0.7),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectGrade(String grade) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.setSelectedGrade(grade);

    // إغلاق الدايلوج
    if (mounted) {
      Navigator.of(context).pop();
    }

    // عرض رسالة نجاح
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.tick_circle,
                  color: _successGreen,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'تم اختيار $grade بنجاح',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: _successGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 3),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
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
                  // رأس البوب آب
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

                  // محتوى البوب آب
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
                          value: authService.selectedGrade ?? 'لم يتم الاختيار',
                          iconColor: _successGreen,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Iconsax.crown_1,
                          title: 'نوع الاشتراك',
                          value: 'مجاني',
                          iconColor: _warningOrange,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Iconsax.shield_tick,
                          title: 'حالة الحساب',
                          value: authService.isAccountActive() ? 'نشط' : 'غير مفعل',
                          iconColor: authService.isAccountActive() ? _successGreen : _errorRed,
                        ),
                      ],
                    ),
                  ),

                  // أزرار التحكم
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
                              setState(() {
                                _currentIndex = 3; // الانتقال لشاشة الملف الشخصي
                              });
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
            mainAxisAlignment: MainAxisAlignment.start, // محاذاة لليسار
            children: [
              // الشعار على اليسار
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
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // محاذاة لليسار
                children: [
                  Text(
                    'تعلم القراءة',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    'منصة التعلم التفاعلية',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 10,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          centerTitle: false,
          elevation: 0,
          // ✅ التعديل: نقل أيقونة المستخدم إلى leading (اليسار)
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
                        size: 20,
                      ),
                    ),
                  ),
                )
              : null,
          // ✅ إزالة الأيقونة من actions لأنها أصبحت في leading
          actions: const [],
        ),
        body: _pages[_currentIndex],
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
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
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
          border: isActive ? Border.all(
            color: _activeColor.withOpacity(0.3),
            width: 1.5,
          ) : null,
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
