import 'package:flutter/material.dart';
import 'package:chiru/app/pages/preload.page.dart';
import 'package:chiru/app/animations/route.animation.dart';

class ChiruApp extends StatelessWidget {
  const ChiruApp({super.key});

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
