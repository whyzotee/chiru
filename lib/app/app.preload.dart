import 'package:chiru/app/app.home.dart';
import 'package:chiru/app/app.pageroute.dart';
import 'package:flutter/material.dart';
import 'package:whatsup/whatsup.dart';

class PreloadPage extends StatefulWidget {
  const PreloadPage({super.key});

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  final rWall = 1; // Random().nextInt(2) + 1;
  final wallpaperDIR = Whatsup().now().split('Good')[1].toLowerCase();

  late final String wallpaper;

  @override
  void initState() {
    super.initState();
    wallpaper = 'assets/images/wp_$wallpaperDIR/$rWall.jpg';

    Future.delayed(const Duration(seconds: 1), () {
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
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Loading", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
