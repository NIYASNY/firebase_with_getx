import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAuth {
  final _firebaseMesseging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMesseging.requestPermission();

    final fcmToken = await _firebaseMesseging.getToken();
    print('Token $fcmToken');
  }
}
