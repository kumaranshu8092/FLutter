import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/add_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/screens/descriotion.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Center(
          child: Text('TODO'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder: (Context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 100,
                child: CircularProgressIndicator(),
              );
            } else {
              final docx = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docx.length,
                itemBuilder: (context, index) {
                  DateTime time = DateTime.parse(docx[index]['time']);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                    title: docx[index]['title'],
                                    description: docx[index]['description'],
                                  )));
                    },
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xff121211),
                            borderRadius: BorderRadius.circular(10)),
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    docx[index]['title'],
                                    style: GoogleFonts.roboto(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text(DateFormat.yMd()
                                        .add_jm()
                                        .format(time))),
                              ],
                            ),
                            SizedBox(
                              child: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor:Colors.transparent,
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(uid)
                                      .collection('mytasks')
                                      .doc(docx[index]['time'])
                                      .delete();
                                },
                              ),
                            )
                          ],
                        )),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTask(),
              ));
        },
      ),
    );
  }
}
