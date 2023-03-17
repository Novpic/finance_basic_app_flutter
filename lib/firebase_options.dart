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
    apiKey: 'AIzaSyBzW_Vg-oU5-Bu5veozPzD7iDTRfoD31kQ',
    appId: '1:661186907944:web:2176516baa545171ca8a1d',
    messagingSenderId: '661186907944',
    projectId: 'finance-flutter-app-87d33',
    authDomain: 'finance-flutter-app-87d33.firebaseapp.com',
    databaseURL: 'https://finance-flutter-app-87d33-default-rtdb.firebaseio.com',
    storageBucket: 'finance-flutter-app-87d33.appspot.com',
    measurementId: 'G-EHCDTX9T9N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCe2J8eBMachP6SozqnKw27ZJ-naI07OYE',
    appId: '1:661186907944:android:cfbc0852be18a6e0ca8a1d',
    messagingSenderId: '661186907944',
    projectId: 'finance-flutter-app-87d33',
    databaseURL: 'https://finance-flutter-app-87d33-default-rtdb.firebaseio.com',
    storageBucket: 'finance-flutter-app-87d33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlW1Bp1fDO_AoA9TfK0hgtMCvyI-aAPOA',
    appId: '1:661186907944:ios:31923fb40ec622f6ca8a1d',
    messagingSenderId: '661186907944',
    projectId: 'finance-flutter-app-87d33',
    databaseURL: 'https://finance-flutter-app-87d33-default-rtdb.firebaseio.com',
    storageBucket: 'finance-flutter-app-87d33.appspot.com',
    iosClientId: '661186907944-acs58lsmlr6pbhgormegv8e502pplr5s.apps.googleusercontent.com',
    iosBundleId: 'com.example.financeBasicAppFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlW1Bp1fDO_AoA9TfK0hgtMCvyI-aAPOA',
    appId: '1:661186907944:ios:31923fb40ec622f6ca8a1d',
    messagingSenderId: '661186907944',
    projectId: 'finance-flutter-app-87d33',
    databaseURL: 'https://finance-flutter-app-87d33-default-rtdb.firebaseio.com',
    storageBucket: 'finance-flutter-app-87d33.appspot.com',
    iosClientId: '661186907944-acs58lsmlr6pbhgormegv8e502pplr5s.apps.googleusercontent.com',
    iosBundleId: 'com.example.financeBasicAppFlutter',
  );
}