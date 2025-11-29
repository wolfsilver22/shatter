import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import '../Auth/auth_service.dart';
import '../widget/subscription_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  Map<String, dynamic> _subscriptionStatus = {};
  bool _isLoadingSubscription = true;

  // دالة تنسيق التاريخ البديلة
  String formatDate(DateTime date) {
    int year = date.year;
    int month = date.month;
    int day = date.day;

    String formattedYear = year.toString();
    String formattedMonth = month.toString().padLeft(2, '0');
    String formattedDay = day.toString().padLeft(2, '0');

    return '$formattedYear/$formattedMonth/$formattedDay';
  }

  @override
  void initState() {
    super.initState();
    _loadSubscriptionStatus();
  }

  Future<void> _loadSubscriptionStatus() async {
    setState(() => _isLoadingSubscription = true);
    _subscriptionStatus = await _subscriptionService.checkUserSubscription();
    setState(() => _isLoadingSubscription = false);
  }

  void _showActivationDialog() {
    TextEditingController codeController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E88E5).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Iconsax.card, color: const Color(0xFF1E88E5), size: 20.sp),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'تفعيل الاشتراك',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                            color: const Color(0xFF1E88E5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'أدخل كود التفعيل الخاص بك لتفعيل الاشتراك',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF718096),
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F9FF),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        controller: codeController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tajawal',
                          color: const Color(0xFF2D3748),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'أدخل الكود هنا',
                          hintStyle: TextStyle(
                            color: const Color(0xFFA0AEC0),
                            fontFamily: 'Tajawal',
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    if (isLoading)
                      CircularProgressIndicator(color: const Color(0xFF1E88E5))
                    else
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF718096),
                                side: BorderSide(color: const Color(0xFFCBD5E0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              child: Text(
                                'إلغاء',
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
                              onPressed: () async {
                                if (codeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('يرجى إدخال كود التفعيل'),
                                      backgroundColor: const Color(0xFFE53E3E),
                                    ),
                                  );
                                  return;
                                }

                                setState(() => isLoading = true);
                                Map<String, dynamic> result =
                                await _subscriptionService.activateSubscription(
                                  codeController.text.trim(),
                                );
                                setState(() => isLoading = false);

                                if (result['success']) {
                                  Navigator.pop(context);
                                  _showActivationSuccessDialog();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result['message']),
                                      backgroundColor: const Color(0xFFE53E3E),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E88E5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              child: Text(
                                'تفعيل',
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showRenewalDialog() {
    TextEditingController codeController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA726).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Iconsax.refresh, color: const Color(0xFFFFA726), size: 20.sp),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'تجديد الاشتراك',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                            color: const Color(0xFFFFA726),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'أدخل كود التفعيل الجديد لتجديد الاشتراك',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF718096),
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFFFA726).withOpacity(0.3)),
                      ),
                      child: TextField(
                        controller: codeController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tajawal',
                          color: const Color(0xFF2D3748),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'أدخل كود التجديد هنا',
                          hintStyle: TextStyle(
                            color: const Color(0xFFA0AEC0),
                            fontFamily: 'Tajawal',
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'ملاحظة: سيتم إضافة المدة الجديدة إلى اشتراكك الحالي',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFFFFA726),
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    if (isLoading)
                      CircularProgressIndicator(color: const Color(0xFFFFA726))
                    else
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF718096),
                                side: BorderSide(color: const Color(0xFFCBD5E0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              child: Text(
                                'إلغاء',
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
                              onPressed: () async {
                                if (codeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('يرجى إدخال كود التجديد'),
                                      backgroundColor: const Color(0xFFE53E3E),
                                    ),
                                  );
                                  return;
                                }

                                setState(() => isLoading = true);
                                Map<String, dynamic> result =
                                await _subscriptionService.activateSubscription(
                                  codeController.text.trim(),
                                );
                                setState(() => isLoading = false);

                                if (result['success']) {
                                  Navigator.pop(context);
                                  _showRenewalSuccessDialog();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result['message']),
                                      backgroundColor: const Color(0xFFE53E3E),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFA726),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              child: Text(
                                'تجديد',
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showRenewalSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.tick_circle,
                    color: const Color(0xFF10B981),
                    size: 40.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'تم التجديد بنجاح!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                    color: const Color(0xFFFFA726),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'تم تجديد اشتراكك بنجاح وتم إضافة المدة الجديدة إلى اشتراكك الحالي.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF718096),
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _loadSubscriptionStatus();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA726),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'متابعة',
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
        ),
      ),
    );
  }

  void _showActivationSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.tick_circle,
                    color: const Color(0xFF10B981),
                    size: 40.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'تم التفعيل بنجاح!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                    color: const Color(0xFF1E88E5),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'تم تفعيل الاشتراك بنجاح. يمكنك الآن الاستفادة من جميع الميزات المميزة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF718096),
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _loadSubscriptionStatus();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'متابعة',
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
        ),
      ),
    );
  }

  Widget _buildSubscriptionSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20.r,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFF1F5F9),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.crown_1,
                  color: const Color(0xFFFFA726),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'حالة الاشتراك',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          if (_isLoadingSubscription)
            Center(
              child: Column(
                children: [
                  CircularProgressIndicator(color: const Color(0xFF1E88E5)),
                  SizedBox(height: 8.h),
                  Text(
                    'جاري التحقق من حالة الاشتراك...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF718096),
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            )
          else if (_subscriptionStatus['isActive'] == true)
            _buildActiveSubscription()
          else
            _buildInactiveSubscription(),
        ],
      ),
    );
  }

  Widget _buildActiveSubscription() {
    String planType = _subscriptionStatus['subscriptionData']?['plan_type'] ?? 'نشط';
    int daysRemaining = _subscriptionStatus['daysRemaining'] ?? 0;
    DateTime endDate = _subscriptionStatus['endDate'] ?? DateTime.now();
    DateTime startDate = (_subscriptionStatus['subscriptionData']?['start_date'] as Timestamp?)?.toDate() ?? DateTime.now();
    String subscriptionCode = _subscriptionStatus['subscriptionData']?['subscription_code'] ?? 'غير محدد';

    // حساب المدة الإجمالية
    int totalDays = endDate.difference(startDate).inDays;
    int usedDays = totalDays - daysRemaining;

    return Column(
      children: [
        // بطاقة معلومات الاشتراك باللون البرتقالي
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                const Color(0xFFFFA726).withOpacity(0.9),
                const Color(0xFFFFB74D),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFA726).withOpacity(0.3),
                blurRadius: 15.r,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الاشتراك نشط',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      planType,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // شريط التقدم
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الأيام المتبقية',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withOpacity(0.9),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      Text(
                        '$daysRemaining يوم',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Stack(
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double progress = daysRemaining / totalDays;
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              width: constraints.maxWidth * progress,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.8),
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
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تم استخدام $usedDays من $totalDays يوم',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // معلومات تفصيلية عن الاشتراك
        _buildSubscriptionInfoRow('نوع الاشتراك', planType),
        _buildSubscriptionInfoRow('كود الاشتراك', subscriptionCode),
        _buildSubscriptionInfoRow('تاريخ البدء', formatDate(startDate)),
        _buildSubscriptionInfoRow('تاريخ الانتهاء', formatDate(endDate)),
        _buildSubscriptionInfoRow('المدة المتبقية', '$daysRemaining يوم'),

        SizedBox(height: 16.h),

        // زر تجديد الاشتراك
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _showRenewalDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFA726),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              elevation: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.refresh, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  'تجديد الاشتراك',
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
    );
  }

  Widget _buildInactiveSubscription() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFFECACA)),
          ),
          child: Row(
            children: [
              Icon(Iconsax.info_circle, color: const Color(0xFFDC2626), size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'لا يوجد اشتراك نشط',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFDC2626),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'قم بتفعيل الاشتراك للاستفادة من الميزات المميزة',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFFDC2626),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _showActivationDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.card, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  'تفعيل الاشتراك',
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
        SizedBox(height: 8.h),
        Text(
          'ادخل كود التفعيل لتفعيل الاشتراك',
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF718096),
            fontFamily: 'Tajawal',
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF64748B),
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF1E88E5),
            const Color(0xFF1976D2),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E88E5).withOpacity(0.3),
            blurRadius: 15.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 3.w,
              ),
            ),
            child: Icon(
              Iconsax.profile_circle,
              color: Colors.white,
              size: 40.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            authService.studentEmail ?? 'مستخدم',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'طالب',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 8.h),
          if (authService.selectedGrade != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                _getGradeText(authService.selectedGrade),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
        ],
      ),
    );
  }

  // دالة لتحويل رقم الصف إلى نص عربي
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

  Widget _buildMenuItems() {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Iconsax.setting_2,
            title: 'الإعدادات',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Iconsax.shield_tick,
            title: 'الخصوصية',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Iconsax.info_circle,
            title: 'عن التطبيق',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Iconsax.headphone,
            title: 'الدعم الفني',
            onTap: () {},
          ),
          // زر تسجيل الخروج
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFF1F5F9),
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              leading: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE53E3E).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.logout,
                  color: const Color(0xFFE53E3E),
                  size: 20.sp,
                ),
              ),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Tajawal',
                  color: const Color(0xFFE53E3E),
                ),
              ),
              trailing: Icon(
                Iconsax.arrow_left_2,
                color: const Color(0xFFCBD5E0),
                size: 18.sp,
              ),
              onTap: () {
                _showLogoutConfirmationDialog(authService);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(AuthService authService) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Row(
            children: [
              Icon(Iconsax.logout, color: const Color(0xFFE53E3E)),
              SizedBox(width: 8.w),
              Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
          content: Text(
            'هل أنت متأكد أنك تريد تسجيل الخروج؟',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Tajawal',
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF718096),
                      side: BorderSide(color: const Color(0xFFCBD5E0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'إلغاء',
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
                    onPressed: () async {
                      Navigator.pop(context);
                      await authService.logout();
                      // سيتم توجيه المستخدم تلقائياً لشاشة تسجيل الدخول
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53E3E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'تسجيل الخروج',
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
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFF1F5F9),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFF1E88E5).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1E88E5),
            size: 20.sp,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Tajawal',
            color: const Color(0xFF1E293B),
          ),
        ),
        trailing: Icon(
          Iconsax.arrow_left_2,
          color: const Color(0xFFCBD5E0),
          size: 18.sp,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F9FF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                _buildProfileHeader(),
                _buildSubscriptionSection(),
                _buildMenuItems(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
