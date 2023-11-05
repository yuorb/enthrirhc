import 'dart:math';

import 'package:enthrirch/common/character/secondary/mod.dart';
import 'package:enthrirch/common/utils.dart';

import '../mod.dart';
import 'core_letter.dart';

(double, double) getSecondaryBoundary(Secondary secondary) {
  final (coreLeft, coreRight) = getCoreBoundary(secondary.core.path);
  final (topExtLeft, topExtRight) = getExtensionBoundary(
    secondary.getStartExtPath() ?? '',
    secondary.core.start.orientation,
  );
  final (bottomExtLeft, bottomExtRight) = getExtensionBoundary(
    secondary.getEndExtPath() ?? '',
    secondary.core.end.orientation,
  );

  final left = [
    coreLeft,
    secondary.core.start.coord.x + topExtLeft,
    secondary.core.end.coord.x + bottomExtLeft,
  ].reduce(min);
  final right = [
    coreRight,
    secondary.core.start.coord.x + topExtRight,
    secondary.core.end.coord.x + bottomExtRight,
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
