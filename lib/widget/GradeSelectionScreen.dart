// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class GradeSelectionScreen extends StatefulWidget {
//   @override
//   _GradeSelectionScreenState createState() => _GradeSelectionScreenState();
// }
//
// class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
//   String? _selectedGrade;
//   final List<String> _grades = [
//     'الصف الأول الابتدائي',
//     'الصف الثاني الابتدائي',
//     'الصف الثالث الابتدائي',
//     'الصف الرابع الابتدائي',
//     'الصف الخامس الابتدائي',
//     'الصف السادس الابتدائي',
//   ];
//
//   void _continueToLessons() {
//     if (_selectedGrade == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'يرجى اختيار الصف الدراسي',
//             style: TextStyle(fontFamily: 'Tajawal'),
//           ),
//           backgroundColor: Color(0xFFFFA726),
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.w),
//           ),
//         ),
//       );
//       return;
//     }
//
//     // الانتقال إلى شاشة الدروس
//     // Navigator.pushReplacement(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => LessonsListScreen()),
//     // );
//
//     // مؤقتاً عرض رسالة نجاح
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'تم اختيار $_selectedGrade بنجاح!',
//           style: TextStyle(fontFamily: 'Tajawal'),
//         ),
//         backgroundColor: Color(0xFF1E88E5),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.w),
//         ),
//       ),
//     );
//   }
//
//   void _backToPrevious() {
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1E88E5),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height -
//                 MediaQuery.of(context).padding.top,
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // زر العودة
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_forward, color: Colors.white),
//                       onPressed: _backToPrevious,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 30.h),
//
//                 // أيقونة اختيار الصف
//                 Container(
//                   width: 120.w,
//                   height: 120.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.15),
//                         blurRadius: 20.w,
//                         offset: Offset(0, 8.h),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.school,
//                     color: Color(0xFF1E88E5),
//                     size: 60.sp,
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // العنوان
//                 Text(
//                   'اختيار الصف الدراسي',
//                   style: TextStyle(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 8.h),
//
//                 // الوصف
//                 Text(
//                   'اختر الصف المناسب لك لبدء رحلة التعلم',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.white.withOpacity(0.9),
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 50.h),
//
//                 // شبكة اختيار الصفوف
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20.w),
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16.w,
//                       mainAxisSpacing: 16.h,
//                       childAspectRatio: 1.2,
//                     ),
//                     itemCount: _grades.length,
//                     itemBuilder: (context, index) {
//                       final grade = _grades[index];
//                       final isSelected = _selectedGrade == grade;
//
//                       return _buildGradeCard(
//                         grade: grade,
//                         isSelected: isSelected,
//                         onTap: () {
//                           setState(() {
//                             _selectedGrade = grade;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // زر المتابعة
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: ElevatedButton(
//                     onPressed: _continueToLessons,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFFA726),
//                       foregroundColor: Colors.black,
//                       padding: EdgeInsets.symmetric(vertical: 18.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.w),
//                       ),
//                       elevation: 6,
//                       shadowColor: Colors.black.withOpacity(0.3),
//                     ),
//                     child: Text(
//                       'المتابعة إلى الدروس',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGradeCard({
//     required String grade,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xFFFFA726) : Colors.white,
//           borderRadius: BorderRadius.circular(20.w),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(isSelected ? 0.3 : 0.1),
//               blurRadius: 15.w,
//               offset: Offset(0, 5.h),
//             ),
//           ],
//           border: isSelected
//               ? Border.all(
//             color: Colors.white,
//             width: 3.w,
//           )
//               : null,
//         ),
//         child: Stack(
//           children: [
//             // المحتوى الرئيسي
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // رقم الصف
//                   Container(
//                     width: 50.w,
//                     height: 50.h,
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.white : Color(0xFF1E88E5),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                       child: Text(
//                         '${_grades.indexOf(grade) + 1}',
//                         style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                           color: isSelected ? Color(0xFFFFA726) : Colors.white,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 12.h),
//
//                   // اسم الصف
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.w),
//                     child: Text(
//                       grade,
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.bold,
//                         color: isSelected ? Colors.black : Color(0xFF1E88E5),
//                         fontFamily: 'Tajawal',
//                       ),
//                       textAlign: TextAlign.center,
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // أيقونة التأكيد عند الاختيار
//             if (isSelected)
//               Positioned(
//                 top: 8.w,
//                 right: 8.w,
//                 child: Container(
//                   width: 24.w,
//                   height: 24.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.check,
//                     color: Color(0xFFFFA726),
//                     size: 16.sp,
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
//
// class GradeSelectionScreen extends StatefulWidget {
//   @override
//   _GradeSelectionScreenState createState() => _GradeSelectionScreenState();
// }
//
// class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
//   String? _selectedGrade;
//   final List<String> _grades = [
//     'الصف الأول الابتدائي',
//     'الصف الثاني الابتدائي',
//     'الصف الثالث الابتدائي',
//     'الصف الرابع الابتدائي',
//     'الصف الخامس الابتدائي',
//     'الصف السادس الابتدائي',
//   ];
//
//   void _continueToLessons() {
//     if (_selectedGrade == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'يرجى اختيار الصف الدراسي',
//             style: TextStyle(fontFamily: 'Tajawal'),
//           ),
//           backgroundColor: Color(0xFFFFA726),
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.w),
//           ),
//         ),
//       );
//       return;
//     }
//
//     // مؤقتاً عرض رسالة نجاح
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'تم اختيار $_selectedGrade بنجاح!',
//           style: TextStyle(fontFamily: 'Tajawal'),
//         ),
//         backgroundColor: Color(0xFF1E88E5),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.w),
//         ),
//       ),
//     );
//   }
//
//   void _backToPrevious() {
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1E88E5),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height -
//                 MediaQuery.of(context).padding.top,
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // زر العودة في أعلى اليسار
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: _backToPrevious,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // أيقونة اختيار الصف
//                 Container(
//                   width: 120.w,
//                   height: 120.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.15),
//                         blurRadius: 20.w,
//                         offset: Offset(0, 8.h),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.school,
//                     color: Color(0xFF1E88E5),
//                     size: 60.sp,
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // العنوان
//                 Text(
//                   'اختيار الصف الدراسي',
//                   style: TextStyle(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 12.h),
//
//                 // الوصف
//                 Text(
//                   'اختر الصف المناسب لك لبدء رحلة التعلم',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.white.withOpacity(0.9),
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 60.h),
//
//                 // حقل اختيار الصف
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'الصف الدراسي',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 12.h),
//
//                       // Dropdown مع عرض العنصر المختار
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16.w),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10.w,
//                               offset: Offset(0, 4.h),
//                             ),
//                           ],
//                         ),
//                         child: DropdownButtonFormField<String>(
//                           value: _selectedGrade,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _selectedGrade = newValue;
//                             });
//                           },
//                           items: _grades.map((String grade) {
//                             return DropdownMenuItem<String>(
//                               value: grade,
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                                 child: Text(
//                                   grade,
//                                   style: TextStyle(
//                                     fontSize: 16.sp,
//                                     color: Colors.black,
//                                     fontFamily: 'Tajawal',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                           decoration: InputDecoration(
//                             // النص الافتراضي يظهر فقط عندما لا يكون هناك اختيار
//                             hintText: _selectedGrade == null ? 'اختر الصف الدراسي' : null,
//                             hintStyle: TextStyle(
//                               fontSize: 16.sp,
//                               color: Colors.grey[600],
//                               fontFamily: 'Tajawal',
//                               fontWeight: FontWeight.w500,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16.w),
//                               borderSide: BorderSide.none,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16.w),
//                               borderSide: BorderSide.none,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16.w),
//                               borderSide: BorderSide(
//                                 color: Color(0xFFFFA726),
//                                 width: 2.w,
//                               ),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: EdgeInsets.symmetric(
//                               horizontal: 20.w,
//                               vertical: 4.h,
//                             ),
//                           ),
//                           // عندما يكون هناك اختيار، يظهر النص المختار داخل الـ Dropdown
//                           selectedItemBuilder: (BuildContext context) {
//                             return _grades.map<Widget>((String grade) {
//                               return Container(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                   _selectedGrade ?? 'اختر الصف الدراسي',
//                                   style: TextStyle(
//                                     fontSize: 16.sp,
//                                     color: _selectedGrade == null ? Colors.grey[600] : Colors.black,
//                                     fontFamily: 'Tajawal',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               );
//                             }).toList();
//                           },
//                           icon: Icon(
//                             Icons.arrow_drop_down,
//                             color: Color(0xFF1E88E5),
//                             size: 28.sp,
//                           ),
//                           dropdownColor: Colors.white,
//                           borderRadius: BorderRadius.circular(16.w),
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: Colors.black,
//                             fontFamily: 'Tajawal',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 80.h),
//
//                 // زر التالي
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: ElevatedButton(
//                     onPressed: _continueToLessons,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFFA726),
//                       foregroundColor: Colors.black,
//                       padding: EdgeInsets.symmetric(vertical: 18.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16.w),
//                       ),
//                       elevation: 8,
//                       shadowColor: Colors.black.withOpacity(0.4),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'التالي',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(width: 8.w),
//                         Icon(
//                           Icons.arrow_forward,
//                           size: 20.sp,
//                           color: Colors.black,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'NavigationBar.dart';
//
// class GradeSelectionScreen extends StatefulWidget {
//   @override
//   _GradeSelectionScreenState createState() => _GradeSelectionScreenState();
// }
//
// class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
//   String? _selectedGrade;
//   final List<String> _grades = [
//     'الصف الأول الابتدائي',
//     'الصف الثاني الابتدائي',
//     'الصف الثالث الابتدائي',
//     'الصف الرابع الابتدائي',
//     'الصف الخامس الابتدائي',
//     'الصف السادس الابتدائي',
//   ];
//
//   void _continueToLessons() {
//     if (_selectedGrade == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'يرجى اختيار الصف الدراسي',
//             style: TextStyle(fontFamily: 'Tajawal'),
//           ),
//           backgroundColor: Color(0xFFFFA726),
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.w),
//           ),
//         ),
//       );
//       return;
//     }
//
//     // الانتقال إلى صفحة Home
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => CustomBottomNav()),
//     );
//   }
//
//   void _backToPrevious() {
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1E88E5),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height -
//                 MediaQuery.of(context).padding.top,
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // زر العودة في أعلى اليسار
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: _backToPrevious,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // أيقونة اختيار الصف
//                 Container(
//                   width: 120.w,
//                   height: 120.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.15),
//                         blurRadius: 20.w,
//                         offset: Offset(0, 8.h),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.school,
//                     color: Color(0xFF1E88E5),
//                     size: 60.sp,
//                   ),
//                 ),
//
//                 SizedBox(height: 40.h),
//
//                 // العنوان
//                 Text(
//                   'اختيار الصف الدراسي',
//                   style: TextStyle(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 12.h),
//
//                 // الوصف
//                 Text(
//                   'اختر الصف المناسب لك لبدء رحلة التعلم',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.white.withOpacity(0.9),
//                     fontFamily: 'Tajawal',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 SizedBox(height: 60.h),
//
//                 // حقل اختيار الصف
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'الصف الدراسي',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           color: Colors.white,
//                           fontFamily: 'Tajawal',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 12.h),
//
//                       // Dropdown مع عرض العنصر المختار
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16.w),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10.w,
//                               offset: Offset(0, 4.h),
//                             ),
//                           ],
//                         ),
//                         child: DropdownButtonFormField<String>(
//                           value: _selectedGrade,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _selectedGrade = newValue;
//                             });
//                           },
//                           items: _grades.map((String grade) {
//                             return DropdownMenuItem<String>(
//                               value: grade,
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                                 child: Text(
//                                   grade,
//                                   style: TextStyle(
//                                     fontSize: 16.sp,
//                                     color: Colors.black,
//                                     fontFamily: 'Tajawal',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                           decoration: InputDecoration(
//                             hintText: _selectedGrade == null ? 'اختر الصف الدراسي' : null,
//                             hintStyle: TextStyle(
//                               fontSize: 16.sp,
//                               color: Colors.grey[600],
//                               fontFamily: 'Tajawal',
//                               fontWeight: FontWeight.w500,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16.w),
//                               borderSide: BorderSide.none,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16.w),
//                               borderSide: BorderSide.none,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16.w),
//                               borderSide: BorderSide(
//                                 color: Color(0xFFFFA726),
//                                 width: 2.w,
//                               ),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: EdgeInsets.symmetric(
//                               horizontal: 20.w,
//                               vertical: 4.h,
//                             ),
//                           ),
//                           selectedItemBuilder: (BuildContext context) {
//                             return _grades.map<Widget>((String grade) {
//                               return Container(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                   _selectedGrade ?? 'اختر الصف الدراسي',
//                                   style: TextStyle(
//                                     fontSize: 16.sp,
//                                     color: _selectedGrade == null ? Colors.grey[600] : Colors.black,
//                                     fontFamily: 'Tajawal',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               );
//                             }).toList();
//                           },
//                           icon: Icon(
//                             Icons.arrow_drop_down,
//                             color: Color(0xFF1E88E5),
//                             size: 28.sp,
//                           ),
//                           dropdownColor: Colors.white,
//                           borderRadius: BorderRadius.circular(16.w),
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: Colors.black,
//                             fontFamily: 'Tajawal',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 80.h),
//
//                 // زر التالي
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 30.w),
//                   child: ElevatedButton(
//                     onPressed: _continueToLessons,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFFA726),
//                       foregroundColor: Colors.black,
//                       padding: EdgeInsets.symmetric(vertical: 18.h),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16.w),
//                       ),
//                       elevation: 8,
//                       shadowColor: Colors.black.withOpacity(0.4),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'التالي',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                           ),
//                         ),
//                         SizedBox(width: 8.w),
//                         Icon(
//                           Icons.arrow_forward,
//                           size: 20.sp,
//                           color: Colors.black,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'NavigationBar.dart';

