import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:mody/widget/NavigationBar.dart';
import 'Auth/auth_service.dart';
import 'firebase_options.dart';
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

  // تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());

  // إزالة شاشة البداية بعد بدء التطبيق
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        // يمكن إضافة المزيد من الـ Providers هنا
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
              // إضافة المزيد من التخصيصات للثيم
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF1E88E5), width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            home: AppWrapper(),
            debugShowCheckedModeBanner: false,
            // إضافة خاصية التعامل مع الأخطاء
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0, // منع تكبير النص
                ),
                child: child!,
              );
            },
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
  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // تهيئة خدمات التطبيق
      await _initializeServices();

      setState(() {
        _isInitialized = true;
      });

    } catch (e) {
      setState(() {
        _errorMessage = 'حدث خطأ في تهيئة التطبيق: $e';
        _isInitialized = true; // للسماح بعرض رسالة الخطأ
      });
    }
  }

  Future<void> _initializeServices() async {
    // تهيئة خدمة المصادقة
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.initialize();

    // يمكن إضافة تهيئة خدمات أخرى هنا
    // مثل: خدمة التخزين المحلي، الإشعارات، etc.

    // انتظار بسيط لضمان اكتمال التهيئة
    await Future.delayed(Duration(milliseconds: 500));
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار التطبيق مع تصميم جميل
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
                size: 50.sp,
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'تعلم القراءة',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E88E5),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'نحو مستقبل أفضل بالقراءة',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 14.sp,
                color: Color(0xFF718096),
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: 40.w,
              height: 40.h,
              child: CircularProgressIndicator(
                color: Color(0xFF1E88E5),
                strokeWidth: 3,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'جاري التحميل...',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 12.sp,
                color: Color(0xFF718096),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 80.sp,
                color: Colors.red,
              ),
              SizedBox(height: 24.h),
              Text(
                'خطأ في التحميل',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                _errorMessage ?? 'حدث خطأ غير معروف',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: _initializeApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'إعادة المحاولة',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // إذا لم يتم التهيئة بعد، اعرض شاشة التحميل
    if (!_isInitialized) {
      return _buildLoadingScreen();
    }

    // إذا كان هناك خطأ، اعرض شاشة الخطأ
    if (_errorMessage != null) {
      return _buildErrorScreen();
    }

    // بناء واجهة المستخدم بناءً على حالة المصادقة
    final authService = Provider.of<AuthService>(context);

    if (authService.isLoggedIn) {
      return MainNavigation();
    } else {
      return IntroScreen();
    }
  }
}

// كلاس مساعد للتعامل مع أخطاء الشبكة
class NetworkErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'network-request-failed':
          return 'فشل في الاتصال بالشبكة. يرجى التحقق من اتصال الإنترنت.';
        case 'too-many-requests':
          return 'تم إجراء العديد من الطلبات. يرجى المحاولة مرة أخرى لاحقاً.';
        case 'invalid-email':
          return 'البريد الإلكتروني غير صالح.';
        case 'user-disabled':
          return 'تم تعطيل هذا الحساب.';
        case 'user-not-found':
          return 'لم يتم العثور على حساب بهذا البريد الإلكتروني.';
        case 'wrong-password':
          return 'كلمة المرور غير صحيحة.';
        case 'email-already-in-use':
          return 'هذا البريد الإلكتروني مستخدم بالفعل.';
        case 'weak-password':
          return 'كلمة المرور ضعيفة. يرجى اختيار كلمة مرور أقوى.';
        default:
          return 'حدث خطأ: ${error.message}';
      }
    }
    return 'حدث خطأ غير متوقع: $error';
  }
}