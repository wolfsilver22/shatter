// // subscription_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class SubscriptionService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // دالة للتحقق من صحة كود الاشتراك
//   Future<Map<String, dynamic>> validateSubscriptionCode(String code) async {
//     try {
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('subscription_codes')
//           .where('code', isEqualTo: code)
//           .where('is_used', isEqualTo: false)
//           .limit(1)
//           .get();
//
//       if (querySnapshot.docs.isEmpty) {
//         return {
//           'success': false,
//           'message': 'كود الاشتراك غير صالح أو مستخدم مسبقاً'
//         };
//       }
//
//       DocumentSnapshot codeDoc = querySnapshot.docs.first;
//       Map<String, dynamic> codeData = codeDoc.data() as Map<String, dynamic>;
//
//       return {
//         'success': true,
//         'codeData': codeData,
//         'codeId': codeDoc.id,
//         'message': 'كود الاشتراك صالح'
//       };
//
//     } catch (e) {
//       return {'success': false, 'message': 'حدث خطأ أثناء التحقق من الكود: $e'};
//     }
//   }
//
//   // دالة تفعيل الاشتراك
//   Future<Map<String, dynamic>> activateSubscription(String code) async {
//     try {
//       User? user = _auth.currentUser;
//       if (user == null) {
//         return {'success': false, 'message': 'يجب تسجيل الدخول أولاً'};
//       }
//
//       Map<String, dynamic> validationResult = await validateSubscriptionCode(code);
//       if (!validationResult['success']) {
//         return validationResult;
//       }
//
//       String codeId = validationResult['codeId'];
//       Map<String, dynamic> codeData = validationResult['codeData'];
//
//       DateTime startDate = DateTime.now();
//       DateTime endDate = startDate.add(Duration(days: codeData['duration_day']));
//
//       String planType = _determinePlanType(codeData['duration_day']);
//
//       await _firestore.collection('user_subscriptions').add({
//         'user_email': user.email ?? '',
//         'user_id': user.uid,
//         'plan_type': planType,
//         'start_date': Timestamp.fromDate(startDate),
//         'end_date': Timestamp.fromDate(endDate),
//         'subscription_code': codeData['code'],
//         'code_id': codeId,
//         'is_active': true,
//         'created_at': Timestamp.now(),
//       });
//
//       await _firestore.collection('subscription_codes').doc(codeId).update({
//         'is_used': true,
//         'used_at': Timestamp.now(),
//         'used_by': user.uid,
//       });
//
//       return {'success': true, 'message': 'تم تفعيل الاشتراك بنجاح'};
//
//     } catch (e) {
//       return {'success': false, 'message': 'حدث خطأ أثناء التفعيل: $e'};
//     }
//   }
//
//   // دالة التحقق من حالة الاشتراك الحالية
//   Future<Map<String, dynamic>> checkUserSubscription() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user == null) {
//         return {'hasSubscription': false, 'isActive': false};
//       }
//
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('user_subscriptions')
//           .where('user_id', isEqualTo: user.uid)
//           .where('is_active', isEqualTo: true)
//           .orderBy('end_date', descending: true)
//           .limit(1)
//           .get();
//
//       if (querySnapshot.docs.isEmpty) {
//         return {'hasSubscription': false, 'isActive': false};
//       }
//
//       DocumentSnapshot subscriptionDoc = querySnapshot.docs.first;
//       Map<String, dynamic> subscriptionData =
//       subscriptionDoc.data() as Map<String, dynamic>;
//
//       Timestamp endTimestamp = subscriptionData['end_date'];
//       DateTime endDate = endTimestamp.toDate();
//       bool isActive = DateTime.now().isBefore(endDate);
//
//       if (!isActive) {
//         await _firestore
//             .collection('user_subscriptions')
//             .doc(subscriptionDoc.id)
//             .update({'is_active': false});
//       }
//
//       return {
//         'hasSubscription': true,
//         'isActive': isActive,
//         'subscriptionData': subscriptionData,
//         'daysRemaining': endDate.difference(DateTime.now()).inDays,
//         'endDate': endDate,
//       };
//
//     } catch (e) {
//       print('خطأ في التحقق من الاشتراك: $e');
//       return {'hasSubscription': false, 'isActive': false};
//     }
//   }
//
//   // دالة مساعدة لتحديد نوع الخطة
//   String _determinePlanType(int durationDays) {
//     if (durationDays <= 7) return 'أسبوعي';
//     if (durationDays <= 30) return 'شهري';
//     if (durationDays <= 90) return 'ربع سنوي';
//     if (durationDays <= 365) return 'سنوي';
//     return 'مخصص';
//   }
// }

