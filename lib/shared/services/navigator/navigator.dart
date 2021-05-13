import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

pushNamed({@required String routeName}) {
  return navigationKey.currentState.pushNamed(routeName);
}

pop() {
  return navigationKey.currentState.pop();
}

popUntillNamed({@required String routeName}) {
  return navigationKey.currentState
      .popUntil((route) => route.settings.name == routeName);
}

pushNamedAndRemoveUntill(
    {@required String routeName, Route<dynamic> predicate}) {
  return navigationKey.currentState
      .pushNamedAndRemoveUntil(routeName, predicate ?? (route) => false);
}

pushReplaceNamed({@required String routeName}) {
  return navigationKey.currentState.pushReplacementNamed(routeName);
}
