// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
//   // ألوان التطبيق التعليمي
//   final Color primaryColor = const Color(0xFF1E88E5); // الأزرق الأساسي
//   final Color secondaryColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
//   final Color accentColor = const Color(0xFFFFA726); // البرتقالي
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//
//   // متحكمات الحركة
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   // بيانات المستخدم
//   final Map<String, dynamic> _userData = {
//     'name': 'أحمد محمد',
//     'email': 'ahmed@example.com',
//     'phone': '+966 50 123 4567',
//     'joinDate': '2024-01-15',
//     'subscriptionType': 'مميز',
//     'subscriptionStatus': 'نشط',
//     'subscriptionExpiry': '2024-12-31',
//     'completedLessons': 24,
//     'totalLessons': 50,
//     'points': 1250,
//     'level': 'متوسط',
//     'avatar': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
//   };
//
//   // الإحصائيات
//   final List<Map<String, dynamic>> _stats = [
//     {
//       'title': 'الدروس المكتملة',
//       'value': '24',
//       'total': '50',
//       'icon': Icons.menu_book,
//       'color': Color(0xFF4CAF50),
//       'progress': 0.48,
//     },
//     {
//       'title': 'النقاط',
//       'value': '1,250',
//       'icon': Icons.emoji_events,
//       'color': Color(0xFFFF9800),
//     },
//     {
//       'title': 'المستوى',
//       'value': 'متوسط',
//       'icon': Icons.trending_up,
//       'color': Color(0xFF2196F3),
//     },
//     {
//       'title': 'الأيام المتتالية',
//       'value': '12',
//       'icon': Icons.calendar_today,
//       'color': Color(0xFF9C27B0),
//     },
//   ];
//
//   // خيارات القائمة
//   final List<Map<String, dynamic>> _menuItems = [
//     {
//       'title': 'الإشعارات',
//       'icon': Icons.notifications,
//       'color': Color(0xFF4CAF50),
//     },
//     {
//       'title': 'الإعدادات',
//       'icon': Icons.settings,
//       'color': Color(0xFF2196F3),
//     },
//     {
//       'title': 'المفضلة',
//       'icon': Icons.favorite,
//       'color': Color(0xFFE91E63),
//     },
//     {
//       'title': 'التقارير',
//       'icon': Icons.analytics,
//       'color': Color(0xFF9C27B0),
//     },
//     {
//       'title': 'المساعدة',
//       'icon': Icons.help,
//       'color': Color(0xFFFF9800),
//     },
//     {
//       'title': 'عن التطبيق',
//       'icon': Icons.info,
//       'color': Color(0xFF607D8B),
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//   }
//
//   void _initAnimations() {
//     // تهيئة متحكمات الحركة
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//
//     // تعريف الحركات
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
//     );
//
//     // بدء الحركات
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _fadeController.forward();
//       _scaleController.forward();
//       _slideController.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _scaleController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   void _showSubscriptionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.all(20.w),
//         child: Container(
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           padding: EdgeInsets.all(24.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // أيقونة الاشتراك
//               Container(
//                 width: 80.w,
//                 height: 80.h,
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.workspace_premium,
//                   color: primaryColor,
//                   size: 40.w,
//                 ),
//               ),
//
//               SizedBox(height: 16.h),
//
//               Text(
//                 'تفاصيل الاشتراك',
//                 style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   color: textPrimary,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//
//               SizedBox(height: 16.h),
//
//               _buildSubscriptionDetail('نوع الاشتراك', _userData['subscriptionType']),
//               _buildSubscriptionDetail('حالة الاشتراك', _userData['subscriptionStatus']),
//               _buildSubscriptionDetail('تاريخ الانتهاء', _userData['subscriptionExpiry']),
//
//               SizedBox(height: 24.h),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: textSecondary,
//                         padding: EdgeInsets.symmetric(vertical: 12.h),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                       child: Text(
//                         'إغلاق',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(width: 12.w),
//
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         _showUpgradeDialog();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12.h),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                       child: Text(
//                         'ترقية',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSubscriptionDetail(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: textSecondary,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.bold,
//               color: textPrimary,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showUpgradeDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.all(20.w),
//         child: Container(
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           padding: EdgeInsets.all(24.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'ترقية الاشتراك',
//                 style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   color: textPrimary,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//
//               SizedBox(height: 16.h),
//
//               _buildSubscriptionPlan('مجاني', 'الوصول الأساسي', '0', false),
//               _buildSubscriptionPlan('مميز', 'جميع الميزات', '49', true),
//               _buildSubscriptionPlan('مدى الحياة', 'وصول دائم', '199', false),
//
//               SizedBox(height: 24.h),
//
//               Text(
//                 'اختر الباقة المناسبة لك واستمتع بتجربة تعلم كاملة',
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: textSecondary,
//                   fontFamily: 'Tajawal',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSubscriptionPlan(String name, String features, String price, bool isRecommended) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: isRecommended ? primaryColor.withOpacity(0.1) : Colors.grey[50],
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(
//           color: isRecommended ? primaryColor : Colors.grey[300]!,
//           width: 2,
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: isRecommended ? primaryColor : textPrimary,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     if (isRecommended) ...[
//                       SizedBox(width: 8.w),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                         decoration: BoxDecoration(
//                           color: primaryColor,
//                           borderRadius: BorderRadius.circular(8.r),
//                         ),
//                         child: Text(
//                           'موصى به',
//                           style: TextStyle(
//                             fontSize: 10.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   features,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: textSecondary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             children: [
//               Text(
//                 '$price ر.س',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//               Text(
//                 '/شهرياً',
//                 style: TextStyle(
//                   fontSize: 10.sp,
//                   color: textSecondary,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: secondaryColor,
//         appBar: _buildAppBar(),
//         body: AnimatedBuilder(
//           animation: _fadeController,
//           builder: (context, child) {
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: ScaleTransition(
//                   scale: _scaleAnimation,
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Column(
//                       children: [
//                         _buildProfileHeader(),
//                         _buildStatsSection(),
//                         _buildSubscriptionCard(),
//                         _buildMenuSection(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, -0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
//         ),
//       ),
//       child: Container(
//         margin: EdgeInsets.all(16.w),
//         padding: EdgeInsets.all(20.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//           gradient: LinearGradient(
//             colors: [primaryColor, primaryColor.withOpacity(0.8)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: primaryColor.withOpacity(0.3),
//               blurRadius: 15.r,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // خلفية متدرجة
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.r),
//                 gradient: LinearGradient(
//                   colors: [
//                     primaryColor.withOpacity(0.9),
//                     primaryColor.withOpacity(0.7)
//                   ],
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                 ),
//               ),
//             ),
//
//             // المحتوى
//             Row(
//               children: [
//                 // الصورة الشخصية
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.white, width: 3.w),
//                     image: DecorationImage(
//                       image: NetworkImage(_userData['avatar']),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(width: 16.w),
//
//                 // المعلومات
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _userData['name'],
//                         style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 4.h),
//
//                       Text(
//                         _userData['email'],
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 8.h),
//
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.phone,
//                             size: 14.sp,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                           SizedBox(width: 4.w),
//                           Text(
//                             _userData['phone'],
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: Colors.white.withOpacity(0.8),
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       SizedBox(height: 4.h),
//
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.calendar_today,
//                             size: 14.sp,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                           SizedBox(width: 4.w),
//                           Text(
//                             'منضم منذ ${_userData['joinDate']}',
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: Colors.white.withOpacity(0.8),
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // زر التعديل
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.edit,
//                     color: Colors.white,
//                     size: 20.w,
//                   ),
//                   style: IconButton.styleFrom(
//                     backgroundColor: Colors.white.withOpacity(0.2),
//                     padding: EdgeInsets.all(8.w),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatsSection() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.2),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'إحصائياتي',
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 color: textPrimary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//
//             SizedBox(height: 12.h),
//
//             GridView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12.w,
//                 mainAxisSpacing: 12.h,
//                 childAspectRatio: 1.6,
//               ),
//               itemCount: _stats.length,
//               itemBuilder: (context, index) {
//                 final stat = _stats[index];
//                 return _buildStatCard(stat, index);
//               },
//             ),
//
//             SizedBox(height: 24.h),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatCard(Map<String, dynamic> stat, int index) {
//     return AnimatedBuilder(
//       animation: _fadeController,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _fadeAnimation.value,
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - _fadeController.value)),
//             child: child,
//           ),
//         );
//       },
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Card(
//           elevation: 4.w,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12.r),
//               color: cardColor,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(6.w),
//                       decoration: BoxDecoration(
//                         color: stat['color'].withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         stat['icon'],
//                         color: stat['color'],
//                         size: 18.sp,
//                       ),
//                     ),
//
//                     SizedBox(width: 8.w),
//
//                     Expanded(
//                       child: Text(
//                         stat['title'],
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: textSecondary,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 8.h),
//
//                 Text(
//                   stat['value'],
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                     color: textPrimary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//
//                 if (stat.containsKey('total')) ...[
//                   SizedBox(height: 4.h),
//                   LinearProgressIndicator(
//                     value: stat['progress'],
//                     backgroundColor: Colors.grey[200],
//                     color: stat['color'],
//                     minHeight: 4.h,
//                   ),
//                   SizedBox(height: 2.h),
//                   Text(
//                     '${stat['value']} من ${stat['total']}',
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       color: textSecondary,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSubscriptionCard() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.3),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Card(
//           elevation: 4.w,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           child: Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16.r),
//               gradient: LinearGradient(
//                 colors: [accentColor, Color(0xFFFFB74D)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 50.w,
//                   height: 50.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.workspace_premium,
//                     color: Colors.white,
//                     size: 24.w,
//                   ),
//                 ),
//
//                 SizedBox(width: 12.w),
//
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'اشتراك ${_userData['subscriptionType']}',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//
//                       SizedBox(height: 4.h),
//
//                       Text(
//                         _userData['subscriptionStatus'] == 'نشط'
//                             ? 'اشتراكك نشط حتى ${_userData['subscriptionExpiry']}'
//                             : 'اشتراكك منتهي',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 ElevatedButton(
//                   onPressed: _showSubscriptionDialog,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: accentColor,
//                     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                   ),
//                   child: Text(
//                     'عرض التفاصيل',
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.bold,
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
//
//   Widget _buildMenuSection() {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.4),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'الإعدادات',
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 color: textPrimary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//
//             SizedBox(height: 12.h),
//
//             Card(
//               elevation: 4.w,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16.r),
//                   color: cardColor,
//                 ),
//                 child: Column(
//                   children: _menuItems.map((item) {
//                     return _buildMenuItem(item);
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMenuItem(Map<String, dynamic> item) {
//     return Column(
//       children: [
//         ListTile(
//           leading: Container(
//             width: 40.w,
//             height: 40.h,
//             decoration: BoxDecoration(
//               color: item['color'].withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               item['icon'],
//               color: item['color'],
//               size: 20.w,
//             ),
//           ),
//           title: Text(
//             item['title'],
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: textPrimary,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           trailing: Icon(
//             Icons.arrow_back_ios_new,
//             size: 16.sp,
//             color: textSecondary,
//           ),
//           onTap: () {
//             // التنقل للشاشة المطلوبة
//           },
//         ),
//         if (_menuItems.indexOf(item) != _menuItems.length - 1)
//           Divider(height: 1, indent: 70.w),
//       ],
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: primaryColor,
//       foregroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       title: Text(
//         'الملف الشخصي',
//         style: TextStyle(
//           fontSize: 20.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../Auth/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  // ألوان التطبيق التعليمي
  final Color primaryColor = const Color(0xFF1E88E5);
  final Color secondaryColor = const Color(0xFFF5F9FF);
  final Color accentColor = const Color(0xFFFFA726);
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF2D3748);
  final Color textSecondary = const Color(0xFF718096);
  final Color errorRed = const Color(0xFFEF4444);
  final Color successGreen = const Color(0xFF10B981);
  final Color warningOrange = const Color(0xFFF59E0B);

  // متحكمات الحركة
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  // الإحصائيات
  List<Map<String, dynamic>> _stats = [];

  // بيانات الاشتراك
  int _subscriptionDays = 0;
  bool _isLoading = true;

  // خيارات القائمة
  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'الإشعارات',
      'icon': Iconsax.notification,
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'الإعدادات',
      'icon': Iconsax.setting_2,
      'color': Color(0xFF2196F3),
    },
    {
      'title': 'المفضلة',
      'icon': Iconsax.heart,
      'color': Color(0xFFE91E63),
    },
    {
      'title': 'التقارير',
      'icon': Iconsax.chart_2,
      'color': Color(0xFF9C27B0),
    },
    {
      'title': 'المساعدة',
      'icon': Iconsax.message_question,
      'color': Color(0xFFFF9800),
    },
    {
      'title': 'عن التطبيق',
      'icon': Iconsax.info_circle,
      'color': Color(0xFF607D8B),
    },
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadSubscriptionData();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeController.forward();
      _scaleController.forward();
      _slideController.forward();
    });
  }

  // ✅ التعديل: دالة لجلب بيانات الاشتراك من Firestore
  Future<void> _loadSubscriptionData() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      // التحقق من أن المستخدم مسجل الدخول
      if (!authService.isLoggedIn || authService.studentEmail == null) {
        setState(() {
          _isLoading = false;
          _subscriptionDays = 0;
        });
        _updateStats();
        return;
      }

      // ✅ جلب بيانات subscription_days من Firestore
      final userData = await authService.getAccountInfo();

      setState(() {
        _subscriptionDays = userData?['subscription_days'] ?? 0;
        _isLoading = false;
      });

      _updateStats();

    } catch (error) {
      print('Error loading subscription data: $error');
      setState(() {
        _isLoading = false;
        _subscriptionDays = 0;
      });
      _updateStats();
    }
  }

  void _updateStats() {
    setState(() {
      _stats = [
        {
          'title': 'الدروس المكتملة',
          'value': '24',
          'total': '50',
          'icon': Iconsax.menu_board,
          'color': Color(0xFF4CAF50),
          'progress': 0.48,
        },
        {
          'title': 'أيام الاشتراك',
          'value': '$_subscriptionDays',
          'icon': Iconsax.calendar_tick,
          'color': _getSubscriptionColor(_subscriptionDays),
          'subtitle': _getSubscriptionStatus(_subscriptionDays),
        },
        {
          'title': 'المستوى',
          'value': 'متوسط',
          'icon': Iconsax.trend_up,
          'color': Color(0xFF2196F3),
        },
        {
          'title': 'الأيام المتتالية',
          'value': '12',
          'icon': Iconsax.calendar_1,
          'color': Color(0xFF9C27B0),
        },
      ];
    });
  }

  Color _getSubscriptionColor(int days) {
    if (days > 30) return successGreen;
    if (days > 7) return warningOrange;
    return errorRed;
  }

  String _getSubscriptionStatus(int days) {
    if (days > 30) return 'ممتاز';
    if (days > 7) return 'ينتهي قريباً';
    if (days > 0) return 'آخر أيام';
    return 'منتهي';
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(28.w),
                margin: EdgeInsets.only(top: 50.h),
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
                    SizedBox(height: 50.h),
                    Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: textSecondary,
                        fontFamily: 'Tajawal',
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: textSecondary,
                              side: BorderSide(color: Colors.grey[400]!),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
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
                            onPressed: _performLogout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: errorRed,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
                              'تسجيل الخروج',
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
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: errorRed,
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
                    child: Icon(Iconsax.logout_1, size: 36.w, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performLogout() async {
    Navigator.pop(context);

    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.logout();

    Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
            (route) => false
    );
  }

  void _showSubscriptionDialog() {
    final subscriptionStatus = _getSubscriptionStatus(_subscriptionDays);
    final subscriptionColor = _getSubscriptionColor(_subscriptionDays);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(20.w),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: subscriptionColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.crown_1,
                  color: subscriptionColor,
                  size: 40.w,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                'تفاصيل الاشتراك',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                  fontFamily: 'Tajawal',
                ),
              ),

              SizedBox(height: 16.h),

              _buildSubscriptionDetail('أيام الاشتراك المتبقية', '$_subscriptionDays يوم'),
              _buildSubscriptionDetailWithColor('حالة الاشتراك', subscriptionStatus, subscriptionColor),

              SizedBox(height: 24.h),

              if (_subscriptionDays > 0) ...[
                Container(
                  width: double.infinity,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double progress = _subscriptionDays / 365;
                          if (progress > 1) progress = 1.0;
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 800),
                            curve: Curves.easeOut,
                            width: constraints.maxWidth * progress,
                            decoration: BoxDecoration(
                              color: subscriptionColor,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '${(_subscriptionDays / 365 * 100).toStringAsFixed(1)}% من السنة',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: textSecondary,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 16.h),
              ],

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textSecondary,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'إغلاق',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ),
                  if (_subscriptionDays <= 7) ...[
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // تجديد الاشتراك
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'تجديد',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionDetail(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: textSecondary,
              fontFamily: 'Tajawal',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: textPrimary,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionDetailWithColor(String title, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: textSecondary,
              fontFamily: 'Tajawal',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'Tajawal',
              ),
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
        backgroundColor: secondaryColor,
        body: _isLoading
            ? _buildLoadingIndicator()
            : AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildProfileHeader(authService),
                        _buildStatsSection(),
                        _buildSubscriptionCard(),
                        _buildMenuSection(),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: primaryColor,
          ),
          SizedBox(height: 16.h),
          Text(
            'جاري تحميل البيانات...',
            style: TextStyle(
              fontSize: 16.sp,
              color: textPrimary,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(AuthService authService) {
    final userData = authService.userData;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [primaryColor, primaryColor.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              blurRadius: 15.r,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.9),
                    primaryColor.withOpacity(0.7)
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.w),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Icon(
                        Iconsax.profile_circle,
                        color: Colors.white,
                        size: 40.w,
                      ),
                    ),
                    if (_subscriptionDays > 0)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: _getSubscriptionColor(_subscriptionDays),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.w),
                          ),
                          child: Icon(
                            Iconsax.crown_1,
                            size: 12.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData?['name'] ?? 'مستخدم',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        userData?['email'] ?? authService.studentEmail ?? 'البريد الإلكتروني', // ✅ التعديل: studentEmail بدلاً من studentNumber
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.9),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Iconsax.book_1,
                            size: 14.sp,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'الصف: ${authService.getGradeText()}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Iconsax.calendar_tick,
                            size: 14.sp,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$_subscriptionDays يوم متبقي',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'إحصائياتي',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textPrimary,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 12.h),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.6,
              ),
              itemCount: _stats.length,
              itemBuilder: (context, index) {
                final stat = _stats[index];
                return _buildStatCard(stat, index);
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, int index) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _fadeController.value)),
            child: child,
          ),
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 4.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: stat['color'].withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        stat['icon'],
                        color: stat['color'],
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        stat['title'],
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: textSecondary,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  stat['value'],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                    fontFamily: 'Tajawal',
                  ),
                ),
                if (stat.containsKey('subtitle')) ...[
                  SizedBox(height: 4.h),
                  Text(
                    stat['subtitle'],
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: stat['color'],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
                if (stat.containsKey('total')) ...[
                  SizedBox(height: 4.h),
                  LinearProgressIndicator(
                    value: stat['progress'],
                    backgroundColor: Colors.grey[200],
                    color: stat['color'],
                    minHeight: 4.h,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${stat['value']} من ${stat['total']}',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: textSecondary,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard() {
    final subscriptionStatus = _getSubscriptionStatus(_subscriptionDays);
    final subscriptionColor = _getSubscriptionColor(_subscriptionDays);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Card(
          elevation: 4.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [subscriptionColor.withOpacity(0.9), subscriptionColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
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
                    Iconsax.crown_1,
                    color: Colors.white,
                    size: 24.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'حالة الاشتراك',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '$_subscriptionDays يوم متبقي',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.9),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          subscriptionStatus,
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
                ),
                ElevatedButton(
                  onPressed: _showSubscriptionDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: subscriptionColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'عرض التفاصيل',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
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

  Widget _buildMenuSection() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.4),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الإعدادات',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textPrimary,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 12.h),
            Card(
              elevation: 4.w,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: cardColor,
                ),
                child: Column(
                  children: [
                    ..._menuItems.map((item) => _buildMenuItem(item)),
                    _buildLogoutMenuItem(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: item['color'].withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item['icon'],
              color: item['color'],
              size: 20.w,
            ),
          ),
          title: Text(
            item['title'],
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
              fontFamily: 'Tajawal',
            ),
          ),
          trailing: Icon(
            Iconsax.arrow_left_2,
            size: 16.sp,
            color: textSecondary,
          ),
          onTap: () {
            // التنقل للشاشة المطلوبة
          },
        ),
        if (_menuItems.indexOf(item) != _menuItems.length - 1)
          Divider(height: 1, indent: 70.w),
      ],
    );
  }

  Widget _buildLogoutMenuItem() {
    return Column(
      children: [
        Divider(height: 1),
        ListTile(
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: errorRed.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.logout_1,
              color: errorRed,
              size: 20.w,
            ),
          ),
          title: Text(
            'تسجيل الخروج',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: errorRed,
              fontFamily: 'Tajawal',
            ),
          ),
          trailing: Icon(
            Iconsax.arrow_left_2,
            size: 16.sp,
            color: errorRed,
          ),
          onTap: _showLogoutDialog,
        ),
      ],
    );
  }
}