// // subscription_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class SubscriptionService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // دالة للتحقق من صحة كود الاشتراك
//   Future<Map<String, dynamic>> validateSubscriptionCode(String code) async {
//     try {
//       print('🔍 البحث عن كود التفعيل: $code');
//
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('subscription_codes')
//           .where('code', isEqualTo: code.trim())
//           .where('is_used', isEqualTo: false)
//           .limit(1)
//           .get();
//
//       if (querySnapshot.docs.isEmpty) {
//         print('❌ الكود غير صالح أو مستخدم مسبقاً');
//         return {
//           'success': false,
//           'message': 'كود الاشتراك غير صالح أو مستخدم مسبقاً'
//         };
//       }
//
//       DocumentSnapshot codeDoc = querySnapshot.docs.first;
//       Map<String, dynamic> codeData = codeDoc.data() as Map<String, dynamic>;
//
//       print('✅ الكود صالح: ${codeData['code']}');
//       print('📅 مدة الكود: ${codeData['duration_day']} يوم');
//
//       return {
//         'success': true,
//         'codeData': codeData,
//         'codeId': codeDoc.id,
//         'message': 'كود الاشتراك صالح'
//       };
//
//     } catch (e) {
//       print('❌ خطأ في التحقق من الكود: $e');
//       return {'success': false, 'message': 'حدث خطأ أثناء التحقق من الكود: $e'};
//     }
//   }
//
//   // دالة تفعيل الاشتراك
//   Future<Map<String, dynamic>> activateSubscription(String code) async {
//     try {
//       User? user = _auth.currentUser;
//       if (user == null) {
//         return {'success': false, 'message': 'يجب تسجيل الدخول أولاً'};
//       }
//
//       print('🚀 بدء تفعيل الاشتراك للمستخدم: ${user.uid}');
//
//       Map<String, dynamic> validationResult = await validateSubscriptionCode(code);
//       if (!validationResult['success']) {
//         return validationResult;
//       }
//
//       String codeId = validationResult['codeId'];
//       Map<String, dynamic> codeData = validationResult['codeData'];
//
//       DateTime startDate = DateTime.now();
//       DateTime endDate = startDate.add(Duration(days: codeData['duration_day']));
//
//       String planType = _determinePlanType(codeData['duration_day']);
//
//       print('📝 إنشاء اشتراك جديد:');
//       print('   📧 المستخدم: ${user.email}');
//       print('   📦 نوع الخطة: $planType');
//       print('   📅 تاريخ البدء: $startDate');
//       print('   📅 تاريخ الانتهاء: $endDate');
//
//       // إضافة الاشتراك الجديد
//       await _firestore.collection('user_subscriptions').add({
//         'user_email': user.email ?? '',
//         'user_id': user.uid,
//         'plan_type': planType,
//         'start_date': Timestamp.fromDate(startDate),
//         'end_date': Timestamp.fromDate(endDate),
//         'subscription_code': codeData['code'],
//         'code_id': codeId,
//         'is_active': true,
//         'created_at': Timestamp.now(),
//       });
//
//       // تحديث حالة الكود إلى مستخدم
//       await _firestore.collection('subscription_codes').doc(codeId).update({
//         'is_used': true,
//         'used_at': Timestamp.now(),
//         'used_by': user.uid,
//       });
//
//       print('✅ تم تفعيل الاشتراك بنجاح');
//       return {'success': true, 'message': 'تم تفعيل الاشتراك بنجاح'};
//
//     } catch (e) {
//       print('❌ خطأ في تفعيل الاشتراك: $e');
//       return {'success': false, 'message': 'حدث خطأ أثناء التفعيل: $e'};
//     }
//   }
//
//   // دالة التحقق من حالة الاشتراك الحالية - محدثة ومحسنة
//   Future<Map<String, dynamic>> checkUserSubscription() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user == null) {
//         print('❌ لا يوجد مستخدم مسجل دخول');
//         return {
//           'hasSubscription': false,
//           'isActive': false,
//           'message': 'لم يتم تسجيل الدخول'
//         };
//       }
//
//       print('🔍 البحث عن اشتراكات المستخدم: ${user.uid}');
//
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('user_subscriptions')
//           .where('user_id', isEqualTo: user.uid)
//           .where('is_active', isEqualTo: true)
//           .orderBy('end_date', descending: true)
//           .limit(1)
//           .get();
//
//       print('📊 عدد الاشتراكات النشطة التي تم العثور عليها: ${querySnapshot.docs.length}');
//
//       if (querySnapshot.docs.isEmpty) {
//         print('📭 لا توجد اشتراكات نشطة للمستخدم');
//         return {
//           'hasSubscription': false,
//           'isActive': false,
//           'message': 'لا يوجد اشتراك نشط'
//         };
//       }
//
//       DocumentSnapshot subscriptionDoc = querySnapshot.docs.first;
//       Map<String, dynamic> subscriptionData =
//       subscriptionDoc.data() as Map<String, dynamic>;
//
//       print('📄 بيانات الاشتراك المستلمة:');
//       print('   📦 نوع الخطة: ${subscriptionData['plan_type']}');
//       print('   📅 تاريخ البدء: ${subscriptionData['start_date']}');
//       print('   📅 تاريخ الانتهاء: ${subscriptionData['end_date']}');
//       print('   🔗 كود الاشتراك: ${subscriptionData['subscription_code']}');
//
//       // التحقق من وجود الحقول المطلوبة
//       if (!subscriptionData.containsKey('end_date')) {
//         print('❌ حقل end_date غير موجود في بيانات الاشتراك');
//         return {
//           'hasSubscription': false,
//           'isActive': false,
//           'message': 'بيانات الاشتراك غير مكتملة'
//         };
//       }
//
//       Timestamp endTimestamp = subscriptionData['end_date'];
//       DateTime endDate = endTimestamp.toDate();
//       DateTime now = DateTime.now();
//
//       bool isActive = now.isBefore(endDate);
//
//       print('📅 تاريخ انتهاء الاشتراك: $endDate');
//       print('⏰ الوقت الحالي: $now');
//       print('🔔 حالة الاشتراك: ${isActive ? "نشط" : "منتهي"}');
//
//       // إذا انتهت المدة، تحديث الحالة في قاعدة البيانات
//       if (!isActive) {
//         print('🔄 تحديث حالة الاشتراك إلى غير نشط');
//         await _firestore
//             .collection('user_subscriptions')
//             .doc(subscriptionDoc.id)
//             .update({'is_active': false});
//       }
//
//       // حساب الأيام المتبقية
//       int daysRemaining = endDate.difference(now).inDays;
//       if (daysRemaining < 0) daysRemaining = 0;
//
//       // الحصول على تاريخ البدء
//       DateTime startDate = subscriptionData.containsKey('start_date')
//           ? (subscriptionData['start_date'] as Timestamp).toDate()
//           : now.subtract(Duration(days: 30)); // افتراضي 30 يوم إذا لم يوجد
//
//       print('📊 الأيام المتبقية: $daysRemaining يوم');
//
//       return {
//         'hasSubscription': true,
//         'isActive': isActive,
//         'subscriptionData': subscriptionData,
//         'daysRemaining': daysRemaining,
//         'endDate': endDate,
//         'startDate': startDate,
//         'subscriptionId': subscriptionDoc.id,
//         'message': isActive ? 'اشتراك نشط' : 'اشتراك منتهي'
//       };
//
//     } catch (e) {
//       print('❌ خطأ في التحقق من الاشتراك: $e');
//       return {
//         'hasSubscription': false,
//         'isActive': false,
//         'message': 'حدث خطأ في التحقق من الاشتراك'
//       };
//     }
//   }
//
//   // دالة مساعدة لتحديد نوع الخطة
//   String _determinePlanType(int durationDays) {
//     if (durationDays <= 7) return 'أسبوعي';
//     if (durationDays <= 30) return 'شهري';
//     if (durationDays <= 90) return 'ربع سنوي';
//     if (durationDays <= 365) return 'سنوي';
//     return 'مخصص';
//   }
//
//   // دالة إضافية: الحصول على تاريخ اشتراك المستخدم
//   Future<Map<String, dynamic>> getUserSubscriptionHistory() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user == null) return {'success': false, 'subscriptions': []};
//
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('user_subscriptions')
//           .where('user_id', isEqualTo: user.uid)
//           .orderBy('created_at', descending: true)
//           .get();
//
//       List<Map<String, dynamic>> subscriptions = [];
//
//       for (var doc in querySnapshot.docs) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         subscriptions.add({
//           'id': doc.id,
//           ...data,
//           'start_date': data['start_date'] != null
//               ? (data['start_date'] as Timestamp).toDate()
//               : null,
//           'end_date': data['end_date'] != null
//               ? (data['end_date'] as Timestamp).toDate()
//               : null,
//         });
//       }
//
//       return {'success': true, 'subscriptions': subscriptions};
//     } catch (e) {
//       print('❌ خطأ في جلب تاريخ الاشتراكات: $e');
//       return {'success': false, 'subscriptions': []};
//     }
//   }
// }

