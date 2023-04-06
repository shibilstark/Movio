import 'package:flutter/material.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';

class AppThemes {
  // Light Theme
  static final light = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.orange,
      onPrimary: AppColors.lightWhite,
      secondary: AppColors.black,
      onSecondary: AppColors.lightBlack,
      error: Colors.redAccent,
      onError: AppColors.lightWhite,
      background: AppColors.lightWhite,
      onBackground: AppColors.lightBlack,
      surface: AppColors.black,
      onSurface: AppColors.white,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: AppFontSize.titleLarge,
        color: AppColors.black,
      ),
      titleMedium: TextStyle(
        fontSize: AppFontSize.titleMedium,
        color: AppColors.black,
      ),
      titleSmall: TextStyle(
        fontSize: AppFontSize.titleSmall,
        color: AppColors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: AppFontSize.bodyLarge,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: AppFontSize.bodyMedium,
        color: AppColors.black,
      ),
      bodySmall: TextStyle(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.black,
      ),
      displayLarge: TextStyle(
        fontSize: AppFontSize.displayLarge,
        color: AppColors.lightBlack,
      ),
      displayMedium: TextStyle(
        fontSize: AppFontSize.displayMedium,
        color: AppColors.lightBlack,
      ),
      displaySmall: TextStyle(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.lightBlack,
      ),
    ),
  );

  // Dark Theme
  static final dark = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.orange,
      onPrimary: AppColors.lightBlack,
      secondary: AppColors.white,
      onSecondary: AppColors.lightWhite,
      error: Colors.redAccent,
      onError: AppColors.lightBlack,
      background: AppColors.lightBlack,
      onBackground: AppColors.lightWhite,
      surface: AppColors.lightWhite,
      onSurface: AppColors.lightBlack,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: AppFontSize.titleLarge,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: AppFontSize.titleMedium,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: AppFontSize.titleSmall,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: AppFontSize.bodyLarge,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: AppFontSize.bodyMedium,
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.white,
      ),
      displayLarge: TextStyle(
        fontSize: AppFontSize.displayLarge,
        color: AppColors.lightWhite,
      ),
      displayMedium: TextStyle(
        fontSize: AppFontSize.displayMedium,
        color: AppColors.lightWhite,
      ),
      displaySmall: TextStyle(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.lightWhite,
      ),
    ),
  );
}
