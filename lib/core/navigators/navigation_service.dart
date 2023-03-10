import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<Object?> navigateTo(String routeName, {Object? arguments}) {
    return _navigationKey.currentState!
        .pushNamed<String>(routeName, arguments: arguments);
  }

  Future<Object?> clearLastAndNavigateTo(
    String routeName, {
    Object? arguments,
  }) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<Object?> removeAllAndNavigateTo(
    String routeName, {
    Object? arguments,
  }) {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (r) => false,
      arguments: arguments,
    );
  }
}
