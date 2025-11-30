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

// subscription_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubscriptionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // دالة للتحقق من صحة كود الاشتراك
  Future<Map<String, dynamic>> validateSubscriptionCode(String code) async {
    try {
      print('🔍 البحث عن كود التفعيل: $code');

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
          'message': 'كود الاشتراك غير صالح أو مستخدم مسبقاً'
        };
      }

      DocumentSnapshot codeDoc = querySnapshot.docs.first;
      Map<String, dynamic> codeData = codeDoc.data() as Map<String, dynamic>;

      print('✅ الكود صالح: ${codeData['code']}');
      print('📅 مدة الكود: ${codeData['duration_day']} يوم');

      return {
        'success': true,
        'codeData': codeData,
        'codeId': codeDoc.id,
        'message': 'كود الاشتراك صالح'
      };

    } catch (e) {
      print('❌ خطأ في التحقق من الكود: $e');
      return {'success': false, 'message': 'حدث خطأ أثناء التحقق من الكود: $e'};
    }
  }

  // دالة تفعيل الاشتراك
  Future<Map<String, dynamic>> activateSubscription(String code) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return {'success': false, 'message': 'يجب تسجيل الدخول أولاً'};
      }

      print('🚀 بدء تفعيل الاشتراك للمستخدم: ${user.uid}');

      Map<String, dynamic> validationResult = await validateSubscriptionCode(code);
      if (!validationResult['success']) {
        return validationResult;
      }

      String codeId = validationResult['codeId'];
      Map<String, dynamic> codeData = validationResult['codeData'];

      DateTime startDate = DateTime.now();
      DateTime endDate = startDate.add(Duration(days: codeData['duration_day']));

      String planType = _determinePlanType(codeData['duration_day']);

      print('📝 إنشاء اشتراك جديد:');
      print('   📧 المستخدم: ${user.email}');
      print('   📦 نوع الخطة: $planType');
      print('   📅 تاريخ البدء: $startDate');
      print('   📅 تاريخ الانتهاء: $endDate');

      // إضافة الاشتراك الجديد
      await _firestore.collection('user_subscriptions').add({
        'user_email': user.email ?? '',
        'user_id': user.uid,
        'plan_type': planType,
        'start_date': Timestamp.fromDate(startDate),
        'end_date': Timestamp.fromDate(endDate),
        'subscription_code': codeData['code'],
        'code_id': codeId,
        'is_active': true,
        'created_at': Timestamp.now(),
      });

      // تحديث حالة الكود إلى مستخدم
      await _firestore.collection('subscription_codes').doc(codeId).update({
        'is_used': true,
        'used_at': Timestamp.now(),
        'used_by': user.uid,
      });

      print('✅ تم تفعيل الاشتراك بنجاح');
      return {'success': true, 'message': 'تم تفعيل الاشتراك بنجاح'};

    } catch (e) {
      print('❌ خطأ في تفعيل الاشتراك: $e');
      return {'success': false, 'message': 'حدث خطأ أثناء التفعيل: $e'};
    }
  }

  // دالة التحقق من حالة الاشتراك الحالية - محدثة ومحسنة
  Future<Map<String, dynamic>> checkUserSubscription() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('❌ لا يوجد مستخدم مسجل دخول');
        return {
          'hasSubscription': false,
          'isActive': false,
          'message': 'لم يتم تسجيل الدخول'
        };
      }

      print('🔍 البحث عن اشتراكات المستخدم: ${user.uid}');

      QuerySnapshot querySnapshot = await _firestore
          .collection('user_subscriptions')
          .where('user_id', isEqualTo: user.uid)
          .where('is_active', isEqualTo: true)
          .orderBy('end_date', descending: true)
          .limit(1)
          .get();

      print('📊 عدد الاشتراكات النشطة التي تم العثور عليها: ${querySnapshot.docs.length}');

      if (querySnapshot.docs.isEmpty) {
        print('📭 لا توجد اشتراكات نشطة للمستخدم');
        return {
          'hasSubscription': false,
          'isActive': false,
          'message': 'لا يوجد اشتراك نشط'
        };
      }

      DocumentSnapshot subscriptionDoc = querySnapshot.docs.first;
      Map<String, dynamic> subscriptionData =
      subscriptionDoc.data() as Map<String, dynamic>;

      print('📄 بيانات الاشتراك المستلمة:');
      print('   📦 نوع الخطة: ${subscriptionData['plan_type']}');
      print('   📅 تاريخ البدء: ${subscriptionData['start_date']}');
      print('   📅 تاريخ الانتهاء: ${subscriptionData['end_date']}');
      print('   🔗 كود الاشتراك: ${subscriptionData['subscription_code']}');

      // التحقق من وجود الحقول المطلوبة
      if (!subscriptionData.containsKey('end_date')) {
        print('❌ حقل end_date غير موجود في بيانات الاشتراك');
        return {
          'hasSubscription': false,
          'isActive': false,
          'message': 'بيانات الاشتراك غير مكتملة'
        };
      }

      Timestamp endTimestamp = subscriptionData['end_date'];
      DateTime endDate = endTimestamp.toDate();
      DateTime now = DateTime.now();

      bool isActive = now.isBefore(endDate);

      print('📅 تاريخ انتهاء الاشتراك: $endDate');
      print('⏰ الوقت الحالي: $now');
      print('🔔 حالة الاشتراك: ${isActive ? "نشط" : "منتهي"}');

      // إذا انتهت المدة، تحديث الحالة في قاعدة البيانات
      if (!isActive) {
        print('🔄 تحديث حالة الاشتراك إلى غير نشط');
        await _firestore
            .collection('user_subscriptions')
            .doc(subscriptionDoc.id)
            .update({'is_active': false});
      }

      // حساب الأيام المتبقية
      int daysRemaining = endDate.difference(now).inDays;
      if (daysRemaining < 0) daysRemaining = 0;

      // الحصول على تاريخ البدء
      DateTime startDate = subscriptionData.containsKey('start_date')
          ? (subscriptionData['start_date'] as Timestamp).toDate()
          : now.subtract(Duration(days: 30)); // افتراضي 30 يوم إذا لم يوجد

      print('📊 الأيام المتبقية: $daysRemaining يوم');

      return {
        'hasSubscription': true,
        'isActive': isActive,
        'subscriptionData': subscriptionData,
        'daysRemaining': daysRemaining,
        'endDate': endDate,
        'startDate': startDate,
        'subscriptionId': subscriptionDoc.id,
        'message': isActive ? 'اشتراك نشط' : 'اشتراك منتهي'
      };

    } catch (e) {
      print('❌ خطأ في التحقق من الاشتراك: $e');
      return {
        'hasSubscription': false,
        'isActive': false,
        'message': 'حدث خطأ في التحقق من الاشتراك'
      };
    }
  }

  // دالة مساعدة لتحديد نوع الخطة
  String _determinePlanType(int durationDays) {
    if (durationDays <= 7) return 'أسبوعي';
    if (durationDays <= 30) return 'شهري';
    if (durationDays <= 90) return 'ربع سنوي';
    if (durationDays <= 365) return 'سنوي';
    return 'مخصص';
  }

  // دالة إضافية: الحصول على تاريخ اشتراك المستخدم
  Future<Map<String, dynamic>> getUserSubscriptionHistory() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return {'success': false, 'subscriptions': []};

      QuerySnapshot querySnapshot = await _firestore
          .collection('user_subscriptions')
          .where('user_id', isEqualTo: user.uid)
          .orderBy('created_at', descending: true)
          .get();

      List<Map<String, dynamic>> subscriptions = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        subscriptions.add({
          'id': doc.id,
          ...data,
          'start_date': data['start_date'] != null
              ? (data['start_date'] as Timestamp).toDate()
              : null,
          'end_date': data['end_date'] != null
              ? (data['end_date'] as Timestamp).toDate()
              : null,
        });
      }

      return {'success': true, 'subscriptions': subscriptions};
    } catch (e) {
      print('❌ خطأ في جلب تاريخ الاشتراكات: $e');
      return {'success': false, 'subscriptions': []};
    }
  }
}