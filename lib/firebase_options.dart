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
    apiKey: 'AIzaSyBUCZ9YClXTgcwS_U2zwJhjdUlmWbcnbpM',
    appId: '1:967755120482:web:2c815ecd7f0cbb7f9bf63b',
    messagingSenderId: '967755120482',
    projectId: 'dateug-91b09',
    authDomain: 'dateug-91b09.firebaseapp.com',
    storageBucket: 'dateug-91b09.appspot.com',
    measurementId: 'G-GVS4RS8FG7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUeRDATtNH-oB61z2AX0sKunsMYUjkq04',
    appId: '1:967755120482:android:21149f1024c2f7269bf63b',
    messagingSenderId: '967755120482',
    projectId: 'dateug-91b09',
    storageBucket: 'dateug-91b09.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKKkkMHzMPxmEFRe7hFbeSKpO2EH7btk0',
    appId: '1:967755120482:ios:3d231724511cd40f9bf63b',
    messagingSenderId: '967755120482',
    projectId: 'dateug-91b09',
    storageBucket: 'dateug-91b09.appspot.com',
    iosClientId: '967755120482-0mqoealhm3v1ne6arb87vn4j3fc0a2pi.apps.googleusercontent.com',
    iosBundleId: 'com.example.dateUg',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKKkkMHzMPxmEFRe7hFbeSKpO2EH7btk0',
    appId: '1:967755120482:ios:3d231724511cd40f9bf63b',
    messagingSenderId: '967755120482',
    projectId: 'dateug-91b09',
    storageBucket: 'dateug-91b09.appspot.com',
    iosClientId: '967755120482-0mqoealhm3v1ne6arb87vn4j3fc0a2pi.apps.googleusercontent.com',
    iosBundleId: 'com.example.dateUg',
  );
}
