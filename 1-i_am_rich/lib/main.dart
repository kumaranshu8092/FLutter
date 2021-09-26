import 'package:flutter/material.dart';

// the main function is starting point for app our Flutter apps
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        // appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text("I Am Rich"),
          centerTitle: true,
        ),
        body: Center(
          child: Center(
            child: Image(image: AssetImage('images/diamond.png')),
          ),
        ),
      ),
    ),
  );
}
