import 'dart:math';

import 'package:enthrirhs/libs/ithkuil/writing/quarternary/mod.dart';

import '../utils.dart';

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
