import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoggedIn = false;
  String? _studentEmail;
  int? _selectedGrade; // ✅ تغيير من String? إلى int?
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  String? get studentEmail => _studentEmail;
  int? get selectedGrade => _selectedGrade; // ✅ تحديث الـ getter
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

  // ✅ تحميل بيانات المستخدم من user_settings - محسّن
  Future<void> _loadUserData() async {
    try {
      if (_studentEmail != null) {
        final doc = await _firestore
            .collection('user_settings')
            .doc(_studentEmail)
            .get();

        if (doc.exists) {
          _userData = doc.data()!;

          // ✅ تحويل student_level إلى int بشكل آمن
          final dynamic level = doc.data()!['student_level'];
          if (level != null) {
            if (level is int) {
              _selectedGrade = level;
            } else if (level is String) {
              _selectedGrade = int.tryParse(level);
            } else if (level is double) {
              _selectedGrade = level.toInt();
            }

            if (_selectedGrade == null) {
              print('⚠️ تحذير: تعذر تحويل student_level إلى int: $level');
            }
          }

          print('✅ تم تحميل بيانات المستخدم للصف: $_selectedGrade (نوع: ${_selectedGrade?.runtimeType})');
          notifyListeners();
        } else {
          print('⚠️ بيانات المستخدم غير موجودة في user_settings');
        }
      }
    } catch (e) {
      print('❌ خطأ في تحميل بيانات المستخدم: $e');
      _userData = null;
      _selectedGrade = null;
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

  // ✅ تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور - محسّن
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

      // ✅ تحديث حالة المصادقة مع تحويل أنواع البيانات
      _isLoggedIn = true;
      _studentEmail = email;
      _userData = userData;

      // ✅ تحويل student_level إلى int
      final dynamic level = userData['student_level'];
      if (level != null) {
        if (level is int) {
          _selectedGrade = level;
        } else if (level is String) {
          _selectedGrade = int.tryParse(level);
        } else if (level is double) {
          _selectedGrade = level.toInt();
        }
      }

      notifyListeners();

      print('✅ تسجيل الدخول ناجح: $email - الصف: $_selectedGrade');
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

  // ✅ دالة محسّنة لجلب الكورسات - تحل مشكلة عدم تطابق أنواع البيانات
  Future<List<Map<String, dynamic>>?> getCoursesForCurrentGrade() async {
    try {
      if (_selectedGrade == null) {
        print('⚠️ لم يتم تحديد صف الطالب بعد.');
        return [];
      }

      final int searchLevel = _selectedGrade!;
      print('🎯 جلب الكورسات للصف المحدد: $searchLevel (نوع: int)');

      // ✅ استعلام مرن يتعامل مع أنواع البيانات المختلفة
      Query query = _firestore
          .collection('courses')
          .where('is_active', isEqualTo: true);

      // ✅ محاولة الاستعلام بـ int أولاً (الأكثر شيوعاً)
      try {
        query = query.where('student_level', isEqualTo: searchLevel);
      } catch (e) {
        print('⚠️ خطأ في الاستعلام بـ int: $e');
      }

      // ✅ إضافة order_by إذا كان الحقل موجوداً
      try {
        query = query.orderBy('order_index');
      } catch (e) {
        print('⚠️ order_index غير متاح، الاستعلام بدون ترتيب');
      }

      final QuerySnapshot querySnapshot = await query.get();
      print('📊 عدد الكورسات المستلمة: ${querySnapshot.docs.length}');

      // ✅ إذا لم توجد نتائج، جرب الطريقة البديلة
      if (querySnapshot.docs.isEmpty) {
        print('🔄 لم توجد نتائج، جرب الطريقة البديلة...');
        return await _getCoursesFallback(searchLevel);
      }

      final courses = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'title': data['title'] ?? 'بدون عنوان',
          'image_url': data['image_url'] ?? '',
          'student_level': data['student_level']?.toString() ?? '',
          'is_active': data['is_active'] ?? true,
          'order_index': data['order_index'] ?? 0,
        };
      }).toList();

      print('✅ تم جلب ${courses.length} كورس بنجاح للصف "$searchLevel"');
      return courses;

    } catch (e) {
      print('❌ خطأ في جلب الكورسات: $e');

      // ✅ محاولة بديلة في حالة الخطأ
      if (_selectedGrade != null) {
        return await _getCoursesFallback(_selectedGrade!);
      }
      return [];
    }
  }

  // ✅ دالة احتياطية لجلب الكورسات بأنواع بيانات مختلفة
  Future<List<Map<String, dynamic>>?> _getCoursesFallback(int gradeLevel) async {
    try {
      print('🔄 استخدام الطريقة البديلة للصف: $gradeLevel');

      // جلب جميع الكورسات النشطة
      final QuerySnapshot allCourses = await _firestore
          .collection('courses')
          .where('is_active', isEqualTo: true)
          .get();

      final List<Map<String, dynamic>> filteredCourses = [];

      for (var doc in allCourses.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final courseLevel = data['student_level'];

        // ✅ التحقق من التطابق بأنواع بيانات مختلفة
        bool isMatch = false;

        if (courseLevel is int) {
          isMatch = courseLevel == gradeLevel;
        } else if (courseLevel is String) {
          isMatch = int.tryParse(courseLevel) == gradeLevel;
        } else if (courseLevel is double) {
          isMatch = courseLevel.toInt() == gradeLevel;
        }

        if (isMatch) {
          filteredCourses.add({
            'id': doc.id,
            'title': data['title'] ?? 'بدون عنوان',
            'image_url': data['image_url'] ?? '',
            'student_level': courseLevel.toString(),
            'is_active': data['is_active'] ?? true,
            'order_index': data['order_index'] ?? 0,
          });
        }
      }

      print('✅ الطريقة البديلة: تم جلب ${filteredCourses.length} كورس');
      return filteredCourses;

    } catch (e) {
      print('❌ فشل الطريقة البديلة: $e');
      return [];
    }
  }

  // ✅ دالة جديدة لجلب الدروس من Subcollection - متوافقة مع الهيكل الجديد
  Future<List<Map<String, dynamic>>?> getLessonsForCourse(String courseId) async {
    try {
      print('🔍 جلب الدروس للكورس: $courseId');

      final QuerySnapshot querySnapshot = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .where('is_active', isEqualTo: true)
          .orderBy('order_index')
          .get();

      print('📊 عدد الدروس المستلمة: ${querySnapshot.docs.length}');

      if (querySnapshot.docs.isEmpty) {
        print('⚠️ لا توجد دروس نشطة في هذا الكورس');
        return [];
      }

      final lessons = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // ✅ طباعة بيانات كل درس للتشخيص
        print('📝 درس: ${data['lesson_title']} - ترتيب: ${data['order_index']}');

        return {
          'id': doc.id,
          'course_id': courseId,
          'lesson_title': data['lesson_title'] ?? 'بدون عنوان',
          'lesson_image': data['lesson_image'] ?? '',
          'video_url': data['video_url'] ?? '',
          'order_index': data['order_index'] ?? 0,
          'is_active': data['is_active'] ?? true,
        };
      }).toList();

      print('✅ تم جلب ${lessons.length} درس بنجاح للكورس $courseId');
      return lessons;

    } catch (e) {
      print('❌ خطأ في جلب الدروس: $e');
      print('📌 StackTrace: ${e.toString()}');
      return [];
    }
  }

  // ✅ حفظ الصف المختار مع تحديث user_settings - محسّن
  Future<void> setSelectedGrade(String grade) async {
    // ✅ تحويل إلى int بشكل آمن
    final int? gradeInt = int.tryParse(grade.trim());

    if (gradeInt == null) {
      print('❌ خطأ: الصف غير صالح - "$grade"');
      return;
    }

    _selectedGrade = gradeInt;

    try {
      if (_isLoggedIn && _studentEmail != null) {
        await _firestore
            .collection('user_settings')
            .doc(_studentEmail!)
            .update({
          'student_level': _selectedGrade, // ✅ حفظ كـ int في Firestore
          'updated_at': FieldValue.serverTimestamp()
        });

        if (_userData != null) {
          _userData!['student_level'] = _selectedGrade;
        }
      }
    } catch (e) {
      print('❌ خطأ في تحديث الصف في user_settings: $e');
    }

    notifyListeners();
    print('✅ تم تحديث الصف إلى: $_selectedGrade');
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

      // ✅ تحويل student_level إلى int إذا كان string
      if (additionalData['student_level'] is String) {
        additionalData['student_level'] = int.tryParse(additionalData['student_level']) ?? 1;
      }

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

      // ✅ تحويل student_level إلى int إذا كان موجوداً
      if (updates['student_level'] is String) {
        updates['student_level'] = int.tryParse(updates['student_level']);
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

  // ✅ دالة مساعدة لتحويل رقم الصف إلى نص - محدثة
  String _getGradeText(int? gradeValue) {
    if (gradeValue == null) {
      return 'لم يتم الاختيار';
    }

    switch (gradeValue) {
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

  // ✅ دوال تشخيصية محسنة للتحقق من البيانات

  // دالة تشخيصية لفحص جميع الكورسات
  Future<void> _debugAllCourses() async {
    try {
      print('🔍 فحص جميع الكورسات في قاعدة البيانات...');

      final QuerySnapshot allCourses = await _firestore
          .collection('courses')
          .where('is_active', isEqualTo: true)
          .get();

      print('📊 إجمالي الكورسات النشطة في النظام: ${allCourses.docs.length}');

      if (allCourses.docs.isEmpty) {
        print('❌ لا توجد أي كورسات نشطة في النظام!');
        return;
      }

      for (var doc in allCourses.docs) {
        final data = doc.data() as Map<String, dynamic>;
        print('''
🎯 كورس نشط:
- العنوان: ${data['title']}
- ID: ${doc.id}
- student_level: "${data['student_level']}" (نوع: ${data['student_level']?.runtimeType})
- is_active: ${data['is_active']}
- order_index: ${data['order_index']}
---''');
      }

    } catch (e) {
      print('❌ خطأ في الفحص التشخيصي: $e');
    }
  }

  // ✅ دالة تشخيصية للتحقق من مستويات الصفوف المتاحة
  Future<void> debugAvailableGradeLevels() async {
    try {
      print('🔍 فحص مستويات الصفوف المتاحة في الكورسات...');

      final QuerySnapshot allCourses = await _firestore
          .collection('courses')
          .where('is_active', isEqualTo: true)
          .get();

      Set<String> availableLevels = {};

      for (var doc in allCourses.docs) {
        final data = doc.data() as Map<String, dynamic>;
        String? level = data['student_level']?.toString();
        if (level != null) {
          availableLevels.add(level);
        }
      }

      print('📊 مستويات الصفوف المتاحة: $availableLevels');

    } catch (e) {
      print('❌ خطأ في فحص مستويات الصفوف: $e');
    }
  }

  // ✅ دالة تشخيصية محسنة للتحقق من البيانات
  Future<void> debugFirestoreData(String gradeLevel) async {
    try {
      print('🔍 فحص بيانات Firestore للصف: $gradeLevel');

      // ✅ تحويل إلى int للاستعلام
      final int? gradeInt = int.tryParse(gradeLevel);

      if (gradeInt != null) {
        // جلب جميع الكورسات للصف المحدد كـ int
        final QuerySnapshot coursesSnapshot = await _firestore
            .collection('courses')
            .where('student_level', isEqualTo: gradeInt)
            .get();

        print('📊 عدد الكورسات للصف $gradeLevel (كـ int): ${coursesSnapshot.docs.length}');
      }

      // ✅ جلب كـ string أيضاً للمقارنة
      final QuerySnapshot coursesSnapshotString = await _firestore
          .collection('courses')
          .where('student_level', isEqualTo: gradeLevel)
          .get();

      print('📊 عدد الكورسات للصف $gradeLevel (كـ string): ${coursesSnapshotString.docs.length}');

      // ✅ جلب جميع الكورسات النشطة
      final QuerySnapshot allActiveCourses = await _firestore
          .collection('courses')
          .where('is_active', isEqualTo: true)
          .get();

      print('📊 إجمالي الكورسات النشطة: ${allActiveCourses.docs.length}');

      for (var doc in allActiveCourses.docs) {
        final data = doc.data() as Map<String, dynamic>;
        print('''
🎯 كورس: ${data['title']}
- ID: ${doc.id}
- student_level: "${data['student_level']}" (نوع: ${data['student_level']?.runtimeType})
- is_active: ${data['is_active']}
- order_index: ${data['order_index']}
---''');
      }

    } catch (e) {
      print('❌ خطأ في الفحص التشخيصي: $e');
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

  // ✅ طباعة حالة المصادقة للتشخيص - محدثة
  void printAuthState() {
    print('''
🔐 حالة المصادقة:
- isLoggedIn: $_isLoggedIn
- studentEmail: $_studentEmail
- selectedGrade: "$_selectedGrade" (نوع: ${_selectedGrade?.runtimeType})
- userData: ${_userData != null ? 'موجود' : 'غير موجود'}
- Firebase User: ${_auth.currentUser?.email}
- Firebase User ID: ${_auth.currentUser?.uid}
- Account Active: ${isAccountActive()}
- Student Number: $studentNumber
- Grade Text: ${getGradeText()}
''');
  }

  // ✅ دالة جديدة للتحقق من نوع البيانات في Firestore
  Future<void> debugDataTypes() async {
    try {
      print('🔍 فحص أنواع البيانات في Firestore...');

      // فحص user_settings
      if (_studentEmail != null) {
        final userDoc = await _firestore
            .collection('user_settings')
            .doc(_studentEmail!)
            .get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          print('''
👤 بيانات المستخدم:
- student_level: "${userData['student_level']}" (نوع: ${userData['student_level']?.runtimeType})
- is_active: ${userData['is_active']}
- islogin: ${userData['islogin']}
''');
        }
      }

      // فحص عينة من الكورسات
      final sampleCourses = await _firestore
          .collection('courses')
          .limit(3)
          .get();

      print('📊 عينة من أنواع بيانات الكورسات:');
      for (var doc in sampleCourses.docs) {
        final data = doc.data();
        print('- "${data['title']}": student_level = "${data['student_level']}" (نوع: ${data['student_level']?.runtimeType})');
      }

    } catch (e) {
      print('❌ خطأ في فحص أنواع البيانات: $e');
    }
  }
}