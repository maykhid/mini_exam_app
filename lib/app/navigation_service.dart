import 'package:flutter/material.dart';

/// This provides routing in the app
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  /// This function navigates to the specified routeName,
  /// you can also pass arguments to the next screen.
  /// If the arguments parameter is null it does not pass information to the next screen.
  Future<dynamic> navigateTo(String routeName, {arguments}) {
    if (arguments != null) {
      return navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  navigateToAndPopPrevious(String routeName) =>
      navigatorKey.currentState!.popAndPushNamed(routeName);

  void navigateBack() {
    return navigatorKey.currentState!.pop();
  }
}
