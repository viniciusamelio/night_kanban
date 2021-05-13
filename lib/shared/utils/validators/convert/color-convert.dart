import 'package:flutter/cupertino.dart';

String colorToHex(Color color) {
  var hex = '#${color.value.toRadixString(16)}';
  return hex;
}
