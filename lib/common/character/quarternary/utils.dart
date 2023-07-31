import 'dart:math';

import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/quarternary/mod.dart';

(double, double) getQuarternaryBoundary(Quarternary quarternary) {
  final (coreLeft, coreRight) = getCoreBoundary(corePath);
  final (topExtLeft, topExtRight) =
      getExtensionBoundary(quarternaryTopPaths[quarternary.top.name]!);

  final left = [
    coreLeft,
    coreTopAnchor.x + topExtLeft,
  ].reduce(min);

  final right = [
    coreRight,
    coreTopAnchor.x + topExtRight,
  ].reduce(max);

  return (left, right);
}
