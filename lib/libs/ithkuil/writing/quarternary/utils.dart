import 'dart:math';

import 'package:enthrirhs/libs/ithkuil/writing/quarternary/mod.dart';

import '../../terms/mod.dart';
import '../utils.dart';

(double, double) getQuarternaryBoundary(Quarternary quarternary) {
  final topPath = switch (quarternary.relation) {
    Noun noun => noun.case$.topPath(),
    FramedVerb verb => verb.illocution.path(),
    UnframedVerb verb => verb.illocution.path(),
  };
  final bottomPath = switch (quarternary.relation) {
    Noun noun => noun.case$.bottomPath(),
    FramedVerb verb => verb.validation.path(),
    UnframedVerb verb => verb.validation.path(),
  };

  final (coreLeft, coreRight) = getCoreBoundary(corePath);
  final (topExtLeft, topExtRight) = getExtensionBoundary(topPath);
  final (bottomExtLeft, bottomExtRight) = getExtensionBoundary(bottomPath);

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
