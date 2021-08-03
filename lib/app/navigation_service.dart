import 'package:flutter/material.dart';

/// This provides routing in the app
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void navigateBack() {
    return navigatorKey.currentState!.pop();
  }
}
