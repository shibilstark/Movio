import 'package:flutter/widgets.dart';

class AppColors {
  static final white = HexColor.fromHex("#FFFFFF");
  static final black = HexColor.fromHex("#1A1A1A");
  static final lightWhite = HexColor.fromHex("#EBEBEB");
  static final lightBlack = HexColor.fromHex("#242424");
  static final orange = HexColor.fromHex("#FF5146");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      // 8 character with 100% opacity
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
