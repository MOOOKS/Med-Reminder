import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAl_BXdXNWj5t4QtWG-iA2tGyesukN-0Ok",
            authDomain: "pillsorter-c326c.firebaseapp.com",
            projectId: "pillsorter-c326c",
            storageBucket: "pillsorter-c326c.appspot.com",
            messagingSenderId: "851088208371",
            appId: "1:851088208371:web:6aeeb84f237011f5ade286"));
  } else {
    await Firebase.initializeApp();
  }
}
