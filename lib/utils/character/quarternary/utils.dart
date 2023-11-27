import 'dart:math';

import 'package:enthrirch/utils/character/mod.dart';
import 'package:enthrirch/utils/character/quarternary/mod.dart';

(double, double) getQuarternaryBoundary(Quarternary quarternary) {
  final (coreLeft, coreRight) = getCoreBoundary(corePath);
  final (topExtLeft, topExtRight) = getExtensionBoundary(quarternary.slotIX.topPath());
  final (bottomExtLeft, bottomExtRight) = getExtensionBoundary(quarternary.slotIX.bottomPath());

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
