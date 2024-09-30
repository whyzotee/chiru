import 'package:flutter/material.dart';
import 'package:whatsup/whatsup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Whatsup ws = Whatsup();
  final String name = "whyzotee";

  final fontSmall = const TextStyle(fontSize: 24, color: Colors.white);

  List sound = [
    'assets/images/heavy-rain.png',
    'assets/images/lightning.png',
    'assets/images/wind.png',
    'assets/images/bonfire.png',
    'assets/images/cloudy-night.png',
    'assets/images/cloudy-day.png',
    'assets/images/owl.png',
  ];

  List background = [
    ['assets/images/wp_morning/1.jpg', 'assets/images/wp_morning/2.jpg'],
    ['assets/images/wp_afternoon/1.jpg', 'assets/images/wp_afternoon/2.jpg'],
    ['assets/images/wp_evening/1.jpg', 'assets/images/wp_evening/2.jpg'],
    ['assets/images/wp_night/1.jpg', 'assets/images/wp_night/2.jpg']
  ];

  List active_sound = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/wp_night/1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("${ws.now()}, $name", style: fontSmall)),
              const Spacer(),
              Text(
                ws.nameOfDay(),
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
              Wrap(
                children: [
                  Text("${DateTime.now().day}", style: fontSmall),
                  const SizedBox(width: 8),
                  Text(ws.nameOfMonth(), style: fontSmall)
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 15,
                runSpacing: 11,
                children: sound.map((image) {
                  return InkWell(
                    onTap: () => setState(() {
                      if (active_sound.contains(image)) {
                        active_sound.remove(image);
                      } else {
                        active_sound.add(image);
                      }
                    }),
                    child: SoundPad(
                      img: image,
                      isActive: active_sound.contains(image),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
