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
    apiKey: 'AIzaSyCYhQuvlVHWxBuxjZeBuCFFlhZ2iQ8gKf0',
    appId: '1:491494250142:web:8cf18fdb5d73aac15bcd8f',
    messagingSenderId: '491494250142',
    projectId: 'timetracker-ac3f2',
    authDomain: 'timetracker-ac3f2.firebaseapp.com',
    storageBucket: 'timetracker-ac3f2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsl2yGoFutoyD16usQyGjppIm3WAyA0TQ',
    appId: '1:491494250142:android:bba2b21120801c645bcd8f',
    messagingSenderId: '491494250142',
    projectId: 'timetracker-ac3f2',
    storageBucket: 'timetracker-ac3f2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSR5hZWZSRB5fjk9ChLuzspxbYguZC6Nw',
    appId: '1:491494250142:ios:8a0380c5a53063855bcd8f',
    messagingSenderId: '491494250142',
    projectId: 'timetracker-ac3f2',
    storageBucket: 'timetracker-ac3f2.appspot.com',
    iosClientId: '491494250142-lv3cc6r6gh20blqchsnrlc75d9l9tuem.apps.googleusercontent.com',
    iosBundleId: 'com.example.timetracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCSR5hZWZSRB5fjk9ChLuzspxbYguZC6Nw',
    appId: '1:491494250142:ios:8a0380c5a53063855bcd8f',
    messagingSenderId: '491494250142',
    projectId: 'timetracker-ac3f2',
    storageBucket: 'timetracker-ac3f2.appspot.com',
    iosClientId: '491494250142-lv3cc6r6gh20blqchsnrlc75d9l9tuem.apps.googleusercontent.com',
    iosBundleId: 'com.example.timetracker',
  );
}
