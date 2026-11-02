import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// Public client configuration only; access is enforced by firestore.rules.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    if (defaultTargetPlatform == TargetPlatform.android) return android;
    throw UnsupportedError('BookShelf supports Android and web.');
  }

  static const web = FirebaseOptions(
    apiKey: 'AIzaSyAOIItMiVxuuHtBXuZmBoOL-Y6qCf1-EjE',
    appId: '1:381509047296:web:8bb91b8ed0c3deef6374e5',
    messagingSenderId: '381509047296',
    projectId: 'bookshelf-qe190001',
    authDomain: 'bookshelf-qe190001.firebaseapp.com',
    storageBucket: 'bookshelf-qe190001.firebasestorage.app',
  );
  static const android = FirebaseOptions(
    apiKey: 'AIzaSyAOIItMiVxuuHtBXuZmBoOL-Y6qCf1-EjE',
    appId: '1:381509047296:android:afa7f332537f0f176374e5',
    messagingSenderId: '381509047296',
    projectId: 'bookshelf-qe190001',
    storageBucket: 'bookshelf-qe190001.firebasestorage.app',
  );
}
