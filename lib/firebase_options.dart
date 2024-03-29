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
    apiKey: 'AIzaSyCP6sxAqXS5JmXDyL6nxFzVQskAHMbJ3Tc',
    appId: '1:739588250426:web:b40ee25f1da9752be80e03',
    messagingSenderId: '739588250426',
    projectId: 'fypstitchvision',
    authDomain: 'fypstitchvision.firebaseapp.com',
    storageBucket: 'fypstitchvision.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAq7SUvne0ZnuC07lpcZVr1U93UKMEtJWY',
    appId: '1:739588250426:android:6fd1533d647c7dd2e80e03',
    messagingSenderId: '739588250426',
    projectId: 'fypstitchvision',
    storageBucket: 'fypstitchvision.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8cshBf74HMZdTeDkN9eE-xbzc1qBt9S0',
    appId: '1:739588250426:ios:7976048c0937578fe80e03',
    messagingSenderId: '739588250426',
    projectId: 'fypstitchvision',
    storageBucket: 'fypstitchvision.appspot.com',
    iosClientId: '739588250426-j0cn5jqu7q57i1cb3hot1aetsc3rhbjq.apps.googleusercontent.com',
    iosBundleId: 'com.example.fypProject',
  );
}
