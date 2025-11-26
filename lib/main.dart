// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mody/widget/NavigationBar.dart';
// import 'package:provider/provider.dart';
// import 'Auth/auth_service.dart';
// import 'firebase_options.dart';
// import 'screens/intro_screen.dart';
//
// void main() async {
//   // تأكد من تهيئة WidgetsBinding
//   final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//
//   // احتفظ بشاشة البداية الأصلية
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//
//   // قفل اتجاه الشاشة للوضع الرأسي
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   // تهيئة Firebase
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => AuthService(),
//           // ✅ إزالة lazy: false لأن التهيئة تتم في AuthService constructor
//         ),
//       ],
//       child: ScreenUtilInit(
//         designSize: Size(360, 690),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         builder: (context, child) {
//           return MaterialApp(
//             title: 'تطبيق تعلم القراءة',
//             theme: ThemeData(
//               primaryColor: Color(0xFF1E88E5),
//               colorScheme: ColorScheme.fromSwatch(
//                 primarySwatch: Colors.blue,
//                 accentColor: Color(0xFFFFA726),
//               ),
//               fontFamily: 'Tajawal',
//               useMaterial3: true,
//               scaffoldBackgroundColor: Color(0xFFF5F9FF),
//               appBarTheme: AppBarTheme(
//                 backgroundColor: Color(0xFF1E88E5),
//                 elevation: 0,
//                 centerTitle: true,
//                 iconTheme: IconThemeData(color: Colors.white),
//                 titleTextStyle: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               bottomNavigationBarTheme: BottomNavigationBarThemeData(
//                 backgroundColor: Colors.white,
//                 selectedItemColor: Color(0xFF1E88E5),
//                 unselectedItemColor: Color(0xFF718096),
//                 selectedLabelStyle: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontWeight: FontWeight.bold,
//                 ),
//                 unselectedLabelStyle: TextStyle(
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ),
//             home: AppWrapper(),
//             debugShowCheckedModeBanner: false,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class AppWrapper extends StatefulWidget {
//   @override
//   State<AppWrapper> createState() => _AppWrapperState();
// }
//
// class _AppWrapperState extends State<AppWrapper> {
//   bool _isInitialized = false;
//   bool _hasError = false;
//   String? _errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }
//
//   Future<void> _initializeApp() async {
//     try {
//       print('🚀 بدء تهيئة التطبيق...');
//
//       // الانتظار قليلاً لضمان اكتمال بناء Widget tree
//       await Future.delayed(Duration(milliseconds: 100));
//
//       // استخدام PostFrameCallback للوصول الآمن إلى Provider
//       WidgetsBinding.instance.addPostFrameCallback((_) async {
//         try {
//           final authService = Provider.of<AuthService>(context, listen: false);
//
//           // ✅ AuthService يتم تهيئته تلقائياً في constructor
//           // ننتظر قليلاً لضمان اكتمال التهيئة
//           await Future.delayed(Duration(milliseconds: 500));
//
//           // طباعة حالة المصادقة للتشخيص
//           // authService.printAuthState();
//
//           print('✅ تهيئة التطبيق مكتملة بنجاح');
//           print('🔐 حالة المستخدم: ${authService.isLoggedIn ? "مسجل دخول" : "غير مسجل"}');
//
//           if (mounted) {
//             setState(() {
//               _isInitialized = true;
//               _hasError = false;
//             });
//           }
//
//         } catch (e) {
//           print('❌ خطأ في تهيئة AuthService: $e');
//           if (mounted) {
//             setState(() {
//               _isInitialized = true;
//               _hasError = true;
//               _errorMessage = 'خطأ في تهيئة التطبيق: $e';
//             });
//           }
//         } finally {
//           // إزالة شاشة البداية بعد التهيئة بغض النظر عن النتيجة
//           FlutterNativeSplash.remove();
//         }
//       });
//
//     } catch (e) {
//       print('❌ خطأ عام في تهيئة التطبيق: $e');
//       if (mounted) {
//         setState(() {
//           _isInitialized = true;
//           _hasError = true;
//           _errorMessage = 'خطأ في بدء التشغيل: $e';
//         });
//       }
//       FlutterNativeSplash.remove();
//     }
//   }
//
//   void _retryInitialization() {
//     if (mounted) {
//       setState(() {
//         _isInitialized = false;
//         _hasError = false;
//         _errorMessage = null;
//       });
//       _initializeApp();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // شاشة التحميل
//     if (!_isInitialized) {
//       return _buildLoadingScreen();
//     }
//
//     // شاشة الخطأ
//     if (_hasError) {
//       return _buildErrorScreen();
//     }
//
//     // التطبيق الرئيسي
//     return _buildMainApp();
//   }
//
//   Widget _buildLoadingScreen() {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // الشعار مع تأثير متحرك
//             AnimatedContainer(
//               duration: Duration(milliseconds: 500),
//               width: 120.w,
//               height: 120.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(24.r),
//                 color: Color(0xFF1E88E5),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFF1E88E5).withOpacity(0.3),
//                     blurRadius: 15.w,
//                     offset: Offset(0, 5.h),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 Icons.menu_book_rounded,
//                 color: Colors.white,
//                 size: 50.sp,
//               ),
//             ),
//
//             SizedBox(height: 30.h),
//
//             // النص مع تأثير متحرك
//             AnimatedOpacity(
//               opacity: 1.0,
//               duration: Duration(milliseconds: 700),
//               child: Column(
//                 children: [
//                   Text(
//                     'تعلم القراءة',
//                     style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 28.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1E88E5),
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     'جاري تحميل التطبيق...',
//                     style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 16.sp,
//                       color: Color(0xFF718096),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 30.h),
//
//             // مؤشر التقدم مع تأثير متحرك
//             AnimatedOpacity(
//               opacity: 1.0,
//               duration: Duration(milliseconds: 900),
//               child: SizedBox(
//                 width: 40.w,
//                 height: 40.h,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 3.w,
//                   color: Color(0xFF1E88E5),
//                   backgroundColor: Color(0xFF1E88E5).withOpacity(0.2),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 20.h),
//
//             // نص توجيهي
//             AnimatedOpacity(
//               opacity: 1.0,
//               duration: Duration(milliseconds: 1100),
//               child: Text(
//                 'يرجى الانتظار',
//                 style: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 14.sp,
//                   color: Color(0xFF94A3B8),
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorScreen() {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(24.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // أيقونة الخطأ
//               Container(
//                 width: 100.w,
//                 height: 100.h,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFEF2F2),
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Color(0xFFFECACA),
//                     width: 2.w,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.error_outline_rounded,
//                   color: Color(0xFFDC2626),
//                   size: 50.sp,
//                 ),
//               ),
//
//               SizedBox(height: 24.h),
//
//               // عنوان الخطأ
//               Text(
//                 'خطأ في التحميل',
//                 style: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFFDC2626),
//                 ),
//               ),
//
//               SizedBox(height: 12.h),
//
//               // وصف الخطأ
//               Text(
//                 _errorMessage ?? 'حدث خطأ غير متوقع أثناء تحميل التطبيق',
//                 style: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 16.sp,
//                   color: Color(0xFF64748B),
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//
//               SizedBox(height: 32.h),
//
//               // زر إعادة المحاولة
//               ElevatedButton(
//                 onPressed: _retryInitialization,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF1E88E5),
//                   foregroundColor: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   elevation: 4,
//                   shadowColor: Color(0xFF1E88E5).withOpacity(0.3),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.refresh_rounded, size: 20.sp),
//                     SizedBox(width: 8.w),
//                     Text(
//                       'إعادة المحاولة',
//                       style: TextStyle(
//                         fontFamily: 'Tajawal',
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 16.h),
//
//               // زر الخروج
//               TextButton(
//                 onPressed: () {
//                   SystemNavigator.pop();
//                 },
//                 style: TextButton.styleFrom(
//                   foregroundColor: Color(0xFF64748B),
//                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
//                 ),
//                 child: Text(
//                   'خروج',
//                   style: TextStyle(
//                     fontFamily: 'Tajawal',
//                     fontSize: 14.sp,
//                     decoration: TextDecoration.underline,
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
//   Widget _buildMainApp() {
//     return Consumer<AuthService>(
//       builder: (context, authService, child) {
//         // ✅ استخدام حالة isLoggedIn من AuthService مباشرة
//         // ✅ Firebase يحافظ على حالة المصادقة تلقائياً
//
//         print('🎯 بناء واجهة التطبيق - حالة المستخدم: ${authService.isLoggedIn}');
//
//         if (authService.isLoggedIn) {
//           print('➡️ الانتقال إلى الشاشة الرئيسية');
//           return MainNavigation();
//         } else {
//           print('➡️ الانتقال إلى شاشة المقدمة');
//           return IntroScreen();
//         }
//       },
//     );
//   }
// }

// main.dart


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حل الواجبات بالذكاء الاصطناعي',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Tajawal'),
      home: const HomeworkSolverScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeworkSolverScreen extends StatefulWidget {
  const HomeworkSolverScreen({super.key});

  @override
  State<HomeworkSolverScreen> createState() => _HomeworkSolverScreenState();
}

