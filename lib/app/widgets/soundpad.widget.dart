import 'package:flutter/material.dart';

class SoundPad extends StatelessWidget {
  final String img;
  final Color color;
  final bool isActive;
  const SoundPad({
    super.key,
    required this.img,
    this.color = Colors.white,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(img),
        ),
        Container(
          width: 28,
          height: 4,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: isActive ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
        )
      ],
    );
  }
}
