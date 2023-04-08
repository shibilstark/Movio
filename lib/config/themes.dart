import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';

class AppThemes {
  // Light Theme
  static final light = ThemeData(
    fontFamily: "Open-Sans",
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
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
    primaryIconTheme: IconThemeData(
      color: AppColors.orange,
      size: 25.sp,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: AppFontSize.titleLarge,
        color: AppColors.black,
        letterSpacing: 1.2,
      ),
      titleMedium: TextStyle(
        fontSize: AppFontSize.titleMedium,
        color: AppColors.black,
        letterSpacing: 1.2,
      ),
      titleSmall: TextStyle(
        fontSize: AppFontSize.titleSmall,
        color: AppColors.black,
        letterSpacing: 1.2,
      ),
      bodyLarge: TextStyle(
        fontSize: AppFontSize.bodyLarge,
        color: AppColors.black,
        letterSpacing: 1.2,
      ),
      bodyMedium: TextStyle(
        fontSize: AppFontSize.bodyMedium,
        color: AppColors.black,
        letterSpacing: 1.2,
      ),
      bodySmall: TextStyle(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.black,
        letterSpacing: 1.2,
      ),
      displayLarge: TextStyle(
        fontSize: AppFontSize.displayLarge,
        color: AppColors.lightBlack,
        letterSpacing: 1.2,
      ),
      displayMedium: TextStyle(
        fontSize: AppFontSize.displayMedium,
        color: AppColors.lightBlack,
        letterSpacing: 1.2,
      ),
      displaySmall: TextStyle(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.lightBlack,
        letterSpacing: 1.2,
      ),
    ),
  );

  // Dark Theme
  static final dark = ThemeData(
    fontFamily: "Open-Sans",
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
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
    primaryIconTheme: IconThemeData(
      color: AppColors.orange,
      size: 25.sp,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: AppFontSize.titleLarge,
        color: AppColors.white,
        letterSpacing: 1.2,
      ),
      titleMedium: TextStyle(
        fontSize: AppFontSize.titleMedium,
        color: AppColors.white,
        letterSpacing: 1.2,
      ),
      titleSmall: TextStyle(
        fontSize: AppFontSize.titleSmall,
        color: AppColors.white,
        letterSpacing: 1.2,
      ),
      bodyLarge: TextStyle(
        fontSize: AppFontSize.bodyLarge,
        color: AppColors.white,
        letterSpacing: 1.2,
      ),
      bodyMedium: TextStyle(
        fontSize: AppFontSize.bodyMedium,
        color: AppColors.white,
        letterSpacing: 1.2,
      ),
      bodySmall: TextStyle(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.white,
        letterSpacing: 1.2,
      ),
      displayLarge: TextStyle(
        fontSize: AppFontSize.displayLarge,
        color: AppColors.lightWhite,
        letterSpacing: 1.2,
      ),
      displayMedium: TextStyle(
        fontSize: AppFontSize.displayMedium,
        color: AppColors.lightWhite,
        letterSpacing: 1.2,
      ),
      displaySmall: TextStyle(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.lightWhite,
        letterSpacing: 1.2,
      ),
    ),
  );
}
