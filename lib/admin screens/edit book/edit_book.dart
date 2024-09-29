import 'package:book_store/admin%20screens/admin%20app%20bar/admin_app_bar.dart';
import 'package:flutter/material.dart';

import '../../const.dart';
import '../admin bottom nav bar/admin_nav_bar.dart';

class EditBook extends StatelessWidget {
  const EditBook({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    //final cubit = context.read<ImageCubit>();
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: const AdminNavBar(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AdminAppBar(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: 15,
              itemBuilder: (context, index) => _bookContainer(height, width),
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bookContainer(double height, double width) {
    return Container(
      height: height * .2,
      width: width * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  15.0,
                ),
                topRight: Radius.circular(
                  15.0,
                ),
                bottomLeft: Radius.circular(
                  15.0,
                ),
                bottomRight: Radius.circular(
                  15.0,
                ),
              ),
              child: SizedBox(
                height: height * .17,
                width: width * .25,
                child: Image.asset("${path}hunger.png"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * .55,
                  child: Row(
                    children: [
                      const Text(
                        "Alone",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const Spacer(),
                      _editBoxes(
                          colors: Colors.orangeAccent, icons: Icons.edit),
                      const SizedBox(
                        width: 10,
                      ),
                      _editBoxes(colors: Colors.red, icons: Icons.delete),
                    ],
                  ),
                ),
                const Text(
                  "By EDFSsdfdsg",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const Text(
                  "550 Pages",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: width * .55,
                  child: const Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            "4.5",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "55\$",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _editBoxes({
    required IconData icons,
    required Color colors,
  }) {
    return Container(
      height: 30,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: colors),
        color: Colors.transparent,
      ),
      child: Center(
        child: Icon(
          icons,
          color: colors,
        ),
      ),
    );
  }
}
