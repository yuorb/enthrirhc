import 'dart:math';

import 'package:enthrirch/common/character/tertiary/extensions.dart';
import 'package:enthrirch/common/character/tertiary/valence.dart';
import 'package:enthrirch/common/utils.dart';

import '../mod.dart';

(double, double) getTertiaryBoundary(Tertiary tertiary) {
  final (valenceLeft, valenceRight) = getHorizontalBoundary(valencePaths[tertiary.valence.name]!);
  final (topExtLeft, topExtRight) =
      getHorizontalBoundary(tertiaryExtensionPaths[tertiary.top.name]!);
  final (bottomExtLeft, bottomExtRight) =
      getHorizontalBoundary(tertiaryExtensionPaths[tertiary.bottom.name]!);

  final left = [
    valenceLeft,
    topExtLeft,
    bottomExtLeft,
  ].reduce(min);

  final right = [
    valenceRight,
    topExtRight,
    bottomExtRight,
  ].reduce(max);

  return (left, right);
}

double getExtensionBottom(TertiaryExtension ext) {
  // Ugly exceptions:
  if (ext == TertiaryExtension.aspectCss) {
    return 7;
  }
  final path = tertiaryExtensionPaths[ext.name]!;
  final list = path.split(" ").map((v) => tryParseString(v)).toList();
  double bottom = -double.infinity;
  for (int i = 1, index = 0; index < list.length; index++) {
    if (list[index] is String) continue;
    if (i % 2 == 0) {
      double coordY = list[index];
      if (coordY > bottom) bottom = coordY;
    }
    i++;
  }

  return bottom;
}

double getExtensionTop(TertiaryExtension ext) {
  // Ugly exceptions:
  if (ext == TertiaryExtension.aspectPrs) {
    return -7;
  }
  final path = tertiaryExtensionPaths[ext.name]!;
  final list = path.split(" ").map((v) => tryParseString(v)).toList();
  double top = double.infinity;
  for (int i = 1, index = 0; index < list.length; index++) {
    if (list[index] is String) continue;
    if (i % 2 == 0) {
      double coordY = list[index];
      if (coordY < top) top = coordY;
    }
    i++;
  }

  return top;
}

(double, double) getHorizontalBoundary(String path) {
  final list = path.split(" ").map((v) => tryParseString(v)).toList();
  double left = double.infinity;
  double right = -double.infinity;
  for (int i = 1, index = 0; index < list.length; index++) {
    if (list[index] is String) continue;
    if (i % 2 != 0) {
      double coordX = list[index];
      if (coordX < left) left = coordX;
      if (coordX > right) right = coordX;
    }
    i++;
  }

  return (left, right);
}
