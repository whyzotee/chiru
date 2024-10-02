import 'package:flutter/material.dart';
import 'package:whatsup/whatsup.dart';
import 'package:just_audio/just_audio.dart';

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
  double volume = 0;
  String settingSound = "";
  List activeSound = [];

  void setup() async {
    for (var type in weather) {
      sounds.addAll({type: AudioPlayer()});
      await sounds[type]?.setAsset('assets/sounds/$type.mp3');
      await sounds[type]?.setLoopMode(LoopMode.all);
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
          settingSound = "";
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
              if (settingSound.isNotEmpty) ...[
                Text("Sound: $settingSound", style: fontSmall),
                Slider(
                  value: sounds[settingSound]?.volume ?? 0,
                  max: 1.0,
                  inactiveColor: Colors.white,
                  thumbColor: const Color(0xFF263238),
                  activeColor: const Color(0xFF263238),
                  onChanged: (value) => setState(() {
                    sounds[settingSound]?.setVolume(value);
                  }),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      for (var type in weather) {
                        sounds[type]?.stop();
                      }

                      setState(() {
                        activeSound.clear();
                        settingSound = "";
                      });
                    },
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
