import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications/main.dart';

class FirebaseApi {
  //create an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notification
  Future<void> initNotifications() async {
    // request permission from user(will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch the firebase cloud messaging[fcm] token from theis device
    final fcmToken = await _firebaseMessaging.getToken();

    //print the token (normally you would send this to your server)
    print('Token:$fcmToken');

    //initialize further settings for push notifications
    initPushNotifications();
  }

  //function to handle received messages
  void handleMessage(RemoteMessage? message) {
    //if the message is null, do nothing
    if (message == null) return;

    //navigate to new screen when message is received and user taps notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  //function to initialize foreground and background settings

  Future initPushNotifications() async {
    //handle notification if the app was terminated and now opened

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach event listners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
