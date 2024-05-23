import 'package:flutter/cupertino.dart';

extension CapitalizeExtension on String {
  String capitalizeFirstChar() {
    if (isEmpty) return "";
    return this[0].toUpperCase() + substring(1);
  }

  String toUrl() {
    return replaceAll('\\', '/');
  }
}