class _HomeworkSolverScreenState extends State<HomeworkSolverScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isProcessing = false;
  bool _hasSolution = false;
  String _solutionText = '';
  String _errorMessage = '';
  List<String> _availableModels = [];
  String _selectedModel = '';

  @override
  void initState() {
    super.initState();
    _initializeModels();
  }

  Future<void> _initializeModels() async {
    try {
      final models = await GeminiService.listAvailableModels();
      setState(() {
        _availableModels = models;
        _selectedModel = models.isNotEmpty ? models.first : '';
      });
    } catch (e) {
      print('Error loading models: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _hasSolution = false;
          _solutionText = '';
          _errorMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ في اختيار الصورة: $e';
      });
    }
  }

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _hasSolution = false;
          _solutionText = '';
          _errorMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ في التقاط الصورة: $e';
      });
    }
  }

  Future<void> _solveHomework() async {
    if (_selectedImage == null) {
      setState(() {
        _errorMessage = 'يرجى اختيار صورة أولاً';
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _errorMessage = '';
    });

    try {
      final solution = await GeminiService.solveHomework(_selectedImage!);
      setState(() {
        _solutionText = solution;
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

  void _clearAll() {
    setState(() {
      _selectedImage = null;
      _hasSolution = false;
      _solutionText = '';
      _errorMessage = '';
    });
  }

  Widget _buildImageSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'الصورة المختارة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 16),
          if (_selectedImage != null)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: FileImage(_selectedImage!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 50, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text(
                    'لم يتم اختيار صورة',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _captureImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text('التقاط صورة'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('من المعرض'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModelInfo() {
    if (_availableModels.isEmpty) return Container();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          Icon(Icons.model_training, color: Colors.blue[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'النموذج المستخدم:',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _selectedModel.split('/').last,
                  style: TextStyle(fontSize: 11, color: Colors.blue[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (_isProcessing)
            Column(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                ),
                const SizedBox(height: 16),
                Text(
                  'جاري معالجة الواجب...',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          else
            ElevatedButton.icon(
              onPressed: _solveHomework,
              icon: const Icon(Icons.psychology),
              label: const Text('حل الواجب باستخدام الذكاء الاصطناعي'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (_selectedImage != null && !_isProcessing)
            TextButton(
              onPressed: _clearAll,
              child: const Text(
                'مسح الكل',
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    if (_errorMessage.isEmpty) return Container();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[100]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.red[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolution() {
    if (!_hasSolution || _solutionText.isEmpty) return Container();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[700], size: 24),
              const SizedBox(width: 8),
              Text(
                'الحل الناتج',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: SingleChildScrollView(
              child: Text(
                _solutionText,
                style: const TextStyle(fontSize: 14, height: 1.5),
                textDirection: TextDirection.rtl,
              ),
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
        appBar: AppBar(
          title: const Text('حل الواجبات بالذكاء الاصطناعي'),
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildModelInfo(),
              _buildImageSection(),
              _buildActionButton(),
              _buildErrorMessage(),
              _buildSolution(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class GeminiService {
  // 🔑 استبدل هذا بمفتاح API الحقيقي الخاص بك
  static const String _apiKey = 'AIzaSyAB7gcV6_BmdCBQ5X_8PIE7t6l-ytQrxvQ';

  static const String _listModelsUrl =
      'https://generativelanguage.googleapis.com/v1/models?key=$_apiKey';

  static String _generateUrlFor(String modelName) {
    final shortName = modelName.split('/').last;
    return 'https://generativelanguage.googleapis.com/v1/models/$shortName:generateContent?key=$_apiKey';
  }

  // استعلام قائمة النماذج المتاحة
  static Future<List<String>> listAvailableModels() async {
    try {
      final response = await http.get(Uri.parse(_listModelsUrl));

      if (response.statusCode != 200) {
        // إذا فشل الاستعلام، نعود بقائمة افتراضية
        print('فشل جلب النماذج: ${response.statusCode}');
        return [
          'models/gemini-2.5-pro-exp-03-25',
          'models/gemini-2.0-flash-exp',
          'models/gemini-1.5-pro',
        ];
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<String> models = [];

      if (data['models'] != null) {
        for (final model in data['models']) {
          if (model['name'] != null) {
            models.add(model['name'] as String);
          }
        }
      }

      // ترتيب النماذج بحيث تكون أحدث الإصدارات في المقدمة
      models.sort((a, b) {
        if (a.contains('2.5') && !b.contains('2.5')) return -1;
        if (!a.contains('2.5') && b.contains('2.5')) return 1;
        if (a.contains('pro') && !b.contains('pro')) return -1;
        if (!a.contains('pro') && b.contains('pro')) return 1;
        return b.compareTo(a);
      });

      return models;
    } catch (e) {
      print('فشل في الاتصال: $e');
      // في حالة الخطأ، نعود بقائمة افتراضية للاختبار
      return [
        'models/gemini-2.5-pro-exp-03-25',
        'models/gemini-2.0-flash-exp',
        'models/gemini-1.5-pro',
      ];
    }
  }

  // إرسال طلب حل الواجب
  static Future<String> solveHomework(File image) async {
    try {
      // قراءة الصورة
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      // الحصول على قائمة النماذج المتاحة
      final models = await listAvailableModels();

      if (models.isEmpty) {
        throw Exception('لا توجد نماذج متاحة');
      }

      // اختيار أفضل نموذج متاح
      String chosenModel = _selectBestModel(models);
      print('🔧 Using model: $chosenModel');

      final url = _generateUrlFor(chosenModel);

      // النص الموجه المحسّن
      const prompt = """
أنت مساعد تعليمي متخصص في حل الواجبات المدرسية. قم بتحليل صورة الواجب وأعطِ الحلول التعليمية مع الشروحات المفصلة.

المتطلبات:
1. حلل كل سؤال أو مسألة على حدة
2. قدم الحلول خطوة بخطوة مع التبرير
3. اشرح المفاهيم والمبادئ المستخدمة
4. تأكد من الدقة الرياضية والعلمية
5. استخدم اللغة العربية الفصحى الواضحة
6. رتب الإجابات حسب تسلسل الأسئلة

أعد الإجابة بتنسيق منظم مع عناوين واضحة.
""";

      final requestBody = {
        "contents": [
          {
            "parts": [
              {"text": prompt},
              {
                "inline_data": {"mime_type": "image/jpeg", "data": base64Image},
              },
            ],
          },
        ],
        "generationConfig": {
          "temperature": 0.2,
          "topK": 40,
          "topP": 0.8,
          "maxOutputTokens": 2048,
        },
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // استخراج النص من الاستجابة
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];

        if (text != null) {
          return text as String;
        } else {
          // نموذج رد للاختبار إذا لم يكن هناك اتصال بالإنترنت
          return """
🎓 تحليل الواجب التعليمي

📚 السؤال الأول: مسألة رياضية
الحل:
١. نبدأ بقراءة المعطيات: ...
٢. نطبق القانون المناسب: ...
٣. نحسب النتيجة: ...
٤. نتحقق من الحل: ...

💡 الشرح:
تم استخدام مبدأ [المبدأ الرياضي] لحل هذه المسألة، حيث أن...

📚 السؤال الثاني: مفهوم علمي
الحل:
١. التعريف بالمفهوم: ...
٢. تطبيق المفهوم: ...
٣. الاستنتاج: ...

💡 الملاحظات:
- هذه مجرد إجابة تجريبية للاختبار
- في التطبيق الفعلي، ستحصل على حلول حقيقية من Gemini
- تأكد من إعداد مفتاح API الصحيح
""";
        }
      } else {
        // في حالة خطأ HTTP، نعود برسالة توضيحية
        throw Exception(
          'فشل استدعاء النموذج (${response.statusCode}). تأكد من صحة API Key والإعدادات.',
        );
      }
    } catch (e) {
      // في حالة أي خطأ، نعود برسالة توضيحية للاختبار
      return """
🎯 نموذج اختباري - حل الواجب

هذا رد تجريبي يظهر عند وجود مشكلة في الاتصال أو إعدادات API.

للتشغيل الفعلي:
١. احصل على مفتاح API من Google AI Studio
٢. استبدل 'YOUR_API_KEY_HERE' بالمفتاح الحقيقي
٣. تأكد من تفعيل Gemini API في مشروعك
٤. تحقق من اتصال الإنترنت

📝 مثال على حل نموذجي:

السؤال: احسب مساحة مستطيل طوله ٨ سم وعرضه ٥ سم

الحل:
١. معطيات المسألة:
   - الطول = ٨ سم
   - العرض = ٥ سم

٢. قانون مساحة المستطيل:
   المساحة = الطول × العرض

٣. التطبيق:
   المساحة = ٨ × ٥ = ٤٠ سم²

٤. التحقق:
   الناتج موجب ومتناسب مع الأبعاد

💡 الشرح:
مساحة المستطيل تمثل الحيز الذي يشغله، وتحسب بضرب بعديه.
""";
    }
  }

  // اختيار أفضل نموذج متاح
  static String _selectBestModel(List<String> models) {
    // الأولوية للنماذج 2.5 Pro
    for (final model in models) {
      if (model.contains('gemini-2.5-pro')) return model;
    }

    // ثم النماذج 2.5 Flash
    for (final model in models) {
      if (model.contains('gemini-2.5-flash')) return model;
    }

    // ثم النماذج 2.0 Pro
    for (final model in models) {
      if (model.contains('gemini-2.0-pro')) return model;
    }

    // ثم أي نموذج يحتوي على 2.5
    for (final model in models) {
      if (model.contains('2.5')) return model;
    }

    // إذا لم نجد، نستخدم الأول في القائمة
    return models.first;
  }
}
