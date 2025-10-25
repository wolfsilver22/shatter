// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   // تهيئة Supabase
// //   await Supabase.initialize(
// //     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
// //     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
// //   );
// //
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ScreenUtilInit(
// //       designSize: Size(360, 690),
// //       minTextAdapt: true,
// //       splitScreenMode: true,
// //       builder: (_, child) {
// //         return MaterialApp(
// //           title: 'تطبيق تعلم القراءة',
// //           theme: ThemeData(
// //             primarySwatch: Colors.green,
// //             fontFamily: 'Tajawal',
// //           ),
// //           home: ReadingLessonScreen(),
// //           debugShowCheckedModeBanner: false,
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // class ReadingLessonScreen extends StatefulWidget {
// //   @override
// //   _ReadingLessonScreenState createState() => _ReadingLessonScreenState();
// // }
// //
// // class _ReadingLessonScreenState extends State<ReadingLessonScreen> with TickerProviderStateMixin {
// //   final FlutterTts flutterTts = FlutterTts();
// //   final SupabaseClient supabase = Supabase.instance.client;
// //
// //   List<Map<String, dynamic>> lessons = [];
// //   Map<String, dynamic>? currentLesson;
// //   bool isLoading = false;
// //   String errorMessage = '';
// //
// //   // متغيرات للتحكم في التظليل
// //   List<String> words = [];
// //   int currentWordIndex = -1;
// //   late AnimationController _animationController;
// //   late Animation<double> _animation;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     // إعداد animation controller
// //     _animationController = AnimationController(
// //       duration: Duration(milliseconds: 300),
// //       vsync: this,
// //     );
// //
// //     _animation = CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeInOut,
// //     );
// //
// //     _setupTTS();
// //     _loadLessonsFromSupabase();
// //   }
// //
// //   Future<void> _setupTTS() async {
// //     await flutterTts.setLanguage("ar-SA");
// //     await flutterTts.setPitch(1.0);
// //     await flutterTts.setSpeechRate(0.4);
// //     await flutterTts.setVolume(1.0);
// //
// //     // إعداد مستمع للتقدم في النطق
// //     flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
// //       _onWordSpoken(word, startOffset, endOffset);
// //     });
// //   }
// //
// //   void _onWordSpoken(String word, int startOffset, int endOffset) {
// //     if (mounted) {
// //       setState(() {
// //         // البحث عن الكلمة في النص
// //         final text = currentLesson?['content'] ?? '';
// //         words = _splitTextIntoWords(text);
// //
// //         // تحديث الفهرس الحالي
// //         currentWordIndex = _findWordIndex(text, startOffset);
// //
// //         // تشغيل animation
// //         _animationController.forward(from: 0.0);
// //       });
// //     }
// //   }
// //
// //   List<String> _splitTextIntoWords(String text) {
// //     // تقسيم النص إلى كلمات مع الحفاظ على علامات الترقيم
// //     return text.split(RegExp(r'\s+'));
// //   }
// //
// //   int _findWordIndex(String fullText, int startOffset) {
// //     final words = _splitTextIntoWords(fullText);
// //     int currentPosition = 0;
// //
// //     for (int i = 0; i < words.length; i++) {
// //       final word = words[i];
// //       if (startOffset >= currentPosition && startOffset < currentPosition + word.length) {
// //         return i;
// //       }
// //       currentPosition += word.length + 1; // +1 للمسافة
// //     }
// //     return -1;
// //   }
// //
// //   Future<void> _loadLessonsFromSupabase() async {
// //     setState(() {
// //       isLoading = true;
// //       errorMessage = '';
// //     });
// //
// //     try {
// //       final response = await supabase
// //           .from('lessons')
// //           .select()
// //           .eq('level', 'beginner')
// //           .order('order_number');
// //
// //       if (response != null && response.isNotEmpty) {
// //         setState(() {
// //           lessons = List<Map<String, dynamic>>.from(response);
// //           if (lessons.isNotEmpty) {
// //             currentLesson = lessons[0];
// //             _initializeText();
// //           }
// //         });
// //       } else {
// //         setState(() {
// //           errorMessage = 'لا توجد دروس متاحة';
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         errorMessage = 'خطأ في تحميل الدروس: $e';
// //       });
// //     } finally {
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }
// //
// //   void _initializeText() {
// //     if (currentLesson != null) {
// //       final text = currentLesson!['content'] ?? '';
// //       words = _splitTextIntoWords(text);
// //       currentWordIndex = -1;
// //       _animationController.reset();
// //     }
// //   }
// //
// //   Future<void> _selectLesson(Map<String, dynamic> lesson) async {
// //     setState(() {
// //       currentLesson = lesson;
// //       _initializeText();
// //     });
// //     await _speakText(lesson['content']);
// //   }
// //
// //   Future<void> _nextLesson() async {
// //     if (lessons.isEmpty) return;
// //
// //     int currentIndex = lessons.indexWhere((lesson) => lesson['id'] == currentLesson?['id']);
// //     int nextIndex = (currentIndex + 1) % lessons.length;
// //
// //     setState(() {
// //       currentLesson = lessons[nextIndex];
// //       _initializeText();
// //     });
// //
// //     await _speakText(currentLesson!['content']);
// //   }
// //
// //   Future<void> _previousLesson() async {
// //     if (lessons.isEmpty) return;
// //
// //     int currentIndex = lessons.indexWhere((lesson) => lesson['id'] == currentLesson?['id']);
// //     int previousIndex = (currentIndex - 1) % lessons.length;
// //     if (previousIndex < 0) previousIndex = lessons.length - 1;
// //
// //     setState(() {
// //       currentLesson = lessons[previousIndex];
// //       _initializeText();
// //     });
// //
// //     await _speakText(currentLesson!['content']);
// //   }
// //
// //   Future<void> _speakText(String text) async {
// //     // إعادة تعيين حالة التظليل
// //     setState(() {
// //       currentWordIndex = -1;
// //       _animationController.reset();
// //     });
// //
// //     await flutterTts.speak(text);
// //   }
// //
// //   Future<void> _stopSpeaking() async {
// //     await flutterTts.stop();
// //     setState(() {
// //       currentWordIndex = -1;
// //       _animationController.reset();
// //     });
// //   }
// //
// //   Future<void> _repeatLesson() async {
// //     if (currentLesson != null) {
// //       await _speakText(currentLesson!['content']);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color(0xFF4CAF50),
// //         foregroundColor: Colors.white,
// //         title: Text(
// //           'مكتبة الدروس التعليمية',
// //           style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: _loadLessonsFromSupabase,
// //             tooltip: 'تحديث الدروس',
// //           ),
// //         ],
// //       ),
// //       backgroundColor: Color(0xFFE8F5E9),
// //       body: isLoading
// //           ? _buildLoadingWidget()
// //           : errorMessage.isNotEmpty
// //           ? _buildErrorWidget()
// //           : _buildMainContent(),
// //     );
// //   }
// //
// //   Widget _buildLoadingWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           CircularProgressIndicator(color: Color(0xFF4CAF50)),
// //           SizedBox(height: 20.h),
// //           Text(
// //             'جاري تحميل الدروس...',
// //             style: TextStyle(fontSize: 18.sp, color: Color(0xFF2E7D32)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildErrorWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
// //           SizedBox(height: 16.h),
// //           Text(
// //             errorMessage,
// //             style: TextStyle(fontSize: 16.sp, color: Colors.red[700]),
// //             textAlign: TextAlign.center,
// //           ),
// //           SizedBox(height: 20.h),
// //           ElevatedButton(
// //             onPressed: _loadLessonsFromSupabase,
// //             child: Text('إعادة المحاولة'),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Color(0xFF4CAF50),
// //               foregroundColor: Colors.white,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildMainContent() {
// //     return Column(
// //       children: [
// //         if (currentLesson != null) _buildCurrentLessonCard(),
// //         SizedBox(height: 16.h),
// //         Expanded(child: _buildLessonsList()),
// //         _buildControlButtons(),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildCurrentLessonCard() {
// //     return Container(
// //       margin: EdgeInsets.symmetric(horizontal: 16.w),
// //       padding: EdgeInsets.all(16.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.3),
// //             blurRadius: 8.w,
// //             offset: Offset(0, 2.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Text(
// //             'الدرس الحالي:',
// //             style: TextStyle(
// //               fontSize: 16.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF2E7D32),
// //             ),
// //           ),
// //           SizedBox(height: 8.h),
// //           Text(
// //             currentLesson!['title'] ?? 'بدون عنوان',
// //             style: TextStyle(
// //               fontSize: 18.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.black87,
// //             ),
// //             textAlign: TextAlign.center,
// //           ),
// //           SizedBox(height: 12.h),
// //           Container(
// //             height: 120.h,
// //             child: SingleChildScrollView(
// //               child: _buildAnimatedText(),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAnimatedText() {
// //     if (words.isEmpty) {
// //       return Text(
// //         currentLesson?['content'] ?? '',
// //         style: TextStyle(fontSize: 16.sp, height: 1.8),
// //         textDirection: TextDirection.rtl,
// //         textAlign: TextAlign.center,
// //       );
// //     }
// //
// //     return Directionality(
// //       textDirection: TextDirection.rtl,
// //       child: Wrap(
// //         alignment: WrapAlignment.center,
// //         crossAxisAlignment: WrapCrossAlignment.center,
// //         children: words.asMap().entries.map((entry) {
// //           final index = entry.key;
// //           final word = entry.value;
// //
// //           final isCurrentWord = index == currentWordIndex;
// //
// //           return AnimatedBuilder(
// //             animation: _animation,
// //             builder: (context, child) {
// //               final scale = isCurrentWord ?
// //               (1.0 + _animation.value * 0.3) : 1.0;
// //
// //               final color = isCurrentWord ?
// //               Color.lerp(Colors.black, Colors.red, _animation.value)! :
// //               Colors.black87;
// //
// //               return Transform.scale(
// //                 scale: scale,
// //                 child: Container(
// //                   margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
// //                   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
// //                   decoration: isCurrentWord ? BoxDecoration(
// //                     color: Colors.red.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(4.w),
// //                     border: Border.all(
// //                       color: Colors.red.withOpacity(0.3),
// //                       width: 1.w,
// //                     ),
// //                   ) : null,
// //                   child: Text(
// //                     word,
// //                     style: TextStyle(
// //                       fontSize: 18.sp,
// //                       height: 1.8,
// //                       color: color,
// //                       fontWeight: isCurrentWord ? FontWeight.bold : FontWeight.normal,
// //                       shadows: isCurrentWord ? [
// //                         Shadow(
// //                           blurRadius: 2.0,
// //                           color: Colors.red.withOpacity(0.5),
// //                           offset: Offset(0, 1.h),
// //                         )
// //                       ] : null,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonsList() {
// //     return Container(
// //       margin: EdgeInsets.symmetric(horizontal: 16.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12.w),
// //       ),
// //       child: Column(
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.all(16.w),
// //             child: Text(
// //               'اختر درساً من القائمة:',
// //               style: TextStyle(
// //                 fontSize: 16.sp,
// //                 fontWeight: FontWeight.bold,
// //                 color: Color(0xFF2E7D32),
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: lessons.length,
// //               itemBuilder: (context, index) {
// //                 final lesson = lessons[index];
// //                 final isCurrent = currentLesson?['id'] == lesson['id'];
// //
// //                 return Card(
// //                   margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
// //                   color: isCurrent ? Color(0xFFE8F5E9) : Colors.white,
// //                   child: ListTile(
// //                     leading: CircleAvatar(
// //                       backgroundColor: Color(0xFF4CAF50),
// //                       child: Text(
// //                         '${index + 1}',
// //                         style: TextStyle(color: Colors.white),
// //                       ),
// //                     ),
// //                     title: Text(
// //                       lesson['title'] ?? 'بدون عنوان',
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         color: isCurrent ? Color(0xFF2E7D32) : Colors.black87,
// //                       ),
// //                     ),
// //                     subtitle: Text(
// //                       _truncateText(lesson['content'] ?? '', 50),
// //                       style: TextStyle(fontSize: 12.sp),
// //                     ),
// //                     trailing: isCurrent ? Icon(Icons.play_arrow, color: Color(0xFF4CAF50)) : null,
// //                     onTap: () => _selectLesson(lesson),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildControlButtons() {
// //     return Container(
// //       padding: EdgeInsets.all(16.w),
// //       color: Colors.white,
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: ElevatedButton.icon(
// //               onPressed: _previousLesson,
// //               icon: Icon(Icons.skip_previous),
// //               label: Text('السابق'),
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Color(0xFF2196F3),
// //                 foregroundColor: Colors.white,
// //                 padding: EdgeInsets.symmetric(vertical: 12.h),
// //               ),
// //             ),
// //           ),
// //           SizedBox(width: 8.w),
// //           Expanded(
// //             child: ElevatedButton.icon(
// //               onPressed: _repeatLesson,
// //               icon: Icon(Icons.replay),
// //               label: Text('إعادة'),
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Color(0xFFFF9800),
// //                 foregroundColor: Colors.white,
// //                 padding: EdgeInsets.symmetric(vertical: 12.h),
// //               ),
// //             ),
// //           ),
// //           SizedBox(width: 8.w),
// //           Expanded(
// //             child: ElevatedButton.icon(
// //               onPressed: _nextLesson,
// //               icon: Icon(Icons.skip_next),
// //               label: Text('التالي'),
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Color(0xFF4CAF50),
// //                 foregroundColor: Colors.white,
// //                 padding: EdgeInsets.symmetric(vertical: 12.h),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   String _truncateText(String text, int maxLength) {
// //     if (text.length <= maxLength) return text;
// //     return text.substring(0, maxLength) + '...';
// //   }
// //
// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     flutterTts.stop();
// //     super.dispose();
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart';
// // import 'package:audioplayers/audioplayers.dart'; // ✅ تم الاستيراد بشكل صحيح
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   await Supabase.initialize(
// //     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
// //     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
// //   );
// //
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ScreenUtilInit(
// //       designSize: Size(360, 690),
// //       minTextAdapt: true,
// //       splitScreenMode: true,
// //       builder: (_, child) {
// //         return MaterialApp(
// //           title: 'تطبيق تعلم القراءة',
// //           theme: ThemeData(
// //             primarySwatch: Colors.green,
// //             fontFamily: 'Tajawal',
// //           ),
// //           home: LessonsListScreen(),
// //           debugShowCheckedModeBanner: false,
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // // شاشة قائمة الدروس
// // class LessonsListScreen extends StatefulWidget {
// //   @override
// //   _LessonsListScreenState createState() => _LessonsListScreenState();
// // }
// //
// // class _LessonsListScreenState extends State<LessonsListScreen> {
// //   final SupabaseClient supabase = Supabase.instance.client;
// //   List<Map<String, dynamic>> lessons = [];
// //   bool isLoading = false;
// //   String errorMessage = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadLessonsFromSupabase();
// //   }
// //
// //   Future<void> _loadLessonsFromSupabase() async {
// //     setState(() {
// //       isLoading = true;
// //       errorMessage = '';
// //     });
// //
// //     try {
// //       final response = await supabase
// //           .from('lessons')
// //           .select()
// //           .order('order_number');
// //
// //       if (response != null && response.isNotEmpty) {
// //         setState(() {
// //           lessons = List<Map<String, dynamic>>.from(response);
// //         });
// //       } else {
// //         setState(() {
// //           errorMessage = 'لا توجد دروس متاحة';
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         errorMessage = 'خطأ في تحميل الدروس: $e';
// //       });
// //     } finally {
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }
// //
// //   void _navigateToLesson(Map<String, dynamic> lesson) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => LessonDetailScreen(lesson: lesson),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color(0xFF4CAF50),
// //         foregroundColor: Colors.white,
// //         title: Text(
// //           'مكتبة الدروس التعليمية',
// //           style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: _loadLessonsFromSupabase,
// //             tooltip: 'تحديث الدروس',
// //           ),
// //         ],
// //       ),
// //       backgroundColor: Color(0xFFE8F5E9),
// //       body: isLoading
// //           ? _buildLoadingWidget()
// //           : errorMessage.isNotEmpty
// //           ? _buildErrorWidget()
// //           : _buildLessonsGrid(),
// //     );
// //   }
// //
// //   Widget _buildLoadingWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           CircularProgressIndicator(color: Color(0xFF4CAF50)),
// //           SizedBox(height: 20.h),
// //           Text(
// //             'جاري تحميل الدروس...',
// //             style: TextStyle(fontSize: 18.sp, color: Color(0xFF2E7D32)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildErrorWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
// //           SizedBox(height: 16.h),
// //           Text(
// //             errorMessage,
// //             style: TextStyle(fontSize: 16.sp, color: Colors.red[700]),
// //             textAlign: TextAlign.center,
// //           ),
// //           SizedBox(height: 20.h),
// //           ElevatedButton(
// //             onPressed: _loadLessonsFromSupabase,
// //             child: Text('إعادة المحاولة'),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Color(0xFF4CAF50),
// //               foregroundColor: Colors.white,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonsGrid() {
// //     return Padding(
// //       padding: EdgeInsets.all(16.w),
// //       child: GridView.builder(
// //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2,
// //           crossAxisSpacing: 16.w,
// //           mainAxisSpacing: 16.h,
// //           childAspectRatio: 0.8,
// //         ),
// //         itemCount: lessons.length,
// //         itemBuilder: (context, index) {
// //           final lesson = lessons[index];
// //           return _buildLessonCard(lesson);
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonCard(Map<String, dynamic> lesson) {
// //     // استخدام order_number مباشرة، وإذا كان null نستخدم رقم افتراضي
// //     int orderNumber = lesson['order_number'] ?? (lessons.indexOf(lesson) + 1);
// //
// //     return Card(
// //       elevation: 4.w,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
// //       child: InkWell(
// //         onTap: () => _navigateToLesson(lesson),
// //         borderRadius: BorderRadius.circular(12.w),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             gradient: LinearGradient(
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //               colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
// //             ),
// //             borderRadius: BorderRadius.circular(12.w),
// //           ),
// //           child: Stack(
// //             children: [
// //               Positioned(
// //                 top: 8.h,
// //                 right: 8.w,
// //                 child: Container(
// //                   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white.withOpacity(0.2),
// //                     borderRadius: BorderRadius.circular(8.w),
// //                   ),
// //                   child: Text(
// //                     '$orderNumber', // ✅ استخدام orderNumber مباشرة
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 14.sp,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Center(
// //                 child: Padding(
// //                   padding: EdgeInsets.all(16.w),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         Icons.menu_book,
// //                         size: 40.sp,
// //                         color: Colors.white,
// //                       ),
// //                       SizedBox(height: 12.h),
// //                       Text(
// //                         lesson['title'] ?? 'بدون عنوان',
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 16.sp,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                         textAlign: TextAlign.center,
// //                         maxLines: 2,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       SizedBox(height: 8.h),
// //                       Text(
// //                         'المستوى: ${lesson['level'] ?? 'مبتدئ'}',
// //                         style: TextStyle(
// //                           color: Colors.white.withOpacity(0.8),
// //                           fontSize: 12.sp,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // شاشة تفاصيل الدرس
// // class LessonDetailScreen extends StatefulWidget {
// //   final Map<String, dynamic> lesson;
// //
// //   const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);
// //
// //   @override
// //   _LessonDetailScreenState createState() => _LessonDetailScreenState();
// // }
// //
// // class _LessonDetailScreenState extends State<LessonDetailScreen> with TickerProviderStateMixin {
// //   final FlutterTts flutterTts = FlutterTts();
// //   final AudioPlayer audioPlayer = AudioPlayer(); // ✅ الآن تم التعريف بشكل صحيح
// //
// //   List<String> words = [];
// //   int currentWordIndex = -1;
// //   bool isPlaying = false;
// //   bool isRecording = false;
// //   bool showRecordingButton = false;
// //   bool isPlayingRecording = false;
// //
// //   late AnimationController _animationController;
// //   late Animation<double> _animation;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     _animationController = AnimationController(
// //       duration: Duration(milliseconds: 400),
// //       vsync: this,
// //     );
// //
// //     _animation = CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeInOut,
// //     );
// //
// //     _setupTTS();
// //     _setupAudioPlayer();
// //     _initializeText();
// //   }
// //
// //   Future<void> _setupTTS() async {
// //     await flutterTts.setLanguage("ar-SA");
// //     await flutterTts.setPitch(1.0);
// //     await flutterTts.setSpeechRate(0.4);
// //     await flutterTts.setVolume(1.0);
// //
// //     flutterTts.setStartHandler(() {
// //       setState(() {
// //         isPlaying = true;
// //       });
// //     });
// //
// //     flutterTts.setCompletionHandler(() {
// //       setState(() {
// //         isPlaying = false;
// //         currentWordIndex = -1;
// //         showRecordingButton = true;
// //         _animationController.reset();
// //       });
// //     });
// //
// //     flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
// //       _onWordSpoken(word, startOffset, endOffset);
// //     });
// //   }
// //
// //   void _setupAudioPlayer() {
// //     audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
// //       setState(() {
// //         isPlayingRecording = state == PlayerState.playing;
// //       });
// //     });
// //   }
// //
// //   void _onWordSpoken(String word, int startOffset, int endOffset) {
// //     if (mounted) {
// //       setState(() {
// //         final text = widget.lesson['content'] ?? '';
// //         words = _splitTextIntoWords(text);
// //         currentWordIndex = _findWordIndex(text, startOffset);
// //         _animationController.forward(from: 0.0);
// //       });
// //     }
// //   }
// //
// //   List<String> _splitTextIntoWords(String text) {
// //     return text.split(RegExp(r'\s+'));
// //   }
// //
// //   int _findWordIndex(String fullText, int startOffset) {
// //     final words = _splitTextIntoWords(fullText);
// //     int currentPosition = 0;
// //
// //     for (int i = 0; i < words.length; i++) {
// //       final word = words[i];
// //       if (startOffset >= currentPosition && startOffset < currentPosition + word.length) {
// //         return i;
// //       }
// //       currentPosition += word.length + 1;
// //     }
// //     return -1;
// //   }
// //
// //   void _initializeText() {
// //     final text = widget.lesson['content'] ?? '';
// //     words = _splitTextIntoWords(text);
// //     currentWordIndex = -1;
// //     _animationController.reset();
// //   }
// //
// //   Future<void> _playLesson() async {
// //     await _speakText(widget.lesson['content']);
// //   }
// //
// //   Future<void> _speakText(String text) async {
// //     setState(() {
// //       currentWordIndex = -1;
// //       showRecordingButton = false;
// //       _animationController.reset();
// //     });
// //
// //     await flutterTts.speak(text);
// //   }
// //
// //   Future<void> _stopPlaying() async {
// //     await flutterTts.stop();
// //     setState(() {
// //       isPlaying = false;
// //       currentWordIndex = -1;
// //       _animationController.reset();
// //     });
// //   }
// //
// //   Future<void> _repeatLesson() async {
// //     await _speakText(widget.lesson['content']);
// //   }
// //
// //   void _startRecording() {
// //     setState(() {
// //       isRecording = true;
// //     });
// //
// //     // محاكاة التسجيل - يمكن إضافة مكتبة تسجيل حقيقية هنا
// //     Future.delayed(Duration(seconds: 3), () {
// //       if (mounted) {
// //         setState(() {
// //           isRecording = false;
// //         });
// //       }
// //     });
// //   }
// //
// //   void _stopRecording() {
// //     setState(() {
// //       isRecording = false;
// //     });
// //   }
// //
// //   Future<void> _playStudentRecording() async {
// //     try {
// //       // محاكاة تشغيل تسجيل - يمكن استبدالها بتسجيل حقيقي
// //       setState(() {
// //         isPlayingRecording = true;
// //       });
// //
// //       await Future.delayed(Duration(seconds: 2));
// //
// //       setState(() {
// //         isPlayingRecording = false;
// //       });
// //
// //       // عرض رسالة نجاح
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('جارٍ تشغيل تسجيلك...'),
// //           backgroundColor: Colors.green,
// //         ),
// //       );
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('خطأ في تشغيل التسجيل'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color(0xFFE8F5E9),
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             _buildAppBar(),
// //             Expanded(child: _buildLessonContent()),
// //             _buildControlButtons(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAppBar() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// //       decoration: BoxDecoration(
// //         color: Color(0xFF4CAF50),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, 2.h),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           IconButton(
// //             icon: Icon(Icons.arrow_back, color: Colors.white),
// //             onPressed: () => Navigator.pop(context),
// //           ),
// //           Expanded(
// //             child: Text(
// //               widget.lesson['title'] ?? 'بدون عنوان',
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontSize: 20.sp,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //           ),
// //           SizedBox(width: 48.w),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonContent() {
// //     return SingleChildScrollView(
// //       padding: EdgeInsets.all(24.w),
// //       child: Column(
// //         children: [
// //           Container(
// //             width: double.infinity,
// //             padding: EdgeInsets.all(20.w),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(16.w),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black12,
// //                   blurRadius: 12.w,
// //                   offset: Offset(0, 4.h),
// //                 ),
// //               ],
// //             ),
// //             child: _buildAnimatedText(),
// //           ),
// //           SizedBox(height: 30.h),
// //           if (showRecordingButton) _buildRecordingSection(),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAnimatedText() {
// //     if (words.isEmpty) {
// //       return Text(
// //         widget.lesson['content'] ?? '',
// //         style: TextStyle(fontSize: 18.sp, height: 2.0),
// //         textDirection: TextDirection.rtl,
// //         textAlign: TextAlign.center,
// //       );
// //     }
// //
// //     return Directionality(
// //       textDirection: TextDirection.rtl,
// //       child: Wrap(
// //         alignment: WrapAlignment.center,
// //         crossAxisAlignment: WrapCrossAlignment.center,
// //         children: words.asMap().entries.map((entry) {
// //           final index = entry.key;
// //           final word = entry.value;
// //           final isCurrentWord = index == currentWordIndex;
// //
// //           return AnimatedBuilder(
// //             animation: _animation,
// //             builder: (context, child) {
// //               final scale = isCurrentWord ? (1.0 + _animation.value * 0.4) : 1.0;
// //               final color = isCurrentWord ?
// //               Color.lerp(Colors.black, Colors.red, _animation.value)! :
// //               Colors.black87;
// //
// //               return Transform.scale(
// //                 scale: scale,
// //                 child: Container(
// //                   margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
// //                   padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
// //                   decoration: isCurrentWord ? BoxDecoration(
// //                     gradient: LinearGradient(
// //                       colors: [Colors.red.shade100, Colors.orange.shade100],
// //                     ),
// //                     borderRadius: BorderRadius.circular(8.w),
// //                     border: Border.all(
// //                       color: Colors.red.withOpacity(0.5),
// //                       width: 2.w,
// //                     ),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.red.withOpacity(0.3),
// //                         blurRadius: 8.w,
// //                         offset: Offset(0, 2.h),
// //                       ),
// //                     ],
// //                   ) : null,
// //                   child: Text(
// //                     word,
// //                     style: TextStyle(
// //                       fontSize: 20.sp,
// //                       height: 1.8,
// //                       color: color,
// //                       fontWeight: isCurrentWord ? FontWeight.bold : FontWeight.normal,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRecordingSection() {
// //     return AnimatedContainer(
// //       duration: Duration(milliseconds: 500),
// //       padding: EdgeInsets.all(20.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 12.w,
// //             offset: Offset(0, 4.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Text(
// //             'الآن دورك للقراءة',
// //             style: TextStyle(
// //               fontSize: 18.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF2E7D32),
// //             ),
// //           ),
// //           SizedBox(height: 16.h),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               _buildRecordingButton(),
// //               _buildPlayRecordingButton(),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRecordingButton() {
// //     return Column(
// //       children: [
// //         GestureDetector(
// //           onTapDown: (_) => _startRecording(),
// //           onTapUp: (_) => _stopRecording(),
// //           child: AnimatedContainer(
// //             duration: Duration(milliseconds: 300),
// //             width: 70.w,
// //             height: 70.h,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: isRecording ? Colors.red : Color(0xFF4CAF50),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: (isRecording ? Colors.red : Color(0xFF4CAF50)).withOpacity(0.5),
// //                   blurRadius: 8.w,
// //                   spreadRadius: 2.w,
// //                 ),
// //               ],
// //             ),
// //             child: Icon(
// //               isRecording ? Icons.stop : Icons.mic,
// //               color: Colors.white,
// //               size: 30.sp,
// //             ),
// //           ),
// //         ),
// //         SizedBox(height: 8.h),
// //         Text(
// //           isRecording ? 'جارٍ التسجيل...' : 'اضغط للتسجيل',
// //           style: TextStyle(fontSize: 14.sp),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildPlayRecordingButton() {
// //     return Column(
// //       children: [
// //         GestureDetector(
// //           onTap: _playStudentRecording,
// //           child: Container(
// //             width: 70.w,
// //             height: 70.h,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: isPlayingRecording ? Colors.orange : Color(0xFF2196F3),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: (isPlayingRecording ? Colors.orange : Color(0xFF2196F3)).withOpacity(0.5),
// //                   blurRadius: 8.w,
// //                   spreadRadius: 2.w,
// //                 ),
// //               ],
// //             ),
// //             child: Icon(
// //               isPlayingRecording ? Icons.stop : Icons.play_arrow,
// //               color: Colors.white,
// //               size: 30.sp,
// //             ),
// //           ),
// //         ),
// //         SizedBox(height: 8.h),
// //         Text(
// //           isPlayingRecording ? 'جارٍ التشغيل...' : 'استمع لتسجيلك',
// //           style: TextStyle(fontSize: 14.sp),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildControlButtons() {
// //     return Container(
// //       padding: EdgeInsets.all(20.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, -2.h),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //         children: [
// //           _buildControlButton(
// //             icon: isPlaying ? Icons.stop : Icons.play_arrow,
// //             text: isPlaying ? 'إيقاف' : 'تشغيل',
// //             onPressed: isPlaying ? _stopPlaying : _playLesson,
// //             color: isPlaying ? Colors.red : Color(0xFF4CAF50),
// //           ),
// //           _buildControlButton(
// //             icon: Icons.replay,
// //             text: 'إعادة',
// //             onPressed: _repeatLesson,
// //             color: Color(0xFFFF9800),
// //           ),
// //           _buildControlButton(
// //             icon: Icons.volume_up,
// //             text: 'التشغيل\nالبطيء',
// //             onPressed: () => _speakText(widget.lesson['content']),
// //             color: Color(0xFF9C27B0),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildControlButton({
// //     required IconData icon,
// //     required String text,
// //     required VoidCallback onPressed,
// //     required Color color,
// //   }) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 60.w,
// //           height: 60.h,
// //           decoration: BoxDecoration(
// //             color: color,
// //             shape: BoxShape.circle,
// //             boxShadow: [
// //               BoxShadow(
// //                 color: color.withOpacity(0.5),
// //                 blurRadius: 8.w,
// //                 offset: Offset(0, 3.h),
// //               ),
// //             ],
// //           ),
// //           child: IconButton(
// //             icon: Icon(icon, color: Colors.white),
// //             onPressed: onPressed,
// //           ),
// //         ),
// //         SizedBox(height: 8.h),
// //         Text(
// //           text,
// //           style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
// //           textAlign: TextAlign.center,
// //         ),
// //       ],
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     flutterTts.stop();
// //     audioPlayer.dispose(); // ✅ الآن يمكن التخلص منه بشكل صحيح
// //     super.dispose();
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart';
// // import 'package:audioplayers/audioplayers.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:record/record.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:path/path.dart' as path;
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   await Supabase.initialize(
// //     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
// //     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
// //   );
// //
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ScreenUtilInit(
// //       designSize: const Size(360, 690),
// //       minTextAdapt: true,
// //       splitScreenMode: true,
// //       builder: (_, child) {
// //         return MaterialApp(
// //           title: 'تطبيق تعلم القراءة',
// //           theme: ThemeData(
// //             primarySwatch: Colors.green,
// //             fontFamily: 'Tajawal',
// //             useMaterial3: true,
// //           ),
// //           home: const LessonsListScreen(),
// //           debugShowCheckedModeBanner: false,
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // class LessonsListScreen extends StatefulWidget {
// //   const LessonsListScreen({super.key});
// //
// //   @override
// //   State<LessonsListScreen> createState() => _LessonsListScreenState();
// // }
// //
// // class _LessonsListScreenState extends State<LessonsListScreen> {
// //   final SupabaseClient _supabase = Supabase.instance.client;
// //   List<Map<String, dynamic>> _lessons = [];
// //   bool _isLoading = false;
// //   String _errorMessage = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadLessonsFromSupabase();
// //   }
// //
// //   Future<void> _loadLessonsFromSupabase() async {
// //     setState(() {
// //       _isLoading = true;
// //       _errorMessage = '';
// //     });
// //
// //     try {
// //       final response = await _supabase
// //           .from('lessons')
// //           .select()
// //           .order('order_number');
// //
// //       if (response != null && response.isNotEmpty) {
// //         setState(() {
// //           _lessons = List<Map<String, dynamic>>.from(response);
// //         });
// //       } else {
// //         setState(() {
// //           _errorMessage = 'لا توجد دروس متاحة';
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         _errorMessage = 'خطأ في تحميل الدروس: $e';
// //       });
// //     } finally {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }
// //
// //   void _navigateToLesson(Map<String, dynamic> lesson) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => LessonDetailScreen(lesson: lesson),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLoadingWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           CircularProgressIndicator(color: Color(0xFF4CAF50)),
// //           SizedBox(height: 20.h),
// //           Text(
// //             'جاري تحميل الدروس...',
// //             style: TextStyle(fontSize: 18.sp, color: Color(0xFF2E7D32)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildErrorWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
// //           SizedBox(height: 16.h),
// //           Text(
// //             _errorMessage,
// //             style: TextStyle(fontSize: 16.sp, color: Colors.red[700]),
// //             textAlign: TextAlign.center,
// //           ),
// //           SizedBox(height: 20.h),
// //           ElevatedButton(
// //             onPressed: _loadLessonsFromSupabase,
// //             child: Text('إعادة المحاولة'),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Color(0xFF4CAF50),
// //               foregroundColor: Colors.white,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
// //     final int orderNumber = lesson['order_number'] ?? (index + 1);
// //     final String title = lesson['title'] ?? 'بدون عنوان';
// //     final String level = lesson['level'] ?? 'مبتدئ';
// //
// //     return Card(
// //       elevation: 4.w,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
// //       child: InkWell(
// //         onTap: () => _navigateToLesson(lesson),
// //         borderRadius: BorderRadius.circular(16.w),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             gradient: const LinearGradient(
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //               colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
// //             ),
// //             borderRadius: BorderRadius.circular(16.w),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black26,
// //                 blurRadius: 8.w,
// //                 offset: Offset(0, 4.h),
// //               ),
// //             ],
// //           ),
// //           child: Stack(
// //             children: [
// //               Positioned(
// //                 top: 12.h,
// //                 right: 12.w,
// //                 child: Container(
// //                   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white.withOpacity(0.2),
// //                     borderRadius: BorderRadius.circular(12.w),
// //                     border: Border.all(color: Colors.white30, width: 1.w),
// //                   ),
// //                   child: Text(
// //                     '$orderNumber',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 14.sp,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Center(
// //                 child: Padding(
// //                   padding: EdgeInsets.all(20.w),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Container(
// //                         width: 60.w,
// //                         height: 60.w,
// //                         decoration: BoxDecoration(
// //                           color: Colors.white.withOpacity(0.2),
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: Icon(
// //                           Icons.menu_book_rounded,
// //                           size: 32.sp,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                       SizedBox(height: 16.h),
// //                       Text(
// //                         title,
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 16.sp,
// //                           fontWeight: FontWeight.bold,
// //                           height: 1.4,
// //                         ),
// //                         textAlign: TextAlign.center,
// //                         maxLines: 2,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       SizedBox(height: 8.h),
// //                       Container(
// //                         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white.withOpacity(0.15),
// //                           borderRadius: BorderRadius.circular(8.w),
// //                         ),
// //                         child: Text(
// //                           'المستوى: $level',
// //                           style: TextStyle(
// //                             color: Colors.white.withOpacity(0.9),
// //                             fontSize: 12.sp,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonsGrid() {
// //     return Padding(
// //       padding: EdgeInsets.all(16.w),
// //       child: GridView.builder(
// //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2,
// //           crossAxisSpacing: 16.w,
// //           mainAxisSpacing: 16.h,
// //           childAspectRatio: 0.85,
// //         ),
// //         itemCount: _lessons.length,
// //         itemBuilder: (context, index) {
// //           final lesson = _lessons[index];
// //           return _buildLessonCard(lesson, index);
// //         },
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color(0xFF4CAF50),
// //         foregroundColor: Colors.white,
// //         title: Text(
// //           'مكتبة الدروس التعليمية',
// //           style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //         elevation: 0,
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh_rounded, size: 24.sp),
// //             onPressed: _loadLessonsFromSupabase,
// //             tooltip: 'تحديث الدروس',
// //           ),
// //         ],
// //       ),
// //       backgroundColor: Color(0xFFF5FDF6),
// //       body: _isLoading
// //           ? _buildLoadingWidget()
// //           : _errorMessage.isNotEmpty
// //           ? _buildErrorWidget()
// //           : _lessons.isEmpty
// //           ? Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(Icons.menu_book_rounded, size: 80.sp, color: Colors.grey),
// //             SizedBox(height: 16.h),
// //             Text(
// //               'لا توجد دروس متاحة',
// //               style: TextStyle(fontSize: 18.sp, color: Colors.grey),
// //             ),
// //           ],
// //         ),
// //       )
// //           : _buildLessonsGrid(),
// //     );
// //   }
// // }
// //
// // class LessonDetailScreen extends StatefulWidget {
// //   final Map<String, dynamic> lesson;
// //
// //   const LessonDetailScreen({super.key, required this.lesson});
// //
// //   @override
// //   State<LessonDetailScreen> createState() => _LessonDetailScreenState();
// // }
// //
// // class _LessonDetailScreenState extends State<LessonDetailScreen>
// //     with TickerProviderStateMixin {
// //   final FlutterTts _flutterTts = FlutterTts();
// //   final AudioPlayer _audioPlayer = AudioPlayer();
// //   final AudioRecorder _audioRecorder = AudioRecorder();
// //
// //   List<String> _words = [];
// //   int _currentWordIndex = -1;
// //   bool _isPlaying = false;
// //   bool _isRecording = false;
// //   bool _showRecordingSection = false;
// //   bool _isPlayingRecording = false;
// //   String? _recordedAudioPath;
// //   double _speechRate = 0.4;
// //
// //   late AnimationController _animationController;
// //   late Animation<double> _animation;
// //   final List<AnimationController> _wordControllers = [];
// //   final List<Animation<double>> _wordAnimations = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     _animationController = AnimationController(
// //       duration: const Duration(milliseconds: 400),
// //       vsync: this,
// //     );
// //
// //     _animation = CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeInOut,
// //     );
// //
// //     _initializeTTS();
// //     _setupAudioPlayer();
// //     _initializeText();
// //   }
// //
// //   Future<void> _initializeTTS() async {
// //     await _flutterTts.setLanguage("ar-SA");
// //     await _flutterTts.setPitch(1.0);
// //     await _flutterTts.setSpeechRate(_speechRate);
// //     await _flutterTts.setVolume(1.0);
// //
// //     _flutterTts.setStartHandler(() {
// //       if (mounted) {
// //         setState(() {
// //           _isPlaying = true;
// //           _showRecordingSection = false;
// //         });
// //       }
// //     });
// //
// //     _flutterTts.setCompletionHandler(() {
// //       if (mounted) {
// //         setState(() {
// //           _isPlaying = false;
// //           _currentWordIndex = -1;
// //           _showRecordingSection = true;
// //           _resetAllAnimations();
// //         });
// //       }
// //     });
// //
// //     _flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
// //       _onWordSpoken(word, startOffset, endOffset);
// //     });
// //
// //     _flutterTts.setErrorHandler((msg) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('خطأ في التشغيل: $msg'),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       }
// //     });
// //   }
// //
// //   void _setupAudioPlayer() {
// //     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
// //       if (mounted) {
// //         setState(() {
// //           _isPlayingRecording = state == PlayerState.playing;
// //         });
// //       }
// //     });
// //
// //     _audioPlayer.onPlayerComplete.listen((event) {
// //       if (mounted) {
// //         setState(() {
// //           _isPlayingRecording = false;
// //         });
// //       }
// //     });
// //   }
// //
// //   void _onWordSpoken(String word, int startOffset, int endOffset) {
// //     if (!mounted) return;
// //
// //     final text = widget.lesson['content'] ?? '';
// //     final wordIndex = _findWordIndex(text, startOffset);
// //
// //     if (wordIndex != -1 && wordIndex < _wordControllers.length) {
// //       setState(() {
// //         _currentWordIndex = wordIndex;
// //       });
// //
// //       // إعادة تعيين ثم تشغيل animation للكلمة الحالية
// //       _wordControllers[wordIndex].reset();
// //       _wordControllers[wordIndex].forward();
// //     }
// //   }
// //
// //   int _findWordIndex(String fullText, int startOffset) {
// //     int currentPosition = 0;
// //     for (int i = 0; i < _words.length; i++) {
// //       final word = _words[i];
// //       if (startOffset >= currentPosition &&
// //           startOffset < currentPosition + word.length) {
// //         return i;
// //       }
// //       currentPosition += word.length + 1;
// //     }
// //     return -1;
// //   }
// //
// //   void _initializeText() {
// //     final text = widget.lesson['content'] ?? '';
// //     _words = _splitTextIntoWords(text);
// //     _currentWordIndex = -1;
// //
// //     // تهيئة animations لكل كلمة
// //     _wordControllers.clear();
// //     _wordAnimations.clear();
// //
// //     for (int i = 0; i < _words.length; i++) {
// //       final controller = AnimationController(
// //         duration: const Duration(milliseconds: 500),
// //         vsync: this,
// //       );
// //       final animation = CurvedAnimation(
// //         parent: controller,
// //         curve: Curves.elasticOut,
// //       );
// //
// //       _wordControllers.add(controller);
// //       _wordAnimations.add(animation);
// //     }
// //
// //     _animationController.reset();
// //   }
// //
// //   List<String> _splitTextIntoWords(String text) {
// //     // تقسيم النص مع الحفاظ على علامات الترقيم
// //     return text.split(RegExp(r'\s+'));
// //   }
// //
// //   void _resetAllAnimations() {
// //     for (final controller in _wordControllers) {
// //       controller.reset();
// //     }
// //     _animationController.reset();
// //   }
// //
// //   Future<bool> _checkAudioPermissions() async {
// //     try {
// //       final Map<Permission, PermissionStatus> statuses = await [
// //         Permission.microphone,
// //         Permission.storage,
// //         Permission.manageExternalStorage,
// //       ].request();
// //
// //       if (statuses[Permission.microphone] != PermissionStatus.granted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('يجب منح إذن الميكروفون لتسجيل الصوت'),
// //             backgroundColor: Colors.orange,
// //             duration: const Duration(seconds: 3),
// //             action: SnackBarAction(
// //               label: 'الإعدادات',
// //               onPressed: openAppSettings,
// //             ),
// //           ),
// //         );
// //         return false;
// //       }
// //
// //       return true;
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('حدث خطأ في التحقق من الأذونات'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //       return false;
// //     }
// //   }
// //
// //   Future<void> _playLesson() async {
// //     await _speakText(widget.lesson['content'] ?? '');
// //   }
// //
// //   Future<void> _speakText(String text) async {
// //     try {
// //       setState(() {
// //         _currentWordIndex = -1;
// //         _showRecordingSection = false;
// //         _resetAllAnimations();
// //       });
// //
// //       await _flutterTts.speak(text);
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('حدث خطأ في تشغيل النص: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _stopPlaying() async {
// //     try {
// //       await _flutterTts.stop();
// //       setState(() {
// //         _isPlaying = false;
// //         _currentWordIndex = -1;
// //         _resetAllAnimations();
// //       });
// //     } catch (e) {
// //       print('Error stopping TTS: $e');
// //     }
// //   }
// //
// //   Future<void> _repeatLesson() async {
// //     await _speakText(widget.lesson['content'] ?? '');
// //   }
// //
// //   Future<void> _changeSpeechRate() async {
// //     final newRate = await showDialog<double>(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text('سرعة التشغيل'),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             ListTile(
// //               title: Text('بطيء'),
// //               leading: Radio<double>(
// //                 value: 0.3,
// //                 groupValue: _speechRate,
// //                 onChanged: (value) => Navigator.pop(context, value),
// //               ),
// //             ),
// //             ListTile(
// //               title: Text('متوسط'),
// //               leading: Radio<double>(
// //                 value: 0.4,
// //                 groupValue: _speechRate,
// //                 onChanged: (value) => Navigator.pop(context, value),
// //               ),
// //             ),
// //             ListTile(
// //               title: Text('سريع'),
// //               leading: Radio<double>(
// //                 value: 0.6,
// //                 groupValue: _speechRate,
// //                 onChanged: (value) => Navigator.pop(context, value),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //
// //     if (newRate != null) {
// //       setState(() {
// //         _speechRate = newRate;
// //       });
// //       await _flutterTts.setSpeechRate(_speechRate);
// //     }
// //   }
// //
// //   Future<void> _startRecording() async {
// //     final hasPermission = await _checkAudioPermissions();
// //     if (!hasPermission) return;
// //
// //     try {
// //       if (await _audioRecorder.isRecording()) {
// //         await _stopRecording();
// //         return;
// //       }
// //
// //       final directory = await getApplicationDocumentsDirectory();
// //       final filePath = path.join(
// //         directory.path,
// //         'recording_${DateTime.now().millisecondsSinceEpoch}.m4a',
// //       );
// //
// //       setState(() {
// //         _isRecording = true;
// //         _recordedAudioPath = filePath;
// //       });
// //
// //       await _audioRecorder.start(
// //         RecordConfig(encoder: AudioEncoder.aacLc),
// //         path: filePath,
// //       );
// //
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('جارٍ تسجيل قراءتك...'),
// //           backgroundColor: Colors.green,
// //           behavior: SnackBarBehavior.floating,
// //         ),
// //       );
// //
// //     } catch (e) {
// //       setState(() {
// //         _isRecording = false;
// //       });
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('حدث خطأ في بدء التسجيل: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _stopRecording() async {
// //     try {
// //       final String? path = await _audioRecorder.stop();
// //       setState(() {
// //         _isRecording = false;
// //       });
// //
// //       if (path != null) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('تم حفظ التسجيل بنجاح'),
// //             backgroundColor: Colors.green,
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       setState(() {
// //         _isRecording = false;
// //       });
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('حدث خطأ في إيقاف التسجيل: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _playStudentRecording() async {
// //     if (_recordedAudioPath == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('لا يوجد تسجيل للعب'),
// //           backgroundColor: Colors.orange,
// //         ),
// //       );
// //       return;
// //     }
// //
// //     try {
// //       setState(() {
// //         _isPlayingRecording = true;
// //       });
// //
// //       await _audioPlayer.play(DeviceFileSource(_recordedAudioPath!));
// //
// //     } catch (e) {
// //       setState(() {
// //         _isPlayingRecording = false;
// //       });
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('حدث خطأ في تشغيل التسجيل: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _stopStudentRecording() async {
// //     try {
// //       await _audioPlayer.stop();
// //       setState(() {
// //         _isPlayingRecording = false;
// //       });
// //     } catch (e) {
// //       print('Error stopping playback: $e');
// //     }
// //   }
// //
// //   Widget _buildAppBar() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// //       decoration: BoxDecoration(
// //         color: Color(0xFF4CAF50),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black26,
// //             blurRadius: 8.w,
// //             offset: Offset(0, 2.h),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           IconButton(
// //             icon: Icon(Icons.arrow_back_ios_new_rounded, size: 22.sp),
// //             onPressed: () => Navigator.pop(context),
// //             color: Colors.white,
// //           ),
// //           Expanded(
// //             child: Text(
// //               widget.lesson['title'] ?? 'بدون عنوان',
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontSize: 20.sp,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //               textAlign: TextAlign.center,
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.speed_rounded, size: 22.sp),
// //             onPressed: _changeSpeechRate,
// //             color: Colors.white,
// //             tooltip: 'سرعة التشغيل',
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAnimatedText() {
// //     if (_words.isEmpty) {
// //       return Text(
// //         widget.lesson['content'] ?? '',
// //         style: TextStyle(fontSize: 18.sp, height: 2.0, color: Colors.black87),
// //         textDirection: TextDirection.rtl,
// //         textAlign: TextAlign.center,
// //       );
// //     }
// //
// //     return Directionality(
// //       textDirection: TextDirection.rtl,
// //       child: Wrap(
// //         alignment: WrapAlignment.center,
// //         crossAxisAlignment: WrapCrossAlignment.center,
// //         spacing: 4.w,
// //         runSpacing: 8.h,
// //         children: List.generate(_words.length, (index) {
// //           final word = _words[index];
// //           final isCurrentWord = index == _currentWordIndex;
// //
// //           return AnimatedBuilder(
// //             animation: _wordAnimations[index],
// //             builder: (context, child) {
// //               final scale = isCurrentWord ?
// //               (1.0 + _wordAnimations[index].value * 0.5) : 1.0;
// //               final color = isCurrentWord ?
// //               Color.lerp(Colors.black, Colors.red, _wordAnimations[index].value)! :
// //               Colors.black87;
// //               final bgColor = isCurrentWord ?
// //               Colors.red.withOpacity(_wordAnimations[index].value * 0.2) :
// //               Colors.transparent;
// //
// //               return Transform.scale(
// //                 scale: scale,
// //                 child: Container(
// //                   margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
// //                   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
// //                   decoration: BoxDecoration(
// //                     color: bgColor,
// //                     borderRadius: BorderRadius.circular(12.w),
// //                     border: isCurrentWord ? Border.all(
// //                       color: Colors.red.withOpacity(0.6),
// //                       width: 2.w,
// //                     ) : null,
// //                     boxShadow: isCurrentWord ? [
// //                       BoxShadow(
// //                         color: Colors.red.withOpacity(0.3),
// //                         blurRadius: 12.w,
// //                         spreadRadius: 2.w,
// //                         offset: Offset(0, 4.h),
// //                       ),
// //                     ] : null,
// //                   ),
// //                   child: Text(
// //                     word,
// //                     style: TextStyle(
// //                       fontSize: 20.sp,
// //                       height: 1.6,
// //                       color: color,
// //                       fontWeight: isCurrentWord ? FontWeight.bold : FontWeight.normal,
// //                       shadows: isCurrentWord ? [
// //                         Shadow(
// //                           blurRadius: 4.0,
// //                           color: Colors.red.withOpacity(0.5),
// //                           offset: Offset(0, 2.h),
// //                         )
// //                       ] : null,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         }),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonContent() {
// //     return SingleChildScrollView(
// //       padding: EdgeInsets.all(20.w),
// //       child: Column(
// //         children: [
// //           // بطاقة النص الرئيسي
// //           Container(
// //             width: double.infinity,
// //             padding: EdgeInsets.all(24.w),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(20.w),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black12,
// //                   blurRadius: 16.w,
// //                   offset: Offset(0, 6.h),
// //                 ),
// //               ],
// //             ),
// //             child: _buildAnimatedText(),
// //           ),
// //
// //           SizedBox(height: 30.h),
// //
// //           // قسم التسجيل (يظهر بعد انتهاء التشغيل)
// //           if (_showRecordingSection) _buildRecordingSection(),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRecordingSection() {
// //     return AnimatedContainer(
// //       duration: Duration(milliseconds: 600),
// //       curve: Curves.easeInOut,
// //       padding: EdgeInsets.all(24.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 16.w,
// //             offset: Offset(0, 6.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Text(
// //             '🎤 الآن دورك للقراءة',
// //             style: TextStyle(
// //               fontSize: 20.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF2E7D32),
// //             ),
// //             textAlign: TextAlign.center,
// //           ),
// //           SizedBox(height: 8.h),
// //           Text(
// //             'سجل قراءتك ثم استمع لها',
// //             style: TextStyle(
// //               fontSize: 14.sp,
// //               color: Colors.grey[600],
// //             ),
// //           ),
// //           SizedBox(height: 24.h),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               _buildRecordingButton(),
// //               _buildPlayRecordingButton(),
// //             ],
// //           ),
// //           if (_recordedAudioPath != null) ...[
// //             SizedBox(height: 16.h),
// //             Container(
// //               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
// //               decoration: BoxDecoration(
// //                 color: Colors.green[50],
// //                 borderRadius: BorderRadius.circular(12.w),
// //                 border: Border.all(color: Colors.green[200]!),
// //               ),
// //               child: Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Icon(Icons.check_circle, color: Colors.green, size: 16.sp),
// //                   SizedBox(width: 8.w),
// //                   Text(
// //                     'تم التسجيل بنجاح',
// //                     style: TextStyle(
// //                       fontSize: 12.sp,
// //                       color: Colors.green[800],
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRecordingButton() {
// //     return Column(
// //       children: [
// //         GestureDetector(
// //           onTapDown: (_) => _startRecording(),
// //           onTapUp: (_) => _stopRecording(),
// //           child: AnimatedContainer(
// //             duration: Duration(milliseconds: 300),
// //             width: 80.w,
// //             height: 80.h,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: _isRecording ? Colors.red : Color(0xFF4CAF50),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: (_isRecording ? Colors.red : Color(0xFF4CAF50)).withOpacity(0.4),
// //                   blurRadius: 12.w,
// //                   spreadRadius: 4.w,
// //                 ),
// //               ],
// //               gradient: _isRecording ? LinearGradient(
// //                 colors: [Colors.red, Colors.redAccent],
// //               ) : null,
// //             ),
// //             child: Icon(
// //               _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
// //               color: Colors.white,
// //               size: 32.sp,
// //             ),
// //           ),
// //         ),
// //         SizedBox(height: 12.h),
// //         Text(
// //           _isRecording ? 'جارٍ التسجيل...' : 'اضغط للتسجيل',
// //           style: TextStyle(
// //             fontSize: 14.sp,
// //             fontWeight: FontWeight.w500,
// //             color: _isRecording ? Colors.red : Color(0xFF2E7D32),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildPlayRecordingButton() {
// //     final bool hasRecording = _recordedAudioPath != null;
// //
// //     return Column(
// //       children: [
// //         GestureDetector(
// //           onTap: _isPlayingRecording ? _stopStudentRecording : _playStudentRecording,
// //           child: Container(
// //             width: 80.w,
// //             height: 80.h,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: _isPlayingRecording ? Colors.orange :
// //               (hasRecording ? Color(0xFF2196F3) : Colors.grey[400]),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: (_isPlayingRecording ? Colors.orange :
// //                   (hasRecording ? Color(0xFF2196F3) : Colors.grey[400]!))
// //                       .withOpacity(0.4),
// //                   blurRadius: 12.w,
// //                   spreadRadius: 4.w,
// //                 ),
// //               ],
// //               gradient: hasRecording ? LinearGradient(
// //                 colors: _isPlayingRecording ?
// //                 [Colors.orange, Colors.deepOrange] :
// //                 [Color(0xFF2196F3), Color(0xFF1976D2)],
// //               ) : null,
// //             ),
// //             child: Icon(
// //               _isPlayingRecording ? Icons.stop_rounded :
// //               (hasRecording ? Icons.play_arrow_rounded : Icons.volume_off_rounded),
// //               color: Colors.white,
// //               size: 32.sp,
// //             ),
// //           ),
// //         ),
// //         SizedBox(height: 12.h),
// //         Text(
// //           _isPlayingRecording ? 'جارٍ التشغيل...' :
// //           (hasRecording ? 'استمع لتسجيلك' : 'لا يوجد تسجيل'),
// //           style: TextStyle(
// //             fontSize: 14.sp,
// //             fontWeight: FontWeight.w500,
// //             color: _isPlayingRecording ? Colors.orange :
// //             (hasRecording ? Color(0xFF1976D2) : Colors.grey),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildControlButtons() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, -2.h),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //         children: [
// //           _buildControlButton(
// //             icon: _isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
// //             text: _isPlaying ? 'إيقاف' : 'تشغيل',
// //             onPressed: _isPlaying ? _stopPlaying : _playLesson,
// //             color: _isPlaying ? Colors.red : Color(0xFF4CAF50),
// //           ),
// //           _buildControlButton(
// //             icon: Icons.replay_rounded,
// //             text: 'إعادة',
// //             onPressed: _repeatLesson,
// //             color: Color(0xFFFF9800),
// //           ),
// //           _buildControlButton(
// //             icon: Icons.volume_up_rounded,
// //             text: 'البطيء',
// //             onPressed: _changeSpeechRate,
// //             color: Color(0xFF9C27B0),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildControlButton({
// //     required IconData icon,
// //     required String text,
// //     required VoidCallback onPressed,
// //     required Color color,
// //   }) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 64.w,
// //           height: 64.h,
// //           decoration: BoxDecoration(
// //             color: color,
// //             shape: BoxShape.circle,
// //             boxShadow: [
// //               BoxShadow(
// //                 color: color.withOpacity(0.4),
// //                 blurRadius: 8.w,
// //                 offset: Offset(0, 4.h),
// //               ),
// //             ],
// //           ),
// //           child: IconButton(
// //             icon: Icon(icon, size: 28.sp),
// //             onPressed: onPressed,
// //             color: Colors.white,
// //           ),
// //         ),
// //         SizedBox(height: 8.h),
// //         Text(
// //           text,
// //           style: TextStyle(
// //             fontSize: 12.sp,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.black87,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color(0xFFF5FDF6),
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             _buildAppBar(),
// //             Expanded(child: _buildLessonContent()),
// //             _buildControlButtons(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     for (final controller in _wordControllers) {
// //       controller.dispose();
// //     }
// //     _flutterTts.stop();
// //     _audioPlayer.dispose();
// //     _audioRecorder.dispose();
// //     super.dispose();
// //   }
// // }
//
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart';
// // import 'package:audioplayers/audioplayers.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:confetti/confetti.dart';
// // import 'package:lottie/lottie.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   await Supabase.initialize(
// //     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
// //     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
// //   );
// //
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ScreenUtilInit(
// //       designSize: Size(360, 690),
// //       minTextAdapt: true,
// //       splitScreenMode: true,
// //       builder: (_, child) {
// //         return MaterialApp(
// //           title: 'تطبيق تعلم القراءة',
// //           theme: ThemeData(
// //             primarySwatch: Colors.green,
// //             fontFamily: 'Tajawal',
// //           ),
// //           home: LessonsListScreen(),
// //           debugShowCheckedModeBanner: false,
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // // شاشة قائمة الدروس
// // class LessonsListScreen extends StatefulWidget {
// //   @override
// //   _LessonsListScreenState createState() => _LessonsListScreenState();
// // }
// //
// // class _LessonsListScreenState extends State<LessonsListScreen> {
// //   final SupabaseClient supabase = Supabase.instance.client;
// //   List<Map<String, dynamic>> lessons = [];
// //   bool isLoading = false;
// //   String errorMessage = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadLessonsFromSupabase();
// //   }
// //
// //   Future<void> _loadLessonsFromSupabase() async {
// //     setState(() {
// //       isLoading = true;
// //       errorMessage = '';
// //     });
// //
// //     try {
// //       final response = await supabase
// //           .from('lessons')
// //           .select()
// //           .order('order_number');
// //
// //       if (response != null && response.isNotEmpty) {
// //         setState(() {
// //           lessons = List<Map<String, dynamic>>.from(response);
// //         });
// //       } else {
// //         setState(() {
// //           errorMessage = 'لا توجد دروس متاحة';
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         errorMessage = 'خطأ في تحميل الدروس: $e';
// //       });
// //     } finally {
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }
// //
// //   void _navigateToLesson(Map<String, dynamic> lesson) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => LessonDetailScreen(lesson: lesson),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color(0xFF4CAF50),
// //         foregroundColor: Colors.white,
// //         title: Text(
// //           'مكتبة الدروس التعليمية',
// //           style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: _loadLessonsFromSupabase,
// //             tooltip: 'تحديث الدروس',
// //           ),
// //         ],
// //       ),
// //       backgroundColor: Color(0xFFE8F5E9),
// //       body: isLoading
// //           ? _buildLoadingWidget()
// //           : errorMessage.isNotEmpty
// //           ? _buildErrorWidget()
// //           : _buildLessonsGrid(),
// //     );
// //   }
// //
// //   Widget _buildLoadingWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           CircularProgressIndicator(color: Color(0xFF4CAF50)),
// //           SizedBox(height: 20.h),
// //           Text(
// //             'جاري تحميل الدروس...',
// //             style: TextStyle(fontSize: 18.sp, color: Color(0xFF2E7D32)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildErrorWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
// //           SizedBox(height: 16.h),
// //           Text(
// //             errorMessage,
// //             style: TextStyle(fontSize: 16.sp, color: Colors.red[700]),
// //             textAlign: TextAlign.center,
// //           ),
// //           SizedBox(height: 20.h),
// //           ElevatedButton(
// //             onPressed: _loadLessonsFromSupabase,
// //             child: Text('إعادة المحاولة'),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Color(0xFF4CAF50),
// //               foregroundColor: Colors.white,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonsGrid() {
// //     return Padding(
// //       padding: EdgeInsets.all(16.w),
// //       child: GridView.builder(
// //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2,
// //           crossAxisSpacing: 16.w,
// //           mainAxisSpacing: 16.h,
// //           childAspectRatio: 0.8,
// //         ),
// //         itemCount: lessons.length,
// //         itemBuilder: (context, index) {
// //           final lesson = lessons[index];
// //           return _buildLessonCard(lesson, index);
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
// //     int orderNumber = lesson['order_number'] ?? (index + 1);
// //
// //     return Card(
// //       elevation: 4.w,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
// //       child: InkWell(
// //         onTap: () => _navigateToLesson(lesson),
// //         borderRadius: BorderRadius.circular(12.w),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             gradient: LinearGradient(
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //               colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
// //             ),
// //             borderRadius: BorderRadius.circular(12.w),
// //           ),
// //           child: Stack(
// //             children: [
// //               Positioned(
// //                 top: 8.h,
// //                 right: 8.w,
// //                 child: Container(
// //                   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white.withOpacity(0.2),
// //                     borderRadius: BorderRadius.circular(8.w),
// //                   ),
// //                   child: Text(
// //                     '$orderNumber',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 14.sp,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Center(
// //                 child: Padding(
// //                   padding: EdgeInsets.all(16.w),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         Icons.menu_book,
// //                         size: 40.sp,
// //                         color: Colors.white,
// //                       ),
// //                       SizedBox(height: 12.h),
// //                       Text(
// //                         lesson['title'] ?? 'بدون عنوان',
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 16.sp,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                         textAlign: TextAlign.center,
// //                         maxLines: 2,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       SizedBox(height: 8.h),
// //                       Text(
// //                         'المستوى: ${lesson['level'] ?? 'مبتدئ'}',
// //                         style: TextStyle(
// //                           color: Colors.white.withOpacity(0.8),
// //                           fontSize: 12.sp,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // شاشة تفاصيل الدرس
// // class LessonDetailScreen extends StatefulWidget {
// //   final Map<String, dynamic> lesson;
// //
// //   const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);
// //
// //   @override
// //   _LessonDetailScreenState createState() => _LessonDetailScreenState();
// // }
// //
// // class _LessonDetailScreenState extends State<LessonDetailScreen>
// //     with TickerProviderStateMixin {
// //   final FlutterTts flutterTts = FlutterTts();
// //   final AudioPlayer audioPlayer = AudioPlayer();
// //   final stt.SpeechToText speechToText = stt.SpeechToText();
// //   final ConfettiController _confettiController = ConfettiController(duration: Duration(seconds: 3));
// //
// //   List<String> words = [];
// //   int currentWordIndex = -1;
// //   bool isPlaying = false;
// //   bool isRecording = false;
// //   bool showRecordingSection = false;
// //   bool isEvaluating = false;
// //   bool showResults = false;
// //   double matchPercentage = 0.0;
// //   String studentSpeech = '';
// //   String feedbackMessage = '';
// //
// //   late AnimationController _animationController;
// //   late Animation<double> _animation;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     _animationController = AnimationController(
// //       duration: Duration(milliseconds: 400),
// //       vsync: this,
// //     );
// //
// //     _animation = CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeInOut,
// //     );
// //
// //     _setupTTS();
// //     _setupAudioPlayer();
// //     _initializeText();
// //     _initSpeech();
// //   }
// //
// //   Future<void> _initSpeech() async {
// //     bool available = await speechToText.initialize();
// //     if (!available) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('تعذر تفعيل خاصية التعرف على الكلام')),
// //       );
// //     }
// //   }
// //
// //   Future<void> _setupTTS() async {
// //     await flutterTts.setLanguage("ar-SA");
// //     await flutterTts.setPitch(1.0);
// //     await flutterTts.setSpeechRate(0.4);
// //     await flutterTts.setVolume(1.0);
// //
// //     flutterTts.setStartHandler(() {
// //       setState(() {
// //         isPlaying = true;
// //         showRecordingSection = false;
// //         showResults = false;
// //       });
// //     });
// //
// //     flutterTts.setCompletionHandler(() {
// //       setState(() {
// //         isPlaying = false;
// //         currentWordIndex = -1;
// //         showRecordingSection = true;
// //         _animationController.reset();
// //       });
// //     });
// //
// //     flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
// //       _onWordSpoken(word, startOffset, endOffset);
// //     });
// //   }
// //
// //   void _setupAudioPlayer() {
// //     audioPlayer.onPlayerStateChanged.listen((PlayerState state) {});
// //   }
// //
// //   void _onWordSpoken(String word, int startOffset, int endOffset) {
// //     if (mounted) {
// //       setState(() {
// //         final text = widget.lesson['content'] ?? '';
// //         words = _splitTextIntoWords(text);
// //         currentWordIndex = _findWordIndex(text, startOffset);
// //         _animationController.forward(from: 0.0);
// //       });
// //     }
// //   }
// //
// //   List<String> _splitTextIntoWords(String text) {
// //     return text.split(RegExp(r'\s+'));
// //   }
// //
// //   int _findWordIndex(String fullText, int startOffset) {
// //     final words = _splitTextIntoWords(fullText);
// //     int currentPosition = 0;
// //
// //     for (int i = 0; i < words.length; i++) {
// //       final word = words[i];
// //       if (startOffset >= currentPosition && startOffset < currentPosition + word.length) {
// //         return i;
// //       }
// //       currentPosition += word.length + 1;
// //     }
// //     return -1;
// //   }
// //
// //   void _initializeText() {
// //     final text = widget.lesson['content'] ?? '';
// //     words = _splitTextIntoWords(text);
// //     currentWordIndex = -1;
// //     _animationController.reset();
// //   }
// //
// //   Future<void> _playLesson() async {
// //     await _speakText(widget.lesson['content'] ?? '');
// //   }
// //
// //   Future<void> _speakText(String text) async {
// //     setState(() {
// //       currentWordIndex = -1;
// //       showRecordingSection = false;
// //       showResults = false;
// //       _animationController.reset();
// //     });
// //
// //     await flutterTts.speak(text);
// //   }
// //
// //   Future<void> _stopPlaying() async {
// //     await flutterTts.stop();
// //     setState(() {
// //       isPlaying = false;
// //       currentWordIndex = -1;
// //       _animationController.reset();
// //     });
// //   }
// //
// //   Future<void> _repeatLesson() async {
// //     await _speakText(widget.lesson['content'] ?? '');
// //   }
// //
// //   Future<void> _startRecording() async {
// //     bool hasPermission = await _checkAudioPermissions();
// //     if (!hasPermission) return;
// //
// //     if (await speechToText.isAvailable) {
// //       setState(() {
// //         isRecording = true;
// //         studentSpeech = '';
// //         showResults = false;
// //       });
// //
// //       await speechToText.listen(
// //         onResult: (result) {
// //           setState(() {
// //             studentSpeech = result.recognizedWords;
// //           });
// //         },
// //         localeId: 'ar_SA',
// //         listenFor: Duration(seconds: 30),
// //       );
// //     }
// //   }
// //
// //   Future<void> _stopRecording() async {
// //     setState(() {
// //       isRecording = false;
// //     });
// //     await speechToText.stop();
// //
// //     if (studentSpeech.isNotEmpty) {
// //       _evaluateSpeech();
// //     }
// //   }
// //
// //   Future<bool> _checkAudioPermissions() async {
// //     PermissionStatus status = await Permission.microphone.request();
// //     return status == PermissionStatus.granted;
// //   }
// //
// //   void _evaluateSpeech() {
// //     setState(() {
// //       isEvaluating = true;
// //     });
// //
// //     Future.delayed(Duration(seconds: 2), () {
// //       String originalText = (widget.lesson['content'] ?? '').toLowerCase();
// //       String studentText = studentSpeech.toLowerCase();
// //
// //       double percentage = _calculateMatchPercentage(originalText, studentText);
// //
// //       setState(() {
// //         matchPercentage = percentage;
// //         isEvaluating = false;
// //         showResults = true;
// //       });
// //
// //       if (percentage >= 75) {
// //         _confettiController.play();
// //         _showSuccessCelebration();
// //       }
// //     });
// //   }
// //
// //   double _calculateMatchPercentage(String original, String student) {
// //     if (original.isEmpty) return 0.0;
// //
// //     List<String> originalWords = _splitTextIntoWords(original);
// //     List<String> studentWords = _splitTextIntoWords(student);
// //
// //     int matches = 0;
// //     for (String word in originalWords) {
// //       if (studentWords.any((studentWord) => _wordsAreSimilar(word, studentWord))) {
// //         matches++;
// //       }
// //     }
// //
// //     return (matches / originalWords.length) * 100;
// //   }
// //
// //   bool _wordsAreSimilar(String word1, String word2) {
// //     // خوارزمية مبسطة لمقارنة الكلمات مع مراعاة الأخطاء البسيطة
// //     if (word1 == word2) return true;
// //     if (word1.length < 3 || word2.length < 3) return word1 == word2;
// //
// //     // مقارنة الأحرف المشتركة
// //     int commonChars = 0;
// //     for (int i = 0; i < min(word1.length, word2.length); i++) {
// //       if (word1[i] == word2[i]) commonChars++;
// //     }
// //
// //     double similarity = commonChars / max(word1.length, word2.length);
// //     return similarity >= 0.7;
// //   }
// //
// //   void _showSuccessCelebration() {
// //     audioPlayer.play(AssetSource('sounds/success.mp3'));
// //   }
// //
// //   void _resetLesson() {
// //     setState(() {
// //       showResults = false;
// //       studentSpeech = '';
// //       matchPercentage = 0.0;
// //       showRecordingSection = true;
// //     });
// //   }
// //
// //   String _getFeedbackMessage(double percentage) {
// //     if (percentage >= 90) return 'ممتاز! 👏 قراءة رائعة';
// //     if (percentage >= 75) return 'جيد جداً! 👍 واصل التقدم';
// //     if (percentage >= 60) return 'جيد! 😊 يمكنك التحسين';
// //     if (percentage >= 40) return 'محاولة جيدة! 💪 حاول مرة أخرى';
// //     return 'حاول مرة أخرى! ✨ لا تستسلم';
// //   }
// //
// //   Color _getPercentageColor(double percentage) {
// //     if (percentage >= 75) return Colors.green;
// //     if (percentage >= 50) return Colors.orange;
// //     return Colors.red;
// //   }
// //
// //   Widget _buildAppBar() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// //       decoration: BoxDecoration(
// //         color: Color(0xFF4CAF50),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, 2.h),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           IconButton(
// //             icon: Icon(Icons.arrow_back, color: Colors.white),
// //             onPressed: () => Navigator.pop(context),
// //           ),
// //           Expanded(
// //             child: Text(
// //               widget.lesson['title'] ?? 'بدون عنوان',
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontSize: 20.sp,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //           ),
// //           SizedBox(width: 48.w),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLessonContent() {
// //     return SingleChildScrollView(
// //       padding: EdgeInsets.all(24.w),
// //       child: Column(
// //         children: [
// //           Container(
// //             width: double.infinity,
// //             padding: EdgeInsets.all(20.w),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(16.w),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black12,
// //                   blurRadius: 12.w,
// //                   offset: Offset(0, 4.h),
// //                 ),
// //               ],
// //             ),
// //             child: _buildAnimatedText(),
// //           ),
// //           SizedBox(height: 30.h),
// //           if (showRecordingSection && !showResults) _buildRecordingSection(),
// //           if (isEvaluating) _buildEvaluatingWidget(),
// //           if (showResults) _buildResultsSection(),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAnimatedText() {
// //     if (words.isEmpty) {
// //       return Text(
// //         widget.lesson['content'] ?? '',
// //         style: TextStyle(fontSize: 18.sp, height: 2.0),
// //         textDirection: TextDirection.rtl,
// //         textAlign: TextAlign.center,
// //       );
// //     }
// //
// //     return Directionality(
// //       textDirection: TextDirection.rtl,
// //       child: Wrap(
// //         alignment: WrapAlignment.center,
// //         crossAxisAlignment: WrapCrossAlignment.center,
// //         children: words.asMap().entries.map((entry) {
// //           final index = entry.key;
// //           final word = entry.value;
// //           final isCurrentWord = index == currentWordIndex;
// //
// //           return AnimatedBuilder(
// //             animation: _animation,
// //             builder: (context, child) {
// //               final scale = isCurrentWord ? (1.0 + _animation.value * 0.4) : 1.0;
// //               final color = isCurrentWord ?
// //               Color.lerp(Colors.black, Colors.red, _animation.value)! :
// //               Colors.black87;
// //
// //               return Transform.scale(
// //                 scale: scale,
// //                 child: Container(
// //                   margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
// //                   padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
// //                   decoration: isCurrentWord ? BoxDecoration(
// //                     gradient: LinearGradient(
// //                       colors: [Colors.red.shade100, Colors.orange.shade100],
// //                     ),
// //                     borderRadius: BorderRadius.circular(8.w),
// //                     border: Border.all(
// //                       color: Colors.red.withOpacity(0.5),
// //                       width: 2.w,
// //                     ),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.red.withOpacity(0.3),
// //                         blurRadius: 8.w,
// //                         offset: Offset(0, 2.h),
// //                       ),
// //                     ],
// //                   ) : null,
// //                   child: Text(
// //                     word,
// //                     style: TextStyle(
// //                       fontSize: 20.sp,
// //                       height: 1.8,
// //                       color: color,
// //                       fontWeight: isCurrentWord ? FontWeight.bold : FontWeight.normal,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRecordingSection() {
// //     return AnimatedContainer(
// //       duration: Duration(milliseconds: 500),
// //       padding: EdgeInsets.all(20.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 12.w,
// //             offset: Offset(0, 4.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Text(
// //             'الآن دورك للقراءة',
// //             style: TextStyle(
// //               fontSize: 18.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF2E7D32),
// //             ),
// //           ),
// //           SizedBox(height: 8.h),
// //           Text(
// //             'اضغط على الميكروفون واقرأ النص بصوت واضح',
// //             style: TextStyle(
// //               fontSize: 14.sp,
// //               color: Colors.grey[600],
// //             ),
// //             textAlign: TextAlign.center,
// //           ),
// //           SizedBox(height: 16.h),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               _buildRecordingButton(),
// //             ],
// //           ),
// //           if (studentSpeech.isNotEmpty) ...[
// //             SizedBox(height: 16.h),
// //             Container(
// //               padding: EdgeInsets.all(12.w),
// //               decoration: BoxDecoration(
// //                 color: Colors.grey[50],
// //                 borderRadius: BorderRadius.circular(8.w),
// //                 border: Border.all(color: Colors.grey[300]!),
// //               ),
// //               child: Text(
// //                 'ما تم التعرف عليه: $studentSpeech',
// //                 style: TextStyle(fontSize: 14.sp),
// //                 textAlign: TextAlign.center,
// //               ),
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildEvaluatingWidget() {
// //     return Container(
// //       padding: EdgeInsets.all(20.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 12.w,
// //             offset: Offset(0, 4.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           CircularProgressIndicator(color: Color(0xFF4CAF50)),
// //           SizedBox(height: 16.h),
// //           Text(
// //             'جاري تقييم قراءتك...',
// //             style: TextStyle(
// //               fontSize: 16.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF2E7D32),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildResultsSection() {
// //     return Container(
// //       padding: EdgeInsets.all(20.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 12.w,
// //             offset: Offset(0, 4.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           if (matchPercentage >= 75)
// //             Lottie.asset(
// //               'assets/animations/success.json',
// //               width: 120.w,
// //               height: 120.h,
// //             ),
// //
// //           Text(
// //             'نتيجة التقييم',
// //             style: TextStyle(
// //               fontSize: 20.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF2E7D32),
// //             ),
// //           ),
// //           SizedBox(height: 16.h),
// //
// //           // دائرة النسبة المئوية
// //           Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               Container(
// //                 width: 120.w,
// //                 height: 120.h,
// //                 child: CircularProgressIndicator(
// //                   value: matchPercentage / 100,
// //                   strokeWidth: 8.w,
// //                   backgroundColor: Colors.grey[300],
// //                   valueColor: AlwaysStoppedAnimation<Color>(_getPercentageColor(matchPercentage)),
// //                 ),
// //               ),
// //               Text(
// //                 '${matchPercentage.round()}%',
// //                 style: TextStyle(
// //                   fontSize: 24.sp,
// //                   fontWeight: FontWeight.bold,
// //                   color: _getPercentageColor(matchPercentage),
// //                 ),
// //               ),
// //             ],
// //           ),
// //
// //           SizedBox(height: 16.h),
// //
// //           Text(
// //             _getFeedbackMessage(matchPercentage),
// //             style: TextStyle(
// //               fontSize: 16.sp,
// //               fontWeight: FontWeight.w500,
// //               color: _getPercentageColor(matchPercentage),
// //             ),
// //             textAlign: TextAlign.center,
// //           ),
// //
// //           SizedBox(height: 20.h),
// //
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               ElevatedButton.icon(
// //                 onPressed: _resetLesson,
// //                 icon: Icon(Icons.replay),
// //                 label: Text('محاولة أخرى'),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Color(0xFFFF9800),
// //                   foregroundColor: Colors.white,
// //                 ),
// //               ),
// //               ElevatedButton.icon(
// //                 onPressed: _repeatLesson,
// //                 icon: Icon(Icons.volume_up),
// //                 label: Text('إعادة الاستماع'),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Color(0xFF4CAF50),
// //                   foregroundColor: Colors.white,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRecordingButton() {
// //     return Column(
// //       children: [
// //         GestureDetector(
// //           onTapDown: (_) => _startRecording(),
// //           onTapUp: (_) => _stopRecording(),
// //           child: AnimatedContainer(
// //             duration: Duration(milliseconds: 300),
// //             width: 80.w,
// //             height: 80.h,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: isRecording ? Colors.red : Color(0xFF4CAF50),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: (isRecording ? Colors.red : Color(0xFF4CAF50)).withOpacity(0.5),
// //                   blurRadius: 8.w,
// //                   spreadRadius: 2.w,
// //                 ),
// //               ],
// //             ),
// //             child: Icon(
// //               isRecording ? Icons.stop : Icons.mic,
// //               color: Colors.white,
// //               size: 36.sp,
// //             ),
// //           ),
// //         ),
// //         SizedBox(height: 8.h),
// //         Text(
// //           isRecording ? 'جارٍ التسجيل...' : 'اضغط للتسجيل',
// //           style: TextStyle(fontSize: 14.sp),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildControlButtons() {
// //     return Container(
// //       padding: EdgeInsets.all(20.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, -2.h),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //         children: [
// //           _buildControlButton(
// //             icon: isPlaying ? Icons.stop : Icons.play_arrow,
// //             text: isPlaying ? 'إيقاف' : 'تشغيل',
// //             onPressed: isPlaying ? _stopPlaying : _playLesson,
// //             color: isPlaying ? Colors.red : Color(0xFF4CAF50),
// //           ),
// //           _buildControlButton(
// //             icon: Icons.replay,
// //             text: 'إعادة',
// //             onPressed: _repeatLesson,
// //             color: Color(0xFFFF9800),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildControlButton({
// //     required IconData icon,
// //     required String text,
// //     required VoidCallback onPressed,
// //     required Color color,
// //   }) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 60.w,
// //           height: 60.h,
// //           decoration: BoxDecoration(
// //             color: color,
// //             shape: BoxShape.circle,
// //             boxShadow: [
// //               BoxShadow(
// //                 color: color.withOpacity(0.5),
// //                 blurRadius: 8.w,
// //                 offset: Offset(0, 3.h),
// //               ),
// //             ],
// //           ),
// //           child: IconButton(
// //             icon: Icon(icon, color: Colors.white),
// //             onPressed: onPressed,
// //           ),
// //         ),
// //         SizedBox(height: 8.h),
// //         Text(
// //           text,
// //           style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
// //           textAlign: TextAlign.center,
// //         ),
// //       ],
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: [
// //         Scaffold(
// //           backgroundColor: Color(0xFFE8F5E9),
// //           body: SafeArea(
// //             child: Column(
// //               children: [
// //                 _buildAppBar(),
// //                 Expanded(child: _buildLessonContent()),
// //                 if (!showResults) _buildControlButtons(),
// //               ],
// //             ),
// //           ),
// //         ),
// //
// //         // Confetti effect للاحتفال
// //         ConfettiWidget(
// //           confettiController: _confettiController,
// //           blastDirectionality: BlastDirectionality.explosive,
// //           shouldLoop: false,
// //           colors: const [
// //             Colors.green,
// //             Colors.blue,
// //             Colors.pink,
// //             Colors.orange,
// //             Colors.purple,
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     flutterTts.stop();
// //     audioPlayer.dispose();
// //     _confettiController.dispose();
// //     speechToText.stop();
// //     super.dispose();
// //   }
// // }
//
// import 'dart:math';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:confetti/confetti.dart';
// import 'package:lottie/lottie.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Supabase.initialize(
//     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
//   );
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, child) {
//         return MaterialApp(
//           title: 'تطبيق تعلم القراءة',
//           theme: ThemeData(
//             primarySwatch: Colors.green,
//             fontFamily: 'Tajawal',
//           ),
//           home: LessonsListScreen(),
//           debugShowCheckedModeBanner: false,
//         );
//       },
//     );
//   }
// }
//
// // شاشة قائمة الدروس
// class LessonsListScreen extends StatefulWidget {
//   @override
//   _LessonsListScreenState createState() => _LessonsListScreenState();
// }
//
// class _LessonsListScreenState extends State<LessonsListScreen> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   List<Map<String, dynamic>> lessons = [];
//   bool isLoading = false;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLessonsFromSupabase();
//   }
//
//   Future<void> _loadLessonsFromSupabase() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });
//
//     try {
//       final response = await supabase
//           .from('lessons')
//           .select()
//           .order('order_number');
//
//       if (response != null && response.isNotEmpty) {
//         setState(() {
//           lessons = List<Map<String, dynamic>>.from(response);
//         });
//       } else {
//         setState(() {
//           errorMessage = 'لا توجد دروس متاحة';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'خطأ في تحميل الدروس: $e';
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void _navigateToLesson(Map<String, dynamic> lesson) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonDetailScreen(lesson: lesson),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF4CAF50),
//         foregroundColor: Colors.white,
//         title: Text(
//           'مكتبة الدروس التعليمية',
//           style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadLessonsFromSupabase,
//             tooltip: 'تحديث الدروس',
//           ),
//         ],
//       ),
//       backgroundColor: Color(0xFFE8F5E9),
//       body: isLoading
//           ? _buildLoadingWidget()
//           : errorMessage.isNotEmpty
//           ? _buildErrorWidget()
//           : _buildLessonsGrid(),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(color: Color(0xFF4CAF50)),
//           SizedBox(height: 20.h),
//           Text(
//             'جاري تحميل الدروس...',
//             style: TextStyle(fontSize: 18.sp, color: Color(0xFF2E7D32)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//           SizedBox(height: 16.h),
//           Text(
//             errorMessage,
//             style: TextStyle(fontSize: 16.sp, color: Colors.red[700]),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20.h),
//           ElevatedButton(
//             onPressed: _loadLessonsFromSupabase,
//             child: Text('إعادة المحاولة'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF4CAF50),
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLessonsGrid() {
//     return Padding(
//       padding: EdgeInsets.all(16.w),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.w,
//           mainAxisSpacing: 16.h,
//           childAspectRatio: 0.8,
//         ),
//         itemCount: lessons.length,
//         itemBuilder: (context, index) {
//           final lesson = lessons[index];
//           return _buildLessonCard(lesson, index);
//         },
//       ),
//     );
//   }
//
//   Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
//     int orderNumber = lesson['order_number'] ?? (index + 1);
//
//     return Card(
//       elevation: 4.w,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
//       child: InkWell(
//         onTap: () => _navigateToLesson(lesson),
//         borderRadius: BorderRadius.circular(12.w),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
//             ),
//             borderRadius: BorderRadius.circular(12.w),
//           ),
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 8.h,
//                 right: 8.w,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(8.w),
//                   ),
//                   child: Text(
//                     '$orderNumber',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.w),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.menu_book,
//                         size: 40.sp,
//                         color: Colors.white,
//                       ),
//                       SizedBox(height: 12.h),
//                       Text(
//                         lesson['title'] ?? 'بدون عنوان',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         'المستوى: ${lesson['level'] ?? 'مبتدئ'}',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.8),
//                           fontSize: 12.sp,
//                         ),
//                       ),
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
// }
//
// // نموذج متقدم لتخزين معلومات الكلمة مع تحكم كامل في الموقع
// class AdvancedWordPosition {
//   final String word;
//   final double x;
//   final double y;
//   final double width;
//   final double height;
//   final double fontSize;
//   final Color textColor;
//   final Color backgroundColor;
//   final Color borderColor;
//   final double borderRadius;
//   final TextAlign textAlign;
//   final FontWeight fontWeight;
//   final bool isEditable;
//
//   AdvancedWordPosition({
//     required this.word,
//     required this.x,
//     required this.y,
//     this.width = 100,
//     this.height = 50,
//     this.fontSize = 24,
//     this.textColor = Colors.black,
//     this.backgroundColor = Colors.transparent,
//     this.borderColor = Colors.transparent,
//     this.borderRadius = 8,
//     this.textAlign = TextAlign.center,
//     this.fontWeight = FontWeight.normal,
//     this.isEditable = true,
//   });
//
//   AdvancedWordPosition copyWith({
//     String? word,
//     double? x,
//     double? y,
//     double? width,
//     double? height,
//     double? fontSize,
//     Color? textColor,
//     Color? backgroundColor,
//     Color? borderColor,
//     double? borderRadius,
//     TextAlign? textAlign,
//     FontWeight? fontWeight,
//     bool? isEditable,
//   }) {
//     return AdvancedWordPosition(
//       word: word ?? this.word,
//       x: x ?? this.x,
//       y: y ?? this.y,
//       width: width ?? this.width,
//       height: height ?? this.height,
//       fontSize: fontSize ?? this.fontSize,
//       textColor: textColor ?? this.textColor,
//       backgroundColor: backgroundColor ?? this.backgroundColor,
//       borderColor: borderColor ?? this.borderColor,
//       borderRadius: borderRadius ?? this.borderRadius,
//       textAlign: textAlign ?? this.textAlign,
//       fontWeight: fontWeight ?? this.fontWeight,
//       isEditable: isEditable ?? this.isEditable,
//     );
//   }
// }
//
// // شاشة تفاصيل الدرس
// class LessonDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> lesson;
//
//   const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);
//
//   @override
//   _LessonDetailScreenState createState() => _LessonDetailScreenState();
// }
//
// class _LessonDetailScreenState extends State<LessonDetailScreen>
//     with TickerProviderStateMixin {
//   final FlutterTts flutterTts = FlutterTts();
//   final AudioPlayer audioPlayer = AudioPlayer();
//   final stt.SpeechToText speechToText = stt.SpeechToText();
//   final ConfettiController _confettiController = ConfettiController(duration: Duration(seconds: 3));
//
//   List<String> words = [];
//   List<AdvancedWordPosition> wordPositions = [];
//   int currentWordIndex = -1;
//   bool isPlaying = false;
//   bool isRecording = false;
//   bool showRecordingSection = false;
//   bool isEvaluating = false;
//   bool showResults = false;
//   double matchPercentage = 0.0;
//   String studentSpeech = '';
//   String feedbackMessage = '';
//   DateTime? _recordingStartTime;
//   Timer? _recordingTimer;
//
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   // متغيرات للتحكم في التحرير
//   bool _isEditMode = false;
//   int? _selectedWordIndex;
//   double _screenWidth = 0;
//   double _screenHeight = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 400),
//       vsync: this,
//     );
//
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//
//     _setupTTS();
//     _setupAudioPlayer();
//     _initializeText();
//     _initSpeech();
//
//     // حساب أبعاد الشاشة بعد بناء الويدجت
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _calculateScreenSize();
//     });
//   }
//
//   void _calculateScreenSize() {
//     final mediaQuery = MediaQuery.of(context);
//     setState(() {
//       _screenWidth = mediaQuery.size.width;
//       _screenHeight = mediaQuery.size.height;
//     });
//     _initializeWordPositions();
//   }
//
//   Future<void> _initSpeech() async {
//     bool available = await speechToText.initialize(
//       onStatus: (status) {
//         print('Speech recognition status: $status');
//         if (status == 'done') {
//           if (isRecording) {
//             _restartRecording();
//           }
//         }
//       },
//       onError: (error) {
//         print('Speech recognition error: $error');
//         if (isRecording) {
//           _restartRecording();
//         }
//       },
//     );
//     if (!available) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('تعذر تفعيل خاصية التعرف على الكلام')),
//       );
//     }
//   }
//
//   Future<void> _setupTTS() async {
//     await flutterTts.setLanguage("ar-SA");
//     await flutterTts.setPitch(1.0);
//     await flutterTts.setSpeechRate(0.4);
//     await flutterTts.setVolume(1.0);
//
//     flutterTts.setStartHandler(() {
//       setState(() {
//         isPlaying = true;
//         showRecordingSection = false;
//         showResults = false;
//         currentWordIndex = -1;
//       });
//     });
//
//     flutterTts.setCompletionHandler(() {
//       setState(() {
//         isPlaying = false;
//         currentWordIndex = -1;
//         showRecordingSection = true;
//         _animationController.reset();
//       });
//     });
//
//     flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
//       _onWordSpoken(word, startOffset, endOffset);
//     });
//   }
//
//   void _setupAudioPlayer() {
//     audioPlayer.onPlayerStateChanged.listen((PlayerState state) {});
//   }
//
//   List<String> _splitTextIntoWords(String text) {
//     if (text.isEmpty) return [];
//     List<String> words = text.split(RegExp(r'\s+'));
//     words = words.where((word) => word.trim().isNotEmpty).toList();
//     return words;
//   }
//
//   void _onWordSpoken(String spokenWord, int startOffset, int endOffset) {
//     if (!mounted) return;
//
//     String fullText = widget.lesson['content'] ?? '';
//     List<String> allWords = _splitTextIntoWords(fullText);
//
//     int foundIndex = -1;
//     String cleanSpokenWord = spokenWord.trim();
//
//     for (int i = 0; i < allWords.length; i++) {
//       if (allWords[i].contains(cleanSpokenWord) ||
//           cleanSpokenWord.contains(allWords[i])) {
//         foundIndex = i;
//         break;
//       }
//     }
//
//     setState(() {
//       currentWordIndex = foundIndex;
//       _animationController.forward(from: 0.0);
//     });
//   }
//
//   void _initializeText() {
//     final text = widget.lesson['content'] ?? '';
//     words = _splitTextIntoWords(text);
//     currentWordIndex = -1;
//     _animationController.reset();
//   }
//
//   // دالة لتطبيق الإحداثيات المحددة للدرس الأول
//   void _initializeWordPositions() {
//     if (_screenWidth == 0 || _screenHeight == 0) return;
//
//     // التحقق إذا كان هذا هو الدرس الأول
//     bool isFirstLesson = widget.lesson['order_number'] == 1 ||
//         widget.lesson['title']?.contains('الأول') == true;
//
//     if (isFirstLesson && words.length >= 6) {
//       // تطبيق الإحداثيات المحددة للدرس الأول
//       _applyFirstLessonCoordinates();
//     } else {
//       // استخدام التوزيع الافتراضي للدروس الأخرى
//       _applyDefaultPositions();
//     }
//   }
//
//   void _applyFirstLessonCoordinates() {
//     List<AdvancedWordPosition> positions = [];
//
//     // الإحداثيات المحددة للدرس الأول (كنسبة مئوية من أبعاد الشاشة)
//     List<Map<String, dynamic>> firstLessonCoordinates = [
//       {'word': words[0], 'x': 0.68, 'y': 0.25, 'width': 120, 'height': 60}, // 🧍‍♀️ كبيرة وردية (علوية)
//       {'word': words[1], 'x': 0.47, 'y': 0.43, 'width': 120, 'height': 60}, // 🧍‍♀️ صغيرة وردية (يسار الوسط)
//       {'word': words[2], 'x': 0.75, 'y': 0.43, 'width': 120, 'height': 60}, // 🧍‍♀️ صغيرة وردية (يمين الوسط)
//       {'word': words[3], 'x': 0.18, 'y': 0.87, 'width': 100, 'height': 50}, // 👶 يسارية (سفلية)
//       {'word': words[4], 'x': 0.46, 'y': 0.87, 'width': 100, 'height': 50}, // 👶 وسطى (سفلية)
//       {'word': words[5], 'x': 0.72, 'y': 0.87, 'width': 100, 'height': 50}, // 👶 يمينية (سفلية)
//     ];
//
//     for (int i = 0; i < firstLessonCoordinates.length; i++) {
//       final coord = firstLessonCoordinates[i];
//       positions.add(AdvancedWordPosition(
//         word: coord['word'],
//         x: coord['x'] * _screenWidth - (coord['width'] / 2), // مركز الكلمة على الإحداثي X
//         y: coord['y'] * _screenHeight - (coord['height'] / 2), // مركز الكلمة على الإحداثي Y
//         width: coord['width'].toDouble(),
//         height: coord['height'].toDouble(),
//         fontSize: i < 3 ? 28 : 24, // حجم خط أكبر للكلمات العلوية
//         textColor: Colors.white,
//         backgroundColor: i < 3 ? Colors.pink.withOpacity(0.7) : Colors.blue.withOpacity(0.7),
//         borderColor: i < 3 ? Colors.pinkAccent : Colors.blueAccent,
//         borderRadius: 12,
//         fontWeight: FontWeight.bold,
//         isEditable: false,
//       ));
//     }
//
//     setState(() {
//       wordPositions = positions;
//     });
//   }
//
//   void _applyDefaultPositions() {
//     List<AdvancedWordPosition> positions = [];
//
//     // توزيع افتراضي للدروس الأخرى
//     double startX = 50;
//     double startY = 200;
//     double lineHeight = 60;
//
//     for (int i = 0; i < words.length; i++) {
//       double x = startX;
//       double y = startY + (i * lineHeight);
//
//       double estimatedWidth = words[i].length * 20.0 + 40;
//
//       positions.add(AdvancedWordPosition(
//         word: words[i],
//         x: x,
//         y: y,
//         width: estimatedWidth,
//         height: 50,
//         fontSize: 24,
//         textColor: Colors.black,
//         backgroundColor: Colors.transparent,
//         borderColor: Colors.transparent,
//         borderRadius: 8,
//         textAlign: TextAlign.center,
//         fontWeight: FontWeight.normal,
//         isEditable: true,
//       ));
//     }
//
//     setState(() {
//       wordPositions = positions;
//     });
//   }
//
//   // دالة لتحريك كلمة
//   void _moveWord(int index, Offset newPosition) {
//     setState(() {
//       wordPositions[index] = wordPositions[index].copyWith(
//         x: newPosition.dx,
//         y: newPosition.dy,
//       );
//     });
//   }
//
//   // الويدجيت: عرض الصورة مع التحكم الكامل في الكلمات
//   Widget _buildInteractiveImage() {
//     String backgroundImageUrl = widget.lesson['background_image'] ?? '';
//
//     if (backgroundImageUrl.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.image_not_supported, size: 60.sp, color: Colors.grey),
//             SizedBox(height: 16.h),
//             Text(
//               'لا توجد صورة للدرس',
//               style: TextStyle(fontSize: 18.sp, color: Colors.grey),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return Stack(
//       children: [
//         // الصورة الخلفية
//         CachedNetworkImage(
//           imageUrl: backgroundImageUrl,
//           fit: BoxFit.cover,
//           width: double.infinity,
//           height: double.infinity,
//           placeholder: (context, url) => Center(
//             child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
//           ),
//           errorWidget: (context, url, error) => Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error, size: 50.sp, color: Colors.red),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'خطأ في تحميل الصورة',
//                   style: TextStyle(fontSize: 16.sp, color: Colors.red),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         // الكلمات المرسومة على الصورة مع إمكانية التحكم
//         ...wordPositions.asMap().entries.map((entry) {
//           final index = entry.key;
//           final position = entry.value;
//           final isCurrentWord = index == currentWordIndex;
//           final isSelected = index == _selectedWordIndex;
//
//           return Positioned(
//             left: position.x,
//             top: position.y,
//             child: GestureDetector(
//               onTap: () {
//                 if (_isEditMode) {
//                   setState(() {
//                     _selectedWordIndex = index;
//                   });
//                 }
//               },
//               onPanUpdate: _isEditMode ? (details) {
//                 _moveWord(index, Offset(
//                   position.x + details.delta.dx,
//                   position.y + details.delta.dy,
//                 ));
//               } : null,
//               child: AnimatedBuilder(
//                 animation: _animation,
//                 builder: (context, child) {
//                   final backgroundColor = isCurrentWord
//                       ? Colors.red.withOpacity(0.8)
//                       : (isSelected ? Colors.yellow.withOpacity(0.5) : position.backgroundColor);
//
//                   final borderColor = isCurrentWord
//                       ? Colors.red
//                       : (isSelected ? Colors.orange : position.borderColor);
//
//                   final textColor = isCurrentWord ? Colors.white : position.textColor;
//
//                   return Container(
//                     width: position.width,
//                     height: position.height,
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//                     decoration: BoxDecoration(
//                       color: backgroundColor,
//                       borderRadius: BorderRadius.circular(position.borderRadius),
//                       border: Border.all(
//                         color: borderColor,
//                         width: isCurrentWord ? 4.w : (isSelected ? 3.w : 2.w),
//                       ),
//                       boxShadow: [
//                         if (isCurrentWord)
//                           BoxShadow(
//                             color: Colors.red.withOpacity(0.8),
//                             blurRadius: 15.w,
//                             spreadRadius: 5.w,
//                           ),
//                         if (isSelected && !isCurrentWord)
//                           BoxShadow(
//                             color: Colors.orange.withOpacity(0.6),
//                             blurRadius: 10.w,
//                             spreadRadius: 3.w,
//                           ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         position.word,
//                         style: TextStyle(
//                           fontSize: position.fontSize.sp,
//                           color: textColor,
//                           fontWeight: isCurrentWord ? FontWeight.bold : position.fontWeight,
//                           fontFamily: 'Tajawal',
//                           shadows: isCurrentWord ? [
//                             Shadow(
//                               color: Colors.black,
//                               blurRadius: 4.w,
//                               offset: Offset(1, 1),
//                             ),
//                           ] : [],
//                         ),
//                         textAlign: position.textAlign,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         }).toList(),
//
//         // مؤشر أن هذا هو الدرس الأول مع الإحداثيات المخصصة
//         if (widget.lesson['order_number'] == 1)
//           Positioned(
//             top: 10,
//             left: 10,
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//               decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(20.w),
//               ),
//               child: Text(
//                 '🎯 الإحداثيات المخصصة',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   void _toggleEditMode() {
//     setState(() {
//       _isEditMode = !_isEditMode;
//       _selectedWordIndex = null;
//     });
//   }
//
//   Widget _buildAppBar() {
//     bool isFirstLesson = widget.lesson['order_number'] == 1;
//
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.6),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.pop(context),
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   widget.lesson['title'] ?? 'بدون عنوان',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 if (isFirstLesson)
//                   Text(
//                     '🧒 درس متقدم بالإحداثيات المخصصة',
//                     style: TextStyle(
//                       color: Colors.yellow,
//                       fontSize: 10.sp,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           if (!isFirstLesson) // إخفاء زر التحرير في الدرس الأول
//             IconButton(
//               icon: Icon(_isEditMode ? Icons.edit_off : Icons.edit, color: Colors.white),
//               onPressed: _toggleEditMode,
//               tooltip: _isEditMode ? 'خروج من وضع التحرير' : 'وضع التحرير',
//             ),
//           SizedBox(width: 8.w),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLessonContent() {
//     return Stack(
//       children: [
//         // الصورة التفاعلية مع التحكم الكامل
//         _buildInteractiveImage(),
//
//         // أقسام التحكم
//         if (showRecordingSection && !showResults)
//           Positioned(
//             bottom: 120.h,
//             left: 20.w,
//             right: 20.w,
//             child: _buildRecordingSection(),
//           ),
//
//         if (isEvaluating)
//           Positioned(
//             bottom: 120.h,
//             left: 20.w,
//             right: 20.w,
//             child: _buildEvaluatingWidget(),
//           ),
//
//         if (showResults)
//           Positioned(
//             bottom: 120.h,
//             left: 20.w,
//             right: 20.w,
//             child: _buildResultsSection(),
//           ),
//       ],
//     );
//   }
//
//   // ... باقي الدوال (التسجيل، التقييم، etc.) تبقى كما هي ...
//
//   Future<void> _playLesson() async {
//     await _speakText(widget.lesson['content'] ?? '');
//   }
//
//   Future<void> _speakText(String text) async {
//     setState(() {
//       currentWordIndex = -1;
//       showRecordingSection = false;
//       showResults = false;
//       _animationController.reset();
//     });
//
//     await flutterTts.speak(text);
//   }
//
//   Future<void> _stopPlaying() async {
//     await flutterTts.stop();
//     setState(() {
//       isPlaying = false;
//       currentWordIndex = -1;
//       _animationController.reset();
//     });
//   }
//
//   Future<void> _repeatLesson() async {
//     await _speakText(widget.lesson['content'] ?? '');
//   }
//
//   Future<void> _toggleRecording() async {
//     if (isRecording) {
//       await _stopRecording();
//     } else {
//       await _startRecording();
//     }
//   }
//
//   Future<void> _startRecording() async {
//     bool hasPermission = await _checkAudioPermissions();
//     if (!hasPermission) return;
//
//     if (await speechToText.isAvailable) {
//       setState(() {
//         isRecording = true;
//         studentSpeech = '';
//         showResults = false;
//         _recordingStartTime = DateTime.now();
//       });
//
//       await _startListening();
//
//       _startRecordingTimer();
//     }
//   }
//
//   Future<void> _startListening() async {
//     try {
//       await speechToText.listen(
//         onResult: (result) {
//           if (result.finalResult) {
//             setState(() {
//               studentSpeech += ' ${result.recognizedWords}';
//             });
//             if (isRecording) {
//               Future.delayed(Duration(milliseconds: 500), () {
//                 _restartRecording();
//               });
//             }
//           }
//         },
//         localeId: 'ar-SA',
//         listenFor: Duration(minutes: 1),
//         pauseFor: Duration(seconds: 5),
//         listenMode: stt.ListenMode.confirmation,
//         cancelOnError: false,
//         partialResults: true,
//       );
//     } catch (e) {
//       print('Error starting speech recognition: $e');
//       if (isRecording) {
//         Future.delayed(Duration(seconds: 1), () {
//           _restartRecording();
//         });
//       }
//     }
//   }
//
//   Future<void> _restartRecording() async {
//     if (!isRecording) return;
//
//     try {
//       await speechToText.stop();
//       await Future.delayed(Duration(milliseconds: 300));
//       await _startListening();
//     } catch (e) {
//       print('Error restarting recording: $e');
//     }
//   }
//
//   void _startRecordingTimer() {
//     _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (!isRecording) {
//         timer.cancel();
//         return;
//       }
//       setState(() {});
//     });
//   }
//
//   Future<void> _stopRecording() async {
//     _recordingTimer?.cancel();
//     setState(() {
//       isRecording = false;
//       _recordingStartTime = null;
//     });
//
//     try {
//       await speechToText.stop();
//     } catch (e) {
//       print('Error stopping recording: $e');
//     }
//
//     if (studentSpeech.trim().isNotEmpty) {
//       _evaluateSpeech();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('لم يتم التعرف على أي كلام. حاول مرة أخرى')),
//       );
//     }
//   }
//
//   Future<bool> _checkAudioPermissions() async {
//     PermissionStatus status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('يجب منح صلاحية الميكروفون للتسجيل')),
//       );
//       return false;
//     }
//     return true;
//   }
//
//   void _evaluateSpeech() {
//     setState(() {
//       isEvaluating = true;
//     });
//
//     Future.delayed(Duration(seconds: 2), () {
//       String originalText = (widget.lesson['content'] ?? '').toLowerCase();
//       String studentText = studentSpeech.toLowerCase();
//
//       double percentage = _calculateMatchPercentage(originalText, studentText);
//
//       setState(() {
//         matchPercentage = percentage;
//         isEvaluating = false;
//         showResults = true;
//       });
//
//       if (percentage >= 75) {
//         _confettiController.play();
//         _showSuccessCelebration();
//       }
//     });
//   }
//
//   double _calculateMatchPercentage(String original, String student) {
//     if (original.isEmpty) return 0.0;
//
//     List<String> originalWords = _splitTextIntoWords(original);
//     List<String> studentWords = _splitTextIntoWords(student);
//
//     int matches = 0;
//     for (String word in originalWords) {
//       if (studentWords.any((studentWord) => _wordsAreSimilar(word, studentWord))) {
//         matches++;
//       }
//     }
//
//     return (matches / originalWords.length) * 100;
//   }
//
//   bool _wordsAreSimilar(String word1, String word2) {
//     if (word1 == word2) return true;
//     if (word1.length < 3 || word2.length < 3) return word1 == word2;
//
//     int commonChars = 0;
//     for (int i = 0; i < min(word1.length, word2.length); i++) {
//       if (word1[i] == word2[i]) commonChars++;
//     }
//
//     double similarity = commonChars / max(word1.length, word2.length);
//     return similarity >= 0.7;
//   }
//
//   void _showSuccessCelebration() {
//     audioPlayer.play(AssetSource('sounds/success.mp3'));
//   }
//
//   void _resetLesson() {
//     setState(() {
//       showResults = false;
//       studentSpeech = '';
//       matchPercentage = 0.0;
//       showRecordingSection = true;
//     });
//   }
//
//   String _getFeedbackMessage(double percentage) {
//     if (percentage >= 90) return 'ممتاز! 👏 قراءة رائعة';
//     if (percentage >= 75) return 'جيد جداً! 👍 واصل التقدم';
//     if (percentage >= 60) return 'جيد! 😊 يمكنك التحسين';
//     if (percentage >= 40) return 'محاولة جيدة! 💪 حاول مرة أخرى';
//     return 'حاول مرة أخرى! ✨ لا تستسلم';
//   }
//
//   Color _getPercentageColor(double percentage) {
//     if (percentage >= 75) return Colors.green;
//     if (percentage >= 50) return Colors.orange;
//     return Colors.red;
//   }
//
//   String _getRecordingDuration() {
//     if (_recordingStartTime == null) return '';
//     final duration = DateTime.now().difference(_recordingStartTime!);
//     final minutes = duration.inMinutes;
//     final seconds = duration.inSeconds.remainder(60);
//     return 'مدة التسجيل: $minutes:${seconds.toString().padLeft(2, '0')}';
//   }
//
//   Widget _buildRecordingSection() {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 16.w,
//             offset: Offset(0, 6.h),
//           ),
//         ],
//         border: Border.all(
//           color: Colors.white.withOpacity(0.8),
//           width: 2.w,
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             'الآن دورك للقراءة',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF2E7D32),
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             isRecording
//                 ? 'انقر على الميكروفون مرة أخرى لإنهاء التسجيل'
//                 : 'انقر على الميكروفون لبدء التسجيل واقرأ النص بصوت واضح',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.grey[700],
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildRecordingButton(),
//             ],
//           ),
//           if (isRecording && _recordingStartTime != null) ...[
//             SizedBox(height: 12.h),
//             Text(
//               _getRecordingDuration(),
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'التسجيل مستمر... يمكنك القراءة ببطء',
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: Colors.blue,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//           ],
//           if (studentSpeech.isNotEmpty) ...[
//             SizedBox(height: 16.h),
//             Container(
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 color: Colors.grey[50],
//                 borderRadius: BorderRadius.circular(8.w),
//                 border: Border.all(color: Colors.grey[300]!),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     'ما تم التعرف عليه:',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     studentSpeech,
//                     style: TextStyle(fontSize: 14.sp, color: Colors.black87),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEvaluatingWidget() {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 16.w,
//             offset: Offset(0, 6.h),
//           ),
//         ],
//         border: Border.all(
//           color: Colors.white.withOpacity(0.8),
//           width: 2.w,
//         ),
//       ),
//       child: Column(
//         children: [
//           CircularProgressIndicator(color: Color(0xFF4CAF50)),
//           SizedBox(height: 16.h),
//           Text(
//             'جاري تقييم قراءتك...',
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF2E7D32),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildResultsSection() {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 16.w,
//             offset: Offset(0, 6.h),
//           ),
//         ],
//         border: Border.all(
//           color: Colors.white.withOpacity(0.8),
//           width: 2.w,
//         ),
//       ),
//       child: Column(
//         children: [
//           if (matchPercentage >= 75)
//             Lottie.asset(
//               'assets/animations/success.json',
//               width: 120.w,
//               height: 120.h,
//             ),
//
//           Text(
//             'نتيجة التقييم',
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF2E7D32),
//             ),
//           ),
//           SizedBox(height: 16.h),
//
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 width: 120.w,
//                 height: 120.h,
//                 child: CircularProgressIndicator(
//                   value: matchPercentage / 100,
//                   strokeWidth: 8.w,
//                   backgroundColor: Colors.grey[300],
//                   valueColor: AlwaysStoppedAnimation<Color>(_getPercentageColor(matchPercentage)),
//                 ),
//               ),
//               Text(
//                 '${matchPercentage.round()}%',
//                 style: TextStyle(
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.bold,
//                   color: _getPercentageColor(matchPercentage),
//                 ),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 16.h),
//
//           Text(
//             _getFeedbackMessage(matchPercentage),
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w500,
//               color: _getPercentageColor(matchPercentage),
//             ),
//             textAlign: TextAlign.center,
//           ),
//
//           SizedBox(height: 20.h),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: _resetLesson,
//                 icon: Icon(Icons.replay),
//                 label: Text('محاولة أخرى'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFFF9800),
//                   foregroundColor: Colors.white,
//                 ),
//               ),
//               ElevatedButton.icon(
//                 onPressed: _repeatLesson,
//                 icon: Icon(Icons.volume_up),
//                 label: Text('إعادة الاستماع'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF4CAF50),
//                   foregroundColor: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRecordingButton() {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: _toggleRecording,
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             width: 80.w,
//             height: 80.h,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isRecording ? Colors.red : Color(0xFF4CAF50),
//               boxShadow: [
//                 BoxShadow(
//                   color: (isRecording ? Colors.red : Color(0xFF4CAF50)).withOpacity(0.5),
//                   blurRadius: 8.w,
//                   spreadRadius: 2.w,
//                 ),
//               ],
//             ),
//             child: Icon(
//               isRecording ? Icons.stop : Icons.mic,
//               color: Colors.white,
//               size: 36.sp,
//             ),
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           isRecording ? 'جارٍ التسجيل... انقر للإيقاف' : 'انقر لبدء التسجيل',
//           style: TextStyle(fontSize: 14.sp, color: Colors.black87),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildControlButtons() {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.3),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.w),
//           topRight: Radius.circular(20.w),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildControlButton(
//             icon: isPlaying ? Icons.stop : Icons.play_arrow,
//             text: isPlaying ? 'إيقاف' : 'تشغيل',
//             onPressed: isPlaying ? _stopPlaying : _playLesson,
//             color: isPlaying ? Colors.red : Color(0xFF4CAF50),
//           ),
//           _buildControlButton(
//             icon: Icons.replay,
//             text: 'إعادة',
//             onPressed: _repeatLesson,
//             color: Color(0xFFFF9800),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildControlButton({
//     required IconData icon,
//     required String text,
//     required VoidCallback onPressed,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 60.w,
//           height: 60.h,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.5),
//                 blurRadius: 8.w,
//                 offset: Offset(0, 3.h),
//               ),
//             ],
//           ),
//           child: IconButton(
//             icon: Icon(icon, color: Colors.white),
//             onPressed: onPressed,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 12.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             shadows: [
//               Shadow(
//                 color: Colors.black,
//                 blurRadius: 2.w,
//                 offset: Offset(1, 1),
//               ),
//             ],
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: Colors.black,
//           body: SafeArea(
//             child: Column(
//               children: [
//                 _buildAppBar(),
//                 Expanded(child: _buildLessonContent()),
//                 if (!showResults) _buildControlButtons(),
//               ],
//             ),
//           ),
//         ),
//
//         ConfettiWidget(
//           confettiController: _confettiController,
//           blastDirectionality: BlastDirectionality.explosive,
//           shouldLoop: false,
//           colors: const [
//             Colors.green,
//             Colors.blue,
//             Colors.pink,
//             Colors.orange,
//             Colors.purple,
//           ],
//         ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     flutterTts.stop();
//     audioPlayer.dispose();
//     _confettiController.dispose();
//     speechToText.stop();
//     _recordingTimer?.cancel();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Supabase.initialize(
//     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
//     anonKey:
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
//   );
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, child) {
//         return MaterialApp(
//           title: 'تطبيق تعلم القراءة',
//           theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Tajawal'),
//           home: LessonsListScreen(),
//           debugShowCheckedModeBanner: false,
//         );
//       },
//     );
//   }
// }
//
// // شاشة قائمة الدروس
// class LessonsListScreen extends StatefulWidget {
//   @override
//   _LessonsListScreenState createState() => _LessonsListScreenState();
// }
//
// class _LessonsListScreenState extends State<LessonsListScreen> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   List<Map<String, dynamic>> lessons = [];
//   bool isLoading = false;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLessonsFromSupabase();
//   }
//
//   Future<void> _loadLessonsFromSupabase() async {
//     if (!mounted) return;
//
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });
//
//     try {
//       final response = await supabase
//           .from('lessons')
//           .select()
//           .order('order_number');
//
//       if (response != null && response.isNotEmpty) {
//         if (mounted) {
//           setState(() {
//             lessons = List<Map<String, dynamic>>.from(response);
//           });
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             errorMessage = 'لا توجد دروس متاحة';
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           errorMessage = 'خطأ في تحميل الدروس: $e';
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _navigateToLesson(Map<String, dynamic> lesson) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonDetailScreen(lesson: lesson),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF4CAF50),
//         foregroundColor: Colors.white,
//         title: Text(
//           'مكتبة الدروس التعليمية',
//           style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadLessonsFromSupabase,
//             tooltip: 'تحديث الدروس',
//           ),
//         ],
//       ),
//       backgroundColor: Color(0xFFE8F5E9),
//       body:
//       isLoading
//           ? _buildLoadingWidget()
//           : errorMessage.isNotEmpty
//           ? _buildErrorWidget()
//           : _buildLessonsGrid(),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(color: Color(0xFF4CAF50)),
//           SizedBox(height: 20.h),
//           Text(
//             'جاري تحميل الدروس...',
//             style: TextStyle(fontSize: 18.sp, color: Color(0xFF2E7D32)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//           SizedBox(height: 16.h),
//           Text(
//             errorMessage,
//             style: TextStyle(fontSize: 16.sp, color: Colors.red[700]),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20.h),
//           ElevatedButton(
//             onPressed: _loadLessonsFromSupabase,
//             child: Text('إعادة المحاولة'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF4CAF50),
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLessonsGrid() {
//     return lessons.isEmpty
//         ? Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.menu_book, size: 80.sp, color: Colors.grey),
//           SizedBox(height: 16.h),
//           Text(
//             'لا توجد دروس متاحة',
//             style: TextStyle(fontSize: 18.sp, color: Colors.grey),
//           ),
//         ],
//       ),
//     )
//         : Padding(
//       padding: EdgeInsets.all(16.w),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.w,
//           mainAxisSpacing: 16.h,
//           childAspectRatio: 0.8,
//         ),
//         itemCount: lessons.length,
//         itemBuilder: (context, index) {
//           final lesson = lessons[index];
//           return _buildLessonCard(lesson, index);
//         },
//       ),
//     );
//   }
//
//   Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
//     int orderNumber = lesson['order_number'] ?? (index + 1);
//     bool hasVideo =
//         lesson['video_url'] != null && lesson['video_url'].isNotEmpty;
//
//     return Card(
//       elevation: 4.w,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
//       child: InkWell(
//         onTap: () => _navigateToLesson(lesson),
//         borderRadius: BorderRadius.circular(12.w),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
//             ),
//             borderRadius: BorderRadius.circular(12.w),
//           ),
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 8.h,
//                 right: 8.w,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(8.w),
//                   ),
//                   child: Text(
//                     '$orderNumber',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               if (hasVideo)
//                 Positioned(
//                   top: 8.h,
//                   left: 8.w,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 6.w,
//                       vertical: 3.h,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.red.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(6.w),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.play_arrow,
//                           color: Colors.white,
//                           size: 14.sp,
//                         ),
//                         SizedBox(width: 2.w),
//                         Text(
//                           'فيديو',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.w),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         hasVideo ? Icons.video_library : Icons.menu_book,
//                         size: 40.sp,
//                         color: Colors.white,
//                       ),
//                       SizedBox(height: 12.h),
//                       Text(
//                         lesson['title'] ?? 'بدون عنوان',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         'المستوى: ${lesson['level'] ?? 'مبتدئ'}',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.8),
//                           fontSize: 12.sp,
//                         ),
//                       ),
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
// }
//
// // شاشة تفاصيل الدرس - الكود المصحح بالكامل
// class LessonDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> lesson;
//
//   const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);
//
//   @override
//   _LessonDetailScreenState createState() => _LessonDetailScreenState();
// }
//
// class _LessonDetailScreenState extends State<LessonDetailScreen> {
//   YoutubePlayerController? _controller;
//   bool _hasVideo = false;
//   bool _isPlayerReady = false;
//   String? _errorMessage;
//   bool _isMuted = false;
//   bool _isInitializing = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeYouTubePlayer();
//   }
//
//   void _initializeYouTubePlayer() async {
//     try {
//       // استخدام رابط فيديو ثابت للتجربة
//       String? videoUrl = 'https://youtu.be/UB1O30fR-EE';
//       // يمكنك استخدام الرابط من قاعدة البيانات لاحقاً:
//       // String? videoUrl = widget.lesson['video_url'];
//
//       _hasVideo = videoUrl != null && videoUrl.isNotEmpty;
//
//       if (_hasVideo) {
//         String? videoId = _extractVideoId(videoUrl!);
//         if (videoId != null) {
//           _controller = YoutubePlayerController.fromVideoId(
//             videoId: videoId,
//             autoPlay: false,
//             params: const YoutubePlayerParams(
//               mute: false,
//               showControls: true,
//               showFullscreenButton: true,
//               loop: false,
//               enableCaption: true,
//               showVideoAnnotations: false,
//               playsInline: true,
//               strictRelatedVideos: false,
//             ),
//           );
//
//           // ✅ الحل: استخدام Future.delayed للتحقق من جاهزية المشغل
//           await Future.delayed(Duration(seconds: 2));
//
//           if (mounted) {
//             setState(() {
//               _isInitializing = false;
//               _isPlayerReady = true;
//               _errorMessage = null;
//             });
//           }
//
//           // ✅ الحل: الاستماع لتغيرات حالة الفيديو
//           _controller!.listen((value) {
//             if (mounted) {
//               // تحديث حالة الجاهزية عندما يكون الفيديو جاهزاً
//               if (value.playerState != PlayerState.unknown &&
//                   value.playerState != PlayerState.unStarted) {
//                 if (!_isPlayerReady) {
//                   setState(() {
//                     _isPlayerReady = true;
//                     _errorMessage = null;
//                   });
//                 }
//               }
//
//               // معالجة الأخطاء
//               if (value.hasError && _errorMessage == null) {
//                 setState(() {
//                   _errorMessage = 'حدث خطأ في تشغيل الفيديو';
//                   _isPlayerReady = false;
//                 });
//               }
//             }
//           });
//
//         } else {
//           if (mounted) {
//             setState(() {
//               _isInitializing = false;
//               _hasVideo = false;
//               _errorMessage = 'رابط الفيديو غير صالح';
//             });
//           }
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             _isInitializing = false;
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _isInitializing = false;
//           _hasVideo = false;
//           _errorMessage = 'خطأ في تهيئة مشغل الفيديو: $e';
//         });
//       }
//     }
//   }
//
//   String? _extractVideoId(String url) {
//     try {
//       // استخدام الطريقة المدمجة أولاً
//       final videoId = YoutubePlayerController.convertUrlToId(url);
//       if (videoId != null) return videoId;
//
//       // الطريقة الاحتياطية
//       final Uri? uri = Uri.tryParse(url);
//       if (uri == null) return null;
//
//       if (uri.host.contains('youtu.be')) {
//         return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
//       } else if (uri.queryParameters.containsKey('v')) {
//         return uri.queryParameters['v'];
//       } else if (uri.pathSegments.contains('embed')) {
//         final embedIndex = uri.pathSegments.indexOf('embed');
//         if (embedIndex + 1 < uri.pathSegments.length) {
//           return uri.pathSegments[embedIndex + 1];
//         }
//       }
//
//       return null;
//     } catch (e) {
//       print('خطأ في استخراج معرف الفيديو: $e');
//       return null;
//     }
//   }
//
//   // ✅ الحل: استخدام الطرق الصحيحة للتحكم في الصوت
//   Widget _buildVideoControls() {
//     if (_controller == null) return SizedBox();
//
//     return YoutubeValueBuilder(
//       controller: _controller!,
//       builder: (context, value) {
//         final bool isVideoReady = _isVideoReady(value);
//
//         return Container(
//           margin: EdgeInsets.symmetric(horizontal: 16.w),
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12.w),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 8.w,
//                 offset: Offset(0, 2.h),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               // أزرار التحكم الأساسية
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildControlButton(
//                     icon: Icons.replay_10,
//                     text: 'رجوع 10ث',
//                     onPressed: isVideoReady ? () => _seekBackward(10) : null,
//                     color: Color(0xFF2196F3),
//                     isEnabled: isVideoReady,
//                   ),
//                   _buildControlButton(
//                     icon:
//                     value.playerState == PlayerState.playing
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     text:
//                     value.playerState == PlayerState.playing
//                         ? 'إيقاف'
//                         : 'تشغيل',
//                     onPressed:
//                     isVideoReady
//                         ? () {
//                       if (value.playerState == PlayerState.playing) {
//                         _controller!.pauseVideo();
//                       } else {
//                         _controller!.playVideo();
//                       }
//                     }
//                         : null,
//                     color: Color(0xFF4CAF50),
//                     isEnabled: isVideoReady,
//                   ),
//                   _buildControlButton(
//                     icon: _isMuted ? Icons.volume_off : Icons.volume_up,
//                     text: _isMuted ? 'كتم' : 'صوت',
//                     onPressed: isVideoReady ? () => _toggleMute() : null,
//                     color: Color(0xFFFF9800),
//                     isEnabled: isVideoReady,
//                   ),
//                   _buildControlButton(
//                     icon: Icons.forward_10,
//                     text: 'تقدم 10ث',
//                     onPressed: isVideoReady ? () => _seekForward(10) : null,
//                     color: Color(0xFF2196F3),
//                     isEnabled: isVideoReady,
//                   ),
//                 ],
//               ),
//
//               // معلومات الفيديو
//               if (isVideoReady && value.metaData.title.isNotEmpty)
//                 Padding(
//                   padding: EdgeInsets.only(top: 12.h),
//                   child: Text(
//                     value.metaData.title,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[700],
//                     ),
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//
//               // سرعة التشغيل
//               if (isVideoReady)
//                 Padding(
//                   padding: EdgeInsets.only(top: 12.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'السرعة: ',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       DropdownButton<double>(
//                         value: value.playbackRate,
//                         items:
//                         [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0]
//                             .map(
//                               (speed) => DropdownMenuItem(
//                             value: speed,
//                             child: Text('${speed}x'),
//                           ),
//                         )
//                             .toList(),
//                         onChanged:
//                         isVideoReady
//                             ? (speed) {
//                           if (speed != null) {
//                             _controller!.setPlaybackRate(speed);
//                           }
//                         }
//                             : null,
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   bool _isVideoReady(YoutubePlayerValue value) {
//     return value.playerState != PlayerState.unknown &&
//         value.playerState != PlayerState.unStarted &&
//         !value.hasError;
//   }
//
//   // ✅ الحل: استخدام mute/unMute مباشرة
//   void _toggleMute() {
//     if (_controller == null) return;
//
//     if (_isMuted) {
//       _controller!.unMute();
//     } else {
//       _controller!.mute();
//     }
//     setState(() {
//       _isMuted = !_isMuted;
//     });
//   }
//
//   Future<void> _seekBackward(int seconds) async {
//     if (_controller == null) return;
//
//     try {
//       final currentPosition = await _controller!.currentTime;
//       final newPosition = currentPosition - seconds;
//       await _controller!.seekTo(seconds: newPosition > 0 ? newPosition : 0);
//     } catch (e) {
//       print('خطأ في التراجع: $e');
//     }
//   }
//
//   Future<void> _seekForward(int seconds) async {
//     if (_controller == null) return;
//
//     try {
//       final currentPosition = await _controller!.currentTime;
//       await _controller!.seekTo(seconds: currentPosition + seconds);
//     } catch (e) {
//       print('خطأ في التقدم: $e');
//     }
//   }
//
//   Widget _buildControlButton({
//     required IconData icon,
//     required String text,
//     required VoidCallback? onPressed,
//     required Color color,
//     required bool isEnabled,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 50.w,
//           height: 50.h,
//           decoration: BoxDecoration(
//             color: isEnabled ? color : Colors.grey,
//             shape: BoxShape.circle,
//             boxShadow:
//             isEnabled
//                 ? [
//               BoxShadow(
//                 color: color.withOpacity(0.4),
//                 blurRadius: 6.w,
//                 offset: Offset(0, 3.h),
//               ),
//             ]
//                 : null,
//           ),
//           child: IconButton(
//             icon: Icon(icon, color: Colors.white, size: 20.sp),
//             onPressed: onPressed,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 10.sp,
//             fontWeight: FontWeight.bold,
//             color: isEnabled ? Colors.black87 : Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildYouTubePlayer() {
//     if (!_hasVideo) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.videocam_off, size: 80.sp, color: Colors.grey),
//             SizedBox(height: 16.h),
//             Text(
//               'لا يتوفر فيديو لهذا الدرس',
//               style: TextStyle(fontSize: 18.sp, color: Colors.grey),
//             ),
//             if (_errorMessage != null) ...[
//               SizedBox(height: 8.h),
//               Text(
//                 _errorMessage!,
//                 style: TextStyle(fontSize: 14.sp, color: Colors.red),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ],
//         ),
//       );
//     }
//
//     if (_controller == null || _isInitializing) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: Color(0xFF4CAF50)),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تهيئة مشغل الفيديو...',
//               style: TextStyle(fontSize: 16.sp, color: Color(0xFF2E7D32)),
//             ),
//           ],
//         ),
//       );
//     }
//
//     if (!_isPlayerReady) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: Color(0xFF4CAF50)),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تحميل الفيديو...',
//               style: TextStyle(fontSize: 16.sp, color: Color(0xFF2E7D32)),
//             ),
//             if (_errorMessage != null) ...[
//               SizedBox(height: 8.h),
//               Text(
//                 _errorMessage!,
//                 style: TextStyle(fontSize: 12.sp, color: Colors.orange),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ],
//         ),
//       );
//     }
//
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 12.w,
//             offset: Offset(0, 6.h),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16.w),
//         child: YoutubePlayerScaffold(
//           controller: _controller!,
//           aspectRatio: 16 / 9,
//           builder: (context, player) {
//             return player;
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLessonInfo() {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'معلومات الدرس:',
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF2E7D32),
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Row(
//             children: [
//               Icon(Icons.school, size: 16.sp, color: Colors.blue),
//               SizedBox(width: 8.w),
//               Text(
//                 'المستوى: ${widget.lesson['level'] ?? 'مبتدئ'}',
//                 style: TextStyle(fontSize: 14.sp),
//               ),
//             ],
//           ),
//           SizedBox(height: 4.h),
//           Row(
//             children: [
//               Icon(
//                 Icons.format_list_numbered,
//                 size: 16.sp,
//                 color: Colors.orange,
//               ),
//               SizedBox(width: 8.w),
//               Text(
//                 'رقم الدرس: ${widget.lesson['order_number'] ?? '1'}',
//                 style: TextStyle(fontSize: 14.sp),
//               ),
//             ],
//           ),
//           if (widget.lesson['description'] != null) ...[
//             SizedBox(height: 8.h),
//             Text(
//               'الوصف:',
//               style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 4.h),
//             Text(
//               widget.lesson['description']!,
//               style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
//               textAlign: TextAlign.right,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Color(0xFF4CAF50),
//       foregroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: _controller != null && _isPlayerReady
//           ? YoutubeValueBuilder(
//         controller: _controller!,
//         builder: (context, value) {
//           final bool isVideoReady = _isVideoReady(value);
//           return Text(
//             isVideoReady && value.metaData.title.isNotEmpty
//                 ? value.metaData.title
//                 : widget.lesson['title'] ?? 'عرض الدرس',
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           );
//         },
//       )
//           : Text(
//         widget.lesson['title'] ?? 'عرض الدرس',
//         style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//       centerTitle: true,
//       elevation: 0,
//       actions: [
//         if (_hasVideo && _controller != null)
//           IconButton(
//             icon: Icon(Icons.fullscreen),
//             onPressed: () => _controller!.toggleFullScreen(),
//             tooltip: 'ملء الشاشة',
//           ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_hasVideo) {
//       return Scaffold(
//           appBar: _buildAppBar(),
//           body: _buildYouTubePlayer()
//       );
//     }
//
//     return YoutubePlayerControllerProvider(
//       controller: _controller!,
//       child: Scaffold(
//         backgroundColor: Color(0xFFF5FDF6),
//         appBar: _buildAppBar(),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: _buildYouTubePlayer(),
//               ),
//
//               if (_hasVideo && _isPlayerReady) ...[
//                 SizedBox(height: 16.h),
//                 _buildVideoControls(),
//               ],
//
//               _buildLessonInfo(),
//               SizedBox(height: 16.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller?.close();
//     super.dispose();
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   await Supabase.initialize(
// //     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
// //     anonKey:
// //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
// //   );
// //   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
// //   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
// //   runApp(MyApp());
// //   // 🔹 وبعد أن يبدأ التطبيق ويكون جاهزًا، أزل شاشة السبلاتش
// //   FlutterNativeSplash.remove();
// // }
//
// void main() async {
//   // ✅ يجب أن يكون هذا أول سطر
//   final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//
//   // ✅ نحافظ على شاشة السبلاتش أثناء تحميل الخدمات
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//
//   // ✅ تحميل Supabase أو أي خدمات أخرى
//   await Supabase.initialize(
//     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
//     anonKey:
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
//   );
//
//   // ✅ الآن نشغّل التطبيق
//   runApp(MyApp());
//
//   // ✅ وأخيرًا، نزيل شاشة السبلاتش بعد بدء واجهة التطبيق
//   FlutterNativeSplash.remove();
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, child) {
//         return MaterialApp(
//           title: 'تطبيق تعلم القراءة',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             primaryColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//             colorScheme: ColorScheme.fromSwatch(
//               primarySwatch: Colors.blue,
//               accentColor: Color(0xFFFFA726), // ✅ اللون الثانوي
//             ),
//             fontFamily: 'Tajawal',
//             useMaterial3: true,
//           ),
//           home: LessonsListScreen(),
//           debugShowCheckedModeBanner: false,
//         );
//       },
//     );
//   }
// }
//
// // شاشة قائمة الدروس
// class LessonsListScreen extends StatefulWidget {
//   @override
//   _LessonsListScreenState createState() => _LessonsListScreenState();
// }
//
// class _LessonsListScreenState extends State<LessonsListScreen> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   List<Map<String, dynamic>> lessons = [];
//   bool isLoading = false;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLessonsFromSupabase();
//   }
//
//   Future<void> _loadLessonsFromSupabase() async {
//     if (!mounted) return;
//
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });
//
//     try {
//       final response = await supabase
//           .from('lessons')
//           .select()
//           .order('order_number');
//
//       if (response != null && response.isNotEmpty) {
//         if (mounted) {
//           setState(() {
//             lessons = List<Map<String, dynamic>>.from(response);
//           });
//         }
//       } else {
//         if (mounted) {
//           setState(() {
//             errorMessage = 'لا توجد دروس متاحة';
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           errorMessage = 'خطأ في تحميل الدروس: $e';
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _navigateToLesson(Map<String, dynamic> lesson) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LessonDetailScreen(lesson: lesson),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//         foregroundColor: Colors.white,
//         title: Text(
//           'مكتبة الدروس التعليمية',
//           style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadLessonsFromSupabase,
//             tooltip: 'تحديث الدروس',
//           ),
//         ],
//       ),
//       backgroundColor: Color(0xFFE3F2FD), // ✅ لون خلفية فاتح من اللون الأساسي
//       body: isLoading
//           ? _buildLoadingWidget()
//           : errorMessage.isNotEmpty
//           ? _buildErrorWidget()
//           : _buildLessonsGrid(),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(color: Color(0xFF1E88E5)), // ✅ اللون الأساسي
//           SizedBox(height: 20.h),
//           Text(
//             'جاري تحميل الدروس...',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Color(0xFF1E88E5), // ✅ اللون الأساسي
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//           SizedBox(height: 16.h),
//           Text(
//             errorMessage,
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.red[700],
//               fontFamily: 'Tajawal',
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20.h),
//           ElevatedButton(
//             onPressed: _loadLessonsFromSupabase,
//             child: Text(
//               'إعادة المحاولة',
//               style: TextStyle(fontFamily: 'Tajawal'),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.w),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLessonsGrid() {
//     return lessons.isEmpty
//         ? Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.menu_book, size: 80.sp, color: Colors.grey),
//           SizedBox(height: 16.h),
//           Text(
//             'لا توجد دروس متاحة',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Colors.grey,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ],
//       ),
//     )
//         : Padding(
//       padding: EdgeInsets.all(16.w),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.w,
//           mainAxisSpacing: 16.h,
//           childAspectRatio: 0.8,
//         ),
//         itemCount: lessons.length,
//         itemBuilder: (context, index) {
//           final lesson = lessons[index];
//           return _buildLessonCard(lesson, index);
//         },
//       ),
//     );
//   }
//
//   Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
//     int orderNumber = lesson['order_number'] ?? (index + 1);
//     bool hasVideo =
//         lesson['video_url'] != null && lesson['video_url'].isNotEmpty;
//
//     return Card(
//       elevation: 4.w,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
//       child: InkWell(
//         onTap: () => _navigateToLesson(lesson),
//         borderRadius: BorderRadius.circular(16.w),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFF1E88E5), Color(0xFF1565C0)], // ✅ اللون الأساسي بتدرج
//             ),
//             borderRadius: BorderRadius.circular(16.w),
//           ),
//           child: Stack(
//             children: [
//               // رقم الدرس
//               Positioned(
//                 top: 12.h,
//                 right: 12.w,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12.w),
//                   ),
//                   child: Text(
//                     'درس $orderNumber',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Tajawal',
//                     ),
//                   ),
//                 ),
//               ),
//
//               // أيقونة الفيديو
//               if (hasVideo)
//                 Positioned(
//                   top: 12.h,
//                   left: 12.w,
//                   child: Container(
//                     padding: EdgeInsets.all(6.w),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFFFA726), // ✅ اللون الثانوي
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 16.sp,
//                     ),
//                   ),
//                 ),
//
//               // محتوى البطاقة
//               Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.w),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         hasVideo ? Icons.video_library : Icons.menu_book,
//                         size: 42.sp,
//                         color: Colors.white,
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         lesson['title'] ?? 'بدون عنوان',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Tajawal',
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         'المستوى: ${lesson['level'] ?? 'مبتدئ'}',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: 12.sp,
//                           fontFamily: 'Tajawal',
//                         ),
//                       ),
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
// }
//
// class LessonDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> lesson;
//
//   const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);
//
//   @override
//   _LessonDetailScreenState createState() => _LessonDetailScreenState();
// }
//
// class _LessonDetailScreenState extends State<LessonDetailScreen> {
//   YoutubePlayerController? _controller;
//   bool _isPlayerReady = false;
//   bool _hasError = false;
//   String _errorMessage = '';
//   bool _isMuted = false;
//   double _volume = 100;
//   bool _isPlaying = false;
//   double _playbackRate = 1.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeYouTubePlayer();
//
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//   }
//
//   void _initializeYouTubePlayer() {
//     try {
//       String? videoUrl = widget.lesson['video_url'] ?? 'https://youtu.be/UB1O30fR-EE';
//
//       if (videoUrl != null && videoUrl.isNotEmpty) {
//         String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
//
//         if (videoId != null) {
//           _controller = YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: YoutubePlayerFlags(
//               autoPlay: false,
//               mute: false,
//               enableCaption: true,
//               captionLanguage: 'ar',
//               hideControls: false,
//               controlsVisibleAtStart: true,
//               useHybridComposition: true,
//               disableDragSeek: false,
//               loop: false,
//               isLive: false,
//               forceHD: true,
//             ),
//           );
//
//           _controller!.addListener(_videoListener);
//
//           if (mounted) {
//             setState(() {
//               _isPlayerReady = true;
//             });
//           }
//
//         } else {
//           _setErrorState('رابط الفيديو غير صالح');
//         }
//       } else {
//         _setErrorState('لا يتوفر فيديو لهذا الدرس');
//       }
//     } catch (e) {
//       _setErrorState('خطأ في تهيئة مشغل الفيديو: $e');
//     }
//   }
//
//   void _videoListener() {
//     if (!mounted) return;
//
//     if (_controller != null) {
//       setState(() {
//         _isPlaying = _controller!.value.isPlaying;
//       });
//     }
//   }
//
//   void _setErrorState(String message) {
//     if (mounted) {
//       setState(() {
//         _hasError = true;
//         _errorMessage = message;
//         _isPlayerReady = false;
//       });
//     }
//   }
//
//   void _togglePlayPause() {
//     if (_isPlayerReady && _controller != null) {
//       if (_controller!.value.isPlaying) {
//         _controller!.pause();
//       } else {
//         _controller!.play();
//       }
//     }
//   }
//
//   void _toggleMute() {
//     if (_controller != null) {
//       if (_isMuted) {
//         _controller!.unMute();
//         setState(() {
//           _isMuted = false;
//           _volume = 100;
//         });
//       } else {
//         _controller!.mute();
//         setState(() {
//           _isMuted = true;
//           _volume = 0;
//         });
//       }
//     }
//   }
//
//   void _seekForward(int seconds) {
//     if (_controller != null) {
//       final newPosition = _controller!.value.position + Duration(seconds: seconds);
//       _controller!.seekTo(newPosition);
//     }
//   }
//
//   void _seekBackward(int seconds) {
//     if (_controller != null) {
//       final newPosition = _controller!.value.position - Duration(seconds: seconds);
//       _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
//     }
//   }
//
//   void _changePlaybackRate(double rate) {
//     if (_controller != null) {
//       _controller!.setPlaybackRate(rate);
//       setState(() {
//         _playbackRate = rate;
//       });
//     }
//   }
//
//   void _changeVolume(double volume) {
//     setState(() {
//       _volume = volume;
//       _isMuted = volume == 0;
//     });
//   }
//
//   void _onVolumeChangeEnd(double volume) {
//     if (_controller != null) {
//       _controller!.setVolume(volume.round());
//     }
//   }
//
//   Widget _buildCustomPlaybackSpeedButton() {
//     return PopupMenuButton<double>(
//       icon: Icon(Icons.speed, color: Colors.white),
//       tooltip: 'سرعة التشغيل',
//       onSelected: (speed) {
//         _changePlaybackRate(speed);
//       },
//       itemBuilder: (context) => [
//         PopupMenuItem(value: 0.25, child: Text('0.25x')),
//         PopupMenuItem(value: 0.5, child: Text('0.5x')),
//         PopupMenuItem(value: 0.75, child: Text('0.75x')),
//         PopupMenuItem(value: 1.0, child: Text('عادي (1.0x)')),
//         PopupMenuItem(value: 1.25, child: Text('1.25x')),
//         PopupMenuItem(value: 1.5, child: Text('1.5x')),
//         PopupMenuItem(value: 1.75, child: Text('1.75x')),
//         PopupMenuItem(value: 2.0, child: Text('2.0x')),
//       ],
//     );
//   }
//
//   Widget _buildVideoControls() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // أزرار التحكم الأساسية
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildControlButton(
//                 icon: Icons.replay_10,
//                 text: 'رجوع 10ث',
//                 onPressed: () => _seekBackward(10),
//                 color: Color(0xFF1E88E5), // ✅ اللون الأساسي
//               ),
//               _buildControlButton(
//                 icon: _isPlaying ? Icons.pause : Icons.play_arrow,
//                 text: _isPlaying ? 'إيقاف' : 'تشغيل',
//                 onPressed: _togglePlayPause,
//                 color: Color(0xFF1E88E5), // ✅ اللون الأساسي
//               ),
//               _buildControlButton(
//                 icon: _isMuted ? Icons.volume_off : Icons.volume_up,
//                 text: _isMuted ? 'كتم' : 'صوت',
//                 onPressed: _toggleMute,
//                 color: Color(0xFFFFA726), // ✅ اللون الثانوي
//               ),
//               _buildControlButton(
//                 icon: Icons.forward_10,
//                 text: 'تقدم 10ث',
//                 onPressed: () => _seekForward(10),
//                 color: Color(0xFF1E88E5), // ✅ اللون الأساسي
//               ),
//             ],
//           ),
//
//           SizedBox(height: 16.h),
//
//           // التحكم في الصوت
//           Row(
//             children: [
//               Icon(Icons.volume_up, size: 20.sp, color: Colors.grey[600]),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Slider(
//                   value: _volume,
//                   min: 0,
//                   max: 100,
//                   divisions: 10,
//                   onChanged: _changeVolume,
//                   onChangeEnd: _onVolumeChangeEnd,
//                   activeColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//                   inactiveColor: Colors.grey[300],
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Text(
//                 '${_volume.round()}%',
//                 style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 12.h),
//
//           // سرعة التشغيل
//           Row(
//             children: [
//               Icon(Icons.speed, size: 20.sp, color: Colors.grey[600]),
//               SizedBox(width: 12.w),
//               Text(
//                 'السرعة:',
//                 style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: DropdownButton<double>(
//                   value: _playbackRate,
//                   isExpanded: true,
//                   items: [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
//                     return DropdownMenuItem(
//                       value: speed,
//                       child: Text(
//                         '${speed}x',
//                         style: TextStyle(fontSize: 12.sp),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (speed) {
//                     if (speed != null) _changePlaybackRate(speed);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildControlButton({
//     required IconData icon,
//     required String text,
//     required VoidCallback onPressed,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 52.w,
//           height: 52.h,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.4),
//                 blurRadius: 6.w,
//                 offset: Offset(0, 3.h),
//               ),
//             ],
//           ),
//           child: IconButton(
//             icon: Icon(icon, color: Colors.white, size: 22.sp),
//             onPressed: onPressed,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 10.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLessonInfo() {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'معلومات الدرس',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1E88E5), // ✅ اللون الأساسي
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 16.h),
//           _buildInfoRow(
//             icon: Icons.school,
//             label: 'المستوى',
//             value: widget.lesson['level'] ?? 'مبتدئ',
//             iconColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//           ),
//           SizedBox(height: 12.h),
//           _buildInfoRow(
//             icon: Icons.format_list_numbered,
//             label: 'رقم الدرس',
//             value: '${widget.lesson['order_number'] ?? '1'}',
//             iconColor: Color(0xFFFFA726), // ✅ اللون الثانوي
//           ),
//           if (widget.lesson['description'] != null) ...[
//             SizedBox(height: 16.h),
//             Text(
//               'الوصف:',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               widget.lesson['description']!,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.grey[700],
//                 fontFamily: 'Tajawal',
//                 height: 1.5,
//               ),
//               textAlign: TextAlign.right,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color iconColor,
//   }) {
//     return Row(
//       children: [
//         Icon(icon, size: 20.sp, color: iconColor),
//         SizedBox(width: 12.w),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: Colors.grey[600],
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//       foregroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: Text(
//         widget.lesson['title'] ?? 'عرض الدرس',
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//         ),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//       centerTitle: true,
//       elevation: 0,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//               SizedBox(height: 16.h),
//               Text(
//                 _errorMessage,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Colors.red[700],
//                   fontFamily: 'Tajawal',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (_controller == null && !_hasError) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(color: Color(0xFF1E88E5)), // ✅ اللون الأساسي
//               SizedBox(height: 16.h),
//               Text(
//                 'جاري تهيئة مشغل الفيديو...',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Color(0xFF1E88E5), // ✅ اللون الأساسي
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (_controller == null) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Text(
//             'خطأ في تحميل الفيديو',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.red,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ),
//       );
//     }
//
//     return WillPopScope(
//       onWillPop: () async {
//         if (_controller != null && _controller!.value.isFullScreen) {
//           _controller!.toggleFullScreenMode();
//           return false;
//         }
//         return true;
//       },
//       child: YoutubePlayerBuilder(
//         onEnterFullScreen: () {
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.landscapeRight,
//             DeviceOrientation.landscapeLeft,
//           ]);
//         },
//         onExitFullScreen: () {
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.portraitUp,
//           ]);
//         },
//         player: YoutubePlayer(
//           controller: _controller!,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//           progressColors: ProgressBarColors(
//             playedColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//             handleColor: Color(0xFF1E88E5), // ✅ اللون الأساسي
//             backgroundColor: Colors.grey[300]!,
//           ),
//           onReady: () {
//             if (mounted) {
//               setState(() {
//                 _isPlayerReady = true;
//               });
//             }
//           },
//           onEnded: (metaData) {
//             if (mounted) {
//               setState(() {
//                 _isPlaying = false;
//               });
//             }
//           },
//           bottomActions: [
//             CurrentPosition(),
//             ProgressBar(isExpanded: true),
//             RemainingDuration(),
//             _buildCustomPlaybackSpeedButton(),
//             FullScreenButton(),
//           ],
//         ),
//         builder: (context, player) {
//           return Scaffold(
//             backgroundColor: Color(0xFFF5F9FF), // ✅ لون خلفية فاتح من اللون الأساسي
//             appBar: _buildAppBar(),
//             body: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     margin: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.w),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 12.w,
//                           offset: Offset(0, 6.h),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12.w),
//                       child: player,
//                     ),
//                   ),
//
//                   if (_isPlayerReady) ...[
//                     SizedBox(height: 16.h),
//                     _buildVideoControls(),
//                   ],
//
//                   SizedBox(height: 16.h),
//                   _buildLessonInfo(),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//
//     _controller?.removeListener(_videoListener);
//     _controller?.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'screens/intro_screen.dart';
//
// void main() async {
//   final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//
//   await Supabase.initialize(
//     url: 'https://kduifnupjvhpgprxtdes.supabase.co',
//     anonKey:
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
//   );
//
//   runApp(MyApp());
//   FlutterNativeSplash.remove();
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, child) {
//         return MaterialApp(
//           title: 'تطبيق تعلم القراءة',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             primaryColor: Color(0xFF1E88E5),
//             colorScheme: ColorScheme.fromSwatch(
//               primarySwatch: Colors.blue,
//               accentColor: Color(0xFFFFA726),
//             ),
//             fontFamily: 'Tajawal',
//             useMaterial3: true,
//           ),
//           home: IntroScreen(),
//           debugShowCheckedModeBanner: false,
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mody/widget/NavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Auth/auth_service.dart';
import 'screens/intro_screen.dart';


void main() async {
  // تأكد من تهيئة WidgetsBinding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // احتفظ بشاشة البداية الأصلية
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // قفل اتجاه الشاشة للوضع الرأسي
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // تهيئة Supabase
  await Supabase.initialize(
    url: 'https://kduifnupjvhpgprxtdes.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtkdWlmbnVwanZocGdwcnh0ZGVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM4MjgsImV4cCI6MjA2MzIzOTgyOH0.Werr7CH4x0lY8m1-g9Je-xUcrmks6RseBgmksIh5T0U',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'تطبيق تعلم القراءة',
            theme: ThemeData(
              primaryColor: Color(0xFF1E88E5),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                accentColor: Color(0xFFFFA726),
              ),
              fontFamily: 'Tajawal',
              useMaterial3: true,
              scaffoldBackgroundColor: Color(0xFFF5F9FF),
              appBarTheme: AppBarTheme(
                backgroundColor: Color(0xFF1E88E5),
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xFF1E88E5),
                unselectedItemColor: Color(0xFF718096),
                selectedLabelStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
            home: AppWrapper(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class AppWrapper extends StatefulWidget {
  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  bool _isSplashRemoved = false;
  bool _isAuthChecked = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // انتظر تحميل حالة المصادقة أولاً
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.initialize();

      setState(() {
        _isAuthChecked = true;
      });

      // انتظر وقت إضافي للتحميل إذا لزم الأمر
      await Future.delayed(Duration(milliseconds: 800));

    } catch (e) {
      print('Error initializing app: $e');
    } finally {
      // إزالة شاشة البداية بعد التهيئة
      if (!_isSplashRemoved) {
        FlutterNativeSplash.remove();
        setState(() {
          _isSplashRemoved = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // إذا لم يتم إزالة الشاشة بعد أو لم يتم التحقق من المصادقة، اعرض شاشة تحميل
    if (!_isSplashRemoved || !_isAuthChecked) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // شعار التطبيق
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF1E88E5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 40.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'تعلم القراءة',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E88E5),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'جاري التحميل...',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14.sp,
                  color: Color(0xFF718096),
                ),
              ),
              SizedBox(height: 20.h),
              CircularProgressIndicator(
                color: Color(0xFF1E88E5),
              ),
            ],
          ),
        ),
      );
    }

    // بناء واجهة المستخدم بناءً على حالة المصادقة
    if (authService.isLoggedIn) {
      return MainNavigation();
    } else {
      return IntroScreen();
    }
  }
}