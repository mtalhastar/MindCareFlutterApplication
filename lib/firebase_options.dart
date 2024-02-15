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
    apiKey: 'AIzaSyDTJ5JzJuX00ZSUQaAcxtQIN61zJ6i0qAs',
    appId: '1:7650677860:web:8347788ee51c43874ebb71',
    messagingSenderId: '7650677860',
    projectId: 'mindcare-7bc26',
    authDomain: 'mindcare-7bc26.firebaseapp.com',
    storageBucket: 'mindcare-7bc26.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0LrAfOYWYgIaNFG9zZq3qPpHsjriHRlo',
    appId: '1:7650677860:android:e43aa795467c5e584ebb71',
    messagingSenderId: '7650677860',
    projectId: 'mindcare-7bc26',
    storageBucket: 'mindcare-7bc26.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6yO7wiNHiHtSsLX4FRH1edI5cJP_IVaQ',
    appId: '1:7650677860:ios:5561550da312228e4ebb71',
    messagingSenderId: '7650677860',
    projectId: 'mindcare-7bc26',
    storageBucket: 'mindcare-7bc26.appspot.com',
    iosBundleId: 'com.example.mindcareflutterapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6yO7wiNHiHtSsLX4FRH1edI5cJP_IVaQ',
    appId: '1:7650677860:ios:8497e0212e20dae14ebb71',
    messagingSenderId: '7650677860',
    projectId: 'mindcare-7bc26',
    storageBucket: 'mindcare-7bc26.appspot.com',
    iosBundleId: 'com.example.mindcareflutterapp.RunnerTests',
  );
}
