import 'package:book_store/Book_description/similar.dart';
import 'package:book_store/const.dart';
import 'package:book_store/home%20screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDescription extends StatelessWidget {
  const BookDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EEE9),
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Get.off(const Home());
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 80),
          child: Text(
            "Detail Book",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
                child: Center(child: Image.asset("${path}book.png")),
              ),
              const SizedBox(
                height: 10,
              ),
              _BookName("The lliands", "Patrick Mauriee"),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  children: [
                    // for rating
                    _BookInfo("Rating", "4.5"),
                    _VerticalDivider(),
                    _BookInfo("N.Pages", "500"),
                    _VerticalDivider(),
                    _BookInfo("Language", "En"),
                    _VerticalDivider(),
                    _BookInfo("Author", "Dana Thomas"),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _BookDescription(),

              const SizedBox(
                height: 15,
              ),
              Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Tags",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  // Col of hashtags
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _buildHashtagChip('#Education'),
                          _buildHashtagChip('#Fantasy'),
                          _buildHashtagChip('#Fiction'),
                          _buildHashtagChip('#Novels'),
                          _buildHashtagChip('#Adventure'),
                          _buildHashtagChip('#Romance'),
                          _buildHashtagChip('#ScienceFiction'),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // Row of similar books
              Row(
                children: [
                  const Text(
                    "Similar Books",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Similar()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "See All",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildContainer(),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildContainer(),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildContainer(),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildContainer(),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildContainer(),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildContainer(),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildContainer(),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    "Reviews",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              _buildReviews(
                  "Mysoon Wilson",
                  "Lorem ipsum dolor sit amet, "
                      "consectetur adipiscing elit, sed do eiusmod tempor"
                      " incididunt ut labore et dolore magna aliqua."
                      "Ut enim ad minim veniam",
                  "${path}book.png"),
              const SizedBox(
                height: 20,
              ),
              _buildReviews(
                  "Mustafa",
                  "Lorem ipsum dolor sit amet, "
                      "consectetur adipiscing elit, sed do eiusmod tempor"
                      " incididunt ut labore et dolore magna aliqua."
                      "Ut enim ad minim veniam",
                  "${path}book2.jpeg"),
              const SizedBox(
                height: 30,
              ),

              _HeadLine("Rate A Review"),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "* * * * * ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              _HeadLine("Write A Review"),

              const SizedBox(
                height: 10,
              ),
              Container(
                height: 130,
                //margin: EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFFF1EEE9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    label: Text(
                      "",
                      style: TextStyle(color: Colors.grey),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color(0xFF495346)),
                child: const Center(
                    child: Text(
                  "Buy Book",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _HeadLine(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Column _BookDescription() {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            )
          ],
        ),
        Container(
          child: const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing"
            " elit. Nulla sit amet tortor ut risus lobortis interdum"
            " sed vel lorem. Morbi finibus, metus vitae interdum"
            " fringilla, quam lectus finibus augue, nec gravida"
            " nunc lectus vitae nunc. In hac habitasse platea",
            style: TextStyle(
              fontSize: 17,
              //fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  Padding _BookInfo(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                text1,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                text2,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }

  VerticalDivider _VerticalDivider() {
    return const VerticalDivider(
      color: Colors.black,
      thickness: 2,
      indent: 25,
      endIndent: 30,
    );
  }

  Column _BookName(String text1, String text2) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            text1,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            text2,
            style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey),
          ),
        ]),
      ],
    );
  }

  Container _buildReviews(String name, String text, String image) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(image),
                  radius: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [Text("********")],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 290,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Image.asset(
                  "${path}book2.jpeg",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "The Hunger",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Patrick Mauriee",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "4.5",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHashtagChip(String hashtag) {
  return Chip(
    label: Text(hashtag,
        style: const TextStyle(
            // fontWeight: FontWeight.bold
            )),
    backgroundColor: const Color(0xFFF1EEE9),
    labelStyle: const TextStyle(color: Colors.black),
  );
}
