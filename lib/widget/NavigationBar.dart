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
  final Color _successGreen = const Color(0xFF10B981);
  final Color _errorRed = const Color(0xFFEF4444);
  final Color _warningOrange = const Color(0xFFFFA726);

  // دالة للتنقل بين الشاشات
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // ✅ التعديل: استخدام courseId بدلاً من tableName
  void navigateToLessons(String imageUrl, String subjectName, String courseId) {
    print('🎯 الانتقال إلى الدروس - الكورس: $courseId');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonsListScreen(
          subjectImageUrl: imageUrl,
          subjectName: subjectName,
          courseId: courseId, // ✅ استخدام courseId
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  // ✅ تهيئة بيانات المستخدم من Firebase
  Future<void> _initializeUserData() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    // ✅ التحقق من صحة الجلسة الحالية
    if (authService.isLoggedIn) {
      print('🔍 التحقق من صحة جلسة المستخدم...');
      final isValid = await authService.checkCurrentSessionValidity();

      if (!isValid && mounted) {
        print('❌ جلسة المستخدم غير صالحة');
        _showSessionExpiredDialog();
        return;
      }

      // ✅ تحميل بيانات المستخدم إذا كانت الجلسة صالحة
      if (authService.userData == null) {
        print('🔄 جاري تحميل بيانات المستخدم...');
        await authService.refreshUserData();
      }

      print('✅ تهيئة بيانات المستخدم مكتملة');
      print('📊 بيانات المستخدم:');
      print('- البريد: ${authService.studentEmail}');
      print('- الصف: ${authService.selectedGrade}');
      print('- مسجل دخول: ${authService.isLoggedIn}');
    } else {
      print('⚠️ لا يوجد مستخدم مسجل دخول');
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

  // ✅ دالة لعرض معلومات المستخدم
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
                          iconColor: _successGreen,
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.crown_1,
                          title: 'نوع الاشتراك',
                          value: _getSubscriptionType(authService),
                          iconColor: _warningOrange,
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.shield_tick,
                          title: 'حالة الحساب',
                          value: _getAccountStatus(authService),
                          iconColor: _getAccountStatusColor(authService),
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

  // ✅ دالة مساعدة لتحديد نوع الاشتراك
  String _getSubscriptionType(AuthService authService) {
    if (authService.userData == null) return 'جاري التحميل...';

    final subscriptionType = authService.userData?['subscription_type'] ?? 'free';
    switch (subscriptionType) {
      case 'premium': return 'مميز';
      case 'basic': return 'أساسي';
      default: return 'مجاني';
    }
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
    if (!authService.isLoggedIn) return _errorRed;
    if (authService.userData == null) return _warningOrange;

    final isActive = authService.userData?['is_active'] == true;
    return isActive ? _successGreen : _errorRed;
  }

  // ✅ دالة لعرض رسالة انتهاء الجلسة
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
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: _warningOrange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.info_circle, color: _warningOrange, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'انتهت الجلسة',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: _warningOrange,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            'انتهت صلاحية جلسة التسجيل. يرجى تسجيل الدخول مرة أخرى للمتابعة.',
            style: TextStyle(
              fontSize: 14.sp,
              color: _inactiveColor,
              fontFamily: 'Tajawal',
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: TextButton.styleFrom(
                foregroundColor: _activeColor,
              ),
              child: Text(
                'موافق',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
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

  // ✅ دالة لبناء محتوى الشاشة الحالية مع التحقق من الجلسة
  Widget _buildCurrentScreen() {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        // ✅ التحقق من صحة الجلسة بشكل مستمر
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (authService.isLoggedIn) {
            final isValid = await authService.checkCurrentSessionValidity();
            if (!isValid && mounted) {
              _showSessionExpiredDialog();
              return;
            }
          }
        });

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        print('🎯 بناء واجهة التنقل - حالة المستخدم: ${authService.isLoggedIn}');

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: _backgroundColor,
            appBar: AppBar(
              backgroundColor: _activeColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(width: 8.w),
                  Text(
                    'تعلم القراءة',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Tajawal',
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
                      icon: Iconsax.book_1,
                      activeIcon: Iconsax.book_1,
                      label: 'المكتبة',
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
      },
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