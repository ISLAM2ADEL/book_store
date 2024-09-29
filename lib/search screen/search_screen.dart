import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1EEE9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.keyboard_backspace_outlined,
                    size: 30,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _searchBar(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  bookWidget(
                      bookName: 'Book1',
                      authorName: 'AuthorName',
                      description: 'Description',
                      rating: '4.5'),
                  const SizedBox(
                    height: 15,
                  ),
                  bookWidget(
                      bookName: 'Book2',
                      authorName: 'AuthorName',
                      description: 'Description',
                      rating: '4.5'),
                  const SizedBox(
                    height: 15,
                  ),
                  bookWidget(
                      bookName: 'Book3',
                      authorName: 'AuthorName',
                      description: 'Description',
                      rating: '4.5'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container bookWidget(
      {required String bookName,
      required String authorName,
      required String description,
      required String rating}) {
    return Container(
      //color: Color(0xffF1EEE9),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/the island.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(authorName),
                const SizedBox(
                  height: 10,
                ),
                Text(description),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_outlined,
                      color: Colors.yellow,
                    ),
                    Text(rating),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Paid',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Row(
                  children: [Text('50')],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Titles or Authors',
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 25,
          color: Colors.grey,
        ),
        suffixIcon: Transform.rotate(
          angle: 90 * (3.1416 / 180), // 90 degrees in radians
          child: const Icon(
            CupertinoIcons.slider_horizontal_3,
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(.35),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(.35),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
