import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final bool active;
  final String soundType;
  final double siderValue;
  final Function(double) onSliderCahnge;
  final Function() clearAll;

  const SettingsWidget({
    super.key,
    required this.active,
    required this.soundType,
    required this.siderValue,
    required this.onSliderCahnge,
    required this.clearAll,
  });

  final fontSmall = const TextStyle(fontSize: 24, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: active ? 150 : 0,
      duration: const Duration(milliseconds: 500),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Sound: $soundType", style: fontSmall),
            Slider(
              value: siderValue,
              max: 1.0,
              inactiveColor: Colors.white,
              thumbColor: const Color(0xFF263238),
              activeColor: const Color(0xFF263238),
              onChanged: onSliderCahnge,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: clearAll,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFF263238),
                ),
                child: Text("Clear All", style: fontSmall),
              ),
            )
          ],
        ),
      ),
    );
  }
}