class GradeSelectionDialog {
  static void show({
    required BuildContext context,
    required Function(String) onGradeSelected,
  }) {
    showGeneralDialog(
      context: context,
      barrierColor: Color(0xFF1E88E5).withOpacity(0.7), // أزرق متلاشي
      barrierDismissible: false,
      barrierLabel: "اختيار الصف",
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _GradeSelectionDialogContent(
          onGradeSelected: onGradeSelected,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.8,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutBack,
            )),
            child: child,
          ),
        );
      },
    );
  }
}

class _GradeSelectionDialogContent extends StatefulWidget {
  final Function(String) onGradeSelected;

  const _GradeSelectionDialogContent({
    Key? key,
    required this.onGradeSelected,
  }) : super(key: key);

  @override
  __GradeSelectionDialogContentState createState() => __GradeSelectionDialogContentState();
}

class __GradeSelectionDialogContentState extends State<_GradeSelectionDialogContent> {
  String? _selectedGrade;
  final List<String> _grades = [
    'الصف الأول الابتدائي',
    'الصف الثاني الابتدائي',
    'الصف الثالث الابتدائي',
    'الصف الرابع الابتدائي',
    'الصف الخامس الابتدائي',
    'الصف السادس الابتدائي',
  ];

  final Color _primaryBlue = Color(0xFF1E88E5);
  final Color _accentOrange = Color(0xFFFFA726);
  final Color _successGreen = Color(0xFF10B981);
  final Color _darkText = Color(0xFF2D3748);
  final Color _grayText = Color(0xFF718096);
  final Color _selectedTextColor = Color(0xFF000000);

