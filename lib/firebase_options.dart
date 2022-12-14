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
    apiKey: 'AIzaSyCSzLmfKUBJfxBwg_ixjsKhiTt8HFGeuRc',
    appId: '1:784260431767:web:572258b68feb8f15e04ed2',
    messagingSenderId: '784260431767',
    projectId: 'my-todolist-dc2ff',
    authDomain: 'my-todolist-dc2ff.firebaseapp.com',
    storageBucket: 'my-todolist-dc2ff.appspot.com',
    measurementId: 'G-S9QJ3GNLW4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkCVBie4gVbbvhsoX89JHD4M-bYcap2jA',
    appId: '1:784260431767:android:5e6b55fa184f8e0ae04ed2',
    messagingSenderId: '784260431767',
    projectId: 'my-todolist-dc2ff',
    storageBucket: 'my-todolist-dc2ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUf51ptJc3ptX_EWDrRjq2pnV99FPTduw',
    appId: '1:784260431767:ios:9c7ea6428725e2e6e04ed2',
    messagingSenderId: '784260431767',
    projectId: 'my-todolist-dc2ff',
    storageBucket: 'my-todolist-dc2ff.appspot.com',
    iosClientId: '784260431767-415j1k67a9006b4kcq7a69u1kltecdl4.apps.googleusercontent.com',
    iosBundleId: 'com.example.myTodolist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUf51ptJc3ptX_EWDrRjq2pnV99FPTduw',
    appId: '1:784260431767:ios:9c7ea6428725e2e6e04ed2',
    messagingSenderId: '784260431767',
    projectId: 'my-todolist-dc2ff',
    storageBucket: 'my-todolist-dc2ff.appspot.com',
    iosClientId: '784260431767-415j1k67a9006b4kcq7a69u1kltecdl4.apps.googleusercontent.com',
    iosBundleId: 'com.example.myTodolist',
  );
}
