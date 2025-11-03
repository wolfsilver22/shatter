import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoggedIn = false;
  String? _studentEmail;
  int? _selectedGrade;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  String? get studentEmail => _studentEmail;
  int? get selectedGrade => _selectedGrade;
  Map<String, dynamic>? get userData => _userData;

  AuthService() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final currentUser = _auth.currentUser;

      if (currentUser != null) {
        _isLoggedIn = true;
        _studentEmail = currentUser.email;
        await _loadUserData();
      } else {
        _isLoggedIn = false;
      }
      notifyListeners();
    } catch (e) {
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  Future<void> _loadUserData() async {
    try {
      if (_studentEmail != null) {
        final doc = await _firestore
            .collection('user_settings')
            .doc(_studentEmail)
            .get();

        if (doc.exists) {
          _userData = doc.data()!;
          final dynamic level = doc.data()!['student_level'];
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
        }
      }
    } catch (e) {
      _userData = null;
      _selectedGrade = null;
    }
  }

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
      throw Exception('فشل في التحقق من حالة الحساب');
    }
  }

  Future<void> updateLoginStatus(String studentEmail, bool isLogin) async {
    try {
      await _firestore
          .collection('user_settings')
          .doc(studentEmail)
          .update({
        'islogin': isLogin,
        'updated_at': FieldValue.serverTimestamp()
      });
    } catch (e) {
      throw Exception('فشل في تحديث حالة الحساب');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final isAlreadyLoggedIn = await checkLoginStatus(email);
      if (isAlreadyLoggedIn) {
        throw Exception('هذا الحساب مسجل حالياً في جهاز آخر. يرجى الخروج منه أولاً ثم المحاولة مرة أخرى.');
      }

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('فشل تسجيل الدخول - لم يتم إرجاع مستخدم');
      }

      final doc = await _firestore
          .collection('user_settings')
          .doc(email)
          .get();

      if (!doc.exists) {
        await _auth.signOut();
        throw Exception('الحساب غير موجود في إعدادات المستخدم');
      }

      final userData = doc.data()!;

      if (userData['is_active'] != true) {
        await _auth.signOut();
        throw Exception('الحساب غير مفعل');
      }

      await updateLoginStatus(email, true);

      _isLoggedIn = true;
      _studentEmail = email;
      _userData = userData;

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
        default:
          errorMessage = 'حدث خطأ غير متوقع: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      if (_studentEmail != null) {
        try {
          await updateLoginStatus(_studentEmail!, false);
        } catch (e) {
          // تجاهل الخطأ في تحديث حالة تسجيل الدخول
        }
      }

      await _auth.signOut();

      _isLoggedIn = false;
      _studentEmail = null;
      _selectedGrade = null;
      _userData = null;

      notifyListeners();
    } catch (e) {
      throw Exception('حدث خطأ أثناء تسجيل الخروج');
    }
  }

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
      await logout();
      return false;
    }
  }

  Future<void> refreshUserData() async {
    if (_studentEmail != null) {
      await _loadUserData();
    }
  }

  Future<List<Map<String, dynamic>>?> getCoursesForCurrentGrade() async {
    try {
      if (_selectedGrade == null) {
        return [];
      }

      final int searchLevel = _selectedGrade!;
      Query query = _firestore
          .collection('courses')
          .where('is_active', isEqualTo: true);

      try {
        query = query.where('student_level', isEqualTo: searchLevel);
      } catch (e) {
        // تجاهل الخطأ والمتابعة بدون فلترة المستوى
      }

      try {
        query = query.orderBy('order_index');
      } catch (e) {
        // تجاهل الخطأ والمتابعة بدون ترتيب
      }

      final QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isEmpty) {
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

      return courses;

    } catch (e) {
      if (_selectedGrade != null) {
        return await _getCoursesFallback(_selectedGrade!);
      }
      return [];
    }
  }

  Future<List<Map<String, dynamic>>?> _getCoursesFallback(int gradeLevel) async {
    try {
      final QuerySnapshot allCourses = await _firestore
          .collection('courses')
          .where('is_active', isEqualTo: true)
          .get();

      final List<Map<String, dynamic>> filteredCourses = [];

      for (var doc in allCourses.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final courseLevel = data['student_level'];

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

      return filteredCourses;

    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>?> getLessonsForCourse(String courseId) async {
    try {
      final baseQuery = _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .where('is_active', isEqualTo: true);

      QuerySnapshot querySnapshot;

      try {
        querySnapshot = await baseQuery.orderBy('order_index').get();
      } on FirebaseException catch (e) {
        if (e.code == 'failed-precondition') {
          querySnapshot = await baseQuery.get();
        } else {
          rethrow;
        }
      }

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      final lessons = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
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

      lessons.sort((a, b) => (a['order_index'] ?? 0).compareTo(b['order_index'] ?? 0));

      return lessons;

    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getLessonById(String courseId, String lessonId) async {
    try {
      final doc = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .doc(lessonId)
          .get();

      if (!doc.exists) {
        return null;
      }

      final data = doc.data() as Map<String, dynamic>;

      return {
        'id': doc.id,
        'course_id': courseId,
        'lesson_title': data['lesson_title'] ?? 'بدون عنوان',
        'lesson_image': data['lesson_image'] ?? '',
        'video_url': data['video_url'] ?? '',
        'order_index': data['order_index'] ?? 0,
        'is_active': data['is_active'] ?? true,
      };
    } catch (e) {
      return null;
    }
  }

  Future<void> setSelectedGrade(String grade) async {
    final int? gradeInt = int.tryParse(grade.trim());

    if (gradeInt == null) {
      return;
    }

    _selectedGrade = gradeInt;

    try {
      if (_isLoggedIn && _studentEmail != null) {
        await _firestore
            .collection('user_settings')
            .doc(_studentEmail!)
            .update({
          'student_level': _selectedGrade,
          'updated_at': FieldValue.serverTimestamp()
        });

        if (_userData != null) {
          _userData!['student_level'] = _selectedGrade;
        }
      }
    } catch (e) {
      // تجاهل الخطأ في التحديث
    }

    notifyListeners();
  }

  bool isAccountActive() {
    return _userData?['is_active'] == true;
  }

  String? get studentNumber {
    return _userData?['student_number']?.toString();
  }

  Future<void> createUserWithEmailAndPassword(String email, String password, Map<String, dynamic> additionalData) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (additionalData['student_level'] is String) {
        additionalData['student_level'] = int.tryParse(additionalData['student_level']) ?? 1;
      }

      final userData = {
        'email': email,
        'is_active': true,
        'islogin': false,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        ...additionalData,
      };

      await _firestore
          .collection('user_settings')
          .doc(email)
          .set(userData);

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

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw Exception('لا يوجد مستخدم مسجل الدخول');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

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

  // أضف هذه الدالة في AuthService
  Future<Map<String, dynamic>?> getUserSubscriptionData() async {
    try {
      if (studentEmail == null) {
        print('❌ studentEmail is null');
        return null;
      }

      print('🎯 جلب بيانات الاشتراك للمستخدم: $studentEmail');

      final docSnapshot = await FirebaseFirestore.instance
          .collection('user_settings')
          .doc(studentEmail)
          .get();

      if (docSnapshot.exists) {
        print('✅ تم العثور على بيانات الاشتراك: ${docSnapshot.data()}');
        return docSnapshot.data();
      } else {
        print('⚠️ لم يتم العثور على مستند user_settings للمستخدم: $studentEmail');
        return null;
      }
    } catch (error) {
      print('❌ خطأ في جلب بيانات الاشتراك: $error');
      return null;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }

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
      return null;
    }
  }

  String getGradeText() {
    return _getGradeText(_selectedGrade);
  }

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
      throw Exception('فشل في إجبار تسجيل الخروج من جميع الأجهزة');
    }
  }
}