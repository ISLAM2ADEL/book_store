import 'package:book_store/firebase/firebase%20auth/firebase_form.dart';
import 'package:flutter/material.dart';

import '../../../const.dart';

class AdminAppBar extends StatelessWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseForm firebaseForm = FirebaseForm();
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: white,
      leadingWidth: 120,
      leading: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "Admin Page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: const Row(
              children: [
                Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  size: 25,
                )
              ],
            ),
            onTap: () {
              firebaseForm.signOutUser();
            },
          ),
        )
      ],
    );
  }
}
