import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsup/whatsup.dart';
import 'package:chiru/app/pages/home.page.dart';
import 'package:chiru/app/animations/route.animation.dart';

class PreloadPage extends StatefulWidget {
  const PreloadPage({super.key});

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  final rWall = Random().nextInt(2) + 1;
  final wallpaperDIR = Whatsup().now().split(' ')[1].toLowerCase();

  late final String wallpaper;

  @override
  void initState() {
    super.initState();
    wallpaper = 'assets/images/wp_$wallpaperDIR/$rWall.jpg';

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.push(
          context,
          HoleMaterialPageRoute(
            builder: (_) => HomePage(wallpaper: wallpaper),
          ),
        );
      }
    });
  }

  @override
  void didChangeDependencies() async {
    await precacheImage(AssetImage(wallpaper), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Container(color: Colors.white);
}
