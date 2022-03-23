import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  const Description({Key? key, required this.title, required this.description})
      : super(key: key);

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text('Description')),
          backgroundColor: Colors.purple),
      body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Text(
              title,
              style:
                  GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10,),

          Container(
            margin: const EdgeInsets.all(10),
            child: Text(
              description,
              style:
                  GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
