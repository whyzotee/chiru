import 'dart:math';

import 'package:chiru/app/animations/route.animation.dart';
import 'package:chiru/app/bloc/counter.bloc.dart';
import 'package:chiru/app/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsup/whatsup.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/app-logo.jpg',
                height: 128,
              ),
            ),
            SizedBox(height: 50),
            Text('Username'),
            TextField(),
            Text('Password'),
            TextField(),
            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final rWall = Random().nextInt(2) + 1;
                  final time = Whatsup().now().split(' ')[1].toLowerCase();

                  Navigator.push(
                    context,
                    HoleMaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => CounterCubit(),
                        child: HomePage(
                          wallpaper: 'assets/images/wp_$time/$rWall.jpg',
                        ),
                      ),
                    ),
                  );
                },
                child: Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
