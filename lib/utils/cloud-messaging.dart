import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lifebloodworld/features/Home/views/body.dart';
import 'package:lifebloodworld/main.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lifebloodworld/features/Ho/me/views/body.dart';
// import 'package:lifebloodworld/main.dart';

// import '../main.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.

//   print("Handling a background message: ${message.notification!.title}");
//   print("Handling a body background message: ${message.notification!.body}");
//   print("Handling a background message: $message");
// }

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print("Handling a background message: ${message.notification?.title}");
  print("Handling a body background message: ${message.notification?.body}");
  // print("Handling a background message: ${message.data}");
}

class FirebaseServices {
  // Create an instance of firebase messaging

  final _fbMessaging = FirebaseMessaging.instance;

  // function to initialize notification
  Future<void> initNotif() async {
    // rewuest permission from user to allow notification
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _fbMessaging.requestPermission();

    // fetch FCM token for this device
    final token = await _fbMessaging.getToken();

    // print token to see
    debugPrint(token);
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// initialise flutter settings for push noti
    initPushNotif();
    // print(check);
  }
  // handle received messages

  void handleMsg(RemoteMessage? msg) {
    if (msg == null) return;
    print(msg.data);
    print("Handling a background message: ${msg.data}");

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });

    navigatorKey.currentState?.pushNamed("/home");
    // navigatorKey.currentState?.pushNamed('/home');
  }

  // function to initialise forebackground and background settings
  Future initPushNotif() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // handle notification if the app was terminated and now opened
    await FirebaseMessaging.instance.getInitialMessage().then(handleMsg);

    // attach event listen for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMsg);

    // // Attach event listener for receiving notifications while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Received a message in the foreground:');
      handleMsg(message);
    });

    // Attach event listener for receiving notifications while the app is in the foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint('Received a message in the foreground:');
        handleMsg(message);
      },
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // debugPrint(test.toString());
  }
}
