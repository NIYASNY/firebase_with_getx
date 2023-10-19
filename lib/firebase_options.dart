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
    apiKey: 'AIzaSyBpfGJN1NTai2xtza5HrPvyllLJrBzCrxs',
    appId: '1:659540110952:web:d6ed96fbb86a785b31d5dd',
    messagingSenderId: '659540110952',
    projectId: 'pushnot-auth',
    authDomain: 'pushnot-auth.firebaseapp.com',
    storageBucket: 'pushnot-auth.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3KVHl5WvBDx-KIY6XtnLofdwdvAf-47Y',
    appId: '1:659540110952:android:c4c1d4169a7a159f31d5dd',
    messagingSenderId: '659540110952',
    projectId: 'pushnot-auth',
    storageBucket: 'pushnot-auth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtxIEIY6hK2CoW7AoCUvVm-WZAHnSNcoM',
    appId: '1:659540110952:ios:dfd9ac1e1718df1131d5dd',
    messagingSenderId: '659540110952',
    projectId: 'pushnot-auth',
    storageBucket: 'pushnot-auth.appspot.com',
    iosBundleId: 'com.example.firebaseWithGetxTodo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDtxIEIY6hK2CoW7AoCUvVm-WZAHnSNcoM',
    appId: '1:659540110952:ios:83e5eec111ca32ab31d5dd',
    messagingSenderId: '659540110952',
    projectId: 'pushnot-auth',
    storageBucket: 'pushnot-auth.appspot.com',
    iosBundleId: 'com.example.firebaseWithGetxTodo.RunnerTests',
  );
}