  void _continueToLessons() {
    if (_selectedGrade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'يرجى اختيار الصف الدراسي',
            style: TextStyle(fontFamily: 'Tajawal'),
          ),
          backgroundColor: _accentOrange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
      );
      return;
    }

    // إغلاق الدايلوج وإرجاع الصف المختار
    Navigator.pop(context);
    widget.onGradeSelected(_selectedGrade!);

    // الانتقال إلى صفحة Home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CustomBottomNav()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            // الخلفية الرئيسية للدايلوج
            Container(
              padding: EdgeInsets.all(24.w),
              margin: EdgeInsets.only(top: 60.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35), // ظلال أغمق لتظهر بوضوح
                    blurRadius: 40.w,
                    offset: Offset(0, 15.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 60.h),

                  // رسالة النجاح
                  Column(
                    children: [
                      // أيقونة النجاح
                      Container(
                        width: 70.w,
                        height: 70.w,
                        decoration: BoxDecoration(
                          color: _successGreen,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _successGreen.withOpacity(0.4),
                              blurRadius: 15.w,
                              offset: Offset(0, 5.h),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 36.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // العنوان الرئيسي
                      Text(
                        'تم تسجيل الدخول بنجاح',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: _successGreen,
                          fontFamily: 'Tajawal',
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 8.h),

                      // رسالة الترحيب
                      Text(
                        'مرحباً بك! يرجى اختيار صفك الدراسي للمتابعة',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: _grayText,
                          fontFamily: 'Tajawal',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                  // حقل اختيار الصف
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'اختر صفك الدراسي',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: _darkText,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Dropdown احترافي مع عرض العنصر المختار
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15), // ظلال أقوى
                                blurRadius: 15.w,
                                offset: Offset(0, 5.h),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.4),
                              width: 1.2.w,
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _selectedGrade,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGrade = newValue;
                              });
                            },
                            items: _grades.map((String grade) {
                              return DropdownMenuItem<String>(
                                value: grade,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: Text(
                                    grade,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: _darkText,
                                      fontFamily: 'Tajawal',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: 'اختر صفك الآن',
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                color: _grayText,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.w),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.w),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.w),
                                borderSide: BorderSide(
                                  color: _accentOrange,
                                  width: 2.w,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 4.h,
                              ),
                              prefixIcon: Icon(
                                Icons.school,
                                color: _primaryBlue,
                                size: 22.sp,
                              ),
                            ),
                            selectedItemBuilder: (BuildContext context) {
                              return _grades.map<Widget>((String grade) {
                                final isSelected = grade == _selectedGrade;
                                return Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    isSelected ? grade : 'اختر صفك الآن',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: isSelected ? _selectedTextColor : _grayText,
                                      fontFamily: 'Tajawal',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                );
                              }).toList();
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: _primaryBlue,
                              size: 28.sp,
                            ),
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(16.w),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: _darkText,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // أزرار التحكم
                  Row(
                    children: [

                      // زر المتابعة
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _continueToLessons,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryBlue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            elevation: 6, // زيادة الارتفاع
                            shadowColor: _primaryBlue.withOpacity(0.4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'متابعة',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 16.w),

                      // زر الإلغاء
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _grayText,
                            side: BorderSide(color: Colors.grey[400]!),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            backgroundColor: Colors.grey[50],
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

                    ],
                  ),

                  SizedBox(height: 8.h),
                ],
              ),
            ),

            // الأيقونة العلوية (تم إزالتها لأننا وضعنا أيقونة النجاح في المحتوى)
          ],
        ),
      ),
    );
  }
}