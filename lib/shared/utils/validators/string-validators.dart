import 'package:flutter/widgets.dart';

String stringSizeValidator(
    {@required String string,
    @required int minLength,
    @required String message}) {
  if (string.length < minLength) return message;
  return null;
}
