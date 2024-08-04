import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) async {
    return Navigator.of(this).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> push(Widget widget) async {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => widget),
    );
  }

  Future<dynamic> pushReplacementNamed(String routeName,
      {Object? arguments}) async {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();

  // void n()=>Navigator.of(this).
  void popUntil(bool Function(Route<dynamic>) predicate) =>
      Navigator.of(this).popUntil(predicate);

  bool get canPop => Navigator.canPop(this);
}

extension Toasts on BuildContext {
  showError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  showSuccess(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
