// subscription_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubscriptionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // دالة للتحقق من صحة كود الاشتراك
  Future<Map<String, dynamic>> validateSubscriptionCode(String code) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('subscription_codes')
          .where('code', isEqualTo: code)
          .where('is_used', isEqualTo: false)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return {
          'success': false,
          'message': 'كود الاشتراك غير صالح أو مستخدم مسبقاً'
        };
      }

      DocumentSnapshot codeDoc = querySnapshot.docs.first;
      Map<String, dynamic> codeData = codeDoc.data() as Map<String, dynamic>;

      return {
        'success': true,
        'codeData': codeData,
        'codeId': codeDoc.id,
        'message': 'كود الاشتراك صالح'
      };

    } catch (e) {
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

      Map<String, dynamic> validationResult = await validateSubscriptionCode(code);
      if (!validationResult['success']) {
        return validationResult;
      }

      String codeId = validationResult['codeId'];
      Map<String, dynamic> codeData = validationResult['codeData'];

      DateTime startDate = DateTime.now();
      DateTime endDate = startDate.add(Duration(days: codeData['duration_day']));

      String planType = _determinePlanType(codeData['duration_day']);

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

      await _firestore.collection('subscription_codes').doc(codeId).update({
        'is_used': true,
        'used_at': Timestamp.now(),
        'used_by': user.uid,
      });

      return {'success': true, 'message': 'تم تفعيل الاشتراك بنجاح'};

    } catch (e) {
      return {'success': false, 'message': 'حدث خطأ أثناء التفعيل: $e'};
    }
  }

  // دالة التحقق من حالة الاشتراك الحالية
  Future<Map<String, dynamic>> checkUserSubscription() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return {'hasSubscription': false, 'isActive': false};
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('user_subscriptions')
          .where('user_id', isEqualTo: user.uid)
          .where('is_active', isEqualTo: true)
          .orderBy('end_date', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return {'hasSubscription': false, 'isActive': false};
      }

      DocumentSnapshot subscriptionDoc = querySnapshot.docs.first;
      Map<String, dynamic> subscriptionData =
      subscriptionDoc.data() as Map<String, dynamic>;

      Timestamp endTimestamp = subscriptionData['end_date'];
      DateTime endDate = endTimestamp.toDate();
      bool isActive = DateTime.now().isBefore(endDate);

      if (!isActive) {
        await _firestore
            .collection('user_subscriptions')
            .doc(subscriptionDoc.id)
            .update({'is_active': false});
      }

      return {
        'hasSubscription': true,
        'isActive': isActive,
        'subscriptionData': subscriptionData,
        'daysRemaining': endDate.difference(DateTime.now()).inDays,
        'endDate': endDate,
      };

    } catch (e) {
      print('خطأ في التحقق من الاشتراك: $e');
      return {'hasSubscription': false, 'isActive': false};
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
}