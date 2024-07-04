// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCtuI6HkBBP6_njF4xIoMEMpKDdlAzn57Q',
    appId: '1:1027233337924:web:2e218f0c2e4377e373e211',
    messagingSenderId: '1027233337924',
    projectId: 'kikwa-60b7c',
    authDomain: 'kikwa-60b7c.firebaseapp.com',
    storageBucket: 'kikwa-60b7c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRStet1qZ8t_oau_IcdecTmUTxRA3RaqU',
    appId: '1:1027233337924:android:1537f5f57311284173e211',
    messagingSenderId: '1027233337924',
    projectId: 'kikwa-60b7c',
    storageBucket: 'kikwa-60b7c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMAo6nC5vKxXf2mMvyO9_fbKyIr8my5aQ',
    appId: '1:1027233337924:ios:d405007dd75d9b2673e211',
    messagingSenderId: '1027233337924',
    projectId: 'kikwa-60b7c',
    storageBucket: 'kikwa-60b7c.appspot.com',
    iosBundleId: 'com.example.kikwa',
  );
}
