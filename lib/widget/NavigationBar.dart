
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mody/widget/subscription_service.dart';
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
  bool _showMandatorySubscriptionDialog = false;

  // ✅ الألوان المحدثة المتناسقة مع التصميم في الصورة
  final Color _activeColor = const Color(0xFF1E88E5);
  final Color _inactiveColor = const Color(0xFF718096);
  final Color _backgroundColor = const Color(0xFFF5F9FF);
  final Color _cardColor = Colors.white;
  final Color _appBarColor = const Color(0xFF1E88E5);

  // إضافة متغيرات الاشتراك
  final SubscriptionService _subscriptionService = SubscriptionService();
  Map<String, dynamic> _subscriptionStatus = {};
  bool _hasTrial = false;
  int _trialDaysRemaining = 30; // شهر مجاني تجريبي

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
    _checkTrialStatus();
  }

  Future<void> _checkTrialStatus() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (authService.isLoggedIn) {
        // التحقق من وجود تجربة مجانية للمستخدم
        final userData = authService.userData;
        final creationDate = userData?['created_at'] != null
            ? DateTime.parse(userData?['created_at'])
            : DateTime.now();

        final daysSinceCreation = DateTime.now().difference(creationDate).inDays;
        _hasTrial = daysSinceCreation <= 30; // شهر مجاني

        if (_hasTrial) {
          _trialDaysRemaining = 30 - daysSinceCreation;
          if (_trialDaysRemaining < 0) _trialDaysRemaining = 0;

          print('🎁 مستخدم تجريبي: $daysSinceCreation يوم منذ الإنشاء');
          print('⏳ أيام تجريبية متبقية: $_trialDaysRemaining');
        }
      }
    } catch (e) {
      print('❌ خطأ في التحقق من الحالة التجريبية: $e');
    }
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

        // التحقق من حالة الاشتراك
        await _checkSubscriptionStatus();

        // إذا لم يكن هناك اشتراك نشط ولم يكن مستخدم تجريبي، عرض الدايلوج الإلزامي
        if (!_subscriptionStatus['isActive'] && !_hasTrial && mounted) {
          print('🔒 لا يوجد اشتراك نشط - عرض الدايلوج الإلزامي');
          await Future.delayed(Duration(milliseconds: 500));
          if (mounted) {
            setState(() {
              _showMandatorySubscriptionDialog = true;
            });
          }
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

  // دالة التحقق من حالة الاشتراك
  Future<void> _checkSubscriptionStatus() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (authService.isLoggedIn) {
        _subscriptionStatus = await _subscriptionService.checkUserSubscription();
        print('📊 حالة الاشتراك: ${_subscriptionStatus['isActive']}');
        if (mounted) setState(() {});
      }
    } catch (e) {
      print('❌ خطأ في التحقق من حالة الاشتراك: $e');
    }
  }

  // ✅ دالة لعرض الدايلوج الإلزامي للاشتراك
  void showMandatorySubscriptionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MandatorySubscriptionDialog(
        onSubscriptionActivated: () {
          setState(() {
            _showMandatorySubscriptionDialog = false;
          });
          _checkSubscriptionStatus();
        },
        trialDaysRemaining: _trialDaysRemaining,
      ),
    );
  }

  // ✅ دالة لتحويل رقم الصف إلى نص عربي
  String _getGradeText(int? gradeValue) {
    if (gradeValue == null) {
      return 'لم يتم الاختيار';
    }

    switch (gradeValue) {
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

  // دالة للحصول على نوع الاشتراك
  String _getSubscriptionType() {
    if (_subscriptionStatus['isActive'] == true) {
      return _subscriptionStatus['subscriptionData']?['plan_type'] ?? 'نشط';
    }
    return _hasTrial ? 'تجريبي' : 'مجاني';
  }

  // دالة للحصول على حالة الاشتراك
  String _getSubscriptionStatus() {
    if (_subscriptionStatus['isActive'] == true) {
      int daysRemaining = _subscriptionStatus['daysRemaining'] ?? 0;
      return 'نشط (${daysRemaining} يوم متبقي)';
    } else if (_hasTrial) {
      return 'تجريبي ($_trialDaysRemaining يوم متبقي)';
    }
    return 'غير نشط';
  }

  // دالة للحصول على لون حالة الاشتراك
  Color _getSubscriptionStatusColor() {
    if (_subscriptionStatus['isActive'] == true) {
      return const Color(0xFF10B981);
    } else if (_hasTrial) {
      return const Color(0xFFFFA726);
    }
    return const Color(0xFFEF4444);
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
    if (_showMandatorySubscriptionDialog) {
      return Container();
    }

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
        if (_showMandatorySubscriptionDialog && !_isInitializing) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showMandatorySubscriptionDialog();
          });
        }

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: _backgroundColor,

            appBar: AppBar(
              backgroundColor: _appBarColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (authService.isLoggedIn && !_showMandatorySubscriptionDialog)
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

                  Text(
                    'منصة شاطر',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Tajawal',
                    ),
                  ),

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

            bottomNavigationBar: _showMandatorySubscriptionDialog ? null : Container(
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
                        icon: Iconsax.camera,
                        activeIcon: Iconsax.camera,
                        label: 'الماسح',
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
                          value: _getSubscriptionType(),
                          iconColor: _hasTrial ? const Color(0xFFFFA726) : _activeColor,
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(
                          icon: Iconsax.calendar_tick,
                          title: 'حالة الاشتراك',
                          value: _getSubscriptionStatus(),
                          iconColor: _getSubscriptionStatusColor(),
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
                              if (!_subscriptionStatus['isActive'] && !_hasTrial) {
                                showMandatorySubscriptionDialog();
                              } else {
                                _onItemTapped(3);
                              }
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
                              _subscriptionStatus['isActive'] ? 'الملف الشخصي' : 'تفعيل الاشتراك',
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

// ✅ دايلوج الاشتراك الإلزامي مع تصميم احترافي
class MandatorySubscriptionDialog extends StatefulWidget {
  final VoidCallback onSubscriptionActivated;
  final int trialDaysRemaining;

  const MandatorySubscriptionDialog({
    super.key,
    required this.onSubscriptionActivated,
    this.trialDaysRemaining = 0,
  });

  @override
  State<MandatorySubscriptionDialog> createState() => _MandatorySubscriptionDialogState();
}

class _MandatorySubscriptionDialogState extends State<MandatorySubscriptionDialog> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;
  int _activeTab = 0; // 0: تجريبي، 1: تفعيل

  @override
  Widget build(BuildContext context) {
    final hasTrial = widget.trialDaysRemaining > 0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxWidth: 400.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 40.r,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ رأس الدايلوج بتصميم أنيق
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      const Color(0xFF4F46E5),
                      const Color(0xFF1E88E5),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  children: [
                    // ✅ أيقونة متحركة
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        hasTrial ? Iconsax.star_1 : Iconsax.crown_1,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ✅ العنوان الرئيسي
                    Text(
                      hasTrial ? '🎁 شهر مجاني تجريبي' : '🌟 اشتراك مطلوب',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Tajawal',
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),

                    // ✅ الوصف
                    Text(
                      hasTrial
                          ? 'استمتع بشهر كامل من الميزات المميزة مجاناً'
                          : 'حان وقت الترقية لاستمرار الاستفادة من الميزات',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                        fontFamily: 'Tajawal',
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // ✅ تبويبات للاختيار بين تجريبي وتفعيل
              if (hasTrial) _buildTabs(),

              // ✅ محتوى الدايلوج
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    if (_activeTab == 0 && hasTrial)
                      _buildTrialContent()
                    else
                      _buildActivationContent(),

                    SizedBox(height: 24.h),

                    // ✅ أزرار التحكم
                    Row(
                      children: [
                        if (hasTrial)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _activeTab = 1;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF1E88E5),
                                side: BorderSide(
                                  color: const Color(0xFF1E88E5),
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                              ),
                              child: Text(
                                'تفعيل الآن',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ),
                          ),

                        SizedBox(width: hasTrial ? 12.w : 0),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: _activeTab == 0 && hasTrial
                                ? () {
                              Navigator.of(context).pop();
                              widget.onSubscriptionActivated();
                            }
                                : _activateSubscription,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _activeTab == 0 && hasTrial
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFF1E88E5),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              elevation: 2,
                              shadowColor: _activeTab == 0 && hasTrial
                                  ? const Color(0xFF10B981).withOpacity(0.3)
                                  : const Color(0xFF1E88E5).withOpacity(0.3),
                            ),
                            child: _isLoading
                                ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _activeTab == 0 && hasTrial
                                      ? Iconsax.play_circle
                                      : Iconsax.card,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  _activeTab == 0 && hasTrial
                                      ? 'بدء التجربة'
                                      : 'تفعيل الاشتراك',
                                  style: TextStyle(
                                    fontSize: 15.sp,
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

                    SizedBox(height: 16.h),

                    // ✅ رسالة مساعدة
                    if (_activeTab == 1 || !hasTrial)
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.info_circle,
                              color: const Color(0xFF6B7280),
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'يمكنك الحصول على كود التفعيل من المسؤول',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF6B7280),
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ),
                          ],
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
  }

  Widget _buildTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _activeTab = 0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: _activeTab == 0 ? const Color(0xFF1E88E5) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.star_1,
                      size: 16.sp,
                      color: _activeTab == 0 ? Colors.white : const Color(0xFF6B7280),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'تجريبي',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: _activeTab == 0 ? Colors.white : const Color(0xFF6B7280),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _activeTab = 1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: _activeTab == 1 ? const Color(0xFF1E88E5) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.crown_1,
                      size: 16.sp,
                      color: _activeTab == 1 ? Colors.white : const Color(0xFF6B7280),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'اشتراك',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: _activeTab == 1 ? Colors.white : const Color(0xFF6B7280),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrialContent() {
    return Column(
      children: [
        // ✅ شريط التقدم للأيام المتبقية
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                const Color(0xFFFEF3C7),
                const Color(0xFFFDE68A),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: const Color(0xFFFFA726).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الأيام المتبقية',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF92400E),
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  Text(
                    '${widget.trialDaysRemaining} يوم',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD97706),
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                height: 8.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE68A),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double progress = widget.trialDaysRemaining / 30.0;
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 800),
                          width: constraints.maxWidth * progress,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFD97706),
                                const Color(0xFFF59E0B),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // ✅ ميزات الاشتراك التجريبي
        Column(
          children: [
            _buildFeatureItem(
              icon: Iconsax.unlimited,
              title: 'وصول كامل',
              description: 'جميع المواد والدروس',
              color: const Color(0xFF10B981),
            ),
            SizedBox(height: 12.h),
            _buildFeatureItem(
              icon: Iconsax.video_play,
              title: 'فيديوهات تعليمية',
              description: 'شروحات مفصلة',
              color: const Color(0xFF3B82F6),
            ),
            SizedBox(height: 12.h),
            _buildFeatureItem(
              icon: Iconsax.document_text,
              title: 'تمارين واختبارات',
              description: 'تدريب عملي',
              color: const Color(0xFF8B5CF6),
            ),
          ],
        ),

        SizedBox(height: 20.h),

        // ✅ ملاحظة
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: const Color(0xFFFDE68A),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.clock,
                color: const Color(0xFFD97706),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'بعد انتهاء الشهر التجريبي، سيتم طلب تفعيل الاشتراك',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF92400E),
                    fontFamily: 'Tajawal',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivationContent() {
    return Column(
      children: [
        // ✅ حقل إدخال الكود بتصميم أنيق
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: _codeController,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: const Color(0xFF1E293B),
              letterSpacing: 1.2,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'أدخل كود التفعيل',
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF94A3B8),
                fontFamily: 'Tajawal',
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 18.h,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Icon(
                  Iconsax.key,
                  color: const Color(0xFF1E88E5),
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 20.h),

        // ✅ ميزات الاشتراك المدفوع
        Column(
          children: [
            _buildFeatureItem(
              icon: Iconsax.crown_1,
              title: 'مميزات متقدمة',
              description: 'وصول غير محدود',
              color: const Color(0xFF8B5CF6),
            ),
            SizedBox(height: 12.h),
            _buildFeatureItem(
              icon: Iconsax.lock_1,
              title: 'بدون إعلانات',
              description: 'تجربة تعليمية نقية',
              color: const Color(0xFF10B981),
            ),
            SizedBox(height: 12.h),
            _buildFeatureItem(
              icon: Iconsax.support,
              title: 'دعم فني مميز',
              description: 'مساعدة متخصصة',
              color: const Color(0xFF3B82F6),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF64748B),
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

  Future<void> _activateSubscription() async {
    if (_codeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('يرجى إدخال كود التفعيل'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      Map<String, dynamic> result = await _subscriptionService.activateSubscription(
        _codeController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (result['success']) {
        // ✅ نجح التفعيل
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🎉 تم تفعيل الاشتراك بنجاح!'),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );

        await Future.delayed(Duration(milliseconds: 500));

        Navigator.of(context).pop();
        widget.onSubscriptionActivated();
      } else {
        // ❌ فشل التفعيل
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء التفعيل'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
