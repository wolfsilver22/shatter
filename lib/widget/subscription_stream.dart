// // lib/services/subscription_stream.dart
// import 'dart:async';
//
// class SubscriptionStream {
//   static final SubscriptionStream _instance = SubscriptionStream._internal();
//   factory SubscriptionStream() => _instance;
//
//   SubscriptionStream._internal();
//
//   // Stream للاشتراكات
//   final StreamController<Map<String, dynamic>> _subscriptionController =
//   StreamController<Map<String, dynamic>>.broadcast();
//
//   // Stream للأحداث العامة
//   final StreamController<String> _eventController =
//   StreamController<String>.broadcast();
//
//   Stream<Map<String, dynamic>> get subscriptionUpdates => _subscriptionController.stream;
//   Stream<String> get eventUpdates => _eventController.stream;
//
//   // إرسال تحديث للاشتراك
//   void notifySubscriptionUpdated(Map<String, dynamic> subscriptionData) {
//     if (!_subscriptionController.isClosed) {
//       _subscriptionController.add(subscriptionData);
//     }
//   }
//
//   // إرسال حدث عام
//   void notifyEvent(String event) {
//     if (!_eventController.isClosed) {
//       _eventController.add(event);
//     }
//   }
//
//   void dispose() {
//     _subscriptionController.close();
//     _eventController.close();
//   }
// }