import 'dart:math';

import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/primary/mod.dart';

import 'a_anchor.dart';
import 'b_anchor.dart';
import 'c_anchor.dart';
import 'd_anchor.dart';

(double, double) getPrimaryBoundary(Primary primary) {
  final aAnchorPath = aAnchorData[primary.essence.name]![primary.affiliation.name]!;
  final bAnchorPath = bAnchorData[primary.perspective.name]![primary.extension.name]!;
  final cAnchorPath = cAnchorData[primary.similarity.name]![primary.separability.name]!;
  final dAnchorPath = dAnchorData[primary.function.name]![primary.version.name]![
      primary.plexity.name]![primary.stem.name]!;
  final (coreLeft, coreRight) = getCoreBoundary(primary.specification.path);
  final (aAnchorLeft, aAnchorRight) = getExtensionBoundary(aAnchorPath);
  final (bAnchorLeft, bAnchorRight) = getExtensionBoundary(bAnchorPath);
  final (cAnchorLeft, cAnchorRight) = getExtensionBoundary(cAnchorPath);
  final (dAnchorLeft, dAnchorRight) = getExtensionBoundary(dAnchorPath);

  final left = [
    coreLeft,
    primary.specification.centerX + aAnchorLeft,
    primary.specification.bAnchor.x + bAnchorLeft,
    primary.specification.centerX + cAnchorLeft,
    primary.specification.dAnchor.x + dAnchorLeft,
  ].reduce(min);
  final right = [
    coreRight,
    primary.specification.centerX + aAnchorRight,
    primary.specification.bAnchor.x + bAnchorRight,
    primary.specification.centerX + cAnchorRight,
    primary.specification.dAnchor.x + dAnchorRight,
  ].reduce(max);

  return (left, right);
}
