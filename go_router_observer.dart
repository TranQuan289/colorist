import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  GoRouterObserver(this.scaffoldMessengerKey);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }
}