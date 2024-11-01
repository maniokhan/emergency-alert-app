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
    apiKey: 'AIzaSyC-9wycoi6uVsFy0F-f3O_VFyxhb3JGs0g',
    appId: '1:345249316107:web:d25a350ba55b85aca8b60e',
    messagingSenderId: '345249316107',
    projectId: 'emergency-alert-app-f3185',
    authDomain: 'emergency-alert-app-f3185.firebaseapp.com',
    storageBucket: 'emergency-alert-app-f3185.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRd-Y3__LKQ51cQeG4JWufCAJoUeBdHjU',
    appId: '1:345249316107:android:655baafcf6dba7e9a8b60e',
    messagingSenderId: '345249316107',
    projectId: 'emergency-alert-app-f3185',
    storageBucket: 'emergency-alert-app-f3185.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEAdxlc6cH3a06NMzCdWxHrTduZs8LQio',
    appId: '1:345249316107:ios:faba444e97387e17a8b60e',
    messagingSenderId: '345249316107',
    projectId: 'emergency-alert-app-f3185',
    storageBucket: 'emergency-alert-app-f3185.appspot.com',
    iosBundleId: 'com.example.emergencyAlertApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEAdxlc6cH3a06NMzCdWxHrTduZs8LQio',
    appId: '1:345249316107:ios:faba444e97387e17a8b60e',
    messagingSenderId: '345249316107',
    projectId: 'emergency-alert-app-f3185',
    storageBucket: 'emergency-alert-app-f3185.appspot.com',
    iosBundleId: 'com.example.emergencyAlertApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-9wycoi6uVsFy0F-f3O_VFyxhb3JGs0g',
    appId: '1:345249316107:web:89af047c65e449a2a8b60e',
    messagingSenderId: '345249316107',
    projectId: 'emergency-alert-app-f3185',
    authDomain: 'emergency-alert-app-f3185.firebaseapp.com',
    storageBucket: 'emergency-alert-app-f3185.appspot.com',
  );
}
