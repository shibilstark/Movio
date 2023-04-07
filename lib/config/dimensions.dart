import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontSize {
  static final titleLarge = 22.sp;
  static final titleMedium = 20.sp;
  static final titleSmall = 18.sp;
  static final bodyLarge = 16.sp;
  static final bodyMedium = 14.sp;
  static final bodySmall = 12.sp;
  static final displayLarge = 10.sp;
  static final displayMedium = 8.sp;
  static final displaySmall = 6.sp;
}

class AppSpecific {
  static const appBarHeight = Size.fromHeight(kToolbarHeight);
  static final bottomNavHeight = Size.fromHeight(60.h);
  static const bottomNavRadius = 15.0;
}

class AppFontWeight {
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
}
