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
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // استخدام PostFrameCallback للوصول الآلى إلى Provider
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final authService = Provider.of<AuthService>(context, listen: false);
        await authService.initialize();

        setState(() {
          _isInitialized = true;
        });

        // إزالة شاشة البداية بعد التهيئة
        FlutterNativeSplash.remove();
      });
    } catch (e) {
      print('Error initializing app: $e');
      setState(() {
        _isInitialized = true;
      });
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

    final authService = Provider.of<AuthService>(context);

    if (authService.isLoggedIn) {
      return MainNavigation();
    } else {
      return IntroScreen();
    }
  }
}