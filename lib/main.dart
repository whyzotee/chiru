import 'package:chiru/app/app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // await initializeFirebase();

  runApp(const ChiruApp());
}

Future<void> initializeFirebase() async {
  final apiKey = dotenv.env["API_KEY"];
  final appId = dotenv.env["APP_ID"];
  final messagingSenderId = dotenv.env["MESSAGING_SENDER_ID"];
  final projectId = dotenv.env["PROJECT_ID"];
  final storageBucket = dotenv.env["STORAGE_BUCKET"];

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception("API_KEY is missing or empty");
  }

  if (appId == null || appId.isEmpty) {
    throw Exception("APP_ID is missing or empty");
  }

  if (messagingSenderId == null || messagingSenderId.isEmpty) {
    throw Exception("MESSAGING_SENDER_ID is missing or empty");
  }

  if (projectId == null || projectId.isEmpty) {
    throw Exception("PROJECT_ID is missing or empty");
  }

  if (storageBucket == null || storageBucket.isEmpty) {
    throw Exception("STORAGE_BUCKET is missing or empty");
  }

  await Firebase.initializeApp(
    name: "Chiru",
    options: FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket,
    ),
  );
}
