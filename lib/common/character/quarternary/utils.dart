import 'dart:math';

import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/quarternary/mod.dart';

(double, double) getQuarternaryBoundary(Quarternary quarternary) {
  final (coreLeft, coreRight) = getCoreBoundary(corePath);
  final (topExtLeft, topExtRight) = getExtensionBoundary(quarternary.top.path);
  final (bottomExtLeft, bottomExtRight) = getExtensionBoundary(quarternary.bottom.path);

  final left = [
    coreLeft,
    coreTopAnchor.x + topExtLeft,
    coreBottomAnchor.x + bottomExtLeft,
  ].reduce(min);

  final right = [
    coreRight,
    coreTopAnchor.x + topExtRight,
    coreBottomAnchor.x + bottomExtRight,
  ].reduce(max);

  return (left, right);
}
