import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  void playsound(int num) {
    final player = AudioCache();
    player.play('note$num.wav');
  }

  Expanded buildkey({Color color, int num}) {
    return Expanded(
      child: Container(
        color: color,
        child: TextButton(
          onPressed: () {
            playsound(num);
          },
          child: Text(' '),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: Center(
            child: Text('Xylophone'),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildkey(color: Colors.red, num: 1),
                buildkey(color: Colors.orange, num: 2),
                buildkey(color: Colors.yellow, num: 3),
                buildkey(color: Colors.blue, num: 4),
                buildkey(color: Colors.green, num: 5),
                buildkey(color: Colors.teal, num: 6),
                buildkey(color: Colors.purple, num: 7),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
