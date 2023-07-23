import 'dart:math';

import 'package:enthrirch/common/utils.dart';

import '../mod.dart';
import 'core.dart';
import 'letter.dart';

(double, double) getSecondaryBoundary(Secondary secondary) {
  final Secondary(:core, start: startExt, end: endExt, :startAnchor, :endAnchor) = secondary;

  final (coreLeft, coreRight) = getCoreBoundary(core.path);
  final (topExtLeft, topExtRight) = getExtensionBoundary(startExt, startAnchor.orientation);
  final (bottomExtLeft, bottomExtRight) = getExtensionBoundary(endExt, endAnchor.orientation);

  final left = [coreLeft, startAnchor.x + topExtLeft, endAnchor.x + bottomExtLeft].reduce(min);
  final right = [coreRight, startAnchor.x + topExtRight, endAnchor.x + bottomExtRight].reduce(max);

  return (left, right);
}

(double, double) getExtensionBoundary(Letter? letter, AnchorOrientation orientation) {
  if (letter == null) return (0, 0);
  final isToRotate = switch (orientation) {
    AnchorOrientation.up => false,
    AnchorOrientation.down => true,
    AnchorOrientation.right => true,
    AnchorOrientation.upperLeft => false,
    AnchorOrientation.lowerRight => true,
  };
  final list = letter.path.split(" ").map((v) => tryParseString(v)).toList();
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

  return isToRotate ? (-right, -left) : (left, right);
}
