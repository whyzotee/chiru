import 'package:chiru/app/app.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   name: "Chiru",
  //   options: const FirebaseOptions(
  //     apiKey: String.fromEnvironment('API_KEY'),
  //     appId: String.fromEnvironment('APP_ID'),
  //     messagingSenderId: String.fromEnvironment('MESSAGING_SENDER_ID'),
  //     projectId: String.fromEnvironment('PROJECT_ID'),
  //     storageBucket: String.fromEnvironment('STORAGE_BUCKET'),
  //     iosBundleId: String.fromEnvironment('BUNDLE_ID'),
  //   ),
  // );

  runApp(const ChiruApp());
}
