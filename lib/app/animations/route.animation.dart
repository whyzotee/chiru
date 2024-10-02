import 'dart:ui';

import 'package:flutter/material.dart';

class HoleMaterialPageRoute extends MaterialPageRoute {
  HoleMaterialPageRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(seconds: 1);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ClipPath(
      clipper: _HoleClipper(animation),
      child: child,
    );
  }
}

class _HoleClipper extends CustomClipper<Path> {
  _HoleClipper(this.animation);

  final Animation<double> animation;
  late final curve = CurvedAnimation(
    parent: animation,
    curve: Curves.easeOut,
    reverseCurve: Curves.easeIn,
  );

  @override
  Path getClip(Size size) {
    final center = size.center(Offset.zero);
    final radius = lerpDouble(0, center.distance, curve.value)!;
    // print('size: $size, radius: $radius');
    final oval = Rect.fromCircle(center: center, radius: radius);
    return Path()..addOval(oval);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class HolePageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ClipPath(
      clipper: _HoleClipper(animation),
      child: child,
    );
  }
}
