
import 'package:flutter/material.dart';
import 'package:images_test/src/resources/text.dart';

import 'colors.dart';

class UIStyles {
  static TextStyle textDescriptionCard = const TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontSize: 20,
  );

  static TextStyle textDateTaken = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    fontSize: 12,
  );

  static TextStyle textAuthorCard = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 12,
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

  static appbar () => AppBar(
    backgroundColor: UIColors.appBarBackground,
    title: const Text(
      UIText.applicationTitle,
      style: UIStyles.optionStyle,
    ),
  );
}
