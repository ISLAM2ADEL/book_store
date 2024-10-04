import 'package:book_store/book%20space%20cubit/recent%20cubit/recent_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../const.dart';
import '../home screen/home.dart';

class Recent extends StatelessWidget {
  const Recent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final recentCubit = context.read<RecentCubit>();
    recentCubit.getRecent();
    return Scaffold(
      backgroundColor: white,
      appBar: _recentAppBar(),
      body: Center(
        child: Container(
          width: width * .9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<RecentCubit, RecentState>(
              builder: (context, state) {
                if (state is RecentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is RecentSuccess) {
                  final recent = state.data;
                  return ListView.separated(
                    shrinkWrap:
                        true, // Ensure the ListView takes only needed height
                    itemCount: recent.length,
                    itemBuilder: (context, index) => _recentBooks(
                      bookImage: recent[index]['imageUrl'],
                      bookText: recent[index]['name'],
                      bookRemaining: "16 h 45 min",
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                  );
                }
                return const Text("");
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _recentBooks({
  required String bookImage,
  required String bookText,
  required String bookRemaining,
}) {
  return Row(
    children: [
      SizedBox(
        width: 150,
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image.network(bookImage),
            ),
            SizedBox(
              width: 100,
              child: Text(
                bookText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      Column(
        children: [
          const Text(
            "Remaining",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            bookRemaining,
            style: const TextStyle(
              color: grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
      const Spacer(),
      const Icon(
        Icons.timelapse_outlined,
        color: darkGreen,
      ),
    ],
  );
}

AppBar _recentAppBar() {
  return AppBar(
    backgroundColor: white,
    leading: InkWell(
      child: const Icon(
        Icons.keyboard_backspace_outlined,
        color: Colors.black,
        size: 26,
      ),
      onTap: () {
        Get.off(() => const Home());
      },
    ),
    title: const Text(
      "Recent Books",
      style: TextStyle(
        color: darkGreen,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    centerTitle: true,
  );
}
