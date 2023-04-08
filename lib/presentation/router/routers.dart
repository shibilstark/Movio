// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movio/presentation/screens/about_movie/about_movie_screen.dart';
import 'package:movio/presentation/screens/dashboard/dash_board.dart';
import 'package:movio/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static const SPLASH_SCREEN = "/";
  static const ABOUT_MOVIE = "/aboutmovie";
  static const DASH_BOARD = "/dashboard";
  static const MORE_MOVIE_TYPE = "/moremovietype";

  static Route? ongeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case DASH_BOARD:
        return MaterialPageRoute(builder: (_) => DashBoard());
      case SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case ABOUT_MOVIE:
        return MaterialPageRoute(builder: (_) => const AboutMovieScreen());

      default:
        return null;
    }
  }
}

class AppNavigator {
  static pop(BuildContext context, {bool? value}) async {
    Navigator.pop(context, value);
  }

  static push({
    required BuildContext context,
    required String screenName,
    Map<String, dynamic>? arguments,
  }) async {
    Navigator.pushNamed(context, screenName, arguments: arguments);
  }

  static pushReplacement({
    required BuildContext context,
    required String screenName,
    Map<String, dynamic>? arguments,
  }) async {
    Navigator.pushReplacementNamed(context, screenName, arguments: arguments);
  }

  static popAndPush(
      {required BuildContext context, required String screenName}) async {
    Navigator.popAndPushNamed(context, screenName);
  }

  static clearRouteIfFirst(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
