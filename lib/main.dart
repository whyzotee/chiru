import 'package:flutter/material.dart';
import 'package:chiru/app/app.preload.dart';
import 'package:chiru/app/app.pageroute.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PreloadPage(),
      theme: ThemeData(
        fontFamily: 'Fredoka',
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: HolePageTransitionsBuilder(),
          TargetPlatform.android: HolePageTransitionsBuilder(),
        }),
      ),
    );
  }
}
