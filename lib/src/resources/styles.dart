import 'dart:math';

import 'package:flutter/material.dart';
import 'package:images_test/src/resources/text.dart';

import '../component/profile/profile_page.dart';
import 'colors.dart';

class UIStyles {
  static TextStyle textDescriptionCard = const TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontSize: 16,
  );

  static TextStyle textDateTaken = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 12,
  );

  static TextStyle textAuthorCard = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 18,
  );

  static TextStyle textAuthorCardDetail = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20,
  );

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static ButtonStyle textButtonStyle(bool value) => TextButton.styleFrom(
        backgroundColor:
            value ? UIColors.pressedButton : UIColors.notPressedButton,
      );

  static SizedBox margins() => const SizedBox(height: 8);

  static const textStyleBold = TextStyle(
    fontWeight: FontWeight.bold,
  );
  static const appBarIcon = Icon(Icons.add_a_photo_outlined, size: 30);

  static PreferredSizeWidget appbar(BuildContext context1) => AppBar(
        backgroundColor: UIColors.appBarBackground,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: UIStyles.appBarIcon,
            ),
            const Text(
              UIText.applicationTitle,
              style: UIStyles.optionStyle,
            ),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return PopupMenuButton(
              icon: const Icon(Icons.menu),
              //don't specify icon if you want 3 dot menu
              color: UIColors.mobileBackgroundColor,
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "Home",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Setting"),
                ),
                PopupMenuItem<int>(
                    value: 2,
                    child: const Text("Profile"),
                    onTap: () {
                      print("PROFILE");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage(account: "UserName", img: "https://variety.com/wp-content/uploads/2021/04/Avatar.jpg?w=800&h=533&crop=1")),
                      );
                    }),
              ],
              onSelected: (item) => {print(item)},
            );
          },
        ),
        actions: [
          //list if widget in appbar actions
          PopupMenuButton(
            icon: Icon(Icons.menu), //don't specify icon if you want 3 dot menu
            color: Colors.blue,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Setting",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Privacy Policy"),
              ),
              PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text("Logout")
                    ],
                  )),
            ],
            onSelected: (item) => {print(item)},
          ),
        ],
      );
}
