import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intent(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static intentReplacement(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  static intentReplacementWithData(
      String routeName, Map<String, dynamic> data) {
    navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: data);
  }

  static back() => navigatorKey.currentState?.pop();
  static backWithData(Map<String, dynamic> data) =>
      navigatorKey.currentState?.pop(data);
}
