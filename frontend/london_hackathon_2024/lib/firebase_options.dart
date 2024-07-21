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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC6rprQTP63e8WDMdK4XzI1y8pj8yS_iyA',
    appId: '1:946749611172:web:99411487f9b578f876da31',
    messagingSenderId: '946749611172',
    projectId: 'london-2024-hackathon',
    authDomain: 'london-2024-hackathon.firebaseapp.com',
    storageBucket: 'london-2024-hackathon.appspot.com',
    measurementId: 'G-7EHJ4YVV7S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfTsQXyxWR7FvwJmHUouQ6tSUtlWin1-o',
    appId: '1:946749611172:android:852c09552d2799cb76da31',
    messagingSenderId: '946749611172',
    projectId: 'london-2024-hackathon',
    storageBucket: 'london-2024-hackathon.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfGETIpdSD5iJnTIWaGJCaHjzJMN-Yabs',
    appId: '1:946749611172:ios:755bdec86da1931376da31',
    messagingSenderId: '946749611172',
    projectId: 'london-2024-hackathon',
    storageBucket: 'london-2024-hackathon.appspot.com',
    androidClientId: '946749611172-79ms2h0f5a18m63r93ou8b6cheqnthvh.apps.googleusercontent.com',
    iosClientId: '946749611172-0e75e1one61sg2045n4uedgbud286ug7.apps.googleusercontent.com',
    iosBundleId: 'com.example.londonHackathon2024',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfGETIpdSD5iJnTIWaGJCaHjzJMN-Yabs',
    appId: '1:946749611172:ios:755bdec86da1931376da31',
    messagingSenderId: '946749611172',
    projectId: 'london-2024-hackathon',
    storageBucket: 'london-2024-hackathon.appspot.com',
    androidClientId: '946749611172-79ms2h0f5a18m63r93ou8b6cheqnthvh.apps.googleusercontent.com',
    iosClientId: '946749611172-0e75e1one61sg2045n4uedgbud286ug7.apps.googleusercontent.com',
    iosBundleId: 'com.example.londonHackathon2024',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC6rprQTP63e8WDMdK4XzI1y8pj8yS_iyA',
    appId: '1:946749611172:web:8ca868b5aa228dcd76da31',
    messagingSenderId: '946749611172',
    projectId: 'london-2024-hackathon',
    authDomain: 'london-2024-hackathon.firebaseapp.com',
    storageBucket: 'london-2024-hackathon.appspot.com',
    measurementId: 'G-XCCLNNHH02',
  );

}