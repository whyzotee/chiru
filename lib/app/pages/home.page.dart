import 'package:whatsup/whatsup.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:chiru/app/widgets/widget.dart';

class HomePage extends StatefulWidget {
  final String wallpaper;
  const HomePage({super.key, required this.wallpaper});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Whatsup ws = Whatsup();
  final String name = "whyzotee";

  final fontSmall = const TextStyle(fontSize: 24, color: Colors.white);

  List<String> weather = [
    'heavy-rain',
    'lightning',
    'wind',
    'bonfire',
    'cloudy-night',
    'sunset',
    'owl'
  ];

  Map<String, AudioPlayer> sounds = {};
  double tempVolume = 0;
  String settingSound = "";
  List activeSound = [];

  void setup() async {
    for (var type in weather) {
      sounds.addAll({type: AudioPlayer()});
      await sounds[type]?.setAsset('assets/sounds/$type.mp3');
      await sounds[type]?.setLoopMode(LoopMode.all);
      await sounds[type]?.setVolume(0.5);
    }
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  String findOrdinal(int day) {
    switch (day) {
      case 1:
        return "st";
      case 2:
        return "rd";
      case 3:
        return "nd";
      default:
        return "th";
    }
  }

  void weatherTapFunc(String type) {
    setState(() {
      if (activeSound.contains(type)) {
        sounds[type]?.stop();
        activeSound.remove(type);

        if (activeSound.isEmpty) {
          tempVolume = sounds[type]?.volume ?? 0;
        } else {
          settingSound = activeSound.last;
        }
      } else {
        activeSound.add(type);
        sounds[type]?.play();
        settingSound = type;
      }
    });
  }

  void weatherDoubleTapFunc(String type) {
    if (activeSound.contains(type)) {
      setState(() => settingSound = type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(widget.wallpaper),
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
                  Text(ws.nameOfMonth(), style: fontSmall),
                  const SizedBox(width: 8),
                  Text("${DateTime.now().day}", style: fontSmall),
                  Text(findOrdinal(DateTime.now().day), style: fontSmall),
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 15,
                runSpacing: 11,
                children: weather.map((type) {
                  return GestureDetector(
                    onTap: () => weatherTapFunc(type),
                    onDoubleTap: () => weatherDoubleTapFunc(type),
                    child: SoundPad(
                      img: 'assets/images/$type.png',
                      isActive: activeSound.contains(type),
                    ),
                  );
                }).toList(),
              ),
              SettingsWidget(
                active: activeSound.isNotEmpty,
                soundType: settingSound,
                onSliderCahnge: (value) {
                  setState(() {
                    sounds[settingSound]?.setVolume(value);
                  });
                },
                siderValue: sounds[settingSound]?.volume ?? tempVolume,
                clearAll: () {
                  for (var type in weather) {
                    sounds[type]?.stop();
                  }

                  setState(() => activeSound.clear());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
