import 'dart:ui';

dynamic tryParseString(String str) {
  try {
    return double.parse(str);
  } catch (e) {
    return str;
  }
}

String colorToHex(Color color) {
  return "#${color.toString().substring(10, 16)}";
}

extension StringExtension on String {
  String capitalize() => this == '' ? '' : "${this[0].toUpperCase()}${substring(1)}";
  String addPeriod() => "$this.";
}

class Coord {
  final double x;
  final double y;

  const Coord(this.x, this.y);
}
