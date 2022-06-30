import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/ui/screens/main_screen.dart';
import 'package:weather_app/ui/screens/next_days_screen.dart';

class AppRouter {
  static const mainScreen = "/";
  static const nextDaysScreen = "/nextDaysScreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return MaterialPageRoute(builder: (context) => MainScreen());
      case nextDaysScreen:
        return CupertinoPageRoute(builder: (context) => NextDaysScreen());
      default:
        return MaterialPageRoute(builder: (context) => MainScreen());
    }
  }
}
