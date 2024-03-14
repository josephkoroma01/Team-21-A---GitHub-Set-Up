// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAQWXAnMYFvtKn4t_TT0JhKRYqS5k3uiHQ',
    appId: '1:619732706955:web:e6f40e4ae833d0d553968e',
    messagingSenderId: '619732706955',
    projectId: 'lifeblood-fa426',
    authDomain: 'lifeblood-fa426.firebaseapp.com',
    storageBucket: 'lifeblood-fa426.appspot.com',
    measurementId: 'G-8FVWC69CLF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC05_62fDbFunLJxfPuAL3T6zhBPalzuOs',
    appId: '1:619732706955:android:4dce40ad8d5f885653968e',
    messagingSenderId: '619732706955',
    projectId: 'lifeblood-fa426',
    storageBucket: 'lifeblood-fa426.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAb_pQ5A7m6IEffOCFT7x6PijCm0bAFuMc',
    appId: '1:619732706955:ios:d90f329a89f6297553968e',
    messagingSenderId: '619732706955',
    projectId: 'lifeblood-fa426',
    storageBucket: 'lifeblood-fa426.appspot.com',
    iosBundleId: 'com.example.lifebloodworld',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAb_pQ5A7m6IEffOCFT7x6PijCm0bAFuMc',
    appId: '1:619732706955:ios:fd9d8107dc9dd23253968e',
    messagingSenderId: '619732706955',
    projectId: 'lifeblood-fa426',
    storageBucket: 'lifeblood-fa426.appspot.com',
    iosBundleId: 'com.example.lifebloodworld.RunnerTests',
  );
}