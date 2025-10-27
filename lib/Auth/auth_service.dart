// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthService with ChangeNotifier {
//   final SupabaseClient _supabase = Supabase.instance.client;
//
//   bool _isLoggedIn = false;
//   String? _studentNumber;
//   String? _selectedGrade;
//
//   bool get isLoggedIn => _isLoggedIn;
//   String? get studentNumber => _studentNumber;
//   String? get selectedGrade => _selectedGrade;
//
//   AuthService() {
//     _loadAuthState();
//   }
//
//   // تحميل حالة المصادقة من الذاكرة المحلية
//   Future<void> _loadAuthState() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//       _studentNumber = prefs.getString('studentNumber');
//       _selectedGrade = prefs.getString('selectedGrade');
//
//       notifyListeners();
//     } catch (e) {
//       print('Error loading auth state: $e');
//     }
//   }
//
//   // حفظ حالة المصادقة في الذاكرة المحلية
//   Future<void> _saveAuthState() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', _isLoggedIn);
//       await prefs.setString('studentNumber', _studentNumber ?? '');
//       await prefs.setString('selectedGrade', _selectedGrade ?? '');
//     } catch (e) {
//       print('Error saving auth state: $e');
//     }
//   }
//
//   // تسجيل الدخول
//   Future<void> login(String studentNumber, String password) async {
//     try {
//       final response = await _supabase
//           .from('users')
//           .select()
//           .eq('student_number', studentNumber)
//           .single();
//
//       if (!response['is_active']) {
//         throw Exception('الحساب غير مفعل');
//       }
//
//       if (response['password'] != password) {
//         throw Exception('كلمة المرور غير صحيحة');
//       }
//
//       _isLoggedIn = true;
//       _studentNumber = studentNumber;
//       await _saveAuthState();
//       notifyListeners();
//
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // حفظ الصف المختار
//   Future<void> setSelectedGrade(String grade) async {
//     _selectedGrade = grade;
//     await _saveAuthState();
//     notifyListeners();
//   }
//
//   // تسجيل الخروج
//   Future<void> logout() async {
//     try {
//       _isLoggedIn = false;
//       _studentNumber = null;
//       _selectedGrade = null;
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.clear();
//
//       notifyListeners();
//     } catch (e) {
//       print('Error during logout: $e');
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthService with ChangeNotifier {
//   final SupabaseClient _supabase = Supabase.instance.client;
//
//   bool _isLoggedIn = false;
//   String? _studentNumber;
//   String? _selectedGrade;
//   Map<String, dynamic>? _userData;
//
//   bool get isLoggedIn => _isLoggedIn;
//   String? get studentNumber => _studentNumber;
//   String? get selectedGrade => _selectedGrade;
//   Map<String, dynamic>? get userData => _userData;
//
//   AuthService() {
//     _loadAuthState();
//   }
//
//   // تحميل حالة المصادقة من الذاكرة المحلية
//   Future<void> _loadAuthState() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//       _studentNumber = prefs.getString('studentNumber');
//       _selectedGrade = prefs.getString('selectedGrade');
//
//       // إذا كان المستخدم مسجلاً، قم بتحميل بياناته
//       if (_isLoggedIn && _studentNumber != null) {
//         await _loadUserData(_studentNumber!);
//       }
//
//       notifyListeners();
//     } catch (e) {
//       print('Error loading auth state: $e');
//     }
//   }
//
//   // تحميل بيانات المستخدم من Supabase
//   Future<void> _loadUserData(String studentNumber) async {
//     try {
//       final response = await _supabase
//           .from('users')
//           .select()
//           .eq('student_number', studentNumber)
//           .single();
//
//       _userData = response;
//       notifyListeners();
//     } catch (e) {
//       print('Error loading user data: $e');
//       // في حالة الخطأ، نحتفظ بتسجيل الدخول ولكن بدون بيانات المستخدم
//       _userData = null;
//     }
//   }
//
//   // حفظ حالة المصادقة في الذاكرة المحلية
//   Future<void> _saveAuthState() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', _isLoggedIn);
//       await prefs.setString('studentNumber', _studentNumber ?? '');
//       await prefs.setString('selectedGrade', _selectedGrade ?? '');
//     } catch (e) {
//       print('Error saving auth state: $e');
//     }
//   }
//
//   // تسجيل الدخول
//   Future<void> login(String studentNumber, String password) async {
//     try {
//       // البحث عن المستخدم في قاعدة البيانات
//       final response = await _supabase
//           .from('users')
//           .select()
//           .eq('student_number', studentNumber)
//           .single();
//
//       // التحقق من حالة الحساب
//       if (!response['is_active']) {
//         throw Exception('الحساب غير مفعل');
//       }
//
//       // التحقق من كلمة المرور
//       if (response['password'] != password) {
//         throw Exception('كلمة المرور غير صحيحة');
//       }
//
//       // تحديث حالة المصادقة
//       _isLoggedIn = true;
//       _studentNumber = studentNumber;
//       _userData = response;
//
//       // حفظ الحالة في الذاكرة المحلية
//       await _saveAuthState();
//       notifyListeners();
//
//     } on PostgrestException catch (e) {
//       if (e.code == 'PGRST116') {
//         throw Exception('الحساب غير موجود');
//       } else {
//         throw Exception('حدث خطأ في النظام: ${e.message}');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // حفظ الصف المختار
//   Future<void> setSelectedGrade(String grade) async {
//     _selectedGrade = grade;
//     await _saveAuthState();
//     notifyListeners();
//   }
//
//   // تسجيل الخروج
//   Future<void> logout() async {
//     try {
//       _isLoggedIn = false;
//       _studentNumber = null;
//       _selectedGrade = null;
//       _userData = null;
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.clear();
//
//       notifyListeners();
//     } catch (e) {
//       print('Error during logout: $e');
//       throw Exception('حدث خطأ أثناء تسجيل الخروج');
//     }
//   }
//
//   // تحديث بيانات المستخدم
//   Future<void> refreshUserData() async {
//     if (_studentNumber != null) {
//       await _loadUserData(_studentNumber!);
//     }
//   }
//
//   // التحقق من صحة الجلسة
//   Future<bool> validateSession() async {
//     if (!_isLoggedIn || _studentNumber == null) {
//       return false;
//     }
//
//     try {
//       final response = await _supabase
//           .from('users')
//           .select('is_active')
//           .eq('student_number', _studentNumber!)
//           .single();
//
//       return response['is_active'] == true;
//     } catch (e) {
//       // إذا فشل التحقق، نقوم بتسجيل الخروج
//       await logout();
//       return false;
//     }
//   }
//
//   // تغيير كلمة المرور
//   Future<void> changePassword(String currentPassword, String newPassword) async {
//     try {
//       if (_studentNumber == null) {
//         throw Exception('يجب تسجيل الدخول أولاً');
//       }
//
//       // التحقق من كلمة المرور الحالية أولاً
//       final user = await _supabase
//           .from('users')
//           .select()
//           .eq('student_number', _studentNumber!)
//           .single();
//
//       if (user['password'] != currentPassword) {
//         throw Exception('كلمة المرور الحالية غير صحيحة');
//       }
//
//       // تحديث كلمة المرور
//       await _supabase
//           .from('users')
//           .update({
//         'password': newPassword,
//         'updated_at': DateTime.now().toIso8601String(),
//       })
//           .eq('student_number', _studentNumber!);
//
//       // تحديث البيانات المحلية
//       if (_userData != null) {
//         _userData!['password'] = newPassword;
//         _userData!['updated_at'] = DateTime.now().toIso8601String();
//       }
//
//       notifyListeners();
//     } catch (e) {
//       throw Exception('فشل تغيير كلمة المرور: $e');
//     }
//   }
//
//   // تحديث الملف الشخصي (للاستخدام المستقبلي عند إضافة المزيد من الحقول)
//   Future<void> updateProfile(Map<String, dynamic> updates) async {
//     try {
//       if (_studentNumber == null) {
//         throw Exception('يجب تسجيل الدخول أولاً');
//       }
//
//       // إضافة تاريخ التحديث
//       updates['updated_at'] = DateTime.now().toIso8601String();
//
//       await _supabase
//           .from('users')
//           .update(updates)
//           .eq('student_number', _studentNumber!);
//
//       // تحديث البيانات المحلية
//       if (_userData != null) {
//         _userData!.addAll(updates);
//       }
//
//       await refreshUserData();
//       notifyListeners();
//     } catch (e) {
//       throw Exception('فشل تحديث الملف الشخصي: $e');
//     }
//   }
//
//   // استعادة كلمة المرور
//   Future<void> resetPassword(String studentNumber) async {
//     try {
//       // التحقق من وجود الحساب
//       final response = await _supabase
//           .from('users')
//           .select('is_active')
//           .eq('student_number', studentNumber)
//           .single();
//
//       if (!response['is_active']) {
//         throw Exception('الحساب غير مفعل');
//       }
//
//       // هنا يمكنك إضافة منطق إرسال البريد الإلكتروني أو رسالة
//       throw Exception('سيتم إضافة خاصية استعادة كلمة المرور قريباً');
//
//     } on PostgrestException catch (e) {
//       if (e.code == 'PGRST116') {
//         throw Exception('الحساب غير موجود');
//       } else {
//         throw Exception('حدث خطأ في النظام');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // الحصول على معلومات الحساب
//   Future<Map<String, dynamic>?> getAccountInfo() async {
//     if (_studentNumber == null) return null;
//
//     try {
//       final response = await _supabase
//           .from('users')
//           .select('id, student_number, is_active, created_at, updated_at')
//           .eq('student_number', _studentNumber!)
//           .single();
//
//       return response;
//     } catch (e) {
//       print('Error fetching account info: $e');
//       return null;
//     }
//   }
//
//   // التحقق من اتصال السيرفر
//   Future<bool> checkServerConnection() async {
//     try {
//       await _supabase
//           .from('users')
//           .select('count')
//           .limit(1);
//       return true;
//     } catch (e) {
//       print('Server connection error: $e');
//       return false;
//     }
//   }
//
//   // تنظيف البيانات المؤقتة
//   void clearTempData() {
//     _userData = null;
//     notifyListeners();
//   }
//
//   // إعادة تحميل حالة المصادقة
//   Future<void> reloadAuthState() async {
//     await _loadAuthState();
//   }
//
//   // الحصول على معلومات الحساب بشكل مختصر
//   String getAccountDisplayInfo() {
//     if (!_isLoggedIn) return 'غير مسجل الدخول';
//
//     return 'رقم الحساب: $_studentNumber - الصف ${_selectedGrade ?? "لم يتم الاختيار"}';
//   }
//
//   // التحقق من صلاحية البيانات
//   bool isValid() {
//     return _isLoggedIn &&
//         _studentNumber != null &&
//         _studentNumber!.isNotEmpty;
//   }
//
//   // الحصول على تاريخ إنشاء الحساب
//   String? getAccountCreationDate() {
//     if (_userData == null) return null;
//
//     try {
//       final createdAt = _userData!['created_at'];
//       if (createdAt != null) {
//         final date = DateTime.parse(createdAt);
//         return '${date.year}/${date.month}/${date.day}';
//       }
//     } catch (e) {
//       print('Error parsing creation date: $e');
//     }
//
//     return null;
//   }
//
//   // الحصول على حالة الحساب كنص
//   String getAccountStatus() {
//     if (_userData == null) return 'غير معروف';
//
//     return _userData!['is_active'] == true ? 'نشط' : 'غير مفعل';
//   }
//
//   // التحقق مما إذا كان الحساب نشط
//   bool isAccountActive() {
//     return _userData?['is_active'] == true;
//   }
//
//   // الحصول على جميع بيانات المستخدم المتاحة
//   Map<String, dynamic> getAvailableUserData() {
//     if (_userData == null) return {};
//
//     // إرجاع نسخة من البيانات لتجنب التعديل المباشر
//     return Map<String, dynamic>.from(_userData!);
//   }
//
//   // تحديث بيانات المستخدم المحلية من السيرفر
//   Future<void> syncUserData() async {
//     if (_studentNumber != null) {
//       await _loadUserData(_studentNumber!);
//     }
//   }
//
//   // التحقق من وجود بيانات المستخدم
//   bool hasUserData() {
//     return _userData != null && _userData!.isNotEmpty;
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthService with ChangeNotifier {
//   final SupabaseClient supabase = Supabase.instance.client;
//
//   bool _isLoggedIn = false;
//   String? _studentNumber;
//   String? _selectedGrade;
//   Map<String, dynamic>? _userData;
//
//   bool get isLoggedIn => _isLoggedIn;
//   String? get studentNumber => _studentNumber;
//   String? get selectedGrade => _selectedGrade;
//   Map<String, dynamic>? get userData => _userData;
//
//   AuthService() {
//     _initialize();
//   }
//
//   // ✅ التعديل: دالة التهيئة المطلوبة للملف main.dart
//   Future<void> initialize() async {
//     try {
//       // جلب حالة المستخدم الحالي من Supabase
//       final currentUser = supabase.auth.currentUser;
//
//       if (currentUser != null) {
//         _isLoggedIn = true;
//         _studentNumber = currentUser.email ?? currentUser.id;
//
//         // جلب البيانات الإضافية من الجدول إذا لزم الأمر
//         await _loadUserData();
//       } else {
//         _isLoggedIn = false;
//       }
//
//       notifyListeners();
//     } catch (e) {
//       print('Error initializing auth: $e');
//       _isLoggedIn = false;
//       notifyListeners();
//     }
//   }
//
//   // ✅ التعديل: دالة تحميل بيانات المستخدم من Supabase
//   Future<void> _loadUserData() async {
//     try {
//       if (_studentNumber != null) {
//         final response = await supabase
//             .from('users')
//             .select()
//             .eq('student_number', _studentNumber!)
//             .single();
//
//         _userData = response;
//         _selectedGrade = response['grade'] ?? _selectedGrade;
//         notifyListeners();
//       }
//     } catch (e) {
//       print('Error loading user data: $e');
//       _userData = null;
//     }
//   }
//
//   // تحميل حالة المصادقة من الذاكرة المحلية
//   Future<void> _loadAuthState() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//       _studentNumber = prefs.getString('studentNumber');
//       _selectedGrade = prefs.getString('selectedGrade');
//
//       // إذا كان المستخدم مسجلاً، قم بتحميل بياناته
//       if (_isLoggedIn && _studentNumber != null) {
//         await _loadUserData();
//       }
//
//       notifyListeners();
//     } catch (e) {
//       print('Error loading auth state: $e');
//     }
//   }
//
//   // تهيئة الخدمة
//   Future<void> _initialize() async {
//     await _loadAuthState();
//   }
//
//   // حفظ حالة المصادقة في الذاكرة المحلية
//   Future<void> _saveAuthState() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', _isLoggedIn);
//       await prefs.setString('studentNumber', _studentNumber ?? '');
//       await prefs.setString('selectedGrade', _selectedGrade ?? '');
//     } catch (e) {
//       print('Error saving auth state: $e');
//     }
//   }
//
//   // تسجيل الدخول
//   Future<void> login(String studentNumber, String password) async {
//     try {
//       // البحث عن المستخدم في قاعدة البيانات
//       final response = await supabase
//           .from('users')
//           .select()
//           .eq('student_number', studentNumber)
//           .single();
//
//       // التحقق من حالة الحساب
//       if (!response['is_active']) {
//         throw Exception('الحساب غير مفعل');
//       }
//
//       // التحقق من كلمة المرور
//       if (response['password'] != password) {
//         throw Exception('كلمة المرور غير صحيحة');
//       }
//
//       // تحديث حالة المصادقة
//       _isLoggedIn = true;
//       _studentNumber = studentNumber;
//       _userData = response;
//       _selectedGrade = response['grade'] ?? _selectedGrade;
//
//       // حفظ الحالة في الذاكرة المحلية
//       await _saveAuthState();
//       notifyListeners();
//
//     } on PostgrestException catch (e) {
//       if (e.code == 'PGRST116') {
//         throw Exception('الحساب غير موجود');
//       } else {
//         throw Exception('حدث خطأ في النظام: ${e.message}');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // ✅ التعديل: حفظ الصف المختار مع تحديث السيرفر
//   Future<void> setSelectedGrade(String grade) async {
//     _selectedGrade = grade;
//
//     try {
//       // إذا كان المستخدم مسجلاً، قم بتحديث الصف في السيرفر
//       if (_isLoggedIn && _studentNumber != null) {
//         await supabase
//             .from('users')
//             .update({'grade': grade})
//             .eq('student_number', _studentNumber!);
//
//         // تحديث البيانات المحلية
//         if (_userData != null) {
//           _userData!['grade'] = grade;
//         }
//       }
//     } catch (e) {
//       print('Error updating grade on server: $e');
//       // نستمر في حفظ البيانات محلياً حتى في حالة فشل السيرفر
//     }
//
//     await _saveAuthState();
//     notifyListeners();
//   }
//
//   // تسجيل الخروج
//   Future<void> logout() async {
//     try {
//       _isLoggedIn = false;
//       _studentNumber = null;
//       _selectedGrade = null;
//       _userData = null;
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.clear();
//
//       notifyListeners();
//     } catch (e) {
//       print('Error during logout: $e');
//       throw Exception('حدث خطأ أثناء تسجيل الخروج');
//     }
//   }
//
//   // تحديث بيانات المستخدم
//   Future<void> refreshUserData() async {
//     if (_studentNumber != null) {
//       await _loadUserData();
//     }
//   }
//
//   // التحقق من صحة الجلسة
//   Future<bool> validateSession() async {
//     if (!_isLoggedIn || _studentNumber == null) {
//       return false;
//     }
//
//     try {
//       final response = await supabase
//           .from('users')
//           .select('is_active')
//           .eq('student_number', _studentNumber!)
//           .single();
//
//       return response['is_active'] == true;
//     } catch (e) {
//       // إذا فشل التحقق، نقوم بتسجيل الخروج
//       await logout();
//       return false;
//     }
//   }
//
//   // تغيير كلمة المرور
//   Future<void> changePassword(String currentPassword, String newPassword) async {
//     try {
//       if (_studentNumber == null) {
//         throw Exception('يجب تسجيل الدخول أولاً');
//       }
//
//       // التحقق من كلمة المرور الحالية أولاً
//       final user = await supabase
//           .from('users')
//           .select()
//           .eq('student_number', _studentNumber!)
//           .single();
//
//       if (user['password'] != currentPassword) {
//         throw Exception('كلمة المرور الحالية غير صحيحة');
//       }
//
//       // تحديث كلمة المرور
//       await supabase
//           .from('users')
//           .update({
//         'password': newPassword,
//         'updated_at': DateTime.now().toIso8601String(),
//       })
//           .eq('student_number', _studentNumber!);
//
//       // تحديث البيانات المحلية
//       if (_userData != null) {
//         _userData!['password'] = newPassword;
//         _userData!['updated_at'] = DateTime.now().toIso8601String();
//       }
//
//       notifyListeners();
//     } catch (e) {
//       throw Exception('فشل تغيير كلمة المرور: $e');
//     }
//   }
//
//   // تحديث الملف الشخصي
//   Future<void> updateProfile(Map<String, dynamic> updates) async {
//     try {
//       if (_studentNumber == null) {
//         throw Exception('يجب تسجيل الدخول أولاً');
//       }
//
//       // إضافة تاريخ التحديث
//       updates['updated_at'] = DateTime.now().toIso8601String();
//
//       await supabase
//           .from('users')
//           .update(updates)
//           .eq('student_number', _studentNumber!);
//
//       // تحديث البيانات المحلية
//       if (_userData != null) {
//         _userData!.addAll(updates);
//       }
//
//       await refreshUserData();
//       notifyListeners();
//     } catch (e) {
//       throw Exception('فشل تحديث الملف الشخصي: $e');
//     }
//   }
//
//   // استعادة كلمة المرور
//   Future<void> resetPassword(String studentNumber) async {
//     try {
//       // التحقق من وجود الحساب
//       final response = await supabase
//           .from('users')
//           .select('is_active')
//           .eq('student_number', studentNumber)
//           .single();
//
//       if (!response['is_active']) {
//         throw Exception('الحساب غير مفعل');
//       }
//
//       // هنا يمكنك إضافة منطق إرسال البريد الإلكتروني أو رسالة
//       throw Exception('سيتم إضافة خاصية استعادة كلمة المرور قريباً');
//
//     } on PostgrestException catch (e) {
//       if (e.code == 'PGRST116') {
//         throw Exception('الحساب غير موجود');
//       } else {
//         throw Exception('حدث خطأ في النظام');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // الحصول على معلومات الحساب
//   Future<Map<String, dynamic>?> getAccountInfo() async {
//     if (_studentNumber == null) return null;
//
//     try {
//       final response = await supabase
//           .from('users')
//           .select('id, student_number, is_active, created_at, updated_at, grade')
//           .eq('student_number', _studentNumber!)
//           .single();
//
//       return response;
//     } catch (e) {
//       print('Error fetching account info: $e');
//       return null;
//     }
//   }
//
//   // التحقق من اتصال السيرفر
//   Future<bool> checkServerConnection() async {
//     try {
//       await supabase
//           .from('users')
//           .select('count')
//           .limit(1);
//       return true;
//     } catch (e) {
//       print('Server connection error: $e');
//       return false;
//     }
//   }
//
//   // تنظيف البيانات المؤقتة
//   void clearTempData() {
//     _userData = null;
//     notifyListeners();
//   }
//
//   // إعادة تحميل حالة المصادقة
//   Future<void> reloadAuthState() async {
//     await _loadAuthState();
//   }
//
//   // الحصول على معلومات الحساب بشكل مختصر
//   String getAccountDisplayInfo() {
//     if (!_isLoggedIn) return 'غير مسجل الدخول';
//
//     return 'رقم الحساب: $_studentNumber - الصف ${_selectedGrade ?? "لم يتم الاختيار"}';
//   }
//
//   // التحقق من صلاحية البيانات
//   bool isValid() {
//     return _isLoggedIn &&
//         _studentNumber != null &&
//         _studentNumber!.isNotEmpty;
//   }
//
//   // الحصول على تاريخ إنشاء الحساب
//   String? getAccountCreationDate() {
//     if (_userData == null) return null;
//
//     try {
//       final createdAt = _userData!['created_at'];
//       if (createdAt != null) {
//         final date = DateTime.parse(createdAt);
//         return '${date.year}/${date.month}/${date.day}';
//       }
//     } catch (e) {
//       print('Error parsing creation date: $e');
//     }
//
//     return null;
//   }
//
//   // الحصول على حالة الحساب كنص
//   String getAccountStatus() {
//     if (_userData == null) return 'غير معروف';
//
//     return _userData!['is_active'] == true ? 'نشط' : 'غير مفعل';
//   }
//
//   // ✅ التعديل: التحقق مما إذا كان الحساب نشط
//   bool isAccountActive() {
//     return _userData?['is_active'] == true;
//   }
//
//   // الحصول على جميع بيانات المستخدم المتاحة
//   Map<String, dynamic> getAvailableUserData() {
//     if (_userData == null) return {};
//
//     // إرجاع نسخة من البيانات لتجنب التعديل المباشر
//     return Map<String, dynamic>.from(_userData!);
//   }
//
//   // ✅ التعديل: دالة مزامنة بيانات المستخدم
//   Future<void> syncUserData() async {
//     if (_studentNumber != null) {
//       await _loadUserData();
//     }
//   }
//
//   // التحقق من وجود بيانات المستخدم
//   bool hasUserData() {
//     return _userData != null && _userData!.isNotEmpty;
//   }
//
//   // ✅ التعديل: دالة مساعدة للتحقق من اكتمال بيانات المستخدم
//   bool isUserDataComplete() {
//     return _isLoggedIn &&
//         _studentNumber != null &&
//         _studentNumber!.isNotEmpty &&
//         _userData != null;
//   }
//
//   // ✅ التعديل: دالة للحصول على بيانات المستخدم الأساسية للعرض
//   Map<String, String> getBasicUserInfo() {
//     return {
//       'student_number': _studentNumber ?? 'غير متوفر',
//       'grade': _selectedGrade ?? 'لم يتم الاختيار',
//       'status': getAccountStatus(),
//       'creation_date': getAccountCreationDate() ?? 'غير معروف',
//     };
//   }
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  bool _isLoggedIn = false;
  String? _studentNumber;
  String? _selectedGrade;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  String? get studentNumber => _studentNumber;
  String? get selectedGrade => _selectedGrade;
  Map<String, dynamic>? get userData => _userData;

  AuthService() {
    _initialize();
  }

  // ✅ التعديل: دالة التهيئة المطلوبة للملف main.dart
  Future<void> initialize() async {
    try {
      // جلب حالة المستخدم الحالي من Supabase
      final currentUser = supabase.auth.currentUser;

      if (currentUser != null) {
        _isLoggedIn = true;
        _studentNumber = currentUser.email ?? currentUser.id;

        // جلب البيانات الإضافية من الجدول إذا لزم الأمر
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

  // ✅ التعديل: دالة تحميل بيانات المستخدم من Supabase
  Future<void> _loadUserData() async {
    try {
      if (_studentNumber != null) {
        final response = await supabase
            .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
            .select()
            .eq('student_number', _studentNumber!)
            .single();

        _userData = response;
        _selectedGrade = response['grade']?.toString() ?? _selectedGrade;
        notifyListeners();
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
      _studentNumber = prefs.getString('studentNumber');
      _selectedGrade = prefs.getString('selectedGrade');

      // إذا كان المستخدم مسجلاً، قم بتحميل بياناته
      if (_isLoggedIn && _studentNumber != null) {
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
      await prefs.setString('studentNumber', _studentNumber ?? '');
      await prefs.setString('selectedGrade', _selectedGrade ?? '');
    } catch (e) {
      print('Error saving auth state: $e');
    }
  }

  // ✅ التعديل الجديد: التحقق من حالة isLogin
  Future<bool> checkLoginStatus(String studentNumber) async {
    try {
      final response = await supabase
          .from('users_new')
          .select('isLogin')
          .eq('student_number', studentNumber)
          .single();

      return response['isLogin'] ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      throw Exception('فشل في التحقق من حالة الحساب');
    }
  }

  // ✅ التعديل الجديد: تحديث حالة isLogin
  Future<void> updateLoginStatus(String studentNumber, bool isLogin) async {
    try {
      await supabase
          .from('users_new')
          .update({
        'isLogin': isLogin,
        'updated_at': DateTime.now().toIso8601String()
      })
          .eq('student_number', studentNumber);
    } catch (e) {
      print('Error updating login status: $e');
      throw Exception('فشل في تحديث حالة الحساب');
    }
  }

  // ✅ التعديل: تسجيل الدخول مع التحقق من isLogin
  Future<void> login(String studentNumber, String password) async {
    try {
      // ✅ التحقق من حالة isLogin أولاً
      final isAlreadyLoggedIn = await checkLoginStatus(studentNumber);
      if (isAlreadyLoggedIn) {
        throw Exception('هذا الحساب مسجل حالياً في جهاز آخر. يرجى الخروج منه أولاً ثم المحاولة مرة أخرى.');
      }

      // البحث عن المستخدم في قاعدة البيانات
      final response = await supabase
          .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
          .select()
          .eq('student_number', studentNumber)
          .single();

      // التحقق من حالة الحساب
      if (!response['is_active']) {
        throw Exception('الحساب غير مفعل');
      }

      // التحقق من كلمة المرور
      if (response['password'] != password) {
        throw Exception('كلمة المرور غير صحيحة');
      }

      // ✅ تحديث حالة isLogin إلى true
      await updateLoginStatus(studentNumber, true);

      // تحديث حالة المصادقة
      _isLoggedIn = true;
      _studentNumber = studentNumber;
      _userData = response;
      _selectedGrade = response['grade']?.toString() ?? _selectedGrade;

      // حفظ الحالة في الذاكرة المحلية
      await _saveAuthState();
      notifyListeners();

    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw Exception('الحساب غير موجود');
      } else {
        throw Exception('حدث خطأ في النظام: ${e.message}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // ✅ التعديل: حفظ الصف المختار مع تحديث السيرفر
  Future<void> setSelectedGrade(String grade) async {
    _selectedGrade = grade;

    try {
      // إذا كان المستخدم مسجلاً، قم بتحديث الصف في السيرفر
      if (_isLoggedIn && _studentNumber != null) {
        await supabase
            .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
            .update({'grade': grade})
            .eq('student_number', _studentNumber!);

        // تحديث البيانات المحلية
        if (_userData != null) {
          _userData!['grade'] = grade;
        }
      }
    } catch (e) {
      print('Error updating grade on server: $e');
      // نستمر في حفظ البيانات محلياً حتى في حالة فشل السيرفر
    }

    await _saveAuthState();
    notifyListeners();
  }

  // ✅ التعديل: تسجيل الخروج مع تحديث isLogin
  Future<void> logout() async {
    try {
      // ✅ تحديث حالة isLogin إلى false قبل مسح البيانات
      if (_studentNumber != null) {
        try {
          await updateLoginStatus(_studentNumber!, false);
        } catch (e) {
          print('Error updating login status during logout: $e');
          // نستمر في عملية تسجيل الخروج حتى لو فشل تحديث السيرفر
        }
      }

      _isLoggedIn = false;
      _studentNumber = null;
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
    if (_studentNumber != null) {
      await _loadUserData();
    }
  }

  // التحقق من صحة الجلسة
  Future<bool> validateSession() async {
    if (!_isLoggedIn || _studentNumber == null) {
      return false;
    }

    try {
      final response = await supabase
          .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
          .select('is_active, isLogin')
          .eq('student_number', _studentNumber!)
          .single();

      // ✅ التحقق من أن الحساب نشط وأن حالة isLogin متوافقة
      return response['is_active'] == true && response['isLogin'] == true;
    } catch (e) {
      // إذا فشل التحقق، نقوم بتسجيل الخروج
      await logout();
      return false;
    }
  }

  // تغيير كلمة المرور
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      if (_studentNumber == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }

      // التحقق من كلمة المرور الحالية أولاً
      final user = await supabase
          .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
          .select()
          .eq('student_number', _studentNumber!)
          .single();

      if (user['password'] != currentPassword) {
        throw Exception('كلمة المرور الحالية غير صحيحة');
      }

      // تحديث كلمة المرور
      await supabase
          .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
          .update({
        'password': newPassword,
        'updated_at': DateTime.now().toIso8601String(),
      })
          .eq('student_number', _studentNumber!);

      // تحديث البيانات المحلية
      if (_userData != null) {
        _userData!['password'] = newPassword;
        _userData!['updated_at'] = DateTime.now().toIso8601String();
      }

      notifyListeners();
    } catch (e) {
      throw Exception('فشل تغيير كلمة المرور: $e');
    }
  }

  // تحديث الملف الشخصي
  Future<void> updateProfile(Map<String, dynamic> updates) async {
    try {
      if (_studentNumber == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }

      // إضافة تاريخ التحديث
      updates['updated_at'] = DateTime.now().toIso8601String();

      await supabase
          .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
          .update(updates)
          .eq('student_number', _studentNumber!);

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
  Future<void> resetPassword(String studentNumber) async {
    try {
      // التحقق من وجود الحساب
      final response = await supabase
          .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
          .select('is_active')
          .eq('student_number', studentNumber)
          .single();

      if (!response['is_active']) {
        throw Exception('الحساب غير مفعل');
      }

      // هنا يمكنك إضافة منطق إرسال البريد الإلكتروني أو رسالة
      throw Exception('سيتم إضافة خاصية استعادة كلمة المرور قريباً');

    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw Exception('الحساب غير موجود');
      } else {
        throw Exception('حدث خطأ في النظام');
      }
    } catch (e) {
      rethrow;
    }
  }

  // الحصول على معلومات الحساب
  Future<Map<String, dynamic>?> getAccountInfo() async {
    if (_studentNumber == null) return null;

    try {
      final response = await supabase
          .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
          .select('id, student_number, is_active, isLogin, created_at, updated_at, grade')
          .eq('student_number', _studentNumber!)
          .single();

      return response;
    } catch (e) {
      print('Error fetching account info: $e');
      return null;
    }
  }

  // التحقق من اتصال السيرفر
  Future<bool> checkServerConnection() async {
    try {
      await supabase
          .from('users_new') // ✅ التعديل: استخدام الجدول الجديد
          .select('count')
          .limit(1);
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

    return 'رقم الحساب: $_studentNumber - الصف ${_selectedGrade ?? "لم يتم الاختيار"}';
  }

  // التحقق من صلاحية البيانات
  bool isValid() {
    return _isLoggedIn &&
        _studentNumber != null &&
        _studentNumber!.isNotEmpty;
  }

  // الحصول على تاريخ إنشاء الحساب
  String? getAccountCreationDate() {
    if (_userData == null) return null;

    try {
      final createdAt = _userData!['created_at'];
      if (createdAt != null) {
        final date = DateTime.parse(createdAt);
        return '${date.year}/${date.month}/${date.day}';
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
    return _userData?['isLogin'] == true && _isLoggedIn;
  }

  // الحصول على جميع بيانات المستخدم المتاحة
  Map<String, dynamic> getAvailableUserData() {
    if (_userData == null) return {};

    // إرجاع نسخة من البيانات لتجنب التعديل المباشر
    return Map<String, dynamic>.from(_userData!);
  }

  // ✅ التعديل: دالة مزامنة بيانات المستخدم
  Future<void> syncUserData() async {
    if (_studentNumber != null) {
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
        _studentNumber != null &&
        _studentNumber!.isNotEmpty &&
        _userData != null;
  }

  // ✅ التعديل: دالة للحصول على بيانات المستخدم الأساسية للعرض
  Map<String, String> getBasicUserInfo() {
    return {
      'student_number': _studentNumber ?? 'غير متوفر',
      'grade': _selectedGrade ?? 'لم يتم الاختيار',
      'status': getAccountStatus(),
      'creation_date': getAccountCreationDate() ?? 'غير معروف',
      'login_status': _userData?['isLogin'] == true ? 'مسجل الدخول' : 'غير مسجل',
    };
  }

  // ✅ التعديل الجديد: إجبار تسجيل الخروج من جميع الأجهزة
  Future<void> forceLogoutFromAllDevices(String studentNumber) async {
    try {
      await supabase
          .from('users_new')
          .update({
        'isLogin': false,
        'updated_at': DateTime.now().toIso8601String()
      })
          .eq('student_number', studentNumber);
    } catch (e) {
      print('Error forcing logout from all devices: $e');
      throw Exception('فشل في إجبار تسجيل الخروج من جميع الأجهزة');
    }
  }

  // ✅ التعديل الجديد: التحقق من صحة الجلسة الحالية
  Future<bool> checkCurrentSessionValidity() async {
    if (!_isLoggedIn || _studentNumber == null) {
      return false;
    }

    try {
      final response = await supabase
          .from('users_new')
          .select('is_active, isLogin')
          .eq('student_number', _studentNumber!)
          .single();

      // يجب أن يكون الحساب نشط وأن تكون حالة isLogin true
      final isValid = response['is_active'] == true && response['isLogin'] == true;

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
}