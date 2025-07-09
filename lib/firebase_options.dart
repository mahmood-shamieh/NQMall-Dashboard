import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5ioDMmAL97aHVBqBOHmrQ3U2virA3lss',
    appId: '1:716979128456:web:f14329008be819ba8eb73d',
    messagingSenderId: '716979128456',
    projectId: 'fcm-test-71bc6',
    authDomain: 'fcm-test-71bc6.firebaseapp.com',
    storageBucket: 'fcm-test-71bc6.firebasestorage.app',
    measurementId: 'G-8BCNWH0W04',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDncwQ0CCo8rIJVb0bjdWw7XUIyYM4H5W8',
    appId: '1:716979128456:android:37d5909d13e6a54b8eb73d',
    messagingSenderId: '716979128456',
    projectId: 'fcm-test-71bc6',
    storageBucket: 'fcm-test-71bc6.firebasestorage.app',
  );
}
