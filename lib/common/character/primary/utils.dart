import 'dart:math';

import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/utils.dart';

import 'b_anchor.dart';
import 'd_anchor.dart';

(double, double) getAnchorBoundary(String path) {
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

(double, double) getPrimaryBoundary(Primary primary) {
  final bAnchorPath = bAnchorData[primary.perspective.name]![primary.extension.name]!;
  final dAnchorPath = dAnchorData[primary.function.name]![primary.version.name]![
      primary.plexity.name]![primary.stem.name]!;
  final (coreLeft, coreRight) = getCoreBoundary(primary.specification.path);
  final (bAnchorLeft, bAnchorRight) = getAnchorBoundary(bAnchorPath);
  final (dAnchorLeft, dAnchorRight) = getAnchorBoundary(dAnchorPath);

  final left = [
    coreLeft,
    primary.specification.bAnchor.x + bAnchorLeft,
    primary.specification.dAnchor.x + dAnchorLeft,
  ].reduce(min);
  final right = [
    coreRight,
    primary.specification.bAnchor.x + bAnchorRight,
    primary.specification.dAnchor.x + dAnchorRight,
  ].reduce(max);

  return (left, right);
}
