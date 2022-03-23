import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/screens/home.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser!;
    String uid = user.uid;
    print(uid);
    var time = DateTime.now();
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
          
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp': time,
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Task',
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
              child: TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Incorrect Title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter Title',
                    border: OutlineInputBorder(),
                  ))),
          const SizedBox(
            height: 10,
            width: double.infinity,
          ),
          Container(
              child: TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Incorrect Description';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter Description',
                    border: OutlineInputBorder(),
                  ))),
          const SizedBox(
            height: 10,
          ),
          Container(
              width: 100,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.purple.shade100;
                      }
                      return Colors.purple;
                    },
                  ),
                ),
                child: Text(
                  'Add Task',
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
                onPressed: () {
                  addtasktofirebase();
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  });
                },
              ))
        ]),
      ),
    );
  }
}
