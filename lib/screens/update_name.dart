import 'package:flutter/material.dart';

import '../const.dart';
class UpdateName extends StatelessWidget {
  UpdateName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title:const Text("Update User Name",
            style: TextStyle(
            color:fontColor,
            fontSize:20,
            fontWeight: FontWeight.bold
            ),
        ),
      ),
      body: ,
    );
  }
}
