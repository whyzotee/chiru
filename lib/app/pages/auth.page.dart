import 'dart:math';

import 'package:chiru/app/pages/home.page.dart';
import 'package:chiru/app/pages/signup.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsup/whatsup.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});
  static String path = 'main screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            final rWall = Random().nextInt(2) + 1;
            final wallpaperDIR = Whatsup().now().split(' ')[1].toLowerCase();

            if (snapshot.hasData) {
              return HomePage(
                wallpaper: 'assets/images/wp_$wallpaperDIR/$rWall.jpg',
              );
            }

            return const SignUpPage();
          }),
    );
  }
}
