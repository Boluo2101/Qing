// UI
import 'package:flutter/material.dart';

class CustomColors {
  static Color getColorByStr(String str) {
    switch (str) {
      case 'blue':
        return Colors.blue;
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
}
