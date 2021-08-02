import 'package:exam_cheat_detector/ui/screens/home/home.dart';
import 'package:exam_cheat_detector/ui/screens/landing/landing.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // landing case
      case (LandingScreen.routeName):
        return MaterialPageRoute(
            builder: (_) => LandingScreen(),
            settings: RouteSettings(name: LandingScreen.routeName));

      //home case
      case (Home.routeName):
        return MaterialPageRoute(
            builder: (_) => Home(),
            settings: RouteSettings(name: Home.routeName));
      // break;
      default:
        return null;
    }
  }
}
