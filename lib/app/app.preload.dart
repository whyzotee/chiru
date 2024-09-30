import 'package:chiru/app/app.home.dart';
import 'package:chiru/app/app.pageroute.dart';
import 'package:flutter/material.dart';

class PreloadPage extends StatefulWidget {
  const PreloadPage({super.key});

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.push(
          context,
          HoleMaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Loading", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
