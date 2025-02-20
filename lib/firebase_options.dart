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
    apiKey: 'AIzaSyA4D_31imlEYiE56GBUuPdt5AC4N6hyt3Q',
    appId: '1:499307464905:web:cb92f02af1ee53c18b2518',
    messagingSenderId: '499307464905',
    projectId: 'geoscraper-ae801',
    authDomain: 'geoscraper-ae801.firebaseapp.com',
    storageBucket: 'geoscraper-ae801.firebasestorage.app',
    measurementId: 'G-J34KDGY961',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSLODEh4I5cAXuDmCTx1ZRTYw_6450pw4',
    appId: '1:499307464905:android:2c72edcfaabe7a748b2518',
    messagingSenderId: '499307464905',
    projectId: 'geoscraper-ae801',
    storageBucket: 'geoscraper-ae801.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLtA1GzQXxGj6mbCtKnOHPFCQw8bM2rUw',
    appId: '1:499307464905:ios:c165efc31e47351e8b2518',
    messagingSenderId: '499307464905',
    projectId: 'geoscraper-ae801',
    storageBucket: 'geoscraper-ae801.firebasestorage.app',
    iosClientId: '499307464905-3d7dnnhihe14dbggebprngc19db1kuq5.apps.googleusercontent.com',
    iosBundleId: 'com.example.geoScraperMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBLtA1GzQXxGj6mbCtKnOHPFCQw8bM2rUw',
    appId: '1:499307464905:ios:c165efc31e47351e8b2518',
    messagingSenderId: '499307464905',
    projectId: 'geoscraper-ae801',
    storageBucket: 'geoscraper-ae801.firebasestorage.app',
    iosClientId: '499307464905-3d7dnnhihe14dbggebprngc19db1kuq5.apps.googleusercontent.com',
    iosBundleId: 'com.example.geoScraperMobile',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA4D_31imlEYiE56GBUuPdt5AC4N6hyt3Q',
    appId: '1:499307464905:web:58c2cc78a7d3307c8b2518',
    messagingSenderId: '499307464905',
    projectId: 'geoscraper-ae801',
    authDomain: 'geoscraper-ae801.firebaseapp.com',
    storageBucket: 'geoscraper-ae801.firebasestorage.app',
    measurementId: 'G-Z6TG1VSQLE',
  );

}