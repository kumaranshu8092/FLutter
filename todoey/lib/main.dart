import 'package:flutter/material.dart';
import 'Screens/task_screens.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:TasksScreen(),
      
    );
  }
}