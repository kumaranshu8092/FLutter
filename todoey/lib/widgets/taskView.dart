// ignore: file_names
import 'package:flutter/material.dart';
import 'package:todoey/widgets/tasktiles.dart';
import 'package:todoey/models/task.dart';

class TasksView extends StatelessWidget {
  List <Task> tasks = [
    Task(name: 'Buy Milk'),
    Task(name: 'Buy Chocolate')
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [TaskTiles(taskTitle: tasks[0].name, ), TaskTiles(), TaskTiles()],
    );
  }
}
