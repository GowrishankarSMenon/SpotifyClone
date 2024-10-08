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
    apiKey: 'AIzaSyAMLwqJfMnw8KhvlQnCxy1rxNEccyMN4y8',
    appId: '1:1056107213938:web:4cb896fae0bb10107e3eeb',
    messagingSenderId: '1056107213938',
    projectId: 'spotify-kannan',
    authDomain: 'spotify-kannan.firebaseapp.com',
    storageBucket: 'spotify-kannan.appspot.com',
    measurementId: 'G-WE6776QBFC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDy-3wlMmhQQxo0Y_uIuPwiLfPzlXmzzC0',
    appId: '1:1056107213938:android:215ca61bb37f3b477e3eeb',
    messagingSenderId: '1056107213938',
    projectId: 'spotify-kannan',
    storageBucket: 'spotify-kannan.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGpSdST8nQZwPdeRs5s5_V3viDkAlwkkI',
    appId: '1:1056107213938:ios:fcf3f4351dc2762c7e3eeb',
    messagingSenderId: '1056107213938',
    projectId: 'spotify-kannan',
    storageBucket: 'spotify-kannan.appspot.com',
    iosBundleId: 'com.example.musicApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGpSdST8nQZwPdeRs5s5_V3viDkAlwkkI',
    appId: '1:1056107213938:ios:fcf3f4351dc2762c7e3eeb',
    messagingSenderId: '1056107213938',
    projectId: 'spotify-kannan',
    storageBucket: 'spotify-kannan.appspot.com',
    iosBundleId: 'com.example.musicApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAMLwqJfMnw8KhvlQnCxy1rxNEccyMN4y8',
    appId: '1:1056107213938:web:69c790a457842c2f7e3eeb',
    messagingSenderId: '1056107213938',
    projectId: 'spotify-kannan',
    authDomain: 'spotify-kannan.firebaseapp.com',
    storageBucket: 'spotify-kannan.appspot.com',
    measurementId: 'G-EH4Q7WHSV0',
  );
}