// subscription_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubscriptionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ دالة محسنة للتحقق من صحة كود الاشتراك
  Future<Map<String, dynamic>> validateSubscriptionCode(String code) async {
    try {
      print('🔍 [SubscriptionService] بدء التحقق من كود التفعيل: $code');

      if (code.isEmpty || code.trim().length < 8) {
        print('❌ الكود قصير جداً أو فارغ');
        return {
          'success': false,
          'message': 'كود التفعيل غير صالح. يجب أن يكون 8 أحرف على الأقل'
        };
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('subscription_codes')
          .where('code', isEqualTo: code.trim())
          .where('is_used', isEqualTo: false)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('❌ الكود غير صالح أو مستخدم مسبقاً');
        return {
          'success': false,
          'message': 'كود الاشتراك غير صالح أو تم استخدامه مسبقاً'
        };
      }

      DocumentSnapshot codeDoc = querySnapshot.docs.first;
      Map<String, dynamic> codeData = codeDoc.data() as Map<String, dynamic>;

      // التحقق من صلاحية الكود
      DateTime now = DateTime.now();
      if (codeData.containsKey('expiry_date')) {
        Timestamp expiryTimestamp = codeData['expiry_date'];
        DateTime expiryDate = expiryTimestamp.toDate();

        if (now.isAfter(expiryDate)) {
          print('❌ الكود منتهي الصلاحية');
          return {
            'success': false,
            'message': 'كود الاشتراك منتهي الصلاحية'
          };
        }
      }

      print('✅ الكود صالح: ${codeData['code']}');
      print('📅 مدة الكود: ${codeData['duration_day']} يوم');
      print('🏷️ نوع الكود: ${codeData['plan_type'] ?? 'غير محدد'}');

      return {
        'success': true,
        'codeData': codeData,
        'codeId': codeDoc.id,
        'message': 'كود الاشتراك صالح وجاهز للتفعيل'
      };

    } catch (e) {
      print('❌ [SubscriptionService] خطأ في التحقق من الكود: $e');
      return {
        'success': false,
        'message': 'حدث خطأ أثناء التحقق من الكود. يرجى المحاولة لاحقاً'
      };
    }
  }

  // ✅ دالة محسنة لتفعيل الاشتراك
  Future<Map<String, dynamic>> activateSubscription(String code) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return {
          'success': false,
          'message': 'يجب تسجيل الدخول أولاً للتفعيل'
        };
      }

      print('🚀 [SubscriptionService] بدء تفعيل الاشتراك للمستخدم: ${user.uid}');
      print('📧 البريد الإلكتروني: ${user.email}');

      Map<String, dynamic> validationResult = await validateSubscriptionCode(code);
      if (!validationResult['success']) {
        return validationResult;
      }

      String codeId = validationResult['codeId'];
      Map<String, dynamic> codeData = validationResult['codeData'];

      // التحقق من عدم تكرار استخدام الكود لنفس المستخدم
      QuerySnapshot existingSubscription = await _firestore
          .collection('user_subscriptions')
          .where('user_id', isEqualTo: user.uid)
          .where('subscription_code', isEqualTo: codeData['code'])
          .limit(1)
          .get();

      if (existingSubscription.docs.isNotEmpty) {
        return {
          'success': false,
          'message': 'هذا الكود تم تفعيله مسبقاً على حسابك'
        };
      }

      DateTime startDate = DateTime.now();
      int durationDays = codeData['duration_day'];
      DateTime endDate = startDate.add(Duration(days: durationDays));

      // استخدام نوع الخطة من الكود أو تحديده تلقائياً
      String planType = codeData.containsKey('plan_type')
          ? codeData['plan_type']
          : _determinePlanType(durationDays);

      print('📝 [SubscriptionService] إنشاء اشتراك جديد:');
      print('   👤 المستخدم: ${user.email}');
      print('   🏷️ نوع الخطة: $planType');
      print('   📅 تاريخ البدء: ${_formatDate(startDate)}');
      print('   📅 تاريخ الانتهاء: ${_formatDate(endDate)}');
      print('   ⏳ المدة: $durationDays يوم');

      // استخدام batch لحفظ البيانات معاً
      WriteBatch batch = _firestore.batch();

      // إضافة الاشتراك الجديد
      DocumentReference subscriptionRef = _firestore.collection('user_subscriptions').doc();
      batch.set(subscriptionRef, {
        'user_email': user.email ?? '',
        'user_id': user.uid,
        'plan_type': planType,
        'start_date': Timestamp.fromDate(startDate),
        'end_date': Timestamp.fromDate(endDate),
        'subscription_code': codeData['code'],
        'original_duration': durationDays,
        'code_id': codeId,
        'is_active': true,
        'status': 'active',
        'created_at': Timestamp.now(),
        'updated_at': Timestamp.now(),
      });

      // تحديث حالة الكود إلى مستخدم
      DocumentReference codeRef = _firestore.collection('subscription_codes').doc(codeId);
      batch.update(codeRef, {
        'is_used': true,
        'used_at': Timestamp.now(),
        'used_by': user.uid,
        'used_by_email': user.email ?? '',
        'activated_date': Timestamp.fromDate(startDate),
      });

      await batch.commit();

      print('✅ [SubscriptionService] تم تفعيل الاشتراك بنجاح');

      // إرسال إشعار نجاح التفعيل (يمكن إضافته لاحقاً)
      await _sendActivationNotification(user.email ?? '', planType, endDate);

      return {
        'success': true,
        'message': '🎉 تم تفعيل الاشتراك بنجاح!',
        'subscriptionData': {
          'plan_type': planType,
          'start_date': startDate,
          'end_date': endDate,
          'duration_days': durationDays,
        }
      };

    } catch (e) {
      print('❌ [SubscriptionService] خطأ في تفعيل الاشتراك: $e');
      return {
        'success': false,
        'message': 'حدث خطأ أثناء التفعيل. يرجى المحاولة مرة أخرى'
      };
    }
  }

  // ✅ دالة محسنة للتحقق من حالة الاشتراك الحالية
  Future<Map<String, dynamic>> checkUserSubscription() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('❌ [SubscriptionService] لا يوجد مستخدم مسجل دخول');
        return {
          'hasSubscription': false,
          'isActive': false,
          'isExpired': true,
          'message': 'لم يتم تسجيل الدخول',
          'requiresMandatoryActivation': false,
        };
      }

      print('🔍 [SubscriptionService] البحث عن اشتراكات المستخدم: ${user.email}');

      QuerySnapshot querySnapshot = await _firestore
          .collection('user_subscriptions')
          .where('user_email', isEqualTo: user.email)
          .where('is_active', isEqualTo: true)
          .orderBy('end_date', descending: true)
          .limit(1)
          .get();

      print('📊 عدد الاشتراكات النشطة: ${querySnapshot.docs.length}');

      if (querySnapshot.docs.isEmpty) {
        print('📭 [SubscriptionService] لا توجد اشتراكات نشطة للمستخدم');
        return {
          'hasSubscription': false,
          'isActive': false,
          'isExpired': true,
          'message': 'لا يوجد اشتراك نشط',
          'requiresMandatoryActivation': true, // ✅ هام: يتطلب تفعيل إجباري
        };
      }

      DocumentSnapshot subscriptionDoc = querySnapshot.docs.first;
      Map<String, dynamic> subscriptionData =
      subscriptionDoc.data() as Map<String, dynamic>;

      // التحقق من وجود الحقول المطلوبة
      if (!subscriptionData.containsKey('end_date')) {
        print('❌ [SubscriptionService] حقل end_date غير موجود');
        return {
          'hasSubscription': false,
          'isActive': false,
          'isExpired': true,
          'message': 'بيانات الاشتراك غير مكتملة',
          'requiresMandatoryActivation': true,
        };
      }

      Timestamp endTimestamp = subscriptionData['end_date'];
      DateTime endDate = endTimestamp.toDate();
      DateTime now = DateTime.now();

      bool isActive = now.isBefore(endDate);
      bool isExpired = !isActive;
      int daysRemaining = isActive ? endDate.difference(now).inDays : 0;

      print('📅 [SubscriptionService] تفاصيل الاشتراك:');
      print('   🏷️ نوع الخطة: ${subscriptionData['plan_type']}');
      print('   📅 تاريخ الانتهاء: ${_formatDate(endDate)}');
      print('   ⏰ الوقت الحالي: ${_formatDate(now)}');
      print('   🔔 الحالة: ${isActive ? "🟢 نشط" : "🔴 منتهي"}');
      print('   ⏳ الأيام المتبقية: $daysRemaining يوم');

      // إذا انتهت المدة، تحديث الحالة في قاعدة البيانات
      if (isExpired) {
        print('🔄 [SubscriptionService] تحديث حالة الاشتراك إلى منتهي');
        await _firestore.collection('user_subscriptions')
            .doc(subscriptionDoc.id)
            .update({
          'is_active': false,
          'status': 'expired',
          'updated_at': Timestamp.now(),
        });
      }

      // الحصول على تاريخ البدء
      DateTime startDate = subscriptionData.containsKey('start_date')
          ? (subscriptionData['start_date'] as Timestamp).toDate()
          : now.subtract(Duration(days: 30));

      return {
        'hasSubscription': true,
        'isActive': isActive,
        'isExpired': isExpired,
        'subscriptionData': subscriptionData,
        'daysRemaining': daysRemaining,
        'endDate': endDate,
        'startDate': startDate,
        'subscriptionId': subscriptionDoc.id,
        'message': isActive
            ? '✅ اشتراك نشط (متبقي $daysRemaining يوم)'
            : '❌ اشتراك منتهي',
        'requiresMandatoryActivation': isExpired, // ✅ هام: إذا منتهي، يتطلب تفعيل إجباري
      };

    } catch (e) {
      print('❌ [SubscriptionService] خطأ في التحقق من الاشتراك: $e');
      return {
        'hasSubscription': false,
        'isActive': false,
        'isExpired': true,
        'message': 'حدث خطأ في التحقق من الاشتراك',
        'requiresMandatoryActivation': true, // ✅ هام: في حالة الخطأ، يتطلب تفعيل
      };
    }
  }

  // ✅ دالة للتحقق الإجباري من الاشتراك (تستخدم في MainNavigation)
  Future<bool> checkMandatorySubscription() async {
    try {
      Map<String, dynamic> subscriptionStatus = await checkUserSubscription();

      // إذا لم يكن هناك اشتراك أو اشتراك منتهي، يتطلب تفعيل إجباري
      bool requiresActivation =
          !subscriptionStatus['hasSubscription'] ||
              subscriptionStatus['isExpired'] ||
              subscriptionStatus['requiresMandatoryActivation'];

      print('🔒 [SubscriptionService] التحقق الإجباري:');
      print('   📊 لديه اشتراك: ${subscriptionStatus['hasSubscription']}');
      print('   🟢 نشط: ${subscriptionStatus['isActive']}');
      print('   🔴 منتهي: ${subscriptionStatus['isExpired']}');
      print('   ⚠️ يتطلب تفعيل: $requiresActivation');

      return requiresActivation;

    } catch (e) {
      print('❌ [SubscriptionService] خطأ في التحقق الإجباري: $e');
      return true; // في حالة الخطأ، نفترض أنه يحتاج تفعيل
    }
  }

  // ✅ دالة لتجديد الاشتراك
  Future<Map<String, dynamic>> renewSubscription(String code) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return {'success': false, 'message': 'يجب تسجيل الدخول أولاً'};
      }

      print('🔄 [SubscriptionService] بدء تجديد الاشتراك للمستخدم: ${user.email}');

      Map<String, dynamic> validationResult = await validateSubscriptionCode(code);
      if (!validationResult['success']) {
        return validationResult;
      }

      // الحصول على الاشتراك الحالي
      Map<String, dynamic> currentSubscription = await checkUserSubscription();

      DateTime newStartDate;

      if (currentSubscription['isActive'] &&
          currentSubscription.containsKey('endDate')) {
        // إذا كان هناك اشتراك نشط، نبدأ من تاريخ انتهائه
        newStartDate = currentSubscription['endDate'];
      } else {
        // إذا لم يكن هناك اشتراك نشط، نبدأ من الآن
        newStartDate = DateTime.now();
      }

      String codeId = validationResult['codeId'];
      Map<String, dynamic> codeData = validationResult['codeData'];
      int durationDays = codeData['duration_day'];
      DateTime newEndDate = newStartDate.add(Duration(days: durationDays));
      String planType = codeData.containsKey('plan_type')
          ? codeData['plan_type']
          : _determinePlanType(durationDays);

      print('📝 [SubscriptionService] تفاصيل التجديد:');
      print('   📅 تاريخ البدء الجديد: ${_formatDate(newStartDate)}');
      print('   📅 تاريخ الانتهاء الجديد: ${_formatDate(newEndDate)}');
      print('   ⏳ المدة المضافة: $durationDays يوم');

      WriteBatch batch = _firestore.batch();

      // إضافة اشتراك جديد للتجديد
      DocumentReference subscriptionRef = _firestore.collection('user_subscriptions').doc();
      batch.set(subscriptionRef, {
        'user_email': user.email ?? '',
        'user_id': user.uid,
        'plan_type': planType,
        'start_date': Timestamp.fromDate(newStartDate),
        'end_date': Timestamp.fromDate(newEndDate),
        'subscription_code': codeData['code'],
        'original_duration': durationDays,
        'code_id': codeId,
        'is_active': true,
        'status': 'active',
        'is_renewal': true,
        'previous_subscription_id': currentSubscription['subscriptionId'],
        'created_at': Timestamp.now(),
        'updated_at': Timestamp.now(),
      });

      // تحديث حالة الكود
      DocumentReference codeRef = _firestore.collection('subscription_codes').doc(codeId);
      batch.update(codeRef, {
        'is_used': true,
        'used_at': Timestamp.now(),
        'used_by': user.uid,
        'used_by_email': user.email ?? '',
        'activated_date': Timestamp.fromDate(newStartDate),
        'is_renewal': true,
      });

      await batch.commit();

      print('✅ [SubscriptionService] تم تجديد الاشتراك بنجاح');

      return {
        'success': true,
        'message': '🎉 تم تجديد الاشتراك بنجاح!',
        'subscriptionData': {
          'plan_type': planType,
          'start_date': newStartDate,
          'end_date': newEndDate,
          'duration_days': durationDays,
          'is_renewal': true,
        }
      };

    } catch (e) {
      print('❌ [SubscriptionService] خطأ في تجديد الاشتراك: $e');
      return {
        'success': false,
        'message': 'حدث خطأ أثناء التجديد. يرجى المحاولة مرة أخرى'
      };
    }
  }

  // ✅ دالة للحصول على تاريخ اشتراك المستخدم
  Future<Map<String, dynamic>> getUserSubscriptionHistory() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return {'success': false, 'message': 'يجب تسجيل الدخول', 'subscriptions': []};
      }

      print('📜 [SubscriptionService] جلب تاريخ اشتراكات المستخدم: ${user.email}');

      QuerySnapshot querySnapshot = await _firestore
          .collection('user_subscriptions')
          .where('user_id', isEqualTo: user.uid)
          .orderBy('created_at', descending: true)
          .get();

      List<Map<String, dynamic>> subscriptions = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        DateTime startDate = data['start_date'] != null
            ? (data['start_date'] as Timestamp).toDate()
            : DateTime.now();

        DateTime endDate = data['end_date'] != null
            ? (data['end_date'] as Timestamp).toDate()
            : DateTime.now();

        DateTime now = DateTime.now();
        bool isActive = data['is_active'] == true && now.isBefore(endDate);

        subscriptions.add({
          'id': doc.id,
          ...data,
          'start_date': startDate,
          'end_date': endDate,
          'is_active_current': isActive,
          'duration_days': data['original_duration'] ??
              endDate.difference(startDate).inDays,
          'formatted_start_date': _formatDate(startDate),
          'formatted_end_date': _formatDate(endDate),
        });
      }

      print('✅ [SubscriptionService] تم جلب ${subscriptions.length} اشتراك');

      return {
        'success': true,
        'subscriptions': subscriptions,
        'total_subscriptions': subscriptions.length,
        'active_subscriptions': subscriptions.where((s) => s['is_active_current']).length,
      };

    } catch (e) {
      print('❌ [SubscriptionService] خطأ في جلب تاريخ الاشتراكات: $e');
      return {'success': false, 'message': 'حدث خطأ', 'subscriptions': []};
    }
  }

  // ✅ دالة مساعدة لتحديد نوع الخطة
  String _determinePlanType(int durationDays) {
    if (durationDays <= 7) return 'أسبوعي';
    if (durationDays <= 30) return 'شهري';
    if (durationDays <= 90) return 'ربع سنوي';
    if (durationDays <= 365) return 'سنوي';
    return 'مخصص';
  }

  // ✅ دالة مساعدة لتنسيق التاريخ
  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  // ✅ دالة إشعار التفعيل (يمكن تطويرها لاحقاً)
  Future<void> _sendActivationNotification(
      String email,
      String planType,
      DateTime endDate
      ) async {
    try {
      // يمكن إضافة إرسال إيميل أو إشعار هنا
      print('📧 [SubscriptionService] إرسال إشعار التفعيل:');
      print('   👤 المستخدم: $email');
      print('   🏷️ الخطة: $planType');
      print('   📅 ينتهي في: ${_formatDate(endDate)}');

      // مثال لحفظ الإشعار في قاعدة البيانات
      await _firestore.collection('subscription_notifications').add({
        'user_email': email,
        'plan_type': planType,
        'end_date': Timestamp.fromDate(endDate),
        'notification_type': 'activation_success',
        'sent_at': Timestamp.now(),
        'message': 'تم تفعيل اشتراكك بنجاح',
      });

    } catch (e) {
      print('⚠️ [SubscriptionService] خطأ في إرسال الإشعار: $e');
    }
  }

  // ✅ دالة لفحص وتحديث جميع الاشتراكات المنتهية
  Future<void> checkAndUpdateExpiredSubscriptions() async {
    try {
      print('🔄 [SubscriptionService] فحص الاشتراكات المنتهية');

      DateTime now = DateTime.now();
      Timestamp nowTimestamp = Timestamp.fromDate(now);

      QuerySnapshot expiredSubscriptions = await _firestore
          .collection('user_subscriptions')
          .where('is_active', isEqualTo: true)
          .where('end_date', isLessThan: nowTimestamp)
          .limit(100) // تحديد حد للمعالجة
          .get();

      print('📊 عدد الاشتراكات المنتهية: ${expiredSubscriptions.docs.length}');

      WriteBatch batch = _firestore.batch();

      for (var doc in expiredSubscriptions.docs) {
        batch.update(doc.reference, {
          'is_active': false,
          'status': 'expired',
          'updated_at': Timestamp.now(),
        });
      }

      if (expiredSubscriptions.docs.isNotEmpty) {
        await batch.commit();
        print('✅ [SubscriptionService] تم تحديث ${expiredSubscriptions.docs.length} اشتراك منتهي');
      }

    } catch (e) {
      print('❌ [SubscriptionService] خطأ في فحص الاشتراكات المنتهية: $e');
    }
  }

  // ✅ دالة للحصول على إحصائيات الاشتراك
  Future<Map<String, dynamic>> getSubscriptionStats() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return {'success': false, 'message': 'يجب تسجيل الدخول'};
      }

      Map<String, dynamic> currentStatus = await checkUserSubscription();
      Map<String, dynamic> history = await getUserSubscriptionHistory();

      int totalDaysUsed = 0;
      int totalSubscriptions = history['subscriptions'].length;
      DateTime? firstSubscriptionDate;
      DateTime? lastSubscriptionDate;

      if (totalSubscriptions > 0) {
        for (var subscription in history['subscriptions']) {
          DateTime start = subscription['start_date'];
          DateTime end = subscription['end_date'];

          totalDaysUsed += end.difference(start).inDays;

          if (firstSubscriptionDate == null || start.isBefore(firstSubscriptionDate)) {
            firstSubscriptionDate = start;
          }

          if (lastSubscriptionDate == null || end.isAfter(lastSubscriptionDate)) {
            lastSubscriptionDate = end;
          }
        }
      }

      return {
        'success': true,
        'stats': {
          'current_status': currentStatus['isActive'] ? 'نشط' : 'منتهي',
          'days_remaining': currentStatus['daysRemaining'] ?? 0,
          'total_subscriptions': totalSubscriptions,
          'total_days_used': totalDaysUsed,
          'first_subscription_date': firstSubscriptionDate,
          'last_subscription_date': lastSubscriptionDate,
          'active_since': currentStatus['startDate'],
          'expires_on': currentStatus['endDate'],
        }
      };

    } catch (e) {
      print('❌ [SubscriptionService] خطأ في جلب الإحصائيات: $e');
      return {'success': false, 'message': 'حدث خطأ في جلب الإحصائيات'};
    }
  }
}