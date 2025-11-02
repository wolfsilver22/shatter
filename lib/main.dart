import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mody/widget/NavigationBar.dart';
import 'package:provider/provider.dart';
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
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
          // ✅ إزالة lazy: false لأن التهيئة تتم في AuthService constructor
        ),
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
  bool _isInitialized = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      print('🚀 بدء تهيئة التطبيق...');

      // الانتظار قليلاً لضمان اكتمال بناء Widget tree
      await Future.delayed(Duration(milliseconds: 100));

      // استخدام PostFrameCallback للوصول الآمن إلى Provider
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final authService = Provider.of<AuthService>(context, listen: false);

          // ✅ AuthService يتم تهيئته تلقائياً في constructor
          // ننتظر قليلاً لضمان اكتمال التهيئة
          await Future.delayed(Duration(milliseconds: 500));

          // طباعة حالة المصادقة للتشخيص
          // authService.printAuthState();

          print('✅ تهيئة التطبيق مكتملة بنجاح');
          print('🔐 حالة المستخدم: ${authService.isLoggedIn ? "مسجل دخول" : "غير مسجل"}');

          if (mounted) {
            setState(() {
              _isInitialized = true;
              _hasError = false;
            });
          }

        } catch (e) {
          print('❌ خطأ في تهيئة AuthService: $e');
          if (mounted) {
            setState(() {
              _isInitialized = true;
              _hasError = true;
              _errorMessage = 'خطأ في تهيئة التطبيق: $e';
            });
          }
        } finally {
          // إزالة شاشة البداية بعد التهيئة بغض النظر عن النتيجة
          FlutterNativeSplash.remove();
        }
      });

    } catch (e) {
      print('❌ خطأ عام في تهيئة التطبيق: $e');
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = true;
          _errorMessage = 'خطأ في بدء التشغيل: $e';
        });
      }
      FlutterNativeSplash.remove();
    }
  }

  void _retryInitialization() {
    if (mounted) {
      setState(() {
        _isInitialized = false;
        _hasError = false;
        _errorMessage = null;
      });
      _initializeApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    // شاشة التحميل
    if (!_isInitialized) {
      return _buildLoadingScreen();
    }

    // شاشة الخطأ
    if (_hasError) {
      return _buildErrorScreen();
    }

    // التطبيق الرئيسي
    return _buildMainApp();
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الشعار مع تأثير متحرك
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: Color(0xFF1E88E5),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1E88E5).withOpacity(0.3),
                    blurRadius: 15.w,
                    offset: Offset(0, 5.h),
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

            // النص مع تأثير متحرك
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 700),
              child: Column(
                children: [
                  Text(
                    'تعلم القراءة',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E88E5),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'جاري تحميل التطبيق...',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16.sp,
                      color: Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // مؤشر التقدم مع تأثير متحرك
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 900),
              child: SizedBox(
                width: 40.w,
                height: 40.h,
                child: CircularProgressIndicator(
                  strokeWidth: 3.w,
                  color: Color(0xFF1E88E5),
                  backgroundColor: Color(0xFF1E88E5).withOpacity(0.2),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // نص توجيهي
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 1100),
              child: Text(
                'يرجى الانتظار',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14.sp,
                  color: Color(0xFF94A3B8),
                  fontStyle: FontStyle.italic,
                ),
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
              // أيقونة الخطأ
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: Color(0xFFFEF2F2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFFECACA),
                    width: 2.w,
                  ),
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  color: Color(0xFFDC2626),
                  size: 50.sp,
                ),
              ),

              SizedBox(height: 24.h),

              // عنوان الخطأ
              Text(
                'خطأ في التحميل',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDC2626),
                ),
              ),

              SizedBox(height: 12.h),

              // وصف الخطأ
              Text(
                _errorMessage ?? 'حدث خطأ غير متوقع أثناء تحميل التطبيق',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16.sp,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32.h),

              // زر إعادة المحاولة
              ElevatedButton(
                onPressed: _retryInitialization,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 4,
                  shadowColor: Color(0xFF1E88E5).withOpacity(0.3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh_rounded, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'إعادة المحاولة',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // زر الخروج
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFF64748B),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
                child: Text(
                  'خروج',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainApp() {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        // ✅ استخدام حالة isLoggedIn من AuthService مباشرة
        // ✅ Firebase يحافظ على حالة المصادقة تلقائياً

        print('🎯 بناء واجهة التطبيق - حالة المستخدم: ${authService.isLoggedIn}');

        if (authService.isLoggedIn) {
          print('➡️ الانتقال إلى الشاشة الرئيسية');
          return MainNavigation();
        } else {
          print('➡️ الانتقال إلى شاشة المقدمة');
          return IntroScreen();
        }
      },
    );
  }
}