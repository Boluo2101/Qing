// UI
import 'package:flutter/material.dart';

class CustomColors {
  static Color getColorByStr(String str) {
    switch (str) {
      case 'blue':
        return Color(0xFF144ee6);
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'pink':
        return Colors.pink;
      case 'orange':
        return Colors.orange;
      case 'teal':
        return Colors.teal;
      default:
        return Colors.grey; // 默认颜色
    }
  }

  static Color getColorInvert(Color color) {
    return Color.fromARGB(
      color.alpha,
      255 - color.red,
      255 - color.green,
      255 - color.blue,
    );
  }
}
