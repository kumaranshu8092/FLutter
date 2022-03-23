import 'package:flutter/material.dart';

class TaskTiles extends StatelessWidget {
  final bool isChecked;
  late final String taskTitle;

  TaskTiles({this.isChecked,required this.taskTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskTitle,
          style: TextStyle(
              decoration: isChecked? TextDecoration.lineThrough : null)),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked, onChanged: (bool? value) {},
        //   onChanged: togglecheckboxState,
        // )
      ),
    );
  }
}

// (bool? checkboxState) {
//     setState(
//       () {
//         isChecked = checkboxState?? true;
//       },
//     );
//   },

