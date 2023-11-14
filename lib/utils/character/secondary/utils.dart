import 'dart:math';

import 'package:enthrirch/utils/character/secondary/mod.dart';
import 'package:enthrirch/libs/mod.dart';

import '../mod.dart';
import 'core_letter.dart';

(double, double) getSecondaryBoundary(Secondary secondary) {
  final (coreLeft, coreRight) = getCoreBoundary(secondary.core.path);
  final (topExtLeft, topExtRight) = getExtensionBoundary(
    secondary.getStartExtPath() ?? '',
    secondary.core.startAnchor.orientation,
  );
  final (bottomExtLeft, bottomExtRight) = getExtensionBoundary(
    secondary.getEndExtPath() ?? '',
    secondary.core.endAnchor.orientation,
  );

  final left = [
    coreLeft,
    secondary.core.startAnchor.coord.x + topExtLeft,
    secondary.core.endAnchor.coord.x + bottomExtLeft,
  ].reduce(min);
  final right = [
    coreRight,
    secondary.core.startAnchor.coord.x + topExtRight,
    secondary.core.endAnchor.coord.x + bottomExtRight,
  ].reduce(max);

  return (left, right);
}

(double, double) getExtensionBoundary(String path, AnchorOrientation orientation) {
  final isToRotate = switch (orientation) {
    AnchorOrientation.up => false,
    AnchorOrientation.down => true,
    AnchorOrientation.right => true,
    AnchorOrientation.upperLeft => false,
    AnchorOrientation.lowerRight => true,
  };
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

  return isToRotate ? (-right, -left) : (left, right);
}
