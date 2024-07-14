import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifebloodworld/features/Home/views/body.dart';
import 'package:lifebloodworld/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lifebloodworld/features/Ho/me/views/body.dart';
// import 'package:lifebloodworld/main.dart';

// import '../main.dart';

//

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print("Handling a background message: ${message.notification?.title}");
  print("Handling a body background message: ${message.notification?.body}");
  debugPrint('Message data: ${message.data}');
  print('Message data: ${message.data['type']}');

  // print("Handling a background message: ${message.data}");
}

class FirebaseServices extends ChangeNotifier {
  // Create an instance of firebase messaging

  String deviceToken = '';

  final _fbMessaging = FirebaseMessaging.instance;

  // function to initialize notification
  Future<void> initNotif() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? permissionRequested = prefs.getBool('permissionRequested');

    if (permissionRequested == null || !permissionRequested) {
      // Request permission from user to allow notification
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      await _fbMessaging.requestPermission();

      // Fetch FCM token for this device
      final token = await _fbMessaging.getToken();

      // Print token to see
      debugPrint(token);

      // Store token in shared preferences
      await prefs.setString('deviceToken', token!);

      // set device toke to the variable deviceToken
      deviceToken = token;
      notifyListeners();

      // Store that permission has been requested
      await prefs.setBool('permissionRequested', true);
    }

    // rewuest permission from user to allow notification
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// initialise flutter settings for push noti
    initPushNotif();
    // print(check);
  }
  // handle received messages

  void handleMsg(RemoteMessage? msg) {
    if (msg == null) return;

    if (msg.data['type'] == 'Blood Donation Request') {
      navigatorKey.currentState?.pushNamed('/notification');
    } else if (msg.data['type'] == 'Campaign') {
      navigatorKey.currentState?.pushNamed('/request');
    } else if (msg.data['type'] == 'Result') {
      navigatorKey.currentState?.pushNamed('/request');
    } else if (msg.data['type'] == 'Next Donation Date') {
      navigatorKey.currentState?.pushNamed('/request');
    } else if (msg.data['type'] == 'Birthday Reminder') {
      navigatorKey.currentState?.pushNamed('/request');
    }
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
