// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ExercisesScreen extends StatefulWidget {
//   const ExercisesScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ExercisesScreen> createState() => _ExercisesScreenState();
// }
//
// class _ExercisesScreenState extends State<ExercisesScreen> with TickerProviderStateMixin {
//   final Color primaryColor = const Color(0xFF1E88E5);
//   final Color secondaryColor = const Color(0xFFF5F9FF);
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<DocumentSnapshot> _mainExercises = [];
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//     _loadMainExercises();
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
//   Future<void> _loadMainExercises() async {
//     try {
//       final querySnapshot = await _firestore.collection('Exercises').get();
//       setState(() {
//         _mainExercises = querySnapshot.docs;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error loading exercises: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
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
//   void _navigateToSubExercises(DocumentSnapshot mainExercise) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SubExercisesScreen(
//           mainExercise: mainExercise,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMainBanner() {
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
//         height: 140.h,
//         margin: EdgeInsets.all(16.w),
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
//             Padding(
//               padding: EdgeInsets.all(20.w),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'التمارين التعليمية',
//                           style: TextStyle(
//                             fontSize: 22.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(height: 8.h),
//                         Text(
//                           'اختبر معرفتك وحسّن مهاراتك',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.white.withOpacity(0.9),
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 60.w,
//                     height: 60.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.school,
//                       color: Colors.white,
//                       size: 30.w,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
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
//             valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             'جاري تحميل التمارين...',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: textSecondary,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.assignment,
//             size: 80.sp,
//             color: textSecondary.withOpacity(0.5),
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             'لا توجد تمارين متاحة حالياً',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: textSecondary,
//               fontFamily: 'Tajawal',
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             'سيتم إضافة تمارين جديدة قريباً',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: textSecondary.withOpacity(0.7),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildExercisesGrid() {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12.w,
//         mainAxisSpacing: 12.h,
//         childAspectRatio: 1.1,
//       ),
//       itemCount: _mainExercises.length,
//       itemBuilder: (context, index) {
//         final exercise = _mainExercises[index];
//         return _buildExerciseCard(exercise, index);
//       },
//     );
//   }
//
//   Widget _buildExerciseCard(DocumentSnapshot exercise, int index) {
//     final data = exercise.data() as Map<String, dynamic>;
//     final title = data['title'] ?? 'بدون عنوان';
//     final description = data['description'] ?? 'لا يوجد وصف';
//     final imageUrl = data['image_url'];
//     final studentLevel = data['student_level'] ?? 'جميع المستويات';
//
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
//           elevation: 6.w,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.w),
//           ),
//           child: InkWell(
//             onTap: () => _navigateToSubExercises(exercise),
//             borderRadius: BorderRadius.circular(16.w),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16.w),
//                 color: cardColor,
//               ),
//               child: Stack(
//                 children: [
//                   if (imageUrl != null && imageUrl.isNotEmpty)
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16.w),
//                       child: Image.network(
//                         imageUrl,
//                         width: double.infinity,
//                         height: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             color: primaryColor.withOpacity(0.1),
//                             child: Icon(
//                               Icons.assignment,
//                               color: primaryColor,
//                               size: 40.sp,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.w),
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                         colors: [
//                           Colors.black.withOpacity(0.7),
//                           Colors.transparent,
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.all(12.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           title,
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontFamily: 'Tajawal',
//                             shadows: [
//                               Shadow(
//                                 color: Colors.black.withOpacity(0.8),
//                                 blurRadius: 4,
//                                 offset: Offset(1, 1),
//                               ),
//                             ],
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//
//                         SizedBox(height: 4.h),
//
//                         Text(
//                           description,
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: Colors.white.withOpacity(0.9),
//                             fontFamily: 'Tajawal',
//                             shadows: [
//                               Shadow(
//                                 color: Colors.black.withOpacity(0.8),
//                                 blurRadius: 4,
//                                 offset: Offset(1, 1),
//                               ),
//                             ],
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//
//                         SizedBox(height: 8.h),
//
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                           decoration: BoxDecoration(
//                             color: primaryColor.withOpacity(0.9),
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           child: Text(
//                             studentLevel,
//                             style: TextStyle(
//                               fontSize: 10.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Tajawal',
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
//         ),
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
//                         _buildMainBanner(),
//
//                         SlideTransition(
//                           position: Tween<Offset>(
//                             begin: const Offset(0, 0.3),
//                             end: Offset.zero,
//                           ).animate(
//                             CurvedAnimation(
//                               parent: _slideController,
//                               curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.w),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'التمارين المتاحة',
//                                   style: TextStyle(
//                                     fontSize: 18.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: textPrimary,
//                                     fontFamily: 'Tajawal',
//                                   ),
//                                 ),
//                                 SizedBox(height: 8.h),
//                                 Text(
//                                   'اختر التمرين لبدء الاختبار',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     color: textSecondary,
//                                     fontFamily: 'Tajawal',
//                                   ),
//                                 ),
//                                 SizedBox(height: 16.h),
//
//                                 if (_isLoading) _buildLoadingIndicator(),
//                                 if (!_isLoading && _mainExercises.isEmpty) _buildEmptyState(),
//                                 if (!_isLoading && _mainExercises.isNotEmpty) _buildExercisesGrid(),
//                               ],
//                             ),
//                           ),
//                         ),
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
// }
//
// // شاشة التمارين الفرعية
// class SubExercisesScreen extends StatefulWidget {
//   final DocumentSnapshot mainExercise;
//
//   const SubExercisesScreen({
//     Key? key,
//     required this.mainExercise,
//   }) : super(key: key);
//
//   @override
//   State<SubExercisesScreen> createState() => _SubExercisesScreenState();
// }
//
// class _SubExercisesScreenState extends State<SubExercisesScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Color primaryColor = const Color(0xFF1E88E5);
//   final Color secondaryColor = const Color(0xFFF5F9FF);
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//
//   List<DocumentSnapshot> _subExercises = [];
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSubExercises();
//   }
//
//   Future<void> _loadSubExercises() async {
//     try {
//       final mainExerciseId = widget.mainExercise.id;
//       final querySnapshot = await _firestore
//           .collection('Exercises')
//           .doc(mainExerciseId)
//           .collection('exercises')
//           .orderBy('id')
//           .get();
//
//       setState(() {
//         _subExercises = querySnapshot.docs;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error loading sub exercises: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _navigateToQuestions(String subExerciseId, String subExerciseTitle) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => QuestionsScreen(
//           mainExercise: widget.mainExercise,
//           subExerciseId: subExerciseId,
//           subExerciseTitle: subExerciseTitle,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     final data = widget.mainExercise.data() as Map<String, dynamic>;
//     final title = data['title'] ?? 'بدون عنوان';
//     final description = data['description'] ?? 'لا يوجد وصف';
//     final imageUrl = data['image_url'];
//     final studentLevel = data['student_level'] ?? 'جميع المستويات';
//
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.r),
//         color: cardColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.r,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           if (imageUrl != null && imageUrl.isNotEmpty)
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
//               child: Image.network(
//                 imageUrl,
//                 width: double.infinity,
//                 height: 150.h,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     height: 150.h,
//                     color: primaryColor.withOpacity(0.1),
//                     child: Icon(
//                       Icons.assignment,
//                       color: primaryColor,
//                       size: 50.sp,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                       decoration: BoxDecoration(
//                         color: primaryColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       child: Text(
//                         studentLevel,
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: primaryColor,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                     Spacer(),
//                     Icon(
//                       Icons.assignment,
//                       color: primaryColor,
//                       size: 24.sp,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12.h),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     color: textPrimary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   description,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: textSecondary,
//                     fontFamily: 'Tajawal',
//                     height: 1.5,
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
//   Widget _buildSubExerciseCard(DocumentSnapshot subExercise, int index) {
//     final data = subExercise.data() as Map<String, dynamic>;
//     final id = data['id'] ?? '';
//     final imageUrl = data['image_url'];
//
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       child: Card(
//         elevation: 4.w,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.w),
//         ),
//         child: InkWell(
//           onTap: () => _navigateToQuestions(subExercise.id, 'تمرين ${index + 1}'),
//           borderRadius: BorderRadius.circular(16.w),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16.w),
//               color: cardColor,
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 80.w,
//                   height: 80.h,
//                   margin: EdgeInsets.all(12.w),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.r),
//                     color: primaryColor.withOpacity(0.1),
//                   ),
//                   child: imageUrl != null && imageUrl.isNotEmpty
//                       ? ClipRRect(
//                     borderRadius: BorderRadius.circular(12.r),
//                     child: Image.network(
//                       imageUrl,
//                       width: double.infinity,
//                       height: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Icon(
//                           Icons.assignment,
//                           color: primaryColor,
//                           size: 30.sp,
//                         );
//                       },
//                     ),
//                   )
//                       : Icon(
//                     Icons.assignment,
//                     color: primaryColor,
//                     size: 30.sp,
//                   ),
//                 ),
//
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.all(12.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'تمرين ${index + 1}',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             color: textPrimary,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'اضغط لبدء حل الأسئلة',
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: textSecondary,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 Padding(
//                   padding: EdgeInsets.all(16.w),
//                   child: Icon(
//                     Icons.arrow_left,
//                     color: primaryColor,
//                     size: 24.sp,
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
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: secondaryColor,
//         appBar: AppBar(
//           backgroundColor: primaryColor,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             'التمارين الفرعية',
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             _buildHeader(),
//             SizedBox(height: 16.h),
//             Text(
//               'التمارين المتاحة',
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 color: textPrimary,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             SizedBox(height: 8.h),
//             if (_isLoading)
//               Expanded(
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                   ),
//                 ),
//               )
//             else if (_subExercises.isEmpty)
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.assignment,
//                         size: 60.sp,
//                         color: textSecondary.withOpacity(0.5),
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         'لا توجد تمارين فرعية متاحة',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           color: textSecondary,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             else
//               Expanded(
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: _subExercises.length,
//                   itemBuilder: (context, index) {
//                     return _buildSubExerciseCard(_subExercises[index], index);
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // شاشة الأسئلة
// class QuestionsScreen extends StatefulWidget {
//   final DocumentSnapshot mainExercise;
//   final String subExerciseId;
//   final String subExerciseTitle;
//
//   const QuestionsScreen({
//     Key? key,
//     required this.mainExercise,
//     required this.subExerciseId,
//     required this.subExerciseTitle,
//   }) : super(key: key);
//
//   @override
//   State<QuestionsScreen> createState() => _QuestionsScreenState();
// }
//
// class _QuestionsScreenState extends State<QuestionsScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Color primaryColor = const Color(0xFF1E88E5);
//   final Color secondaryColor = const Color(0xFFF5F9FF);
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//
//   List<DocumentSnapshot> _questions = [];
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadQuestions();
//   }
//
//   Future<void> _loadQuestions() async {
//     try {
//       final mainExerciseId = widget.mainExercise.id;
//       final querySnapshot = await _firestore
//           .collection('Exercises')
//           .doc(mainExerciseId)
//           .collection('exercises')
//           .doc(widget.subExerciseId)
//           .collection('questions')
//           .orderBy('id')
//           .get();
//
//       setState(() {
//         _questions = querySnapshot.docs;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error loading questions: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Widget _buildQuestionCard(DocumentSnapshot question, int index) {
//     final data = question.data() as Map<String, dynamic>;
//     final id = data['id'] ?? '';
//     final imageUrl = data['image_url'];
//
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       child: Card(
//         elevation: 4.w,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.w),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16.w),
//             color: cardColor,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(16.w),
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 30.w,
//                       height: 30.h,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           '${index + 1}',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Text(
//                       'سؤال ${index + 1}',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: textPrimary,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               Padding(
//                 padding: EdgeInsets.all(16.w),
//                 child: Column(
//                   children: [
//                     if (imageUrl != null && imageUrl.isNotEmpty)
//                       Container(
//                         width: double.infinity,
//                         height: 200.h,
//                         margin: EdgeInsets.only(bottom: 16.h),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12.r),
//                           color: secondaryColor,
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(12.r),
//                           child: Image.network(
//                             imageUrl,
//                             width: double.infinity,
//                             height: double.infinity,
//                             fit: BoxFit.contain,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: secondaryColor,
//                                 child: Icon(
//                                   Icons.image_not_supported,
//                                   color: textSecondary,
//                                   size: 40.sp,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//
//                     Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(12.w),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade300),
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'اكتب إجابتك هنا...',
//                           hintStyle: TextStyle(
//                             color: textSecondary,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         maxLines: 3,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: textPrimary,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
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
//         appBar: AppBar(
//           backgroundColor: primaryColor,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             widget.subExerciseTitle,
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.all(16.w),
//               padding: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: cardColor,
//                 borderRadius: BorderRadius.circular(16.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8.r,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.quiz,
//                     color: primaryColor,
//                     size: 24.sp,
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'أسئلة ${widget.subExerciseTitle}',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             color: textPrimary,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           '${_questions.length} سؤال',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: textSecondary,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             if (_isLoading)
//               Expanded(
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                   ),
//                 ),
//               )
//             else if (_questions.isEmpty)
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.quiz,
//                         size: 60.sp,
//                         color: textSecondary.withOpacity(0.5),
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         'لا توجد أسئلة متاحة',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           color: textSecondary,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             else
//               Expanded(
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: _questions.length,
//                   itemBuilder: (context, index) {
//                     return _buildQuestionCard(_questions[index], index);
//                   },
//                 ),
//               ),
//
//             if (_questions.isNotEmpty)
//               Container(
//                 padding: EdgeInsets.all(16.w),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // إرسال الإجابات
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
//                   ),
//                   child: Text(
//                     'إرسال الإجابات',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'dart:io';
//
// class HomeworkSolverScreen extends StatefulWidget {
//   const HomeworkSolverScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeworkSolverScreen> createState() => _HomeworkSolverScreenState();
// }
//
// class _HomeworkSolverScreenState extends State<HomeworkSolverScreen>
//     with TickerProviderStateMixin {
//   final Color primaryColor = const Color(0xFF1E88E5);
//   final Color secondaryColor = const Color(0xFFF5F9FF);
//   final Color cardColor = Colors.white;
//   final Color textPrimary = const Color(0xFF2D3748);
//   final Color textSecondary = const Color(0xFF718096);
//   final Color successColor = const Color(0xFF4CAF50);
//   final Color warningColor = const Color(0xFFFF9800);
//
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   final ImagePicker _imagePicker = ImagePicker();
//   File? _selectedImage;
//   bool _isProcessing = false;
//   bool _hasSolution = false;
//   List<QuestionSolution> _solutions = [];
//   String _errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//   }
//
//   void _initAnimations() {
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.2),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
//     );
//
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _fadeController.forward();
//       _scaleController.forward();
//       _slideController.forward();
//     });
//   }
//
//   Future<void> _captureImage() async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         maxWidth: 1200,
//         maxHeight: 1200,
//         imageQuality: 90,
//       );
//
//       if (image != null) {
//         setState(() {
//           _selectedImage = File(image.path);
//           _hasSolution = false;
//           _solutions.clear();
//           _errorMessage = '';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'خطأ في التقاط الصورة: $e';
//       });
//     }
//   }
//
//   Future<void> _pickImageFromGallery() async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1200,
//         maxHeight: 1200,
//         imageQuality: 90,
//       );
//
//       if (image != null) {
//         setState(() {
//           _selectedImage = File(image.path);
//           _hasSolution = false;
//           _solutions.clear();
//           _errorMessage = '';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'خطأ في اختيار الصورة: $e';
//       });
//     }
//   }
//
//   Future<void> _solveHomework() async {
//     if (_selectedImage == null) return;
//
//     setState(() {
//       _isProcessing = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final solutionText = await GeminiService.solveHomework(_selectedImage!);
//       _parseSolutions(solutionText);
//
//       setState(() {
//         _isProcessing = false;
//         _hasSolution = true;
//       });
//
//     } catch (e) {
//       setState(() {
//         _isProcessing = false;
//         _errorMessage = 'خطأ في معالجة الواجب: $e';
//       });
//     }
//   }
//
//   void _parseSolutions(String responseText) {
//     final List<QuestionSolution> solutions = [];
//
//     try {
//       // طريقة أكثر قوة لتحليل الرد
//       final blocks = responseText.split(RegExp(r'(?=سؤال|Question|Problem)', caseSensitive: false));
//
//       for (final block in blocks) {
//         if (block.trim().isEmpty) continue;
//
//         final questionMatch = RegExp(r'^(سؤال|Question|Problem)[:\s]*(.*?)(?=(الحل|Solution|$))', dotAll: true).firstMatch(block);
//         final solutionMatch = RegExp(r'(الحل|Solution)[:\s]*(.*?)(?=(شرح|Explanation|$))', dotAll: true).firstMatch(block);
//         final explanationMatch = RegExp(r'(شرح|Explanation)[:\s]*(.*)', dotAll: true).firstMatch(block);
//
//         if (questionMatch != null) {
//           solutions.add(QuestionSolution(
//             question: questionMatch.group(0)?.trim() ?? 'سؤال',
//             solution: solutionMatch?.group(2)?.trim() ?? '',
//             explanation: explanationMatch?.group(2)?.trim() ?? '',
//           ));
//         }
//       }
//     } catch (e) {
//       // fallback
//       solutions.add(QuestionSolution(
//         question: 'تحليل الواجب',
//         solution: responseText,
//         explanation: 'تم تحليل المحتوى بنجاح',
//       ));
//     }
//
//     setState(() => _solutions = solutions);
//   }
//
//   void _clearAll() {
//     setState(() {
//       _selectedImage = null;
//       _hasSolution = false;
//       _solutions.clear();
//       _errorMessage = '';
//     });
//   }
//
//   Widget _buildHeader() {
//     return SlideTransition(
//       position: _slideAnimation,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 width: 80.w,
//                 height: 80.h,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [primaryColor, primaryColor.withOpacity(0.8)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: primaryColor.withOpacity(0.3),
//                       blurRadius: 15.r,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.auto_awesome,
//                   color: Colors.white,
//                   size: 40.w,
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               Text(
//                 'حل الواجبات بالذكاء الاصطناعي',
//                 style: TextStyle(
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.bold,
//                   color: textPrimary,
//                   fontFamily: 'Tajawal',
//                   height: 1.3,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 'التقط صورة للواجب واحصل على الحل فوراً\nباستخدام أحدث تقنيات الذكاء الاصطناعي',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: textSecondary,
//                   fontFamily: 'Tajawal',
//                   height: 1.5,
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
//   Widget _buildImageSection() {
//     return SlideTransition(
//       position: _slideAnimation,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(24.w),
//                 decoration: BoxDecoration(
//                   color: cardColor,
//                   borderRadius: BorderRadius.circular(24.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 20.r,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                   border: Border.all(
//                     color: Colors.grey.shade100,
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.photo_library,
//                               color: primaryColor,
//                               size: 20.w,
//                             ),
//                             SizedBox(width: 8.w),
//                             Text(
//                               'صورة الواجب',
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: textPrimary,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ],
//                         ),
//                         if (_selectedImage != null)
//                           InkWell(
//                             onTap: _clearAll,
//                             borderRadius: BorderRadius.circular(8.r),
//                             child: Container(
//                               padding: EdgeInsets.all(6.w),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade100,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.close,
//                                 size: 16.w,
//                                 color: textSecondary,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//
//                     if (_selectedImage == null)
//                       Container(
//                         width: double.infinity,
//                         height: 200.h,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey.shade300,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(16.r),
//                           color: secondaryColor,
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 70.w,
//                               height: 70.h,
//                               decoration: BoxDecoration(
//                                 color: primaryColor.withOpacity(0.1),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.camera_alt_outlined,
//                                 size: 32.w,
//                                 color: primaryColor,
//                               ),
//                             ),
//                             SizedBox(height: 16.h),
//                             Text(
//                               'لم يتم اختيار صورة',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color: textSecondary,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                             SizedBox(height: 8.h),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 20.w),
//                               child: Text(
//                                 'قم باختيار صورة الواجب من الكاميرا أو المعرض لبدء التحليل',
//                                 style: TextStyle(
//                                   fontSize: 12.sp,
//                                   color: textSecondary.withOpacity(0.7),
//                                   fontFamily: 'Tajawal',
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     else
//                       Container(
//                         width: double.infinity,
//                         height: 260.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16.r),
//                           color: secondaryColor,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 8.r,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(16.r),
//                               child: Image.file(
//                                 _selectedImage!,
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     color: Colors.grey.shade200,
//                                     child: Icon(
//                                       Icons.error_outline,
//                                       color: Colors.grey.shade400,
//                                       size: 50.w,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             Positioned(
//                               top: 8.w,
//                               right: 8.w,
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 8.w,
//                                   vertical: 4.h,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.6),
//                                   borderRadius: BorderRadius.circular(8.r),
//                                 ),
//                                 child: Text(
//                                   'صورة الواجب',
//                                   style: TextStyle(
//                                     fontSize: 10.sp,
//                                     color: Colors.white,
//                                     fontFamily: 'Tajawal',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                     SizedBox(height: 24.h),
//
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Material(
//                             color: primaryColor,
//                             borderRadius: BorderRadius.circular(14.r),
//                             child: InkWell(
//                               onTap: _captureImage,
//                               borderRadius: BorderRadius.circular(14.r),
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 14.h,
//                                   horizontal: 16.w,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.camera_alt,
//                                       size: 18.w,
//                                       color: Colors.white,
//                                     ),
//                                     SizedBox(width: 8.w),
//                                     Text(
//                                       'التقط صورة',
//                                       style: TextStyle(
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                         fontFamily: 'Tajawal',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               onTap: _pickImageFromGallery,
//                               borderRadius: BorderRadius.circular(14.r),
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 14.h,
//                                   horizontal: 16.w,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: primaryColor,
//                                     width: 1.5,
//                                   ),
//                                   borderRadius: BorderRadius.circular(14.r),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.photo_library,
//                                       size: 18.w,
//                                       color: primaryColor,
//                                     ),
//                                     SizedBox(width: 8.w),
//                                     Text(
//                                       'المعرض',
//                                       style: TextStyle(
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.bold,
//                                         color: primaryColor,
//                                         fontFamily: 'Tajawal',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButton() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 400),
//         child: _selectedImage == null
//             ? Container()
//             : _isProcessing
//             ? ScaleTransition(
//           scale: _scaleAnimation,
//           child: Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(24.w),
//             decoration: BoxDecoration(
//               color: cardColor,
//               borderRadius: BorderRadius.circular(20.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 15.r,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 22.w,
//                       height: 22.h,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2.5,
//                         valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                       ),
//                     ),
//                     SizedBox(width: 16.w),
//                     Text(
//                       'جاري حل الواجب...',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: textPrimary,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12.h),
//                 Text(
//                   'قد تستغرق العملية بضع ثوانٍ',
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: textSecondary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//             : Material(
//           color: _hasSolution ? successColor : primaryColor,
//           borderRadius: BorderRadius.circular(16.r),
//           child: InkWell(
//             onTap: _solveHomework,
//             borderRadius: BorderRadius.circular(16.r),
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (_hasSolution ? successColor : primaryColor).withOpacity(0.3),
//                     blurRadius: 15.r,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     _hasSolution ? Icons.check_circle : Icons.auto_awesome,
//                     size: 22.w,
//                     color: Colors.white,
//                   ),
//                   SizedBox(width: 12.w),
//                   Text(
//                     _hasSolution ? 'تم حل الواجب بنجاح' : 'حل الواجب بالذكاء الاصطناعي',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSolutions() {
//     if (!_hasSolution || _solutions.isEmpty) return Container();
//
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, 0.3),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(
//           parent: _slideController,
//           curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
//         ),
//       ),
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Container(
//           margin: EdgeInsets.all(20.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(8.w),
//                       decoration: BoxDecoration(
//                         color: successColor.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.assignment_turned_in,
//                         color: successColor,
//                         size: 22.w,
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Text(
//                       'حلول الواجب',
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                         color: textPrimary,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               ..._solutions.asMap().entries.map((entry) {
//                 final index = entry.key;
//                 final solution = entry.value;
//                 return _buildSolutionCard(solution, index);
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSolutionCard(QuestionSolution solution, int index) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.h),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Theme(
//         data: ThemeData().copyWith(
//           dividerColor: Colors.transparent,
//         ),
//         child: ExpansionTile(
//           tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
//           leading: Container(
//             width: 36.w,
//             height: 36.h,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [primaryColor, primaryColor.withOpacity(0.8)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 '${index + 1}',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ),
//           ),
//           title: Text(
//             solution.question,
//             style: TextStyle(
//               fontSize: 15.sp,
//               fontWeight: FontWeight.w600,
//               color: textPrimary,
//               fontFamily: 'Tajawal',
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           children: [
//             Divider(
//               height: 1,
//               color: Colors.grey.shade200,
//             ),
//             Padding(
//               padding: EdgeInsets.all(20.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (solution.solution.isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.lightbulb_outline,
//                               color: primaryColor,
//                               size: 18.w,
//                             ),
//                             SizedBox(width: 8.w),
//                             Text(
//                               'الحل:',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: primaryColor,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 12.h),
//                         Container(
//                           padding: EdgeInsets.all(16.w),
//                           decoration: BoxDecoration(
//                             color: secondaryColor,
//                             borderRadius: BorderRadius.circular(12.r),
//                             border: Border.all(
//                               color: primaryColor.withOpacity(0.1),
//                             ),
//                           ),
//                           child: Text(
//                             solution.solution,
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: textPrimary,
//                               fontFamily: 'Tajawal',
//                               height: 1.6,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20.h),
//                       ],
//                     ),
//
//                   if (solution.explanation.isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.info_outline,
//                               color: successColor,
//                               size: 18.w,
//                             ),
//                             SizedBox(width: 8.w),
//                             Text(
//                               'الشرح:',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: successColor,
//                                 fontFamily: 'Tajawal',
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 12.h),
//                         Container(
//                           padding: EdgeInsets.all(16.w),
//                           decoration: BoxDecoration(
//                             color: successColor.withOpacity(0.05),
//                             borderRadius: BorderRadius.circular(12.r),
//                             border: Border.all(
//                               color: successColor.withOpacity(0.1),
//                             ),
//                           ),
//                           child: Text(
//                             solution.explanation,
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: textSecondary,
//                               fontFamily: 'Tajawal',
//                               height: 1.6,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorMessage() {
//     if (_errorMessage.isEmpty) return Container();
//
//     return SlideTransition(
//       position: _slideAnimation,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.red[50],
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border.all(color: Colors.red[200]!),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(8.w),
//               decoration: BoxDecoration(
//                 color: Colors.red[100],
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.error_outline,
//                 color: Colors.red[700],
//                 size: 18.w,
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'حدث خطأ',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red[700],
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     _errorMessage,
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: Colors.red[600],
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
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
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: secondaryColor,
//         body: SafeArea(
//           child: AnimatedBuilder(
//             animation: _fadeController,
//             builder: (context, child) {
//               return FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 20.h),
//                       _buildHeader(),
//                       _buildImageSection(),
//                       _buildActionButton(),
//                       _buildErrorMessage(),
//                       _buildSolutions(),
//                       SizedBox(height: 40.h),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class QuestionSolution {
//   final String question;
//   final String solution;
//   final String explanation;
//
//   QuestionSolution({
//     required this.question,
//     required this.solution,
//     required this.explanation,
//   });
// }
//
// class GeminiService {
//   static const String _apiKey = 'AIzaSyASShc1a3f3qrwr0Icnpb5Jzqo_-9tdMBw'; // استبدل بمفتاحك الحقيقي
//
//   static Future<String> solveHomework(File image) async {
//     try {
//       // تهيئة نموذج Gemini
//       final model = GenerativeModel(
//         model: 'gemini-2.0-flash',
//         apiKey: _apiKey,
//       );
//
//       // قراءة الصورة وتحويلها إلى bytes
//       final bytes = await image.readAsBytes();
//
//       // إنشاء المحتوى مع النص التعليمي والصورة
//       final content = [
//         Content.multi([
//           TextPart("""
// أنت مساعد تعليمي متخصص في حل الواجبات المدرسية. قم بتحليل الصورة التي تحتوي على واجب منزلي وأجب عن الأسئلة بطريقة تعليمية واضحة.
//
// التعليمات:
// 1. حلل كل سؤال على حدة
// 2. قدم الحلول خطوة بخطوة
// 3. اشرح المفاهيم الأساسية
// 4. تأكد من دقة الحلول الرياضية
// 5. استخدم أسلوباً تعليمياً واضحاً وسهلاً
// 6. رتب الإجابات حسب ترتيب الأسئلة في الصورة
// 7. استخدم اللغة العربية الفصحى
// 8. اذكر الخطوات التفصيلية لكل حل
//
// أعد الإجابة بتنسيق منظم مع شرح كل خطوة.
//           """),
//           DataPart('image/jpeg', bytes),
//         ])
//       ];
//
//       // إرسال الطلب والحصول على الرد
//       final response = await model.generateContent(content);
//
//       // التحقق من وجود رد
//       if (response.text != null) {
//         return response.text!;
//       } else {
//         throw Exception('لم يتم إرجاع أي رد من النموذج');
//       }
//     } catch (e) {
//       // معالجة الأخطاء بشكل أكثر تفصيلاً
//       if (e is GenerativeAIException) {
//         throw Exception('خطأ في الذكاء الاصطناعي: ${e.message}');
//       } else {
//         throw Exception('خطأ في الاتصال: $e');
//       }
//     }
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';

class HomeworkSolverScreen extends StatefulWidget {
  const HomeworkSolverScreen({Key? key}) : super(key: key);

  @override
  State<HomeworkSolverScreen> createState() => _HomeworkSolverScreenState();
}

class _HomeworkSolverScreenState extends State<HomeworkSolverScreen>
    with TickerProviderStateMixin {
  final Color primaryColor = const Color(0xFF1E88E5);
  final Color secondaryColor = const Color(0xFFF5F9FF);
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF2D3748);
  final Color textSecondary = const Color(0xFF718096);
  final Color successColor = const Color(0xFF4CAF50);
  final Color warningColor = const Color(0xFFFF9800);

  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isProcessing = false;
  bool _hasSolution = false;
  List<QuestionSolution> _solutions = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
      _scaleController.forward();
      _slideController.forward();
    });
  }

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _hasSolution = false;
          _solutions.clear();
          _errorMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ في التقاط الصورة: $e';
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _hasSolution = false;
          _solutions.clear();
          _errorMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ في اختيار الصورة: $e';
      });
    }
  }

  Future<void> _solveHomework() async {
    if (_selectedImage == null) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = '';
    });

    try {
      final solutionText = await OpenRouterService.solveHomework(_selectedImage!);
      _parseSolutions(solutionText);

      setState(() {
        _isProcessing = false;
        _hasSolution = true;
      });

    } catch (e) {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'خطأ في معالجة الواجب: $e';
      });
    }
  }

  void _parseSolutions(String responseText) {
    final List<QuestionSolution> solutions = [];

    print("الرد الخام من النموذج: $responseText");

    try {
      // طريقة محسنة جداً لتحليل الرد
      solutions.addAll(_parseWithEnhancedMethod(responseText));

      // إذا لم نجد حلول، نجرب الطرق البديلة
      if (solutions.isEmpty) {
        solutions.addAll(_parseWithSectionMethod(responseText));
      }

      // إذا استمر عدم وجود حلول، نستخدم الرد كاملاً
      if (solutions.isEmpty) {
        solutions.add(QuestionSolution(
          question: 'تحليل الواجب',
          solution: responseText,
          explanation: 'تم تحليل محتوى الواجب بنجاح',
        ));
      }

    } catch (e) {
      print('خطأ في التحليل: $e');
      solutions.add(QuestionSolution(
        question: 'حل الواجب',
        solution: responseText,
        explanation: 'تم معالجة الواجب بنجاح',
      ));
    }

    setState(() => _solutions = solutions);
  }

  List<QuestionSolution> _parseWithEnhancedMethod(String text) {
    final List<QuestionSolution> solutions = [];

    // regex محسن للتعرف على التنسيق المنظم
    final pattern = RegExp(
      r'(?:سؤال|Question)[\s:\-]*([^\n]*)(?:\n\s*)?(?:الحل|Solution)[\s:\-]*([\s\S]*?)(?=(?:\n\s*)?(?:شرح|Explanation)[\s:\-]*([\s\S]*?)(?=(?:\n\s*)?(?:سؤال|Question|$))|(?:\n\s*)?(?:سؤال|Question|$))',
      caseSensitive: false,
    );

    final matches = pattern.allMatches(text);

    for (final match in matches) {
      if (match.groupCount >= 1) {
        String question = match.group(1)?.trim() ?? 'سؤال';
        String solution = match.group(2)?.trim() ?? '';
        String explanation = match.group(3)?.trim() ?? '';

        // تنظيف النصوص
        question = _cleanText(question, ['سؤال', 'Question', ':']);
        solution = _cleanText(solution, ['الحل', 'Solution', ':']);
        explanation = _cleanText(explanation, ['شرح', 'Explanation', ':']);

        if (question.isNotEmpty || solution.isNotEmpty) {
          solutions.add(QuestionSolution(
            question: question.isNotEmpty ? question : 'سؤال ${solutions.length + 1}',
            solution: solution,
            explanation: explanation,
          ));
        }
      }
    }

    return solutions;
  }

  List<QuestionSolution> _parseWithSectionMethod(String text) {
    final List<QuestionSolution> solutions = [];

    // تقسيم النص إلى أقسام بناءً على العناوين الرئيسية
    final sections = text.split(RegExp(r'\n\s*\n'));
    int questionCount = 0;

    for (final section in sections) {
      if (section.trim().isEmpty) continue;

      final lines = section.split('\n');
      String currentQuestion = '';
      String currentSolution = '';
      String currentExplanation = '';
      String currentSection = 'question';

      for (final line in lines) {
        final trimmedLine = line.trim();
        if (trimmedLine.isEmpty) continue;

        // اكتشاف نوع المحتوى
        if (trimmedLine.contains(RegExp(r'^(سؤال|Question|السؤال|Problem|المسألة)'))) {
          currentSection = 'question';
          if (currentQuestion.isNotEmpty && (currentSolution.isNotEmpty || currentExplanation.isNotEmpty)) {
            solutions.add(QuestionSolution(
              question: _cleanText(currentQuestion, ['سؤال', 'Question']),
              solution: currentSolution,
              explanation: currentExplanation,
            ));
            currentQuestion = '';
            currentSolution = '';
            currentExplanation = '';
          }
          currentQuestion = trimmedLine;
        }
        else if (trimmedLine.contains(RegExp(r'^(الحل|Solution|الإجابة|Answer)'))) {
          currentSection = 'solution';
        }
        else if (trimmedLine.contains(RegExp(r'^(شرح|Explanation|توضيح|ملاحظة)'))) {
          currentSection = 'explanation';
        }
        else {
          // إضافة المحتوى للقسم الحالي
          switch (currentSection) {
            case 'question':
              if (currentQuestion.isEmpty) {
                currentQuestion = trimmedLine;
              } else {
                currentQuestion += '\n$trimmedLine';
              }
              break;
            case 'solution':
              currentSolution += '$trimmedLine\n';
              break;
            case 'explanation':
              currentExplanation += '$trimmedLine\n';
              break;
          }
        }
      }

      // إضافة القسم الأخير
      if (currentQuestion.isNotEmpty) {
        solutions.add(QuestionSolution(
          question: _cleanText(currentQuestion, ['سؤال', 'Question']),
          solution: currentSolution.trim(),
          explanation: currentExplanation.trim(),
        ));
      } else if (section.trim().isNotEmpty) {
        // إذا لم يكن هناك سؤال واضح، نعتبر النص كله حلاً
        questionCount++;
        solutions.add(QuestionSolution(
          question: 'سؤال $questionCount',
          solution: section.trim(),
          explanation: 'تم تحليل السؤال وإيجاد الحل المناسب',
        ));
      }
    }

    return solutions;
  }

  String _cleanText(String text, List<String> prefixes) {
    String cleaned = text;
    for (final prefix in prefixes) {
      cleaned = cleaned.replaceAll(RegExp('^$prefix[\\s:\\-]*', caseSensitive: false), '');
    }
    return cleaned.trim();
  }

  void _clearAll() {
    setState(() {
      _selectedImage = null;
      _hasSolution = false;
      _solutions.clear();
      _errorMessage = '';
    });
  }

  Widget _buildHeader() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 15.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 40.w,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'حل الواجبات بالذكاء الاصطناعي',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                  fontFamily: 'Tajawal',
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'التقط صورة للواجب واحصل على الحل فوراً\nباستخدام أحدث تقنيات الذكاء الاصطناعي',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: textSecondary,
                  fontFamily: 'Tajawal',
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20.r,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.shade100,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.photo_library,
                              color: primaryColor,
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'صورة الواجب',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        if (_selectedImage != null)
                          InkWell(
                            onTap: _clearAll,
                            borderRadius: BorderRadius.circular(8.r),
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 16.w,
                                color: textSecondary,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    if (_selectedImage == null)
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                          color: secondaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 32.w,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'لم يتم اختيار صورة',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                'قم باختيار صورة الواجب من الكاميرا أو المعرض لبدء التحليل',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: textSecondary.withOpacity(0.7),
                                  fontFamily: 'Tajawal',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        height: 260.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: secondaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8.r,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.file(
                                _selectedImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: Icon(
                                      Icons.error_outline,
                                      color: Colors.grey.shade400,
                                      size: 50.w,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 8.w,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  'صورة الواجب',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.white,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 24.h),

                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(14.r),
                            child: InkWell(
                              onTap: _captureImage,
                              borderRadius: BorderRadius.circular(14.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                  horizontal: 16.w,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 18.w,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'التقط صورة',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Tajawal',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _pickImageFromGallery,
                              borderRadius: BorderRadius.circular(14.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.photo_library,
                                      size: 18.w,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'المعرض',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontFamily: 'Tajawal',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildActionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _selectedImage == null
            ? Container()
            : _isProcessing
            ? ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15.r,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 22.w,
                      height: 22.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'جاري حل الواجب...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'قد تستغرق العملية بضع ثوانٍ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: textSecondary,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        )
            : Material(
          color: _hasSolution ? successColor : primaryColor,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            onTap: _solveHomework,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: (_hasSolution ? successColor : primaryColor).withOpacity(0.3),
                    blurRadius: 15.r,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _hasSolution ? Icons.check_circle : Icons.auto_awesome,
                    size: 22.w,
                    color: Colors.white,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    _hasSolution ? 'تم حل الواجب بنجاح' : 'حل الواجب بالذكاء الاصطناعي',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSolutions() {
    if (!_hasSolution) return Container();

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: successColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.assignment_turned_in,
                        color: successColor,
                        size: 22.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'حلول الواجب',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${_solutions.length}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              if (_solutions.isEmpty)
                _buildNoSolutionsFound()
              else
                ..._solutions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final solution = entry.value;
                  return _buildSolutionCard(solution, index);
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoSolutionsFound() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 50.w,
            color: textSecondary.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'لم يتم العثور على أسئلة منظمة',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'قد تحتوي الصورة على نص غير منظم أو قد تحتاج إلى تحسين جودة الصورة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: textSecondary,
              fontFamily: 'Tajawal',

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionCard(QuestionSolution solution, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          leading: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
          ),
          title: Text(
            solution.question.isNotEmpty ? solution.question : 'سؤال ${index + 1}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
              fontFamily: 'Tajawal',
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عرض الحل
                  if (solution.solution.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: primaryColor,
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'الحل:',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.1),
                            ),
                          ),
                          child: Text(
                            solution.solution,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: textPrimary,
                              fontFamily: 'Tajawal',
                              height: 1.6,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.orange[100]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Colors.orange[600], size: 18.w),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'لا يوجد حل مفصل متوفر',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.orange[700],
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // عرض الشرح
                  if (solution.explanation.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: successColor,
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'الشرح:',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: successColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: successColor.withOpacity(0.1),
                            ),
                          ),
                          child: Text(
                            solution.explanation,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: textSecondary,
                              fontFamily: 'Tajawal',
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    if (_errorMessage.isEmpty) return Container();

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                color: Colors.red[700],
                size: 18.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'حدث خطأ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _errorMessage,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red[600],
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      _buildHeader(),
                      _buildImageSection(),
                      _buildActionButton(),
                      _buildErrorMessage(),
                      _buildSolutions(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class QuestionSolution {
  final String question;
  final String solution;
  final String explanation;

  QuestionSolution({
    required this.question,
    required this.solution,
    required this.explanation,
  });
}

class OpenRouterService {
  static const String _apiKey = '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';
  static const String _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';

  static Future<String> solveHomework(File image) async {
    try {
      // تحويل الصورة إلى base64
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      final mimeType = 'image/jpeg';

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
          'HTTP-Referer': 'https://your-app-domain.com', // Required by OpenRouter
          'X-Title': 'Homework Solver App', // Optional but recommended
        },
        body: jsonEncode({
          "model": "x-ai/grok-4.1-fast:free", // أو أي نموذج آخر متوفر
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text": """
أنت مساعد تعليمي متخصص في حل الواجبات المدرسية. قم بتحليل الصورة التي تحتوي على واجب منزلي وأجب عن الأسئلة بطريقة تعليمية واضحة.

التعليمات المهمة:
1. حلل كل سؤال على حدة
2. قدم الحلول خطوة بخطوة
3. اشرح المفاهيم الأساسية
4. تأكد من دقة الحلول الرياضية
5. استخدم أسلوباً تعليمياً واضحاً
6. رتب الإجابات حسب ترتيب الأسئلة
7. استخدم اللغة العربية الفصحى
8. اذكر الخطوات التفصيلية لكل حل

أعد الإجابة باستخدام هذا التنسيق بالضبط لكل سؤال:

سؤال: [نص السؤال هنا]
الحل: [الحل التفصيلي خطوة بخطوة هنا]
شرح: [الشرح والتوضيح هنا]

إذا كان هناك أكثر من سؤال، كرر هذا التنسيق لكل سؤال.
                  """
                },
                {
                  "type": "image_url",
                  "image_url": {
                    "url": "data:$mimeType;base64,$base64Image"
                  }
                }
              ]
            }
          ],
          "max_tokens": 4096,
          "temperature": 0.3,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        return content ?? 'لم يتم إرجاع أي رد من النموذج';
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error']['message'] ?? 'خطأ غير معروف';
        throw Exception('فشل في تحميل الحل: ${response.statusCode} - $errorMessage');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io';
// import 'dart:convert';
//
// class HomeworkSolverScreen extends StatefulWidget {
//   const HomeworkSolverScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeworkSolverScreen> createState() => _HomeworkSolverScreenState();
// }
//
// class _HomeworkSolverScreenState extends State<HomeworkSolverScreen> {
//   // ✅ الألوان المحدثة المتناسقة مع التصميم
//   final Color _primaryBlue = const Color(0xFF1E88E5);
//   final Color _secondaryColor = const Color(0xFFF5F9FF);
//   final Color _cardColor = Colors.white;
//   final Color _textPrimary = const Color(0xFF2D3748);
//   final Color _textSecondary = const Color(0xFF718096);
//   final Color _accentColor = const Color(0xFFFFA726);
//
//   final ImagePicker _imagePicker = ImagePicker();
//   File? _selectedImage;
//   bool _isProcessing = false;
//   bool _hasSolution = false;
//   String _solutionText = '';
//   String _errorMessage = '';
//
//   // ✅ مفتاح API الحقيقي من Google AI Studio
//   static const String _apiKey = 'AIzaSyAB7gcV6_BmdCBQ5X_8PIE7t6l-ytQrxvQ';
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: _secondaryColor,
//         body: SafeArea(
//           child: Column(
//             children: [
//               // ✅ الهيدر العلوي
//               _buildAppBar(),
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                   child: Column(
//                     children: [
//                       // ✅ البانر الرئيسي
//                       _buildMainBanner(),
//                       SizedBox(height: 24.h),
//
//                       // ✅ قسم التقاط الصورة
//                       _buildImageSection(),
//                       SizedBox(height: 20.h),
//
//                       // ✅ زر الحل
//                       if (_selectedImage != null && !_hasSolution)
//                         _buildSolveButton(),
//
//                       // ✅ رسالة الخطأ
//                       if (_errorMessage.isNotEmpty)
//                         _buildErrorMessage(),
//
//                       // ✅ عرض الحل
//                       if (_hasSolution)
//                         _buildSolutionSection(),
//
//                       SizedBox(height: 40.h),
//                     ],
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
//   Widget _buildAppBar() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: _primaryBlue,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8.r,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // ✅ زر العودة (اختياري)
//           Container(
//             width: 40.w,
//             height: 40.h,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.arrow_back_ios_new,
//               color: Colors.white,
//               size: 20.sp,
//             ),
//           ),
//
//           Text(
//             'المعلم الذكي',
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//
//           // ✅ أيقونة للحفاظ على التوازن
//           Container(
//             width: 40.w,
//             height: 40.h,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.help_outline,
//               color: Colors.white,
//               size: 20.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMainBanner() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: _cardColor,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 50.w,
//                 height: 50.h,
//                 decoration: BoxDecoration(
//                   color: _primaryBlue.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.auto_awesome,
//                   color: _primaryBlue,
//                   size: 28.sp,
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'المعلم الذكي',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                         color: _textPrimary,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       'حل واجباتك في ثوانٍ',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: _textSecondary,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             'صور سؤالك\nقم بتصوير الواجب المنزلي وسيقوم المعلم الذكي بحله وشرحه لك',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: _textPrimary,
//               fontFamily: 'Tajawal',
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildImageSection() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: _cardColor,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // ✅ عنوان القسم
//           Row(
//             children: [
//               Icon(
//                 Icons.camera_alt_rounded,
//                 color: _primaryBlue,
//                 size: 24.sp,
//               ),
//               SizedBox(width: 8.w),
//               Text(
//                 'التقاط صورة',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: _textPrimary,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//
//           // ✅ منطقة عرض الصورة
//           Container(
//             width: double.infinity,
//             height: 200.h,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: _selectedImage != null ? Colors.transparent : Colors.grey.shade300,
//                 width: 2,
//               ),
//               borderRadius: BorderRadius.circular(12.r),
//               color: _selectedImage != null ? Colors.transparent : _secondaryColor,
//             ),
//             child: _selectedImage != null
//                 ? ClipRRect(
//               borderRadius: BorderRadius.circular(12.r),
//               child: Image.file(
//                 _selectedImage!,
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             )
//                 : Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.photo_camera_back_rounded,
//                   size: 50.sp,
//                   color: _textSecondary.withOpacity(0.5),
//                 ),
//                 SizedBox(height: 12.h),
//                 Text(
//                   'لم يتم اختيار صورة',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: _textSecondary,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20.h),
//
//           // ✅ أزرار التقاط الصورة
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton.icon(
//                   onPressed: _captureImage,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _primaryBlue,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
//                     elevation: 2,
//                   ),
//                   icon: Icon(Icons.camera_alt, size: 20.sp),
//                   label: Text(
//                     'التقط صورة',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed: _pickImageFromGallery,
//                   style: OutlinedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
//                     side: BorderSide(color: _primaryBlue),
//                   ),
//                   icon: Icon(Icons.photo_library_rounded, size: 20.sp, color: _primaryBlue),
//                   label: Text(
//                     'المعرض',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: _primaryBlue,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           // ✅ زر مسح الصورة إذا كانت موجودة
//           if (_selectedImage != null)
//             Padding(
//               padding: EdgeInsets.only(top: 12.h),
//               child: OutlinedButton(
//                 onPressed: _clearImage,
//                 style: OutlinedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
//                   side: BorderSide(color: Colors.red),
//                 ),
//                 child: Text(
//                   'مسح الصورة',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.red,
//                     fontFamily: 'Tajawal',
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSolveButton() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: _isProcessing
//           ? Container(
//         padding: EdgeInsets.all(20.w),
//         decoration: BoxDecoration(
//           color: _cardColor,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10.r,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 24.w,
//               height: 24.h,
//               child: CircularProgressIndicator(
//                 strokeWidth: 3,
//                 valueColor: AlwaysStoppedAnimation<Color>(_primaryBlue),
//               ),
//             ),
//             SizedBox(width: 16.w),
//             Text(
//               'جاري حل الواجب...',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: _textPrimary,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       )
//           : ElevatedButton(
//         onPressed: _solveHomework,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _primaryBlue,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
//           elevation: 4,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.auto_awesome_rounded, size: 22.sp),
//             SizedBox(width: 8.w),
//             Text(
//               'حل الواجب بالذكاء الاصطناعي',
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
//   Widget _buildErrorMessage() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 20.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.red[50],
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.red[200]!),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.error_outline_rounded, color: Colors.red, size: 24.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Text(
//               _errorMessage,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.red[700],
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSolutionSection() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: _cardColor,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10.r,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ✅ عنوان قسم الحل
//           Row(
//             children: [
//               Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   color: Color(0xFF4CAF50).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.check_circle_rounded,
//                   color: Color(0xFF4CAF50),
//                   size: 24.sp,
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Text(
//                 'تم حل الواجب بنجاح',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: _textPrimary,
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//
//           // ✅ محتوى الحل
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: _secondaryColor,
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(color: Colors.grey.shade200),
//             ),
//             child: Text(
//               _solutionText.isNotEmpty ? _solutionText : 'جاري تحميل الحل...',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: _textPrimary,
//                 fontFamily: 'Tajawal',
//                 height: 1.6,
//               ),
//             ),
//           ),
//           SizedBox(height: 16.h),
//
//           // ✅ أزرار إضافية
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed: _shareSolution,
//                   style: OutlinedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 12.h),
//                     side: BorderSide(color: _primaryBlue),
//                   ),
//                   icon: Icon(Icons.share_rounded, size: 18.sp, color: _primaryBlue),
//                   label: Text(
//                     'مشاركة',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: _primaryBlue,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed: _clearAll,
//                   style: OutlinedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 12.h),
//                     side: BorderSide(color: Colors.grey),
//                   ),
//                   icon: Icon(Icons.refresh_rounded, size: 18.sp, color: Colors.grey),
//                   label: Text(
//                     'حل جديد',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.grey,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _captureImage() async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         maxWidth: 1200,
//         maxHeight: 1200,
//         imageQuality: 85,
//       );
//
//       if (image != null) {
//         setState(() {
//           _selectedImage = File(image.path);
//           _hasSolution = false;
//           _solutionText = '';
//           _errorMessage = '';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'خطأ في التقاط الصورة: $e';
//       });
//     }
//   }
//
//   Future<void> _pickImageFromGallery() async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1200,
//         maxHeight: 1200,
//         imageQuality: 85,
//       );
//
//       if (image != null) {
//         setState(() {
//           _selectedImage = File(image.path);
//           _hasSolution = false;
//           _solutionText = '';
//           _errorMessage = '';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'خطأ في اختيار الصورة: $e';
//       });
//     }
//   }
//
//   Future<void> _solveHomework() async {
//     if (_selectedImage == null) return;
//
//     setState(() {
//       _isProcessing = true;
//       _errorMessage = '';
//     });
//
//     try {
//       final solution = await GeminiService.solveHomework(_selectedImage!);
//
//       setState(() {
//         _solutionText = solution;
//         _isProcessing = false;
//         _hasSolution = true;
//       });
//
//     } catch (e) {
//       setState(() {
//         _isProcessing = false;
//         _errorMessage = 'خطأ في معالجة الواجب: $e';
//       });
//     }
//   }
//
//   void _clearImage() {
//     setState(() {
//       _selectedImage = null;
//       _hasSolution = false;
//       _solutionText = '';
//       _errorMessage = '';
//     });
//   }
//
//   void _clearAll() {
//     setState(() {
//       _selectedImage = null;
//       _hasSolution = false;
//       _solutionText = '';
//       _errorMessage = '';
//       _isProcessing = false;
//     });
//   }
//
//   void _shareSolution() {
//     // ✅ يمكن إضافة منطق المشاركة هنا
//     // مثلاً: مشاركة النص أو حفظ الصورة مع الحل
//   }
// }
//
// class GeminiService {
//   static const String _apiKey = 'AIzaSyAB7gcV6_BmdCBQ5X_8PIE7t6l-ytQrxvQ';
//   static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent';
//
//   static Future<String> solveHomework(File image) async {
//     try {
//       final bytes = await image.readAsBytes();
//       final base64Image = base64Encode(bytes);
//
//       final response = await http.post(
//         Uri.parse('$_baseUrl?key=$_apiKey'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "contents": [
//             {
//               "parts": [
//                 {
//                   "text": "أنت معلم ذكي متخصص في حل الواجبات المدرسية. قم بتحليل الصورة التي تحتوي على واجب منزلي وأجب عن الأسئلة بطريقة تعليمية واضحة ومفهومة.\n\nالتعليمات:\n1. حلل كل سؤال على حدة\n2. قدم الحلول خطوة بخطوة\n3. اشرح المفاهيم الأساسية\n4. تأكد من دقة الحلول\n5. استخدم أسلوباً تعليمياً واضحاً\n6. استخدم اللغة العربية الفصحى\n7. رتب الإجابات حسب ترتيب الأسئلة\n8. اذكر الخطوات التفصيلية لكل حل\n\nأعد الإجابة بطريقة منظمة وواضحة مع التركيز على الشرح التعليمي."
//                 },
//                 {
//                   "inline_data": {
//                     "mime_type": "image/jpeg",
//                     "data": base64Image
//                   }
//                 }
//               ]
//             }
//           ],
//           "generationConfig": {
//             "temperature": 0.3,
//             "topK": 32,
//             "topP": 1,
//             "maxOutputTokens": 2048,
//           }
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final text = data['candidates'][0]['content']['parts'][0]['text'];
//         return text;
//       } else {
//         throw Exception('فشل في تحميل الحل: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('خطأ في الاتصال: $e');
//     }
//   }
// }