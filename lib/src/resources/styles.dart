
import 'package:flutter/material.dart';

import 'colors.dart';

class UIStyles {
  static TextStyle textTitleCard = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 24,
  );

  static TextStyle textDescriptionCard = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 12,
  );

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static ButtonStyle textButtonStyle(bool value) => TextButton.styleFrom(
        backgroundColor:
            value ? UIColors.pressedButton : UIColors.notPressedButton,
      );

  static SizedBox margins() => const SizedBox(height: 8);
}
