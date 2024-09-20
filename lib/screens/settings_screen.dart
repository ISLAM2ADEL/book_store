import 'package:flutter/material.dart';
import 'package:book_store/const.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        leading: const Icon(Icons.arrow_back_ios),
        title: const Center(child: Text("Settings",
        style: TextStyle(
          color:fontColor,
          fontSize:20,
          fontWeight: FontWeight.bold
        ),
        )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _profileBar(height),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: height * .09,
                child: Column(
                  children: [
                    Row(
                      children: [
                        _models(height,
                            image: "solar_bag-smile-bold-duotone.png",
                            text: "Orders"),
                        _models(height,
                            image: "solar_library-bold-duotone.png",
                            text: "Library"),
                      ],
                    ),
                    Row(
                      children: [
                        _models(height,
                            image: "solar_heart-bold.png", text: "Wish List"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "General Settings",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: fontColor),
                    ),
                  ),
                  _generalSetting(
                      icon: Icons.supervised_user_circle,
                      text: "Change Photo",
                      value: ""),
                  Divider(
                    indent: width * .018,
                    endIndent: width * .018,
                    color: fontColor,
                    thickness: height*.00015,
                  ),
                  _generalSetting(
                      image: "${asset}solar_password-line-duotone.png",
                      text: "Change Password",
                      value: ""),
                  Divider(
                    indent: width * .018,
                    endIndent: width * .018,
                    color: fontColor,
                    thickness: height*.00015,
                  ),
                  _generalSetting(
                      image: "${asset}tabler_language.png",
                      text: "Language",
                      value: "English"),
                  Divider(
                    indent: width * .018,
                    endIndent: width * .018,
                    color: fontColor,
                    thickness: height*.00015,
                  ),
                  _generalSetting(
                      value: "Lite", text: "them", icon: Icons.dark_mode),
                  Divider(
                    indent: width * .018,
                    endIndent: width * .018,
                    color: fontColor,
                    thickness: height*.00015,
                  ),
                  _generalSetting(
                      value: "", text: "log out", icon: Icons.logout),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded _profileBar(double height) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: height * .1,
        child: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("${asset}Frame 65.png"),
              radius: 23,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "UserName",
                  style: TextStyle(fontWeight: FontWeight.w300,color:fontColor),
                ),
                Text(
                  "aadna@gmail.com",
                  style: TextStyle(fontWeight: FontWeight.w300,color: Colors.grey),
                )
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }

  Widget _models(double? height, {String? image, String? text}) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: height! * .08,
        decoration: BoxDecoration(
            color: fontColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("$asset$image"),
            const SizedBox(
              width: 5,
            ),
            Text(
              text.toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _generalSetting(
      {IconData? icon, String? text, String? image, required String? value}) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            image == null
                ? Icon(
                    icon,
                  )
                : Image.asset(image.toString()),
            const SizedBox(
              width: 10,
            ),
            Text(text.toString()),
            const Spacer(),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 14, color:Colors.grey),
            ),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
