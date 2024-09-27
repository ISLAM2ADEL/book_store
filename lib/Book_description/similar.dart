import 'package:flutter/material.dart';

class Similar extends StatefulWidget {
  const Similar({super.key});

  @override
  State<Similar> createState() => _SimilarState();
}

class _SimilarState extends State<Similar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Waiting for merge pages",style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
    );
  }
}
