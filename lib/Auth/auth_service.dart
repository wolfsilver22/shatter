import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // ✅ التعديل: دالة التهيئة المطلوبة للملف main.dart
  Future<void> initialize() async {
    try {
      // جلب حالة المستخدم الحالي من Firebase
      final currentUser = _auth.currentUser;

      if (currentUser != null) {
        _isLoggedIn = true;
        _studentEmail = currentUser.email;

        // جلب البيانات الإضافية من Firestore
        await _loadUserData();
      } else {
        _isLoggedIn = false;
      }

      notifyListeners();
    } catch (e) {
      print('Error initializing auth: $e');
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  // ✅ التعديل: دالة تحميل بيانات المستخدم من Firestore
  Future<void> _loadUserData() async {
    try {
      if (_studentEmail != null) {
        final doc = await _firestore
            .collection('users')
            .doc(_studentEmail)
            .get();

        if (doc.exists) {
          _userData = doc.data()!;
          // ✅ استخدام الحقل student_level بدلاً من grade
          _selectedGrade = doc.data()!['student_level']?.toString() ?? _selectedGrade;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
      _userData = null;
    }
  }

  // تحميل حالة المصادقة من الذاكرة المحلية
  Future<void> _loadAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      _studentEmail = prefs.getString('studentEmail');
      _selectedGrade = prefs.getString('selectedGrade');

      // إذا كان المستخدم مسجلاً، قم بتحميل بياناته
      if (_isLoggedIn && _studentEmail != null) {
        await _loadUserData();
      }

      notifyListeners();
    } catch (e) {
      print('Error loading auth state: $e');
    }
  }

  // تهيئة الخدمة
  Future<void> _initialize() async {
    await _loadAuthState();
  }

  // حفظ حالة المصادقة في الذاكرة المحلية
  Future<void> _saveAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', _isLoggedIn);
      await prefs.setString('studentEmail', _studentEmail ?? '');
      await prefs.setString('selectedGrade', _selectedGrade ?? '');
    } catch (e) {
      print('Error saving auth state: $e');
    }
  }

  // ✅ التعديل الجديد: التحقق من حالة islogin (بالحروف الصغيرة)
  Future<bool> checkLoginStatus(String studentEmail) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(studentEmail)
          .get();

      if (doc.exists) {
        return doc.data()!['islogin'] ?? false;
      }
      return false;
    } catch (e) {
      print('Error checking login status: $e');
      throw Exception('فشل في التحقق من حالة الحساب');
    }
  }

  // ✅ التعديل الجديد: تحديث حالة islogin (بالحروف الصغيرة)
  Future<void> updateLoginStatus(String studentEmail, bool isLogin) async {
    try {
      await _firestore
          .collection('users')
          .doc(studentEmail)
          .update({
        'islogin': isLogin,
        'updated_at': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print('Error updating login status: $e');
      throw Exception('فشل في تحديث حالة الحساب');
    }
  }

  // ✅ التعديل الجديد: تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // ✅ التحقق من حالة islogin أولاً
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

      // التحقق من أن البريد الإلكتروني مفعل
      if (!user.emailVerified) {
        await _auth.signOut();
        throw Exception('يرجى تفعيل البريد الإلكتروني أولاً');
      }

      // جلب بيانات المستخدم من Firestore
      final doc = await _firestore
          .collection('users')
          .doc(email)
          .get();

      if (!doc.exists) {
        await _auth.signOut();
        throw Exception('الحساب غير موجود في قاعدة البيانات');
      }

      final userData = doc.data()!;

      // التحقق من حالة الحساب
      if (!userData['is_active']) {
        await _auth.signOut();
        throw Exception('الحساب غير مفعل');
      }

      // ✅ تحديث حالة islogin إلى true
      await updateLoginStatus(email, true);

      // تحديث حالة المصادقة
      _isLoggedIn = true;
      _studentEmail = email;
      _userData = userData;
      // ✅ استخدام الحقل student_level بدلاً من grade
      _selectedGrade = userData['student_level']?.toString() ?? _selectedGrade;

      // حفظ الحالة في الذاكرة المحلية
      await _saveAuthState();
      notifyListeners();

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
// في class AuthService
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
      print('Error getting courses: $e');
      return null;
    }
  }
  // في class AuthService

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
          // يمكن إضافة المزيد من الحقول حسب الحاجة
        };
      }).toList();
    } catch (e) {
      print('Error getting lessons: $e');
      return null;
    }
  }
  // ✅ التعديل: حفظ الصف المختار مع تحديث Firestore
  Future<void> setSelectedGrade(String grade) async {
    _selectedGrade = grade;

    try {
      // إذا كان المستخدم مسجلاً، قم بتحديث الصف في Firestore
      if (_isLoggedIn && _studentEmail != null) {
        await _firestore
            .collection('users')
            .doc(_studentEmail!)
            .update({
          'student_level': grade,
          'updated_at': FieldValue.serverTimestamp()
        });

        // تحديث البيانات المحلية
        if (_userData != null) {
          _userData!['student_level'] = grade;
        }
      }
    } catch (e) {
      print('Error updating grade on server: $e');
      // نستمر في حفظ البيانات محلياً حتى في حالة فشل السيرفر
    }

    await _saveAuthState();
    notifyListeners();
  }

  // ✅ التعديل: تسجيل الخروج مع تحديث islogin
  Future<void> logout() async {
    try {
      // ✅ تحديث حالة islogin إلى false قبل مسح البيانات
      if (_studentEmail != null) {
        try {
          await updateLoginStatus(_studentEmail!, false);
        } catch (e) {
          print('Error updating login status during logout: $e');
          // نستمر في عملية تسجيل الخروج حتى لو فشل تحديث السيرفر
        }
      }

      // تسجيل الخروج من Firebase Auth
      await _auth.signOut();

      _isLoggedIn = false;
      _studentEmail = null;
      _selectedGrade = null;
      _userData = null;

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      notifyListeners();
    } catch (e) {
      print('Error during logout: $e');
      throw Exception('حدث خطأ أثناء تسجيل الخروج');
    }
  }

  // تحديث بيانات المستخدم
  Future<void> refreshUserData() async {
    if (_studentEmail != null) {
      await _loadUserData();
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

      // التحقق من أن البريد الإلكتروني مفعل
      if (!user.emailVerified) {
        return false;
      }

      final doc = await _firestore
          .collection('users')
          .doc(_studentEmail!)
          .get();

      if (!doc.exists) {
        return false;
      }

      final userData = doc.data()!;

      // ✅ التحقق من أن الحساب نشط وأن حالة islogin متوافقة
      return userData['is_active'] == true && userData['islogin'] == true;
    } catch (e) {
      // إذا فشل التحقق، نقوم بتسجيل الخروج
      await logout();
      return false;
    }
  }

  // تغيير كلمة المرور
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }

      // إعادة المصادقة بالمستخدم الحالي
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // تغيير كلمة المرور
      await user.updatePassword(newPassword);

      // تحديث البيانات في Firestore
      await _firestore
          .collection('users')
          .doc(user.email!)
          .update({
        'updated_at': FieldValue.serverTimestamp()
      });

      // تحديث البيانات المحلية
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

      // إضافة تاريخ التحديث
      updates['updated_at'] = FieldValue.serverTimestamp();

      await _firestore
          .collection('users')
          .doc(user.email!)
          .update(updates);

      // تحديث البيانات المحلية
      if (_userData != null) {
        _userData!.addAll(updates);
      }

      await refreshUserData();
      notifyListeners();
    } catch (e) {
      throw Exception('فشل تحديث الملف الشخصي: $e');
    }
  }

  // استعادة كلمة المرور
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'فشل إرسال رابط استعادة كلمة المرور';

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'الحساب غير موجود';
          break;
        case 'invalid-email':
          errorMessage = 'بريد إلكتروني غير صالح';
          break;
        default:
          errorMessage = 'فشل إرسال رابط استعادة كلمة المرور: ${e.message}';
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('فشل إرسال رابط استعادة كلمة المرور: $e');
    }
  }

  // الحصول على معلومات الحساب
  Future<Map<String, dynamic>?> getAccountInfo() async {
    if (_studentEmail == null) return null;

    try {
      final doc = await _firestore
          .collection('users')
          .doc(_studentEmail!)
          .get();

      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      print('Error fetching account info: $e');
      return null;
    }
  }

  // التحقق من اتصال السيرفر
  Future<bool> checkServerConnection() async {
    try {
      await _firestore.collection('users').limit(1).get();
      return true;
    } catch (e) {
      print('Server connection error: $e');
      return false;
    }
  }

  // تنظيف البيانات المؤقتة
  void clearTempData() {
    _userData = null;
    notifyListeners();
  }

  // إعادة تحميل حالة المصادقة
  Future<void> reloadAuthState() async {
    await _loadAuthState();
  }

  // الحصول على معلومات الحساب بشكل مختصر
  String getAccountDisplayInfo() {
    if (!_isLoggedIn) return 'غير مسجل الدخول';

    return 'البريد الإلكتروني: $_studentEmail - الصف ${_selectedGrade ?? "لم يتم الاختيار"}';
  }

  // التحقق من صلاحية البيانات
  bool isValid() {
    return _isLoggedIn &&
        _studentEmail != null &&
        _studentEmail!.isNotEmpty;
  }

  // الحصول على تاريخ إنشاء الحساب
  String? getAccountCreationDate() {
    if (_userData == null) return null;

    try {
      final createdAt = _userData!['created_at'];
      if (createdAt != null) {
        if (createdAt is Timestamp) {
          final date = createdAt.toDate();
          return '${date.year}/${date.month}/${date.day}';
        } else if (createdAt is String) {
          final date = DateTime.parse(createdAt);
          return '${date.year}/${date.month}/${date.day}';
        }
      }
    } catch (e) {
      print('Error parsing creation date: $e');
    }

    return null;
  }

  // الحصول على حالة الحساب كنص
  String getAccountStatus() {
    if (_userData == null) return 'غير معروف';

    return _userData!['is_active'] == true ? 'نشط' : 'غير مفعل';
  }

  // ✅ التعديل: التحقق مما إذا كان الحساب نشط
  bool isAccountActive() {
    return _userData?['is_active'] == true;
  }

  // ✅ التعديل الجديد: التحقق من حالة تسجيل الدخول
  bool get isCurrentlyLoggedIn {
    return _userData?['islogin'] == true && _isLoggedIn;
  }

  // الحصول على جميع بيانات المستخدم المتاحة
  Map<String, dynamic> getAvailableUserData() {
    if (_userData == null) return {};

    // إرجاع نسخة من البيانات لتجنب التعديل المباشر
    return Map<String, dynamic>.from(_userData!);
  }

  // ✅ التعديل: دالة مزامنة بيانات المستخدم
  Future<void> syncUserData() async {
    if (_studentEmail != null) {
      await _loadUserData();
    }
  }

  // التحقق من وجود بيانات المستخدم
  bool hasUserData() {
    return _userData != null && _userData!.isNotEmpty;
  }

  // ✅ التعديل: دالة مساعدة للتحقق من اكتمال بيانات المستخدم
  bool isUserDataComplete() {
    return _isLoggedIn &&
        _studentEmail != null &&
        _studentEmail!.isNotEmpty &&
        _userData != null;
  }

  // ✅ التعديل: دالة للحصول على بيانات المستخدم الأساسية للعرض
  Map<String, String> getBasicUserInfo() {
    return {
      'student_email': _studentEmail ?? 'غير متوفر',
      'grade': _selectedGrade ?? 'لم يتم الاختيار',
      'status': getAccountStatus(),
      'creation_date': getAccountCreationDate() ?? 'غير معروف',
      'login_status': _userData?['islogin'] == true ? 'مسجل الدخول' : 'غير مسجل',
    };
  }

  // ✅ التعديل الجديد: إجبار تسجيل الخروج من جميع الأجهزة
  Future<void> forceLogoutFromAllDevices(String studentEmail) async {
    try {
      await _firestore
          .collection('users')
          .doc(studentEmail)
          .update({
        'islogin': false,
        'updated_at': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print('Error forcing logout from all devices: $e');
      throw Exception('فشل في إجبار تسجيل الخروج من جميع الأجهزة');
    }
  }

  // ✅ التعديل الجديد: التحقق من صحة الجلسة الحالية
  Future<bool> checkCurrentSessionValidity() async {
    if (!_isLoggedIn || _studentEmail == null) {
      return false;
    }

    try {
      final user = _auth.currentUser;
      if (user == null || !user.emailVerified) {
        await logout();
        return false;
      }

      final doc = await _firestore
          .collection('users')
          .doc(_studentEmail!)
          .get();

      if (!doc.exists) {
        await logout();
        return false;
      }

      final userData = doc.data()!;

      // يجب أن يكون الحساب نشط وأن تكون حالة islogin true
      final isValid = userData['is_active'] == true && userData['islogin'] == true;

      if (!isValid) {
        // إذا كانت الجلسة غير صالحة، نقوم بتسجيل الخروج محلياً
        await logout();
      }

      return isValid;
    } catch (e) {
      print('Error checking session validity: $e');
      await logout();
      return false;
    }
  }

  // ✅ دالة لتحويل رقم الصف إلى نص عربي
  String getGradeText() {
    if (_selectedGrade == null || _selectedGrade!.isEmpty) {
      return 'لم يتم الاختيار';
    }

    // تحويل القيمة إلى رقم للتحقق منها
    final gradeNumber = int.tryParse(_selectedGrade!);

    if (gradeNumber == null) {
      return _selectedGrade!; // إذا لم يكن رقماً، نعيد القيمة كما هي
    }

    // تحويل رقم الصف إلى النص المقابل
    switch (gradeNumber) {
      case 1:
        return 'الصف الأول الابتدائي';
      case 2:
        return 'الصف الثاني الابتدائي';
      case 3:
        return 'الصف الثالث الابتدائي';
      case 4:
        return 'الصف الرابع الابتدائي';
      case 5:
        return 'الصف الخامس الابتدائي';
      case 6:
        return 'الصف السادس الابتدائي';
      case 7:
        return 'الصف الأول المتوسط';
      case 8:
        return 'الصف الثاني المتوسط';
      case 9:
        return 'الصف الثالث المتوسط';
      case 10:
        return 'الصف الأول الثانوي';
      case 11:
        return 'الصف الثاني الثانوي';
      case 12:
        return 'الصف الثالث الثانوي';
      default:
        return 'الصف $_selectedGrade';
    }
  }

  // ✅ دالة جديدة: إنشاء حساب جديد
  Future<void> createUserWithEmailAndPassword(String email, String password, Map<String, dynamic> additionalData) async {
    try {
      // إنشاء المستخدم في Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // إعداد البيانات الأساسية للمستخدم
      final userData = {
        'email': email,
        'is_active': true,
        'islogin': false,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        ...additionalData,
      };

      // حفظ بيانات المستخدم في Firestore
      await _firestore
          .collection('users')
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

  // ✅ دالة جديدة: إرسال رابط تفعيل البريد الإلكتروني
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw Exception('لا يوجد مستخدم مسجل الدخول');
    }
  }

  // ✅ دالة جديدة: إعادة تعيين كلمة المرور
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
