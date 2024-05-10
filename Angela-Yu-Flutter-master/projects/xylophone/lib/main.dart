import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class SoundButton {
  final Color color;
  final String sound;

  SoundButton({required this.color, required this.sound});
}

class XylophoneApp extends StatelessWidget {
  XylophoneApp({super.key});

  final List<Color> buttonColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  final List<String> soundFiles = [
    'note1.wav',
    'note2wav',
    'note3.wav',
    'note4.wav',
    'note5.wav',
    'note6.wav',
    'note7.wav',
  ];

  List<SoundButton> get soundButtons {
    return List<SoundButton>.generate(
        soundFiles.length,
        (index) =>
            SoundButton(color: buttonColors[index], sound: soundFiles[index]));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: soundButtons
                .map(
                  (soundButton) => Expanded(
                    child: Container(
                      color: soundButton.color,
                      child: TextButton(
                        onPressed: () {
                          final player = AudioPlayer();
                          player.play(AssetSource(soundButton.sound));
                        },
                        child: Text(
                          'Play ${soundButton.sound}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
