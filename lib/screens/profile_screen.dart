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

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import '../Auth/auth_service.dart';
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
//   final Color primaryColor = const Color(0xFF1E88E5);
//   final Color secondaryColor = const Color(0xFFF5F9FF);
//   final Color accentColor = const Color(0xFFFFA726);
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//   final Color errorRed = const Color(0xFFEF4444);
//   final Color successGreen = const Color(0xFF10B981);
//   final Color warningOrange = const Color(0xFFF59E0B);
//
//   // متحكمات الحركة
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   // بيانات الاشتراك
//   int _subscriptionDays = 0;
//   bool _isLoading = true;
//
//   // نظام Cache
//   int? _cachedSubscriptionDays;
//   DateTime? _lastFetchTime;
//
//   // خيارات القائمة
//   final List<Map<String, dynamic>> _menuItems = [
//     {
//       'title': 'الإشعارات',
//       'icon': Iconsax.notification,
//       'color': Color(0xFF4CAF50),
//     },
//     {
//       'title': 'الإعدادات',
//       'icon': Iconsax.setting_2,
//       'color': Color(0xFF2196F3),
//     },
//     {
//       'title': 'المفضلة',
//       'icon': Iconsax.heart,
//       'color': Color(0xFFE91E63),
//     },
//     {
//       'title': 'التقارير',
//       'icon': Iconsax.chart_2,
//       'color': Color(0xFF9C27B0),
//     },
//     {
//       'title': 'المساعدة',
//       'icon': Iconsax.message_question,
//       'color': Color(0xFFFF9800),
//     },
//     {
//       'title': 'عن التطبيق',
//       'icon': Iconsax.info_circle,
//       'color': Color(0xFF607D8B),
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//     _loadSubscriptionData();
//   }
//
//   void _initAnimations() {
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
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _fadeController.forward();
//       _scaleController.forward();
//       _slideController.forward();
//     });
//   }
//
//   // ✅ دالة محسنة لجلب بيانات الاشتراك مع نظام Cache
//   Future<void> _loadSubscriptionData() async {
//     try {
//       // ✅ التحقق من وجود بيانات مخزنة مؤقتاً (Cache لمدة 10 دقائق)
//       final now = DateTime.now();
//       if (_cachedSubscriptionDays != null &&
//           _lastFetchTime != null &&
//           now.difference(_lastFetchTime!).inMinutes < 10) {
//         if (mounted) {
//           setState(() {
//             _subscriptionDays = _cachedSubscriptionDays!;
//             _isLoading = false;
//           });
//         }
//         return;
//       }
//
//       final authService = Provider.of<AuthService>(context, listen: false);
//
//       // التحقق من أن المستخدم مسجل الدخول
//       if (!authService.isLoggedIn || authService.studentEmail == null) {
//         _setLoadingState(false, 0);
//         return;
//       }
//
//       // ✅ جلب بيانات subscription من كولكشن user_settings
//       final subscriptionData = await authService.getUserSubscriptionData();
//
//       int days = 0;
//
//       if (subscriptionData != null && subscriptionData['subscription'] != null) {
//         final subscriptionValue = subscriptionData['subscription'];
//
//         // ✅ معالجة مختلفة لأنواع البيانات
//         if (subscriptionValue is String) {
//           days = int.tryParse(subscriptionValue) ?? 0;
//         } else if (subscriptionValue is int) {
//           days = subscriptionValue;
//         } else if (subscriptionValue is double) {
//           days = subscriptionValue.toInt();
//         } else if (subscriptionValue is num) {
//           days = subscriptionValue.toInt();
//         }
//
//         print('🎯 تم جلب بيانات الاشتراك: $days يوم');
//
//         // ✅ تخزين البيانات في Cache
//         _cachedSubscriptionDays = days;
//         _lastFetchTime = DateTime.now();
//       } else {
//         print('⚠️ لم يتم العثور على بيانات الاشتراك');
//         _cachedSubscriptionDays = 0;
//         _lastFetchTime = DateTime.now();
//       }
//
//       _setLoadingState(false, days);
//
//     } catch (error) {
//       print('❌ خطأ في جلب بيانات الاشتراك: $error');
//       // استخدام البيانات المخزنة مؤقتاً في حالة الخطأ
//       final fallbackDays = _cachedSubscriptionDays ?? 0;
//       _setLoadingState(false, fallbackDays);
//     }
//   }
//
//   void _setLoadingState(bool loading, int days) {
//     if (mounted) {
//       setState(() {
//         _isLoading = loading;
//         _subscriptionDays = days;
//       });
//     }
//   }
//
//   Color _getSubscriptionColor(int days) {
//     if (days > 30) return successGreen;
//     if (days > 7) return warningOrange;
//     return errorRed;
//   }
//
//   String _getSubscriptionStatus(int days) {
//     if (days > 30) return 'ممتاز';
//     if (days > 7) return 'جيد';
//     if (days > 0) return 'ينتهي قريباً';
//     return 'منتهي';
//   }
//
//   String _getSubscriptionMessage(int days) {
//     if (days > 30) return 'اشتراكك نشط ومتوفر لفترة طويلة';
//     if (days > 7) return 'اشتراكك لا يزال نشطاً';
//     if (days > 0) return 'اشتراكك على وشك الانتهاء';
//     return 'يرجى تجديد الاشتراك للمتابعة';
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
//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black54,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           child: Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(28.w),
//                 margin: EdgeInsets.only(top: 50.h),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20.r),
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
//                       'تسجيل الخروج',
//                       style: TextStyle(
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.bold,
//                         color: textPrimary,
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: textSecondary,
//                         fontFamily: 'Tajawal',
//                         height: 1.6,
//                       ),
//                     ),
//                     SizedBox(height: 28.h),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () => Navigator.pop(context),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: textSecondary,
//                               side: BorderSide(color: Colors.grey[400]!),
//                               padding: EdgeInsets.symmetric(vertical: 16.h),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14.r),
//                               ),
//                             ),
//                             child: Text(
//                               'إلغاء',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 16.w),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: _performLogout,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: errorRed,
//                               foregroundColor: Colors.white,
//                               padding: EdgeInsets.symmetric(vertical: 16.h),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14.r),
//                               ),
//                               elevation: 4,
//                             ),
//                             child: Text(
//                               'تسجيل الخروج',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
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
//                     width: 80.w,
//                     height: 80.h,
//                     decoration: BoxDecoration(
//                       color: errorRed,
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
//                     child: Icon(Iconsax.logout_1, size: 36.w, color: Colors.white),
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
//   void _performLogout() async {
//     Navigator.pop(context);
//
//     final authService = Provider.of<AuthService>(context, listen: false);
//     await authService.logout();
//
//     Navigator.pushNamedAndRemoveUntil(
//         context,
//         '/login',
//             (route) => false
//     );
//   }
//
//   void _showSubscriptionDialog() {
//     final subscriptionStatus = _getSubscriptionStatus(_subscriptionDays);
//     final subscriptionColor = _getSubscriptionColor(_subscriptionDays);
//     final subscriptionMessage = _getSubscriptionMessage(_subscriptionDays);
//
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.all(20.w),
//         child: Container(
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(20.r),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 20.r,
//                 offset: Offset(0, 10.h),
//               ),
//             ],
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
//                   color: subscriptionColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                   border: Border.all(color: subscriptionColor.withOpacity(0.3), width: 2.w),
//                 ),
//                 child: Icon(
//                   Iconsax.crown_1,
//                   color: subscriptionColor,
//                   size: 40.w,
//                 ),
//               ),
//
//               SizedBox(height: 16.h),
//
//               // العنوان
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
//               SizedBox(height: 8.h),
//
//               // الرسالة التوضيحية
//               Text(
//                 subscriptionMessage,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: textSecondary,
//                   fontFamily: 'Tajawal',
//                   height: 1.5,
//                 ),
//               ),
//
//               SizedBox(height: 20.h),
//
//               // تفاصيل الاشتراك
//               _buildSubscriptionDetail('الأيام المتبقية', '$_subscriptionDays يوم'),
//               _buildSubscriptionDetailWithColor('حالة الاشتراك', subscriptionStatus, subscriptionColor),
//               _buildSubscriptionDetail('تاريخ آخر تحديث', _lastFetchTime != null
//                   ? '${_lastFetchTime!.hour}:${_lastFetchTime!.minute}'
//                   : 'غير متوفر'),
//
//               SizedBox(height: 20.h),
//
//               // شريط التقدم
//               if (_subscriptionDays > 0) ...[
//                 Container(
//                   width: double.infinity,
//                   height: 8.h,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(4.r),
//                   ),
//                   child: Stack(
//                     children: [
//                       AnimatedContainer(
//                         duration: Duration(milliseconds: 1000),
//                         curve: Curves.easeOut,
//                         width: _calculateProgressWidth(),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [subscriptionColor, subscriptionColor.withOpacity(0.7)],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                           ),
//                           borderRadius: BorderRadius.circular(4.r),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '0 يوم',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: textSecondary,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     Text(
//                       '${(_subscriptionDays / 365 * 100).toStringAsFixed(1)}%',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: subscriptionColor,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     Text(
//                       '365 يوم',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: textSecondary,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.h),
//               ],
//
//               // الأزرار
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
//                         side: BorderSide(color: textSecondary.withOpacity(0.5)),
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
//                   if (_subscriptionDays <= 7) ...[
//                     SizedBox(width: 12.w),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: _renewSubscription,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryColor,
//                           foregroundColor: Colors.white,
//                           padding: EdgeInsets.symmetric(vertical: 12.h),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.r),
//                           ),
//                           elevation: 2,
//                         ),
//                         child: Text(
//                           'تجديد الاشتراك',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   double _calculateProgressWidth() {
//     double progress = _subscriptionDays / 365;
//     if (progress > 1) progress = 1.0;
//     if (progress < 0) progress = 0.0;
//     return progress * (MediaQuery.of(context).size.width - 88.w);
//   }
//
//   void _renewSubscription() {
//     // TODO: تنفيذ منطق تجديد الاشتراك
//     Navigator.pop(context);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'سيتم توجيهك إلى صفحة تجديد الاشتراك',
//           style: TextStyle(fontFamily: 'Tajawal'),
//         ),
//         backgroundColor: successGreen,
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
//   Widget _buildSubscriptionDetailWithColor(String title, String value, Color color) {
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
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8.r),
//               border: Border.all(color: color.withOpacity(0.3)),
//             ),
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ),
//         ],
//       ),
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
//         backgroundColor: secondaryColor,
//         body: _isLoading
//             ? _buildLoadingIndicator()
//             : AnimatedBuilder(
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
//                         _buildProfileHeader(authService),
//                         _buildSubscriptionCard(),
//                         _buildMenuSection(),
//                         SizedBox(height: 20.h),
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
//   Widget _buildLoadingIndicator() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             color: primaryColor,
//             strokeWidth: 3.w,
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             'جاري تحميل بيانات الاشتراك...',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: textPrimary,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             'يتم جلب أحدث البيانات من السحابة',
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: textSecondary,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader(AuthService authService) {
//     final userData = authService.userData;
//     final subscriptionColor = _getSubscriptionColor(_subscriptionDays);
//
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
//             Row(
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       width: 80.w,
//                       height: 80.h,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 3.w),
//                         color: Colors.white.withOpacity(0.2),
//                       ),
//                       child: Icon(
//                         Iconsax.profile_circle,
//                         color: Colors.white,
//                         size: 40.w,
//                       ),
//                     ),
//                     if (_subscriptionDays > 0)
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           padding: EdgeInsets.all(4.w),
//                           decoration: BoxDecoration(
//                             color: subscriptionColor,
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.white, width: 2.w),
//                           ),
//                           child: Icon(
//                             Iconsax.crown_1,
//                             size: 12.w,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 SizedBox(width: 16.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         userData?['name'] ?? 'مستخدم',
//                         style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         userData?['email'] ?? authService.studentEmail ?? 'البريد الإلكتروني',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Row(
//                         children: [
//                           Icon(
//                             Iconsax.book_1,
//                             size: 14.sp,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                           SizedBox(width: 4.w),
//                           Text(
//                             'الصف: ${authService.getGradeText()}',
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: Colors.white.withOpacity(0.8),
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 4.h),
//                       Row(
//                         children: [
//                           Icon(
//                             Iconsax.calendar_tick,
//                             size: 14.sp,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                           SizedBox(width: 4.w),
//                           Text(
//                             '$_subscriptionDays يوم متبقي',
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
//                 IconButton(
//                   onPressed: _loadSubscriptionData,
//                   icon: Icon(
//                     Iconsax.refresh,
//                     color: Colors.white.withOpacity(0.8),
//                     size: 20.w,
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
//   Widget _buildSubscriptionCard() {
//     final subscriptionStatus = _getSubscriptionStatus(_subscriptionDays);
//     final subscriptionColor = _getSubscriptionColor(_subscriptionDays);
//
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
//                 colors: [subscriptionColor.withOpacity(0.9), subscriptionColor.withOpacity(0.7)],
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
//                     Iconsax.crown_1,
//                     color: Colors.white,
//                     size: 24.w,
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'حالة الاشتراك',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         '$_subscriptionDays يوم متبقي',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       SizedBox(height: 2.h),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(6.r),
//                         ),
//                         child: Text(
//                           subscriptionStatus,
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _showSubscriptionDialog,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: subscriptionColor,
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
//             SizedBox(height: 12.h),
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
//                   children: [
//                     ..._menuItems.map((item) => _buildMenuItem(item)),
//                     _buildLogoutMenuItem(),
//                   ],
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
//             Iconsax.arrow_left_2,
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
//   Widget _buildLogoutMenuItem() {
//     return Column(
//       children: [
//         Divider(height: 1),
//         ListTile(
//           leading: Container(
//             width: 40.w,
//             height: 40.h,
//             decoration: BoxDecoration(
//               color: errorRed.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Iconsax.logout_1,
//               color: errorRed,
//               size: 20.w,
//             ),
//           ),
//           title: Text(
//             'تسجيل الخروج',
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: errorRed,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           trailing: Icon(
//             Iconsax.arrow_left_2,
//             size: 16.sp,
//             color: errorRed,
//           ),
//           onTap: _showLogoutDialog,
//         ),
//       ],
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import '../Auth/auth_service.dart';
// import '../widget/subscription_service.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final SubscriptionService _subscriptionService = SubscriptionService();
//   Map<String, dynamic> _subscriptionStatus = {};
//   bool _isLoadingSubscription = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSubscriptionStatus();
//   }
//
//   Future<void> _loadSubscriptionStatus() async {
//     print('🔄 بدء تحميل حالة الاشتراك...');
//     setState(() => _isLoadingSubscription = true);
//
//     try {
//       _subscriptionStatus = await _subscriptionService.checkUserSubscription();
//       print('✅ حالة الاشتراك بعد التحميل:');
//       print('   - hasSubscription: ${_subscriptionStatus['hasSubscription']}');
//       print('   - isActive: ${_subscriptionStatus['isActive']}');
//       print('   - daysRemaining: ${_subscriptionStatus['daysRemaining']}');
//     } catch (e) {
//       print('❌ خطأ في تحميل حالة الاشتراك: $e');
//       _subscriptionStatus = {
//         'hasSubscription': false,
//         'isActive': false,
//         'message': 'خطأ في تحميل البيانات'
//       };
//     }
//
//     setState(() => _isLoadingSubscription = false);
//   }
//
//   // دالة تنسيق التاريخ البديلة
//   String formatDate(DateTime date) {
//     int year = date.year;
//     int month = date.month;
//     int day = date.day;
//
//     String formattedYear = year.toString();
//     String formattedMonth = month.toString().padLeft(2, '0');
//     String formattedDay = day.toString().padLeft(2, '0');
//
//     return '$formattedYear/$formattedMonth/$formattedDay';
//   }
//
//   void _showActivationDialog() {
//     TextEditingController codeController = TextEditingController();
//     bool isLoading = false;
//
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E88E5).withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Iconsax.card, color: const Color(0xFF1E88E5), size: 20.sp),
//                         ),
//                         SizedBox(width: 12.w),
//                         Text(
//                           'تفعيل الاشتراك',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: const Color(0xFF1E88E5),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'أدخل كود التفعيل الخاص بك لتفعيل الاشتراك',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xFF718096),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF5F9FF),
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: const Color(0xFFE2E8F0)),
//                       ),
//                       child: TextField(
//                         controller: codeController,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                           color: const Color(0xFF2D3748),
//                         ),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أدخل الكود هنا',
//                           hintStyle: TextStyle(
//                             color: const Color(0xFFA0AEC0),
//                             fontFamily: 'Tajawal',
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 14.h,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     if (isLoading)
//                       CircularProgressIndicator(color: const Color(0xFF1E88E5))
//                     else
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF718096),
//                                 side: BorderSide(color: const Color(0xFFCBD5E0)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (codeController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('يرجى إدخال كود التفعيل'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 setState(() => isLoading = true);
//                                 Map<String, dynamic> result =
//                                 await _subscriptionService.activateSubscription(
//                                   codeController.text.trim(),
//                                 );
//                                 setState(() => isLoading = false);
//
//                                 if (result['success']) {
//                                   Navigator.pop(context);
//                                   _showActivationSuccessDialog();
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(result['message']),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF1E88E5),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'تفعيل',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showRenewalDialog() {
//     TextEditingController codeController = TextEditingController();
//     bool isLoading = false;
//
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFFA726).withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Iconsax.refresh, color: const Color(0xFFFFA726), size: 20.sp),
//                         ),
//                         SizedBox(width: 12.w),
//                         Text(
//                           'تجديد الاشتراك',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: const Color(0xFFFFA726),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'أدخل كود التفعيل الجديد لتجديد الاشتراك',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xFF718096),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFFF8E1),
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: const Color(0xFFFFA726).withOpacity(0.3)),
//                       ),
//                       child: TextField(
//                         controller: codeController,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                           color: const Color(0xFF2D3748),
//                         ),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أدخل كود التجديد هنا',
//                           hintStyle: TextStyle(
//                             color: const Color(0xFFA0AEC0),
//                             fontFamily: 'Tajawal',
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 14.h,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'ملاحظة: سيتم إضافة المدة الجديدة إلى اشتراكك الحالي',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFFFA726),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 24.h),
//                     if (isLoading)
//                       CircularProgressIndicator(color: const Color(0xFFFFA726))
//                     else
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF718096),
//                                 side: BorderSide(color: const Color(0xFFCBD5E0)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (codeController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('يرجى إدخال كود التجديد'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 setState(() => isLoading = true);
//                                 Map<String, dynamic> result =
//                                 await _subscriptionService.activateSubscription(
//                                   codeController.text.trim(),
//                                 );
//                                 setState(() => isLoading = false);
//
//                                 if (result['success']) {
//                                   Navigator.pop(context);
//                                   _showRenewalSuccessDialog();
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(result['message']),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFFFA726),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'تجديد',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showRenewalSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Iconsax.tick_circle,
//                     color: const Color(0xFF10B981),
//                     size: 40.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'تم التجديد بنجاح!',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                     color: const Color(0xFFFFA726),
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'تم تجديد اشتراكك بنجاح وتم إضافة المدة الجديدة إلى اشتراكك الحالي.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: const Color(0xFF718096),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _loadSubscriptionStatus();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFFA726),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                     ),
//                     child: Text(
//                       'متابعة',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
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
//   void _showActivationSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Iconsax.tick_circle,
//                     color: const Color(0xFF10B981),
//                     size: 40.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'تم التفعيل بنجاح!',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                     color: const Color(0xFF1E88E5),
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'تم تفعيل الاشتراك بنجاح. يمكنك الآن الاستفادة من جميع الميزات المميزة.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: const Color(0xFF718096),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _loadSubscriptionStatus();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E88E5),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                     ),
//                     child: Text(
//                       'متابعة',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
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
//   Widget _buildSubscriptionSection() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border: Border.all(
//           color: const Color(0xFFF1F5F9),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFFA726).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.crown_1,
//                   color: const Color(0xFFFFA726),
//                   size: 20.sp,
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Text(
//                 'حالة الاشتراك',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                   color: const Color(0xFF1E293B),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//
//           if (_isLoadingSubscription)
//             _buildLoadingSubscription()
//           else if (_subscriptionStatus['isActive'] == true)
//             _buildActiveSubscription()
//           else
//             _buildInactiveSubscription(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingSubscription() {
//     return Center(
//       child: Column(
//         children: [
//           CircularProgressIndicator(color: const Color(0xFF1E88E5)),
//           SizedBox(height: 16.h),
//           Text(
//             'جاري التحقق من حالة الاشتراك...',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: const Color(0xFF718096),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             'قد تستغرق العملية بضع ثوانٍ',
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: const Color(0xFFA0AEC0),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActiveSubscription() {
//     // استخدام البيانات بشكل آمن مع القيم الافتراضية
//     Map<String, dynamic> subscriptionData = _subscriptionStatus['subscriptionData'] ?? {};
//
//     String planType = subscriptionData['plan_type'] ?? 'غير محدد';
//     int daysRemaining = _subscriptionStatus['daysRemaining'] ?? 0;
//     DateTime endDate = _subscriptionStatus['endDate'] ?? DateTime.now();
//     DateTime startDate = _subscriptionStatus['startDate'] ?? DateTime.now();
//     String subscriptionCode = subscriptionData['subscription_code'] ?? 'غير محدد';
//
//     // حساب المدة الإجمالية بشكل آمن
//     int totalDays = endDate.difference(startDate).inDays;
//     int usedDays = totalDays > 0 ? totalDays - daysRemaining : 0;
//
//     // التأكد من أن totalDays ليس صفراً لتجنب القسمة على صفر
//     if (totalDays <= 0) totalDays = 30;
//
//     return Column(
//       children: [
//         // بطاقة معلومات الاشتراك باللون البرتقالي
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 const Color(0xFFFFA726).withOpacity(0.9),
//                 const Color(0xFFFFB74D),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFFFFA726).withOpacity(0.3),
//                 blurRadius: 15.r,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'الاشتراك نشط',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20.r),
//                     ),
//                     child: Text(
//                       planType,
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//
//               // شريط التقدم
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'الأيام المتبقية',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       Text(
//                         '$daysRemaining يوم',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Container(
//                     width: double.infinity,
//                     height: 8.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                     child: Stack(
//                       children: [
//                         LayoutBuilder(
//                           builder: (context, constraints) {
//                             double progress = daysRemaining / totalDays;
//                             if (progress > 1) progress = 1.0;
//                             if (progress < 0) progress = 0.0;
//
//                             return AnimatedContainer(
//                               duration: Duration(milliseconds: 500),
//                               width: constraints.maxWidth * progress,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.white,
//                                     Colors.white.withOpacity(0.8),
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(4.r),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'تم استخدام $usedDays من $totalDays يوم',
//                         style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.white.withOpacity(0.8),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//
//         // معلومات تفصيلية عن الاشتراك
//         _buildSubscriptionInfoRow('نوع الاشتراك', planType),
//         _buildSubscriptionInfoRow('كود الاشتراك', subscriptionCode),
//         _buildSubscriptionInfoRow('تاريخ البدء', formatDate(startDate)),
//         _buildSubscriptionInfoRow('تاريخ الانتهاء', formatDate(endDate)),
//         _buildSubscriptionInfoRow('المدة المتبقية', '$daysRemaining يوم'),
//
//         SizedBox(height: 16.h),
//
//         // زر تجديد الاشتراك
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: _showRenewalDialog,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFFA726),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14.h),
//               elevation: 2,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Iconsax.refresh, size: 18.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'تجديد الاشتراك',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInactiveSubscription() {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFEF2F2),
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: const Color(0xFFFECACA)),
//           ),
//           child: Row(
//             children: [
//               Icon(Iconsax.info_circle, color: const Color(0xFFDC2626), size: 20.sp),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'لا يوجد اشتراك نشط',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       'قم بتفعيل الاشتراك للاستفادة من الميزات المميزة',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: _showActivationDialog,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF1E88E5),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14.h),
//               elevation: 0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Iconsax.card, size: 18.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'تفعيل الاشتراك',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           'ادخل كود التفعيل لتفعيل الاشتراك',
//           style: TextStyle(
//             fontSize: 12.sp,
//             color: const Color(0xFF718096),
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSubscriptionInfoRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: const Color(0xFF64748B),
//               fontFamily: 'Tajawal',
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF1E293B),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             const Color(0xFF1E88E5),
//             const Color(0xFF1976D2),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF1E88E5).withOpacity(0.3),
//             blurRadius: 15.r,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80.w,
//             height: 80.h,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.3),
//                 width: 3.w,
//               ),
//             ),
//             child: Icon(
//               Iconsax.profile_circle,
//               color: Colors.white,
//               size: 40.sp,
//             ),
//           ),
//           SizedBox(height: 12.h),
//           Text(
//             authService.studentEmail ?? 'مستخدم',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Tajawal',
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             'طالب',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.white.withOpacity(0.9),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 8.h),
//           if (authService.selectedGrade != null)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Text(
//                 _getGradeText(authService.selectedGrade),
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // دالة لتحويل رقم الصف إلى نص عربي
//   String _getGradeText(int? gradeValue) {
//     if (gradeValue == null) {
//       return 'لم يتم الاختيار';
//     }
//
//     switch (gradeValue) {
//       case 1: return 'الصف الأول الابتدائي';
//       case 2: return 'الصف الثاني الابتدائي';
//       case 3: return 'الصف الثالث الابتدائي';
//       case 4: return 'الصف الرابع الابتدائي';
//       case 5: return 'الصف الخامس الابتدائي';
//       case 6: return 'الصف السادس الابتدائي';
//       case 7: return 'الصف الأول المتوسط';
//       case 8: return 'الصف الثاني المتوسط';
//       case 9: return 'الصف الثالث المتوسط';
//       case 10: return 'الصف الأول الثانوي';
//       case 11: return 'الصف الثاني الثانوي';
//       case 12: return 'الصف الثالث الثانوي';
//       default: return 'الصف $gradeValue';
//     }
//   }
//
//   Widget _buildMenuItems() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildMenuItem(
//             icon: Iconsax.setting_2,
//             title: 'الإعدادات',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.shield_tick,
//             title: 'الخصوصية',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.info_circle,
//             title: 'عن التطبيق',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.headphone,
//             title: 'الدعم الفني',
//             onTap: () {},
//           ),
//           // زر تسجيل الخروج
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: const Color(0xFFF1F5F9),
//                   width: 1,
//                 ),
//               ),
//             ),
//             child: ListTile(
//               leading: Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE53E3E).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.logout,
//                   color: const Color(0xFFE53E3E),
//                   size: 20.sp,
//                 ),
//               ),
//               title: Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Tajawal',
//                   color: const Color(0xFFE53E3E),
//                 ),
//               ),
//               trailing: Icon(
//                 Iconsax.arrow_left_2,
//                 color: const Color(0xFFCBD5E0),
//                 size: 18.sp,
//               ),
//               onTap: () {
//                 _showLogoutConfirmationDialog(authService);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showLogoutConfirmationDialog(AuthService authService) {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           title: Row(
//             children: [
//               Icon(Iconsax.logout, color: const Color(0xFFE53E3E)),
//               SizedBox(width: 8.w),
//               Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             'هل أنت متأكد أنك تريد تسجيل الخروج؟',
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           actions: [
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: const Color(0xFF718096),
//                       side: BorderSide(color: const Color(0xFFCBD5E0)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'إلغاء',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Navigator.pop(context);
//                       await authService.logout();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFE53E3E),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'تسجيل الخروج',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
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
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: const Color(0xFFF1F5F9),
//             width: 1,
//           ),
//         ),
//       ),
//       child: ListTile(
//         leading: Container(
//           width: 40.w,
//           height: 40.h,
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E88E5).withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: const Color(0xFF1E88E5),
//             size: 20.sp,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Tajawal',
//             color: const Color(0xFF1E293B),
//           ),
//         ),
//         trailing: Icon(
//           Iconsax.arrow_left_2,
//           color: const Color(0xFFCBD5E0),
//           size: 18.sp,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F9FF),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 16.h),
//                 _buildProfileHeader(),
//                 _buildSubscriptionSection(),
//                 _buildMenuItems(),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import '../Auth/auth_service.dart';
// import '../widget/subscription_service.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final SubscriptionService _subscriptionService = SubscriptionService();
//   Map<String, dynamic> _subscriptionStatus = {};
//   bool _isLoadingSubscription = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSubscriptionStatus();
//   }
//
//   Future<void> _loadSubscriptionStatus() async {
//     print('🔄 بدء تحميل حالة الاشتراك...');
//     setState(() => _isLoadingSubscription = true);
//
//     try {
//       _subscriptionStatus = await _subscriptionService.checkUserSubscription();
//       print('✅ حالة الاشتراك بعد التحميل:');
//       print('   - hasSubscription: ${_subscriptionStatus['hasSubscription']}');
//       print('   - isActive: ${_subscriptionStatus['isActive']}');
//       print('   - daysRemaining: ${_subscriptionStatus['daysRemaining']}');
//     } catch (e) {
//       print('❌ خطأ في تحميل حالة الاشتراك: $e');
//       _subscriptionStatus = {
//         'hasSubscription': false,
//         'isActive': false,
//         'message': 'خطأ في تحميل البيانات'
//       };
//     }
//
//     setState(() => _isLoadingSubscription = false);
//   }
//
//   // دالة تنسيق التاريخ البديلة
//   String formatDate(DateTime date) {
//     int year = date.year;
//     int month = date.month;
//     int day = date.day;
//
//     String formattedYear = year.toString();
//     String formattedMonth = month.toString().padLeft(2, '0');
//     String formattedDay = day.toString().padLeft(2, '0');
//
//     return '$formattedYear/$formattedMonth/$formattedDay';
//   }
//
//   void _showActivationDialog() {
//     TextEditingController codeController = TextEditingController();
//     bool isLoading = false;
//
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E88E5).withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Iconsax.card, color: const Color(0xFF1E88E5), size: 20.sp),
//                         ),
//                         SizedBox(width: 12.w),
//                         Text(
//                           'تفعيل الاشتراك',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: const Color(0xFF1E88E5),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'أدخل كود التفعيل الخاص بك لتفعيل الاشتراك',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xFF718096),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF5F9FF),
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: const Color(0xFFE2E8F0)),
//                       ),
//                       child: TextField(
//                         controller: codeController,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                           color: const Color(0xFF2D3748),
//                         ),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أدخل الكود هنا',
//                           hintStyle: TextStyle(
//                             color: const Color(0xFFA0AEC0),
//                             fontFamily: 'Tajawal',
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 14.h,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     if (isLoading)
//                       CircularProgressIndicator(color: const Color(0xFF1E88E5))
//                     else
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF718096),
//                                 side: BorderSide(color: const Color(0xFFCBD5E0)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (codeController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('يرجى إدخال كود التفعيل'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 setState(() => isLoading = true);
//                                 Map<String, dynamic> result =
//                                 await _subscriptionService.activateSubscription(
//                                   codeController.text.trim(),
//                                 );
//                                 setState(() => isLoading = false);
//
//                                 if (result['success']) {
//                                   Navigator.pop(context);
//                                   _showActivationSuccessDialog();
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(result['message']),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF1E88E5),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'تفعيل',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showRenewalDialog() {
//     TextEditingController codeController = TextEditingController();
//     bool isLoading = false;
//
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFFA726).withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Iconsax.refresh, color: const Color(0xFFFFA726), size: 20.sp),
//                         ),
//                         SizedBox(width: 12.w),
//                         Text(
//                           'تجديد الاشتراك',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: const Color(0xFFFFA726),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'أدخل كود التفعيل الجديد لتجديد الاشتراك',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xFF718096),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFFF8E1),
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: const Color(0xFFFFA726).withOpacity(0.3)),
//                       ),
//                       child: TextField(
//                         controller: codeController,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                           color: const Color(0xFF2D3748),
//                         ),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أدخل كود التجديد هنا',
//                           hintStyle: TextStyle(
//                             color: const Color(0xFFA0AEC0),
//                             fontFamily: 'Tajawal',
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 14.h,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'ملاحظة: سيتم إضافة المدة الجديدة إلى اشتراكك الحالي',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFFFA726),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 24.h),
//                     if (isLoading)
//                       CircularProgressIndicator(color: const Color(0xFFFFA726))
//                     else
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF718096),
//                                 side: BorderSide(color: const Color(0xFFCBD5E0)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (codeController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('يرجى إدخال كود التجديد'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 setState(() => isLoading = true);
//                                 Map<String, dynamic> result =
//                                 await _subscriptionService.activateSubscription(
//                                   codeController.text.trim(),
//                                 );
//                                 setState(() => isLoading = false);
//
//                                 if (result['success']) {
//                                   Navigator.pop(context);
//                                   _showRenewalSuccessDialog();
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(result['message']),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFFFA726),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'تجديد',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showRenewalSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Iconsax.tick_circle,
//                     color: const Color(0xFF10B981),
//                     size: 40.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'تم التجديد بنجاح!',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                     color: const Color(0xFFFFA726),
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'تم تجديد اشتراكك بنجاح وتم إضافة المدة الجديدة إلى اشتراكك الحالي.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: const Color(0xFF718096),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _loadSubscriptionStatus();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFFA726),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                     ),
//                     child: Text(
//                       'متابعة',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
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
//   void _showActivationSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Iconsax.tick_circle,
//                     color: const Color(0xFF10B981),
//                     size: 40.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'تم التفعيل بنجاح!',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                     color: const Color(0xFF1E88E5),
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'تم تفعيل الاشتراك بنجاح. يمكنك الآن الاستفادة من جميع الميزات المميزة.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: const Color(0xFF718096),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _loadSubscriptionStatus();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E88E5),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                     ),
//                     child: Text(
//                       'متابعة',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
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
//   Widget _buildSubscriptionSection() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border: Border.all(
//           color: const Color(0xFFF1F5F9),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFFA726).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.crown_1,
//                   color: const Color(0xFFFFA726),
//                   size: 20.sp,
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Text(
//                 'حالة الاشتراك',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                   color: const Color(0xFF1E293B),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//
//           if (_isLoadingSubscription)
//             _buildLoadingSubscription()
//           else if (_subscriptionStatus['isActive'] == true)
//             _buildActiveSubscription()
//           else
//             _buildInactiveSubscription(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingSubscription() {
//     return Center(
//       child: Column(
//         children: [
//           CircularProgressIndicator(color: const Color(0xFF1E88E5)),
//           SizedBox(height: 16.h),
//           Text(
//             'جاري التحقق من حالة الاشتراك...',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: const Color(0xFF718096),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             'قد تستغرق العملية بضع ثوانٍ',
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: const Color(0xFFA0AEC0),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActiveSubscription() {
//     // استخدام البيانات بشكل آمن مع القيم الافتراضية
//     Map<String, dynamic> subscriptionData = _subscriptionStatus['subscriptionData'] ?? {};
//
//     String planType = subscriptionData['plan_type'] ?? 'غير محدد';
//     int daysRemaining = _subscriptionStatus['daysRemaining'] ?? 0;
//     DateTime endDate = _subscriptionStatus['endDate'] ?? DateTime.now();
//     DateTime startDate = _subscriptionStatus['startDate'] ?? DateTime.now();
//     String subscriptionCode = subscriptionData['subscription_code'] ?? 'غير محدد';
//
//     // حساب المدة الإجمالية بشكل آمن
//     int totalDays = endDate.difference(startDate).inDays;
//     int usedDays = totalDays > 0 ? totalDays - daysRemaining : 0;
//
//     // التأكد من أن totalDays ليس صفراً لتجنب القسمة على صفر
//     if (totalDays <= 0) totalDays = 30;
//
//     return Column(
//       children: [
//         // بطاقة معلومات الاشتراك باللون البرتقالي
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 const Color(0xFFFFA726).withOpacity(0.9),
//                 const Color(0xFFFFB74D),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFFFFA726).withOpacity(0.3),
//                 blurRadius: 15.r,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'الاشتراك نشط',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20.r),
//                     ),
//                     child: Text(
//                       planType,
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//
//               // شريط التقدم
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'الأيام المتبقية',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       Text(
//                         '$daysRemaining يوم',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Container(
//                     width: double.infinity,
//                     height: 8.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                     child: Stack(
//                       children: [
//                         LayoutBuilder(
//                           builder: (context, constraints) {
//                             double progress = daysRemaining / totalDays;
//                             if (progress > 1) progress = 1.0;
//                             if (progress < 0) progress = 0.0;
//
//                             return AnimatedContainer(
//                               duration: Duration(milliseconds: 500),
//                               width: constraints.maxWidth * progress,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.white,
//                                     Colors.white.withOpacity(0.8),
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(4.r),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'تم استخدام $usedDays من $totalDays يوم',
//                         style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.white.withOpacity(0.8),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//
//         // معلومات تفصيلية عن الاشتراك
//         _buildSubscriptionInfoRow('نوع الاشتراك', planType),
//         _buildSubscriptionInfoRow('كود الاشتراك', subscriptionCode),
//         _buildSubscriptionInfoRow('تاريخ البدء', formatDate(startDate)),
//         _buildSubscriptionInfoRow('تاريخ الانتهاء', formatDate(endDate)),
//         _buildSubscriptionInfoRow('المدة المتبقية', '$daysRemaining يوم'),
//
//         SizedBox(height: 16.h),
//
//         // زر تجديد الاشتراك
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: _showRenewalDialog,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFFA726),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14.h),
//               elevation: 2,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Iconsax.refresh, size: 18.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'تجديد الاشتراك',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInactiveSubscription() {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFEF2F2),
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: const Color(0xFFFECACA)),
//           ),
//           child: Row(
//             children: [
//               Icon(Iconsax.info_circle, color: const Color(0xFFDC2626), size: 20.sp),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'لا يوجد اشتراك نشط',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       'قم بتفعيل الاشتراك للاستفادة من الميزات المميزة',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: _showActivationDialog,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF1E88E5),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14.h),
//               elevation: 0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Iconsax.card, size: 18.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'تفعيل الاشتراك',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           'ادخل كود التفعيل لتفعيل الاشتراك',
//           style: TextStyle(
//             fontSize: 12.sp,
//             color: const Color(0xFF718096),
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSubscriptionInfoRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: const Color(0xFF64748B),
//               fontFamily: 'Tajawal',
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF1E293B),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             const Color(0xFF1E88E5),
//             const Color(0xFF1976D2),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF1E88E5).withOpacity(0.3),
//             blurRadius: 15.r,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80.w,
//             height: 80.h,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.3),
//                 width: 3.w,
//               ),
//             ),
//             child: Icon(
//               Iconsax.profile_circle,
//               color: Colors.white,
//               size: 40.sp,
//             ),
//           ),
//           SizedBox(height: 12.h),
//           Text(
//             authService.studentEmail ?? 'مستخدم',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Tajawal',
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             'طالب',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.white.withOpacity(0.9),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 8.h),
//           if (authService.selectedGrade != null)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Text(
//                 _getGradeText(authService.selectedGrade),
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // دالة لتحويل رقم الصف إلى نص عربي
//   String _getGradeText(int? gradeValue) {
//     if (gradeValue == null) {
//       return 'لم يتم الاختيار';
//     }
//
//     switch (gradeValue) {
//       case 1: return 'الصف الأول الابتدائي';
//       case 2: return 'الصف الثاني الابتدائي';
//       case 3: return 'الصف الثالث الابتدائي';
//       case 4: return 'الصف الرابع الابتدائي';
//       case 5: return 'الصف الخامس الابتدائي';
//       case 6: return 'الصف السادس الابتدائي';
//       case 7: return 'الصف الأول المتوسط';
//       case 8: return 'الصف الثاني المتوسط';
//       case 9: return 'الصف الثالث المتوسط';
//       case 10: return 'الصف الأول الثانوي';
//       case 11: return 'الصف الثاني الثانوي';
//       case 12: return 'الصف الثالث الثانوي';
//       default: return 'الصف $gradeValue';
//     }
//   }
//
//   Widget _buildMenuItems() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildMenuItem(
//             icon: Iconsax.setting_2,
//             title: 'الإعدادات',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.shield_tick,
//             title: 'الخصوصية',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.info_circle,
//             title: 'عن التطبيق',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.headphone,
//             title: 'الدعم الفني',
//             onTap: () {},
//           ),
//           // زر تسجيل الخروج
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: const Color(0xFFF1F5F9),
//                   width: 1,
//                 ),
//               ),
//             ),
//             child: ListTile(
//               leading: Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE53E3E).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.logout,
//                   color: const Color(0xFFE53E3E),
//                   size: 20.sp,
//                 ),
//               ),
//               title: Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Tajawal',
//                   color: const Color(0xFFE53E3E),
//                 ),
//               ),
//               trailing: Icon(
//                 Iconsax.arrow_left_2,
//                 color: const Color(0xFFCBD5E0),
//                 size: 18.sp,
//               ),
//               onTap: () {
//                 _showLogoutConfirmationDialog(authService);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showLogoutConfirmationDialog(AuthService authService) {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           title: Row(
//             children: [
//               Icon(Iconsax.logout, color: const Color(0xFFE53E3E)),
//               SizedBox(width: 8.w),
//               Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             'هل أنت متأكد أنك تريد تسجيل الخروج؟',
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           actions: [
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: const Color(0xFF718096),
//                       side: BorderSide(color: const Color(0xFFCBD5E0)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'إلغاء',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Navigator.pop(context);
//                       await authService.logout();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFE53E3E),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'تسجيل الخروج',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
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
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: const Color(0xFFF1F5F9),
//             width: 1,
//           ),
//         ),
//       ),
//       child: ListTile(
//         leading: Container(
//           width: 40.w,
//           height: 40.h,
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E88E5).withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: const Color(0xFF1E88E5),
//             size: 20.sp,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Tajawal',
//             color: const Color(0xFF1E293B),
//           ),
//         ),
//         trailing: Icon(
//           Iconsax.arrow_left_2,
//           color: const Color(0xFFCBD5E0),
//           size: 18.sp,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F9FF),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 16.h),
//                 _buildProfileHeader(),
//                 _buildSubscriptionSection(),
//                 _buildMenuItems(),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import '../Auth/auth_service.dart';
// import '../widget/subscription_service.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final SubscriptionService _subscriptionService = SubscriptionService();
//   Map<String, dynamic> _subscriptionStatus = {};
//   bool _isLoadingSubscription = true;
//   bool _isRefreshing = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSubscriptionStatus();
//   }
//
//   Future<void> _loadSubscriptionStatus() async {
//     print('🔄 بدء تحميل حالة الاشتراك...');
//
//     if (!_isRefreshing) {
//       setState(() => _isLoadingSubscription = true);
//     }
//
//     try {
//       final status = await _subscriptionService.checkUserSubscription();
//
//       setState(() {
//         _subscriptionStatus = status;
//       });
//
//       print('✅ حالة الاشتراك بعد التحميل:');
//       print('   - hasSubscription: ${_subscriptionStatus['hasSubscription']}');
//       print('   - isActive: ${_subscriptionStatus['isActive']}');
//       print('   - daysRemaining: ${_subscriptionStatus['daysRemaining']}');
//     } catch (e) {
//       print('❌ خطأ في تحميل حالة الاشتراك: $e');
//       setState(() {
//         _subscriptionStatus = {
//           'hasSubscription': false,
//           'isActive': false,
//           'message': 'خطأ في تحميل البيانات'
//         };
//       });
//     }
//
//     setState(() {
//       _isLoadingSubscription = false;
//       _isRefreshing = false;
//     });
//   }
//
//   // دالة تحديث سريعة
//   Future<void> _refreshSubscription() async {
//     setState(() => _isRefreshing = true);
//     await _loadSubscriptionStatus();
//   }
//
//   // دالة تنسيق التاريخ
//   String formatDate(DateTime? date) {
//     if (date == null) return 'غير محدد';
//
//     int year = date.year;
//     int month = date.month;
//     int day = date.day;
//
//     String formattedYear = year.toString();
//     String formattedMonth = month.toString().padLeft(2, '0');
//     String formattedDay = day.toString().padLeft(2, '0');
//
//     return '$formattedYear/$formattedMonth/$formattedDay';
//   }
//
//   void _showActivationDialog() {
//     TextEditingController codeController = TextEditingController();
//     bool isLoading = false;
//
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E88E5).withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Iconsax.card, color: const Color(0xFF1E88E5), size: 20.sp),
//                         ),
//                         SizedBox(width: 12.w),
//                         Text(
//                           'تفعيل الاشتراك',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: const Color(0xFF1E88E5),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'أدخل كود التفعيل الخاص بك لتفعيل الاشتراك',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xFF718096),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF5F9FF),
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: const Color(0xFFE2E8F0)),
//                       ),
//                       child: TextField(
//                         controller: codeController,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                           color: const Color(0xFF2D3748),
//                         ),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أدخل الكود هنا',
//                           hintStyle: TextStyle(
//                             color: const Color(0xFFA0AEC0),
//                             fontFamily: 'Tajawal',
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 14.h,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     if (isLoading)
//                       CircularProgressIndicator(color: const Color(0xFF1E88E5))
//                     else
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF718096),
//                                 side: BorderSide(color: const Color(0xFFCBD5E0)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (codeController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('يرجى إدخال كود التفعيل'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 setState(() => isLoading = true);
//
//                                 try {
//                                   Map<String, dynamic> result =
//                                   await _subscriptionService.activateSubscription(
//                                     codeController.text.trim(),
//                                   );
//
//                                   setState(() => isLoading = false);
//
//                                   if (result['success']) {
//                                     Navigator.pop(context);
//                                     _showActivationSuccessDialog(
//                                       daysRemaining: result['daysRemaining'] ?? 30,
//                                       endDate: result['endDate'] ?? DateTime.now().add(const Duration(days: 30)),
//                                       code: codeController.text.trim(),
//                                     );
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text(result['message']),
//                                         backgroundColor: const Color(0xFFE53E3E),
//                                       ),
//                                     );
//                                   }
//                                 } catch (e) {
//                                   setState(() => isLoading = false);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('حدث خطأ غير متوقع: $e'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF1E88E5),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'تفعيل',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showRenewalDialog() {
//     TextEditingController codeController = TextEditingController();
//     bool isLoading = false;
//
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFFA726).withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Iconsax.refresh, color: const Color(0xFFFFA726), size: 20.sp),
//                         ),
//                         SizedBox(width: 12.w),
//                         Text(
//                           'تجديد الاشتراك',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: const Color(0xFFFFA726),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'أدخل كود التفعيل الجديد لتجديد الاشتراك',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xFF718096),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFFF8E1),
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: const Color(0xFFFFA726).withOpacity(0.3)),
//                       ),
//                       child: TextField(
//                         controller: codeController,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                           color: const Color(0xFF2D3748),
//                         ),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أدخل كود التجديد هنا',
//                           hintStyle: TextStyle(
//                             color: const Color(0xFFA0AEC0),
//                             fontFamily: 'Tajawal',
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 14.h,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'ملاحظة: سيتم إضافة المدة الجديدة إلى اشتراكك الحالي',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFFFA726),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 24.h),
//                     if (isLoading)
//                       CircularProgressIndicator(color: const Color(0xFFFFA726))
//                     else
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF718096),
//                                 side: BorderSide(color: const Color(0xFFCBD5E0)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (codeController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('يرجى إدخال كود التجديد'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 setState(() => isLoading = true);
//
//                                 try {
//                                   Map<String, dynamic> result =
//                                   await _subscriptionService.renewSubscription(
//                                     codeController.text.trim(),
//                                   );
//
//                                   setState(() => isLoading = false);
//
//                                   if (result['success']) {
//                                     Navigator.pop(context);
//                                     _showRenewalSuccessDialog(
//                                       daysRemaining: result['daysRemaining'] ?? 30,
//                                       endDate: result['endDate'] ?? DateTime.now().add(const Duration(days: 30)),
//                                     );
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text(result['message']),
//                                         backgroundColor: const Color(0xFFE53E3E),
//                                       ),
//                                     );
//                                   }
//                                 } catch (e) {
//                                   setState(() => isLoading = false);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('حدث خطأ غير متوقع: $e'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFFFA726),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'تجديد',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showRenewalSuccessDialog({int daysRemaining = 30, DateTime? endDate}) {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Iconsax.tick_circle,
//                     color: const Color(0xFF10B981),
//                     size: 40.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'تم التجديد بنجاح!',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                     color: const Color(0xFFFFA726),
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'تم تجديد اشتراكك بنجاح وتم إضافة 30 يوم إلى اشتراكك الحالي.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: const Color(0xFF718096),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Container(
//                   padding: EdgeInsets.all(12.w),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF0FFF4),
//                     borderRadius: BorderRadius.circular(12.r),
//                     border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Iconsax.calendar, color: const Color(0xFF10B981), size: 16.sp),
//                       SizedBox(width: 8.w),
//                       Text(
//                         'ينتهي في: ${formatDate(endDate)}',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: const Color(0xFF10B981),
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _refreshSubscription();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFFA726),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                     ),
//                     child: Text(
//                       'متابعة',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
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
//   void _showActivationSuccessDialog({int daysRemaining = 30, DateTime? endDate, String code = ''}) {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Iconsax.tick_circle,
//                     color: const Color(0xFF10B981),
//                     size: 40.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'تم التفعيل بنجاح!',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                     color: const Color(0xFF1E88E5),
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'تم تفعيل الاشتراك بنجاح. يمكنك الآن الاستفادة من جميع الميزات المميزة.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: const Color(0xFF718096),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Container(
//                   padding: EdgeInsets.all(12.w),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF0F9FF),
//                     borderRadius: BorderRadius.circular(12.r),
//                     border: Border.all(color: const Color(0xFF1E88E5).withOpacity(0.3)),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Iconsax.calendar, color: const Color(0xFF1E88E5), size: 16.sp),
//                           SizedBox(width: 8.w),
//                           Text(
//                             'ينتهي في: ${formatDate(endDate)}',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: const Color(0xFF1E88E5),
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Iconsax.card, color: const Color(0xFF1E88E5), size: 16.sp),
//                           SizedBox(width: 8.w),
//                           Text(
//                             'الكود: $code',
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: const Color(0xFF718096),
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _refreshSubscription();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E88E5),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                     ),
//                     child: Text(
//                       'متابعة',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
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
//   Widget _buildSubscriptionSection() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border: Border.all(
//           color: const Color(0xFFF1F5F9),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 40.w,
//                     height: 40.h,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFFA726).withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Iconsax.crown_1,
//                       color: const Color(0xFFFFA726),
//                       size: 20.sp,
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Text(
//                     'حالة الاشتراك',
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                       color: const Color(0xFF1E293B),
//                     ),
//                   ),
//                 ],
//               ),
//               if (!_isLoadingSubscription)
//                 IconButton(
//                   onPressed: _refreshSubscription,
//                   icon: Icon(
//                     _isRefreshing ? Iconsax.refresh : Iconsax.refresh_circle,
//                     color: _isRefreshing ? const Color(0xFF1E88E5) : const Color(0xFFCBD5E0),
//                     size: 22.sp,
//                   ),
//                 ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//
//           if (_isLoadingSubscription)
//             _buildLoadingSubscription()
//           else if (_subscriptionStatus['isActive'] == true)
//             _buildActiveSubscription()
//           else
//             _buildInactiveSubscription(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingSubscription() {
//     return Center(
//       child: Column(
//         children: [
//           CircularProgressIndicator(color: const Color(0xFF1E88E5)),
//           SizedBox(height: 16.h),
//           Text(
//             'جاري التحقق من حالة الاشتراك...',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: const Color(0xFF718096),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             'قد تستغرق العملية بضع ثوانٍ',
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: const Color(0xFFA0AEC0),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActiveSubscription() {
//     // استخدام البيانات بشكل آمن مع القيم الافتراضية
//     Map<String, dynamic> subscriptionData = _subscriptionStatus['subscriptionData'] ?? {};
//
//     String planType = subscriptionData['plan_type'] ?? 'مميز';
//     int daysRemaining = _subscriptionStatus['daysRemaining'] ?? 0;
//     DateTime endDate = _subscriptionStatus['endDate'] is DateTime
//         ? _subscriptionStatus['endDate']
//         : DateTime.now();
//     DateTime startDate = _subscriptionStatus['startDate'] is DateTime
//         ? _subscriptionStatus['startDate']
//         : DateTime.now();
//     String subscriptionCode = subscriptionData['subscription_code'] ?? 'غير محدد';
//
//     // حساب المدة الإجمالية بشكل آمن
//     int totalDays = endDate.difference(startDate).inDays;
//     int usedDays = totalDays > 0 ? totalDays - daysRemaining : 0;
//     double progress = totalDays > 0 ? daysRemaining / totalDays : 0.0;
//
//     return Column(
//       children: [
//         // بطاقة معلومات الاشتراك باللون البرتقالي
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 const Color(0xFFFFA726).withOpacity(0.9),
//                 const Color(0xFFFFB74D),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFFFFA726).withOpacity(0.3),
//                 blurRadius: 15.r,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'الاشتراك نشط',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20.r),
//                     ),
//                     child: Text(
//                       planType,
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//
//               // شريط التقدم
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'الأيام المتبقية',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       Text(
//                         '$daysRemaining يوم',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Container(
//                     width: double.infinity,
//                     height: 8.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                     child: Stack(
//                       children: [
//                         AnimatedContainer(
//                           duration: const Duration(milliseconds: 500),
//                           width: double.infinity * progress,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.white,
//                                 Colors.white.withOpacity(0.8),
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(4.r),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'تم استخدام $usedDays من $totalDays يوم',
//                         style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.white.withOpacity(0.8),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       if (progress <= 0.3)
//                         Text(
//                           'متبقي قليل!',
//                           style: TextStyle(
//                             fontSize: 10.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//
//         // معلومات تفصيلية عن الاشتراك
//         _buildSubscriptionInfoRow('نوع الاشتراك', planType),
//         _buildSubscriptionInfoRow('كود الاشتراك', subscriptionCode),
//         _buildSubscriptionInfoRow('تاريخ البدء', formatDate(startDate)),
//         _buildSubscriptionInfoRow('تاريخ الانتهاء', formatDate(endDate)),
//         _buildSubscriptionInfoRow('المدة المتبقية', '$daysRemaining يوم'),
//
//         SizedBox(height: 16.h),
//
//         // زر تجديد الاشتراك
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: _showRenewalDialog,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFFA726),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14.h),
//               elevation: 2,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Iconsax.refresh, size: 18.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'تجديد الاشتراك',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInactiveSubscription() {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFEF2F2),
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: const Color(0xFFFECACA)),
//           ),
//           child: Row(
//             children: [
//               Icon(Iconsax.info_circle, color: const Color(0xFFDC2626), size: 20.sp),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'لا يوجد اشتراك نشط',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       'قم بتفعيل الاشتراك للاستفادة من الميزات المميزة',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: _showActivationDialog,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF1E88E5),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14.h),
//               elevation: 0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Iconsax.card, size: 18.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'تفعيل الاشتراك',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           'ادخل كود التفعيل لتفعيل الاشتراك',
//           style: TextStyle(
//             fontSize: 12.sp,
//             color: const Color(0xFF718096),
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSubscriptionInfoRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: const Color(0xFF64748B),
//               fontFamily: 'Tajawal',
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF1E293B),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             const Color(0xFF1E88E5),
//             const Color(0xFF1976D2),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF1E88E5).withOpacity(0.3),
//             blurRadius: 15.r,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80.w,
//             height: 80.h,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.3),
//                 width: 3.w,
//               ),
//             ),
//             child: Icon(
//               Iconsax.profile_circle,
//               color: Colors.white,
//               size: 40.sp,
//             ),
//           ),
//           SizedBox(height: 12.h),
//           Text(
//             authService.studentEmail ?? 'مستخدم',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Tajawal',
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             'طالب',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.white.withOpacity(0.9),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 8.h),
//           if (authService.selectedGrade != null)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Text(
//                 _getGradeText(authService.selectedGrade),
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   String _getGradeText(int? gradeValue) {
//     if (gradeValue == null) {
//       return 'لم يتم الاختيار';
//     }
//
//     switch (gradeValue) {
//       case 1: return 'الصف الأول الابتدائي';
//       case 2: return 'الصف الثاني الابتدائي';
//       case 3: return 'الصف الثالث الابتدائي';
//       case 4: return 'الصف الرابع الابتدائي';
//       case 5: return 'الصف الخامس الابتدائي';
//       case 6: return 'الصف السادس الابتدائي';
//       case 7: return 'الصف الأول المتوسط';
//       case 8: return 'الصف الثاني المتوسط';
//       case 9: return 'الصف الثالث المتوسط';
//       case 10: return 'الصف الأول الثانوي';
//       case 11: return 'الصف الثاني الثانوي';
//       case 12: return 'الصف الثالث الثانوي';
//       default: return 'الصف $gradeValue';
//     }
//   }
//
//   Widget _buildMenuItems() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildMenuItem(
//             icon: Iconsax.setting_2,
//             title: 'الإعدادات',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.shield_tick,
//             title: 'الخصوصية',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.info_circle,
//             title: 'عن التطبيق',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.headphone,
//             title: 'الدعم الفني',
//             onTap: () {},
//           ),
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: const Color(0xFFF1F5F9),
//                   width: 1,
//                 ),
//               ),
//             ),
//             child: ListTile(
//               leading: Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE53E3E).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.logout,
//                   color: const Color(0xFFE53E3E),
//                   size: 20.sp,
//                 ),
//               ),
//               title: Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Tajawal',
//                   color: const Color(0xFFE53E3E),
//                 ),
//               ),
//               trailing: Icon(
//                 Iconsax.arrow_left_2,
//                 color: const Color(0xFFCBD5E0),
//                 size: 18.sp,
//               ),
//               onTap: () {
//                 _showLogoutConfirmationDialog(authService);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showLogoutConfirmationDialog(AuthService authService) {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           title: Row(
//             children: [
//               Icon(Iconsax.logout, color: const Color(0xFFE53E3E)),
//               SizedBox(width: 8.w),
//               Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             'هل أنت متأكد أنك تريد تسجيل الخروج؟',
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           actions: [
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: const Color(0xFF718096),
//                       side: BorderSide(color: const Color(0xFFCBD5E0)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'إلغاء',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Navigator.pop(context);
//                       await authService.logout();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFE53E3E),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'تسجيل الخروج',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
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
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: const Color(0xFFF1F5F9),
//             width: 1,
//           ),
//         ),
//       ),
//       child: ListTile(
//         leading: Container(
//           width: 40.w,
//           height: 40.h,
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E88E5).withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: const Color(0xFF1E88E5),
//             size: 20.sp,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Tajawal',
//             color: const Color(0xFF1E293B),
//           ),
//         ),
//         trailing: Icon(
//           Iconsax.arrow_left_2,
//           color: const Color(0xFFCBD5E0),
//           size: 18.sp,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F9FF),
//         body: SafeArea(
//           child: RefreshIndicator(
//             onRefresh: _refreshSubscription,
//             color: const Color(0xFF1E88E5),
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   SizedBox(height: 16.h),
//                   _buildProfileHeader(),
//                   _buildSubscriptionSection(),
//                   _buildMenuItems(),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import '../Auth/auth_service.dart';
// import '../widget/subscription_service.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final SubscriptionService _subscriptionService = SubscriptionService();
//   Map<String, dynamic> _subscriptionStatus = {};
//   bool _isLoadingSubscription = true;
//   bool _isRefreshing = false;
//   bool _hasConnectionError = false;
//   StreamSubscription<Map<String, dynamic>>? _subscriptionStreamSubscription;
//   bool _isDataCached = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeFirestoreCache();
//     _loadSubscriptionStatus();
//     _setupSubscriptionListener();
//   }
//
//   @override
//   void dispose() {
//     _subscriptionStreamSubscription?.cancel();
//     _subscriptionService.dispose();
//     super.dispose();
//   }
//
//   Future<void> _initializeFirestoreCache() async {
//     try {
//       // تهيئة التخزين المؤقت لـ Firestore
//       await FirebaseFirestore.instance
//           .collection('user_subscriptions')
//           .limit(1)
//           .get(const GetOptions(source: Source.cache));
//
//       print('✅ تم تهيئة التخزين المؤقت لـ Firestore');
//     } catch (e) {
//       print('⚠️ خطأ في تهيئة التخزين المؤقت: $e');
//     }
//   }
//
//   void _setupSubscriptionListener() {
//     final stream = _subscriptionService.getSubscriptionStream();
//     if (stream != null) {
//       _subscriptionStreamSubscription = stream.listen((data) {
//         print('📡 [ProfileScreen] استلام تحديث مباشر لحالة الاشتراك');
//         _handleSubscriptionUpdate(data, isLiveUpdate: true);
//       }, onError: (error) {
//         print('❌ [ProfileScreen] خطأ في الاشتراك المباشر: $error');
//       });
//     }
//   }
//
//   void _handleSubscriptionUpdate(Map<String, dynamic> data, {bool isLiveUpdate = false}) {
//     if (mounted) {
//       setState(() {
//         _subscriptionStatus = data;
//         _isDataCached = data['isCached'] == true;
//         _hasConnectionError = data['hasError'] == true;
//
//         if (isLiveUpdate) {
//           _isLoadingSubscription = false;
//           _isRefreshing = false;
//         }
//       });
//
//       if (isLiveUpdate) {
//         print('✅ [ProfileScreen] تم تحديث حالة الاشتراك مباشرةً');
//       }
//     }
//   }
//
//   Future<void> _loadSubscriptionStatus() async {
//     print('🔄 [ProfileScreen] بدء تحميل حالة الاشتراك...');
//
//     if (!_isRefreshing) {
//       setState(() {
//         _isLoadingSubscription = true;
//         _hasConnectionError = false;
//       });
//     }
//
//     try {
//       final status = await _subscriptionService.checkUserSubscription();
//
//       _handleSubscriptionUpdate(status);
//
//       print('✅ [ProfileScreen] حالة الاشتراك بعد التحميل:');
//       print('   - hasSubscription: ${_subscriptionStatus['hasSubscription']}');
//       print('   - isActive: ${_subscriptionStatus['isActive']}');
//       print('   - daysRemaining: ${_subscriptionStatus['daysRemaining']}');
//       print('   - isCached: ${_subscriptionStatus['isCached']}');
//
//       // تحديث البيانات من السيرفر في الخلفية إذا كانت مخزنة مؤقتاً
//       if (_subscriptionStatus['isCached'] == true) {
//         _refreshFromServerInBackground();
//       }
//
//     } catch (e) {
//       print('❌ [ProfileScreen] خطأ في تحميل حالة الاشتراك: $e');
//
//       if (mounted) {
//         setState(() {
//           _hasConnectionError = true;
//           _subscriptionStatus = {
//             'hasSubscription': false,
//             'isActive': false,
//             'message': 'خطأ في تحميل البيانات',
//             'errorMessage': 'تعذر الاتصال بالخادم'
//           };
//         });
//       }
//     }
//
//     if (mounted) {
//       setState(() {
//         _isLoadingSubscription = false;
//         _isRefreshing = false;
//       });
//     }
//   }
//
//   Future<void> _refreshFromServerInBackground() async {
//     try {
//       print('🔄 [ProfileScreen] تحديث البيانات من السيرفر في الخلفية...');
//       final freshStatus = await _subscriptionService.refreshSubscriptionFromServer();
//
//       if (mounted) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (_isDataOutdated(freshStatus)) {
//             _handleSubscriptionUpdate(freshStatus);
//             print('✅ [ProfileScreen] تم تحديث البيانات من السيرفر في الخلفية');
//           }
//         });
//       }
//     } catch (e) {
//       print('⚠️ [ProfileScreen] لا يمكن تحديث البيانات من السيرفر: $e');
//     }
//   }
//
//   bool _isDataOutdated(Map<String, dynamic> freshData) {
//     if (_subscriptionStatus['lastUpdated'] == null) return true;
//
//     final currentLastUpdated = _subscriptionStatus['lastUpdated'];
//     final freshLastUpdated = freshData['lastUpdated'];
//
//     if (currentLastUpdated == null || freshLastUpdated == null) return true;
//
//     if (currentLastUpdated is! DateTime || freshLastUpdated is! DateTime) return true;
//
//     return freshLastUpdated.isAfter(currentLastUpdated);
//   }
//
//   Future<void> _refreshSubscription() async {
//     setState(() {
//       _isRefreshing = true;
//       _hasConnectionError = false;
//     });
//
//     await _loadSubscriptionStatus();
//
//     // إظهار مؤشر نجاح
//     if (!_hasConnectionError && mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             _isDataCached
//                 ? 'تم تحديث البيانات (مخزنة مؤقتاً)'
//                 : 'تم تحديث البيانات بنجاح',
//             textAlign: TextAlign.center,
//           ),
//           backgroundColor: _isDataCached
//               ? const Color(0xFFFFA726)
//               : const Color(0xFF10B981),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//   Future<void> _forceRefreshFromServer() async {
//     setState(() {
//       _isRefreshing = true;
//       _hasConnectionError = false;
//     });
//
//     try {
//       final status = await _subscriptionService.refreshSubscriptionFromServer();
//
//       _handleSubscriptionUpdate(status);
//
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               status['isCached'] == true
//                   ? 'البيانات محدثة (مخزنة مؤقتاً)'
//                   : 'تم تحديث البيانات من السيرفر',
//               textAlign: TextAlign.center,
//             ),
//             backgroundColor: status['isCached'] == true
//                 ? const Color(0xFFFFA726)
//                 : const Color(0xFF10B981),
//           ),
//         );
//       }
//     } catch (e) {
//       print('❌ [ProfileScreen] خطأ في التحديث القسري: $e');
//       setState(() {
//         _hasConnectionError = true;
//       });
//
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text('تعذر الاتصال بالسيرفر'),
//             backgroundColor: const Color(0xFFE53E3E),
//           ),
//         );
//       }
//     }
//
//     setState(() => _isRefreshing = false);
//   }
//
//   String formatDate(DateTime? date) {
//     if (date == null) return 'غير محدد';
//
//     int year = date.year;
//     int month = date.month;
//     int day = date.day;
//
//     String formattedYear = year.toString();
//     String formattedMonth = month.toString().padLeft(2, '0');
//     String formattedDay = day.toString().padLeft(2, '0');
//
//     return '$formattedYear/$formattedMonth/$formattedDay';
//   }
//
//   void _showActivationDialog() {
//     TextEditingController codeController = TextEditingController();
//     bool isLoading = false;
//
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E88E5).withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Iconsax.card, color: const Color(0xFF1E88E5), size: 20.sp),
//                         ),
//                         SizedBox(width: 12.w),
//                         Text(
//                           'تفعيل الاشتراك',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: const Color(0xFF1E88E5),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'أدخل كود التفعيل الخاص بك لتفعيل الاشتراك',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xFF718096),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF5F9FF),
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: const Color(0xFFE2E8F0)),
//                       ),
//                       child: TextField(
//                         controller: codeController,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                           color: const Color(0xFF2D3748),
//                         ),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أدخل الكود هنا',
//                           hintStyle: TextStyle(
//                             color: const Color(0xFFA0AEC0),
//                             fontFamily: 'Tajawal',
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 14.h,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     if (isLoading)
//                       CircularProgressIndicator(color: const Color(0xFF1E88E5))
//                     else
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF718096),
//                                 side: BorderSide(color: const Color(0xFFCBD5E0)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (codeController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('يرجى إدخال كود التفعيل'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 setState(() => isLoading = true);
//
//                                 try {
//                                   Map<String, dynamic> result =
//                                   await _subscriptionService.activateSubscription(
//                                     codeController.text.trim(),
//                                   );
//
//                                   setState(() => isLoading = false);
//
//                                   if (result['success']) {
//                                     Navigator.pop(context);
//                                     _showActivationSuccessDialog(
//                                       daysRemaining: result['subscriptionData']['duration_days'] ?? 30,
//                                       endDate: result['subscriptionData']['end_date'] ?? DateTime.now().add(const Duration(days: 30)),
//                                       code: codeController.text.trim(),
//                                     );
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text(result['message']),
//                                         backgroundColor: const Color(0xFFE53E3E),
//                                       ),
//                                     );
//                                   }
//                                 } catch (e) {
//                                   setState(() => isLoading = false);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('حدث خطأ غير متوقع: $e'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF1E88E5),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'تفعيل',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showRenewalDialog() {
//     TextEditingController codeController = TextEditingController();
//     bool isLoading = false;
//
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.h,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFFA726).withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(Iconsax.refresh, color: const Color(0xFFFFA726), size: 20.sp),
//                         ),
//                         SizedBox(width: 12.w),
//                         Text(
//                           'تجديد الاشتراك',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: const Color(0xFFFFA726),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'أدخل كود التفعيل الجديد لتجديد الاشتراك',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xFF718096),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFFF8E1),
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: const Color(0xFFFFA726).withOpacity(0.3)),
//                       ),
//                       child: TextField(
//                         controller: codeController,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                           color: const Color(0xFF2D3748),
//                         ),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أدخل كود التجديد هنا',
//                           hintStyle: TextStyle(
//                             color: const Color(0xFFA0AEC0),
//                             fontFamily: 'Tajawal',
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.w,
//                             vertical: 14.h,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'ملاحظة: سيتم إضافة المدة الجديدة إلى اشتراكك الحالي',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFFFA726),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 24.h),
//                     if (isLoading)
//                       CircularProgressIndicator(color: const Color(0xFFFFA726))
//                     else
//                       Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: const Color(0xFF718096),
//                                 side: BorderSide(color: const Color(0xFFCBD5E0)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'إلغاء',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (codeController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('يرجى إدخال كود التجديد'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 setState(() => isLoading = true);
//
//                                 try {
//                                   Map<String, dynamic> result =
//                                   await _subscriptionService.renewSubscription(
//                                     codeController.text.trim(),
//                                   );
//
//                                   setState(() => isLoading = false);
//
//                                   if (result['success']) {
//                                     Navigator.pop(context);
//                                     _showRenewalSuccessDialog(
//                                       daysRemaining: result['subscriptionData']['duration_days'] ?? 30,
//                                       endDate: result['subscriptionData']['end_date'] ?? DateTime.now().add(const Duration(days: 30)),
//                                     );
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text(result['message']),
//                                         backgroundColor: const Color(0xFFE53E3E),
//                                       ),
//                                     );
//                                   }
//                                 } catch (e) {
//                                   setState(() => isLoading = false);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('حدث خطأ غير متوقع: $e'),
//                                       backgroundColor: const Color(0xFFE53E3E),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFFFA726),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                               ),
//                               child: Text(
//                                 'تجديد',
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Tajawal',
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showRenewalSuccessDialog({int daysRemaining = 30, DateTime? endDate}) {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Iconsax.tick_circle,
//                     color: const Color(0xFF10B981),
//                     size: 40.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'تم التجديد بنجاح!',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                     color: const Color(0xFFFFA726),
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'تم تجديد اشتراكك بنجاح وتم إضافة $daysRemaining يوم إلى اشتراكك الحالي.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: const Color(0xFF718096),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Container(
//                   padding: EdgeInsets.all(12.w),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF0FFF4),
//                     borderRadius: BorderRadius.circular(12.r),
//                     border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Iconsax.calendar, color: const Color(0xFF10B981), size: 16.sp),
//                       SizedBox(width: 8.w),
//                       Text(
//                         'ينتهي في: ${formatDate(endDate)}',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: const Color(0xFF10B981),
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _forceRefreshFromServer();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFFA726),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                     ),
//                     child: Text(
//                       'متابعة',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
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
//   void _showActivationSuccessDialog({int daysRemaining = 30, DateTime? endDate, String code = ''}) {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(24.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF10B981).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Iconsax.tick_circle,
//                     color: const Color(0xFF10B981),
//                     size: 40.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'تم التفعيل بنجاح!',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                     color: const Color(0xFF1E88E5),
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'تم تفعيل الاشتراك بنجاح. يمكنك الآن الاستفادة من جميع الميزات المميزة.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: const Color(0xFF718096),
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Container(
//                   padding: EdgeInsets.all(12.w),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF0F9FF),
//                     borderRadius: BorderRadius.circular(12.r),
//                     border: Border.all(color: const Color(0xFF1E88E5).withOpacity(0.3)),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Iconsax.calendar, color: const Color(0xFF1E88E5), size: 16.sp),
//                           SizedBox(width: 8.w),
//                           Text(
//                             'ينتهي في: ${formatDate(endDate)}',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: const Color(0xFF1E88E5),
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Iconsax.card, color: const Color(0xFF1E88E5), size: 16.sp),
//                           SizedBox(width: 8.w),
//                           Text(
//                             'الكود: $code',
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: const Color(0xFF718096),
//                               fontFamily: 'Tajawal',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _forceRefreshFromServer();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E88E5),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                     ),
//                     child: Text(
//                       'متابعة',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
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
//   Widget _buildSubscriptionSection() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border: Border.all(
//           color: const Color(0xFFF1F5F9),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 40.w,
//                     height: 40.h,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFFA726).withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Iconsax.crown_1,
//                       color: const Color(0xFFFFA726),
//                       size: 20.sp,
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Text(
//                     'حالة الاشتراك',
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                       color: const Color(0xFF1E293B),
//                     ),
//                   ),
//                 ],
//               ),
//               if (!_isLoadingSubscription)
//                 Row(
//                   children: [
//                     if (_isDataCached || _hasConnectionError)
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                         decoration: BoxDecoration(
//                           color: _hasConnectionError
//                               ? const Color(0xFFFEE2E2)
//                               : const Color(0xFFFEF3C7),
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               _hasConnectionError
//                                   ? Iconsax.warning_2
//                                   : Iconsax.cloud,
//                               size: 12.sp,
//                               color: _hasConnectionError
//                                   ? const Color(0xFFDC2626)
//                                   : const Color(0xFFD97706),
//                             ),
//                             SizedBox(width: 4.w),
//                             Text(
//                               _hasConnectionError ? 'غير متصل' : 'مخزن',
//                               style: TextStyle(
//                                 fontSize: 10.sp,
//                                 color: _hasConnectionError
//                                     ? const Color(0xFFDC2626)
//                                     : const Color(0xFFD97706),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     SizedBox(width: 8.w),
//                     IconButton(
//                       onPressed: _refreshSubscription,
//                       icon: Icon(
//                         _isRefreshing ? Iconsax.refresh : Iconsax.refresh_circle,
//                         color: _isRefreshing
//                             ? const Color(0xFF1E88E5)
//                             : _hasConnectionError
//                             ? const Color(0xFFDC2626)
//                             : const Color(0xFFCBD5E0),
//                         size: 22.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//
//           if (_isLoadingSubscription)
//             _buildLoadingSubscription()
//           else if (_hasConnectionError)
//             _buildErrorState()
//           else if (_subscriptionStatus['isActive'] == true)
//               _buildActiveSubscription()
//             else
//               _buildInactiveSubscription(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingSubscription() {
//     return Center(
//       child: Column(
//         children: [
//           CircularProgressIndicator(color: const Color(0xFF1E88E5)),
//           SizedBox(height: 16.h),
//           Text(
//             'جاري التحقق من حالة الاشتراك...',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: const Color(0xFF718096),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorState() {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFEF2F2),
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: const Color(0xFFFECACA)),
//           ),
//           child: Row(
//             children: [
//               Icon(Iconsax.warning_2, color: const Color(0xFFDC2626), size: 24.sp),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'خطأ في الاتصال',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       _subscriptionStatus['errorMessage'] ?? 'تعذر الاتصال بالخادم',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       _isDataCached
//                           ? 'يتم عرض البيانات المخزنة محلياً'
//                           : 'تأكد من اتصالك بالإنترنت',
//                       style: TextStyle(
//                         fontSize: 10.sp,
//                         color: const Color(0xFFDC2626).withOpacity(0.7),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//         if (_subscriptionStatus['hasSubscription'] == true && _isDataCached)
//           _buildActiveSubscription()
//         else
//           Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _forceRefreshFromServer,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFDC2626),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 12.h),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Iconsax.refresh, size: 18.sp),
//                       SizedBox(width: 8.w),
//                       Text(
//                         'إعادة المحاولة',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 'حاول إعادة التحميل عند استعادة الاتصال',
//                 style: TextStyle(
//                   fontSize: 10.sp,
//                   color: const Color(0xFF718096),
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
//
//   Widget _buildActiveSubscription() {
//     Map<String, dynamic> subscriptionData = _subscriptionStatus['subscriptionData'] ?? {};
//
//     String planType = subscriptionData['plan_type'] ?? 'مميز';
//     int daysRemaining = _subscriptionStatus['daysRemaining'] ?? 0;
//     DateTime endDate = _subscriptionStatus['endDate'] is DateTime
//         ? _subscriptionStatus['endDate']
//         : DateTime.now();
//     DateTime startDate = _subscriptionStatus['startDate'] is DateTime
//         ? _subscriptionStatus['startDate']
//         : DateTime.now();
//     String subscriptionCode = subscriptionData['subscription_code'] ?? 'غير محدد';
//
//     int totalDays = endDate.difference(startDate).inDays;
//     int usedDays = totalDays > 0 ? totalDays - daysRemaining : 0;
//     double progress = totalDays > 0 ? daysRemaining / totalDays : 0.0;
//
//     return Column(
//       children: [
//         // مؤشر البيانات المخزنة مؤقتاً
//         if (_isDataCached)
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(12.w),
//             margin: EdgeInsets.only(bottom: 12.h),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFEF3C7),
//               borderRadius: BorderRadius.circular(8.r),
//               border: Border.all(color: const Color(0xFFFBBF24)),
//             ),
//             child: Row(
//               children: [
//                 Icon(Iconsax.info_circle, color: const Color(0xFFD97706), size: 16.sp),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   child: Text(
//                     'يتم عرض البيانات المخزنة محلياً. آخر تحديث: ${_formatLastUpdate()}',
//                     style: TextStyle(
//                       fontSize: 11.sp,
//                       color: const Color(0xFFD97706),
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: _forceRefreshFromServer,
//                   child: Text(
//                     'تحديث',
//                     style: TextStyle(
//                       fontSize: 11.sp,
//                       color: const Color(0xFF1E88E5),
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//         // بطاقة معلومات الاشتراك
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 const Color(0xFFFFA726).withOpacity(0.9),
//                 const Color(0xFFFFB74D),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFFFFA726).withOpacity(0.3),
//                 blurRadius: 15.r,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'الاشتراك نشط',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20.r),
//                     ),
//                     child: Text(
//                       planType,
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//
//               // شريط التقدم
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'الأيام المتبقية',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.white.withOpacity(0.9),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       Text(
//                         '$daysRemaining يوم',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Container(
//                     width: double.infinity,
//                     height: 8.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                     child: Stack(
//                       children: [
//                         AnimatedContainer(
//                           duration: const Duration(milliseconds: 500),
//                           width: double.infinity * progress,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.white,
//                                 Colors.white.withOpacity(0.8),
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(4.r),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'تم استخدام $usedDays من $totalDays يوم',
//                         style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.white.withOpacity(0.8),
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                       if (progress <= 0.3)
//                         Text(
//                           'متبقي قليل!',
//                           style: TextStyle(
//                             fontSize: 10.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//
//         // معلومات تفصيلية عن الاشتراك
//         _buildSubscriptionInfoRow('نوع الاشتراك', planType),
//         _buildSubscriptionInfoRow('كود الاشتراك', subscriptionCode),
//         _buildSubscriptionInfoRow('تاريخ البدء', formatDate(startDate)),
//         _buildSubscriptionInfoRow('تاريخ الانتهاء', formatDate(endDate)),
//         _buildSubscriptionInfoRow('المدة المتبقية', '$daysRemaining يوم'),
//
//         SizedBox(height: 16.h),
//
//         // زر تجديد الاشتراك
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: _showRenewalDialog,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFFA726),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14.h),
//               elevation: 2,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Iconsax.refresh, size: 18.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'تجديد الاشتراك',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   String _formatLastUpdate() {
//     if (_subscriptionStatus['lastUpdated'] == null) return 'غير معروف';
//     if (_subscriptionStatus['lastUpdated'] is! DateTime) return 'غير معروف';
//
//     final lastUpdated = _subscriptionStatus['lastUpdated'] as DateTime;
//     final now = DateTime.now();
//     final difference = now.difference(lastUpdated);
//
//     if (difference.inMinutes < 1) return 'الآن';
//     if (difference.inMinutes < 60) return 'قبل ${difference.inMinutes} دقيقة';
//     if (difference.inHours < 24) return 'قبل ${difference.inHours} ساعة';
//     return 'قبل ${difference.inDays} يوم';
//   }
//
//   Widget _buildInactiveSubscription() {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFEF2F2),
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: const Color(0xFFFECACA)),
//           ),
//           child: Row(
//             children: [
//               Icon(Iconsax.info_circle, color: const Color(0xFFDC2626), size: 20.sp),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'لا يوجد اشتراك نشط',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       'قم بتفعيل الاشتراك للاستفادة من الميزات المميزة',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: const Color(0xFFDC2626),
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: _showActivationDialog,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF1E88E5),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 14.h),
//               elevation: 0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Iconsax.card, size: 18.sp),
//                 SizedBox(width: 8.w),
//                 Text(
//                   'تفعيل الاشتراك',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           'ادخل كود التفعيل لتفعيل الاشتراك',
//           style: TextStyle(
//             fontSize: 12.sp,
//             color: const Color(0xFF718096),
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSubscriptionInfoRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: const Color(0xFF64748B),
//               fontFamily: 'Tajawal',
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF1E293B),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             const Color(0xFF1E88E5),
//             const Color(0xFF1976D2),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF1E88E5).withOpacity(0.3),
//             blurRadius: 15.r,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80.w,
//             height: 80.h,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.3),
//                 width: 3.w,
//               ),
//             ),
//             child: Icon(
//               Iconsax.profile_circle,
//               color: Colors.white,
//               size: 40.sp,
//             ),
//           ),
//           SizedBox(height: 12.h),
//           Text(
//             authService.studentEmail ?? 'مستخدم',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Tajawal',
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             'طالب',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.white.withOpacity(0.9),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 8.h),
//           if (authService.selectedGrade != null)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Text(
//                 _getGradeText(authService.selectedGrade),
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   String _getGradeText(int? gradeValue) {
//     if (gradeValue == null) {
//       return 'لم يتم الاختيار';
//     }
//
//     switch (gradeValue) {
//       case 1: return 'الصف الأول الابتدائي';
//       case 2: return 'الصف الثاني الابتدائي';
//       case 3: return 'الصف الثالث الابتدائي';
//       case 4: return 'الصف الرابع الابتدائي';
//       case 5: return 'الصف الخامس الابتدائي';
//       case 6: return 'الصف السادس الابتدائي';
//       case 7: return 'الصف الأول المتوسط';
//       case 8: return 'الصف الثاني المتوسط';
//       case 9: return 'الصف الثالث المتوسط';
//       case 10: return 'الصف الأول الثانوي';
//       case 11: return 'الصف الثاني الثانوي';
//       case 12: return 'الصف الثالث الثانوي';
//       default: return 'الصف $gradeValue';
//     }
//   }
//
//   Widget _buildMenuItems() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildMenuItem(
//             icon: Iconsax.setting_2,
//             title: 'الإعدادات',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.shield_tick,
//             title: 'الخصوصية',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.info_circle,
//             title: 'عن التطبيق',
//             onTap: () {},
//           ),
//           _buildMenuItem(
//             icon: Iconsax.headphone,
//             title: 'الدعم الفني',
//             onTap: () {},
//           ),
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: const Color(0xFFF1F5F9),
//                   width: 1,
//                 ),
//               ),
//             ),
//             child: ListTile(
//               leading: Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE53E3E).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.logout,
//                   color: const Color(0xFFE53E3E),
//                   size: 20.sp,
//                 ),
//               ),
//               title: Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Tajawal',
//                   color: const Color(0xFFE53E3E),
//                 ),
//               ),
//               trailing: Icon(
//                 Iconsax.arrow_left_2,
//                 color: const Color(0xFFCBD5E0),
//                 size: 18.sp,
//               ),
//               onTap: () {
//                 _showLogoutConfirmationDialog(authService);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showLogoutConfirmationDialog(AuthService authService) {
//     showDialog(
//       context: context,
//       builder: (context) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           title: Row(
//             children: [
//               Icon(Iconsax.logout, color: const Color(0xFFE53E3E)),
//               SizedBox(width: 8.w),
//               Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             'هل أنت متأكد أنك تريد تسجيل الخروج؟',
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           actions: [
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: const Color(0xFF718096),
//                       side: BorderSide(color: const Color(0xFFCBD5E0)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'إلغاء',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Navigator.pop(context);
//                       await authService.logout();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFE53E3E),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.h),
//                     ),
//                     child: Text(
//                       'تسجيل الخروج',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
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
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: const Color(0xFFF1F5F9),
//             width: 1,
//           ),
//         ),
//       ),
//       child: ListTile(
//         leading: Container(
//           width: 40.w,
//           height: 40.h,
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E88E5).withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: const Color(0xFF1E88E5),
//             size: 20.sp,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Tajawal',
//             color: const Color(0xFF1E293B),
//           ),
//         ),
//         trailing: Icon(
//           Iconsax.arrow_left_2,
//           color: const Color(0xFFCBD5E0),
//           size: 18.sp,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F9FF),
//         body: SafeArea(
//           child: RefreshIndicator(
//             onRefresh: _refreshSubscription,
//             color: const Color(0xFF1E88E5),
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   SizedBox(height: 16.h),
//                   _buildProfileHeader(),
//                   _buildSubscriptionSection(),
//                   _buildMenuItems(),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubscriptionStatus();
  }

  // ✅ دالة تحميل حالة الاشتراك
  Future<void> _loadSubscriptionStatus() async {
    setState(() => _isLoading = true);

    try {
      final status = await _subscriptionService.checkUserSubscription();
      setState(() {
        _subscriptionStatus = status;
      });
    } catch (e) {
      print('❌ خطأ في تحميل حالة الاشتراك: $e');
    }

    setState(() => _isLoading = false);
  }

  // ✅ دالة تفعيل الاشتراك
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
                    Text(
                      'تفعيل الاشتراك',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                        color: const Color(0xFF1E88E5),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'أدخل كود التفعيل الخاص بك',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF718096),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      controller: codeController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'أدخل الكود هنا',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
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
                              child: Text('إلغاء'),
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
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                setState(() => isLoading = true);

                                try {
                                  Map<String, dynamic> result =
                                  await _subscriptionService.activateSubscription(
                                    codeController.text.trim(),
                                  );

                                  if (result['success']) {
                                    Navigator.pop(context);
                                    _showSuccessDialog(
                                      message: 'تم تفعيل الاشتراك بنجاح!',
                                      endDate: result['end_date'],
                                      daysRemaining: result['duration_days'],
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(result['message']),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('حدث خطأ: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }

                                setState(() => isLoading = false);
                              },
                              child: Text('تفعيل'),
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

  // ✅ دالة تجديد الاشتراك
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
                    Text(
                      'تجديد الاشتراك',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                        color: const Color(0xFFFFA726),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'أدخل كود التفعيل الجديد',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF718096),
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      controller: codeController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'أدخل كود التجديد',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
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
                              child: Text('إلغاء'),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (codeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('يرجى إدخال الكود'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                setState(() => isLoading = true);

                                try {
                                  Map<String, dynamic> result =
                                  await _subscriptionService.renewSubscription(
                                    codeController.text.trim(),
                                  );

                                  if (result['success']) {
                                    Navigator.pop(context);
                                    _showSuccessDialog(
                                      message: 'تم تجديد الاشتراك بنجاح!',
                                      endDate: result['end_date'],
                                      daysRemaining: result['duration_days'],
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(result['message']),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('حدث خطأ: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }

                                setState(() => isLoading = false);
                              },
                              child: Text('تجديد'),
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

  // ✅ دالة إظهار نجاح العملية
  void _showSuccessDialog({
    required String message,
    required DateTime endDate,
    required int daysRemaining,
  }) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text('تم بنجاح!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50.sp),
              SizedBox(height: 16.h),
              Text(message),
              SizedBox(height: 16.h),
              Text('ينتهي في: ${_formatDate(endDate)}'),
              SizedBox(height: 8.h),
              Text('المدة: $daysRemaining يوم'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _loadSubscriptionStatus(); // إعادة تحميل البيانات
              },
              child: Text('موافق'),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ تنسيق التاريخ
  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  // ✅ بناء قسم الاشتراك
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
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Iconsax.crown_1, color: const Color(0xFFFFA726)),
              SizedBox(width: 12.w),
              Text(
                'حالة الاشتراك',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          if (_isLoading)
            _buildLoadingState()
          else if (_subscriptionStatus['isActive'] == true)
            _buildActiveSubscription()
          else
            _buildInactiveSubscription(),
        ],
      ),
    );
  }

  // ✅ حالة التحميل
  Widget _buildLoadingState() {
    return Column(
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16.h),
        Text('جاري التحقق من حالة الاشتراك...'),
      ],
    );
  }

  // ✅ اشتراك نشط
  Widget _buildActiveSubscription() {
    Map<String, dynamic> data = _subscriptionStatus['subscriptionData'] ?? {};
    int daysRemaining = _subscriptionStatus['daysRemaining'] ?? 0;
    DateTime endDate = _subscriptionStatus['endDate'] ?? DateTime.now();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF10B981)),
          ),
          child: Column(
            children: [
              Text(
                '✅ اشتراك نشط',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF10B981),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'متبقي $daysRemaining يوم',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // معلومات الاشتراك
        _buildInfoRow('نوع الاشتراك', data['plan_type'] ?? 'مميز'),
        _buildInfoRow('تاريخ الانتهاء', _formatDate(endDate)),
        _buildInfoRow('حالة الاشتراك', 'نشط'),

        SizedBox(height: 16.h),

        // زر التجديد
        ElevatedButton(
          onPressed: _showRenewalDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFA726),
            minimumSize: Size(double.infinity, 50.h),
          ),
          child: Text('تجديد الاشتراك'),
        ),
      ],
    );
  }

  // ✅ لا يوجد اشتراك
  Widget _buildInactiveSubscription() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFEF4444)),
          ),
          child: Column(
            children: [
              Text(
                '❌ لا يوجد اشتراك نشط',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFEF4444),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'يجب تفعيل الاشتراك للاستفادة من الميزات',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // زر التفعيل
        ElevatedButton(
          onPressed: _showActivationDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E88E5),
            minimumSize: Size(double.infinity, 50.h),
          ),
          child: Text('تفعيل الاشتراك'),
        ),
      ],
    );
  }

  // ✅ صف معلومات
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ✅ بناء واجهة الملف الشخصي
  Widget _buildProfileHeader() {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E88E5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(Icons.person, color: Colors.white, size: 60.sp),
          SizedBox(height: 12.h),
          Text(
            authService.studentEmail ?? 'مستخدم',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(),
                _buildSubscriptionSection(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}