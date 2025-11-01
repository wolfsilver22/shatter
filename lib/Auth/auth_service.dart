import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoggedIn = false;
  String? _studentEmail;
  String? _selectedGrade;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  String? get studentEmail => _studentEmail;
  String? get selectedGrade => _selectedGrade;
  Map<String, dynamic>? get userData => _userData;

  AuthService() {
    _initialize();
  }

  // دالة التهيئة الرئيسية
  Future<void> _initialize() async {
    try {
      final currentUser = _auth.currentUser;

      if (currentUser != null) {
        _isLoggedIn = true;
        _studentEmail = currentUser.email;
        await _loadUserData();
        print('✅ تم التهيئة مع مستخدم مسجل: $_studentEmail');
      } else {
        _isLoggedIn = false;
        print('✅ تم التهيئة بدون مستخدم مسجل');
      }

      notifyListeners();
    } catch (e) {
      print('❌ خطأ في تهيئة المصادقة: $e');
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  // تحميل بيانات المستخدم من user_settings
  Future<void> _loadUserData() async {
    try {
      if (_studentEmail != null) {
        final doc = await _firestore
            .collection('user_settings')
            .doc(_studentEmail)
            .get();

        if (doc.exists) {
          _userData = doc.data()!;
          _selectedGrade = doc.data()!['student_level']?.toString();
          print('✅ تم تحميل بيانات المستخدم للصف: $_selectedGrade');
          notifyListeners();
        } else {
          print('⚠️ بيانات المستخدم غير موجودة في user_settings');
        }
      }
    } catch (e) {
      print('❌ خطأ في تحميل بيانات المستخدم: $e');
      _userData = null;
    }
  }

  // التحقق من حالة islogin في user_settings
  Future<bool> checkLoginStatus(String studentEmail) async {
    try {
      final doc = await _firestore
          .collection('user_settings')
          .doc(studentEmail)
          .get();

      if (doc.exists) {
        return doc.data()!['islogin'] ?? false;
      }
      return false;
    } catch (e) {
      print('❌ خطأ في التحقق من حالة الحساب: $e');
      throw Exception('فشل في التحقق من حالة الحساب');
    }
  }

  // تحديث حالة islogin في user_settings
  Future<void> updateLoginStatus(String studentEmail, bool isLogin) async {
    try {
      await _firestore
          .collection('user_settings')
          .doc(studentEmail)
          .update({
        'islogin': isLogin,
        'updated_at': FieldValue.serverTimestamp()
      });
      print('✅ تم تحديث حالة تسجيل الدخول إلى: $isLogin');
    } catch (e) {
      print('❌ خطأ في تحديث حالة الحساب: $e');
      throw Exception('فشل في تحديث حالة الحساب');
    }
  }

  // تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      print('🔐 بدء تسجيل الدخول: $email');

      // التحقق من حالة islogin أولاً
      final isAlreadyLoggedIn = await checkLoginStatus(email);
      if (isAlreadyLoggedIn) {
        throw Exception('هذا الحساب مسجل حالياً في جهاز آخر. يرجى الخروج منه أولاً ثم المحاولة مرة أخرى.');
      }

      // تسجيل الدخول باستخدام Firebase Auth
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw Exception('فشل تسجيل الدخول - لم يتم إرجاع مستخدم');
      }

      // جلب بيانات المستخدم من user_settings
      final doc = await _firestore
          .collection('user_settings')
          .doc(email)
          .get();

      if (!doc.exists) {
        await _auth.signOut();
        throw Exception('الحساب غير موجود في إعدادات المستخدم');
      }

      final userData = doc.data()!;

      // التحقق من حالة الحساب
      if (userData['is_active'] != true) {
        await _auth.signOut();
        throw Exception('الحساب غير مفعل');
      }

      // تحديث حالة islogin إلى true
      await updateLoginStatus(email, true);

      // تحديث حالة المصادقة
      _isLoggedIn = true;
      _studentEmail = email;
      _userData = userData;
      _selectedGrade = userData['student_level']?.toString();

      notifyListeners();

      print('✅ تسجيل الدخول ناجح: $email');
      return;

    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ في تسجيل الدخول';

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'الحساب غير موجود';
          break;
        case 'wrong-password':
          errorMessage = 'كلمة المرور غير صحيحة';
          break;
        case 'invalid-email':
          errorMessage = 'بريد إلكتروني غير صالح';
          break;
        case 'user-disabled':
          errorMessage = 'الحساب معطل';
          break;
        case 'too-many-requests':
          errorMessage = 'طلبات كثيرة جداً. الرجاء المحاولة لاحقاً';
          break;
        case 'network-request-failed':
          errorMessage = 'مشكلة في الاتصال بالإنترنت';
          break;
        case 'operation-not-allowed':
          errorMessage = 'طريقة التسجيل غير مسموحة';
          break;
        case 'invalid-credential':
          errorMessage = 'بيانات الدخول غير صالحة';
          break;
        default:
          errorMessage = 'حدث خطأ غير متوقع: ${e.message}';
      }

      print('🔥 خطأ في تسجيل الدخول: ${e.code} - ${e.message}');
      throw Exception(errorMessage);
    } catch (e) {
      print('🔥 خطأ غير متوقع في تسجيل الدخول: $e');
      rethrow;
    }
  }

  // تسجيل الخروج مع تحديث islogin
  Future<void> logout() async {
    try {
      if (_studentEmail != null) {
        try {
          await updateLoginStatus(_studentEmail!, false);
        } catch (e) {
          print('⚠️ تحذير: فشل تحديث حالة تسجيل الدخول: $e');
        }
      }

      await _auth.signOut();

      _isLoggedIn = false;
      _studentEmail = null;
      _selectedGrade = null;
      _userData = null;

      notifyListeners();

      print('✅ تسجيل الخروج ناجح');
    } catch (e) {
      print('❌ خطأ أثناء تسجيل الخروج: $e');
      throw Exception('حدث خطأ أثناء تسجيل الخروج');
    }
  }

  // التحقق من صحة الجلسة
  Future<bool> validateSession() async {
    if (!_isLoggedIn || _studentEmail == null) {
      return false;
    }

    try {
      final user = _auth.currentUser;
      if (user == null) {
        return false;
      }

      final doc = await _firestore
          .collection('user_settings')
          .doc(_studentEmail!)
          .get();

      if (!doc.exists) {
        return false;
      }

      final userData = doc.data()!;
      return userData['is_active'] == true && userData['islogin'] == true;
    } catch (e) {
      await logout();
      return false;
    }
  }

  // ✅ التحقق من صحة الجلسة الحالية (مطلوبة من MainNavigation)
  Future<bool> checkCurrentSessionValidity() async {
    if (!_isLoggedIn || _studentEmail == null) {
      return false;
    }

    try {
      final user = _auth.currentUser;
      if (user == null) {
        await logout();
        return false;
      }

      final doc = await _firestore
          .collection('user_settings')
          .doc(_studentEmail!)
          .get();

      if (!doc.exists) {
        await logout();
        return false;
      }

      final userData = doc.data()!;
      final isValid = userData['is_active'] == true && userData['islogin'] == true;

      if (!isValid) {
        await logout();
      }

      return isValid;
    } catch (e) {
      print('❌ خطأ في التحقق من صحة الجلسة: $e');
      await logout();
      return false;
    }
  }

  // ✅ تحديث بيانات المستخدم (مطلوبة من MainNavigation)
  Future<void> refreshUserData() async {
    if (_studentEmail != null) {
      await _loadUserData();
    }
  }

  // ✅ الحصول على الكورسات حسب الصف (مطلوبة من HomeScreen)
  Future<List<Map<String, dynamic>>?> getCoursesForGrade(String gradeLevel) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .where('student_level', isEqualTo: gradeLevel)
          .where('is_active', isEqualTo: true)
          .orderBy('order_index')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'title': data['title'] ?? '',
          'image_url': data['image_url'] ?? '',
          'student_level': data['student_level'] ?? '',
          'is_active': data['is_active'] ?? true,
          'order_index': data['order_index'] ?? 0,
        };
      }).toList();
    } catch (e) {
      print('❌ خطأ في جلب الكورسات: $e');
      return null;
    }
  }

  // ✅ الحصول على الدروس للمادة (مطلوبة من LessonsListScreen)
  Future<List<Map<String, dynamic>>?> getLessonsForSubject(String collectionName) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .orderBy('student_level')
          .orderBy('order_index')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'lesson_title': data['lesson_title'] ?? data['title'] ?? '',
          'lesson_image': data['lesson_image'] ?? data['image_url'] ?? '',
          'student_level': data['student_level'] ?? 1,
          'order_index': data['order_index'] ?? 0,
          'video_url': data['video_url'] ?? '',
          'description': data['description'] ?? '',
          'duration': data['duration'] ?? '',
          'is_free': data['is_free'] ?? false,
        };
      }).toList();
    } catch (e) {
      print('❌ خطأ في جلب الدروس: $e');
      return null;
    }
  }

  // ✅ حفظ الصف المختار مع تحديث user_settings (مطلوبة من MainNavigation)
  Future<void> setSelectedGrade(String grade) async {
    _selectedGrade = grade;

    try {
      if (_isLoggedIn && _studentEmail != null) {
        await _firestore
            .collection('user_settings')
            .doc(_studentEmail!)
            .update({
          'student_level': grade,
          'updated_at': FieldValue.serverTimestamp()
        });

        if (_userData != null) {
          _userData!['student_level'] = grade;
        }
      }
    } catch (e) {
      print('❌ خطأ في تحديث الصف في user_settings: $e');
    }

    notifyListeners();
  }

  // ✅ دوال إضافية مطلوبة من MainNavigation

  // التحقق من حالة الحساب النشط
  bool isAccountActive() {
    return _userData?['is_active'] == true;
  }

  // الحصول على رقم الطالب
  String? get studentNumber {
    return _userData?['student_number']?.toString();
  }

  // ✅ دوال إدارة الحساب

  // إنشاء حساب جديد
  Future<void> createUserWithEmailAndPassword(String email, String password, Map<String, dynamic> additionalData) async {
    try {
      // إنشاء المستخدم في Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // إعداد البيانات الأساسية للمستخدم في user_settings
      final userData = {
        'email': email,
        'is_active': true,
        'islogin': false,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        ...additionalData,
      };

      // حفظ بيانات المستخدم في user_settings
      await _firestore
          .collection('user_settings')
          .doc(email)
          .set(userData);

      // إرسال رابط تفعيل البريد الإلكتروني
      await userCredential.user!.sendEmailVerification();

    } on FirebaseAuthException catch (e) {
      String errorMessage = 'فشل إنشاء الحساب';

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'البريد الإلكتروني مستخدم مسبقاً';
          break;
        case 'weak-password':
          errorMessage = 'كلمة المرور ضعيفة جداً';
          break;
        case 'invalid-email':
          errorMessage = 'بريد إلكتروني غير صالح';
          break;
        default:
          errorMessage = 'فشل إنشاء الحساب: ${e.message}';
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('فشل إنشاء الحساب: $e');
    }
  }

  // إرسال رابط تفعيل البريد الإلكتروني
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw Exception('لا يوجد مستخدم مسجل الدخول');
    }
  }

  // إعادة تعيين كلمة المرور
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // تغيير كلمة المرور
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      await _firestore
          .collection('user_settings')
          .doc(user.email!)
          .update({
        'updated_at': FieldValue.serverTimestamp()
      });

      if (_userData != null) {
        _userData!['updated_at'] = DateTime.now().toIso8601String();
      }

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'فشل تغيير كلمة المرور';

      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'كلمة المرور الحالية غير صحيحة';
          break;
        case 'weak-password':
          errorMessage = 'كلمة المرور الجديدة ضعيفة جداً';
          break;
        default:
          errorMessage = 'فشل تغيير كلمة المرور: ${e.message}';
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('فشل تغيير كلمة المرور: $e');
    }
  }

  // تحديث الملف الشخصي
  Future<void> updateProfile(Map<String, dynamic> updates) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }

      updates['updated_at'] = FieldValue.serverTimestamp();

      await _firestore
          .collection('user_settings')
          .doc(user.email!)
          .update(updates);

      if (_userData != null) {
        _userData!.addAll(updates);
      }

      await refreshUserData();
      notifyListeners();
    } catch (e) {
      throw Exception('فشل تحديث الملف الشخصي: $e');
    }
  }

  // الحصول على معلومات الحساب
  Future<Map<String, dynamic>?> getAccountInfo() async {
    if (_studentEmail == null) return null;

    try {
      final doc = await _firestore
          .collection('user_settings')
          .doc(_studentEmail!)
          .get();

      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      print('❌ خطأ في جلب معلومات الحساب: $e');
      return null;
    }
  }

  // ✅ دوال مساعدة

  // الحصول على نص الصف
  String getGradeText() {
    return _getGradeText(_selectedGrade);
  }

  // دالة مساعدة لتحويل رقم الصف إلى نص
  String _getGradeText(String? gradeValue) {
    if (gradeValue == null || gradeValue.isEmpty) {
      return 'لم يتم الاختيار';
    }

    final gradeNumber = int.tryParse(gradeValue);
    if (gradeNumber == null) return gradeValue;

    switch (gradeNumber) {
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

  // إجبار تسجيل الخروج من جميع الأجهزة
  Future<void> forceLogoutFromAllDevices(String studentEmail) async {
    try {
      await _firestore
          .collection('user_settings')
          .doc(studentEmail)
          .update({
        'islogin': false,
        'updated_at': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print('❌ خطأ في إجبار تسجيل الخروج من جميع الأجهزة: $e');
      throw Exception('فشل في إجبار تسجيل الخروج من جميع الأجهزة');
    }
  }

  // طباعة حالة المصادقة للتشخيص
  void printAuthState() {
    print('''
🔐 حالة المصادقة:
- isLoggedIn: $_isLoggedIn
- studentEmail: $_studentEmail
- selectedGrade: $_selectedGrade
- userData: ${_userData != null ? 'موجود' : 'غير موجود'}
- Firebase User: ${_auth.currentUser?.email}
- Firebase User ID: ${_auth.currentUser?.uid}
- Account Active: ${isAccountActive()}
- Student Number: $studentNumber
''');
  }
}