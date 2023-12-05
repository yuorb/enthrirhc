import 'dart:math';

import 'package:enthrirhs/libs/ithkuil/writing/quarternary/mod.dart';

import '../../terms/mod.dart';
import '../utils.dart';

(double, double) getQuarternaryBoundary(Quarternary quarternary) {
  final topPath = switch (quarternary.formativeType) {
    Standalone(relation: final relation) || Parent(relation: final relation) => switch (relation) {
        Noun noun => noun.case$.topPath(),
        FramedVerb verb => verb.illocution.path(),
        UnframedVerb verb => verb.illocution.path(),
      },
    Concatenated(format: final format) => format.topPath(),
  };
  final bottomPath = switch (quarternary.formativeType) {
    Standalone(relation: final relation) || Parent(relation: final relation) => switch (relation) {
        Noun noun => noun.case$.bottomPath(),
        FramedVerb verb => verb.validation.path(),
        UnframedVerb verb => verb.validation.path(),
      },
    Concatenated(format: final format) => format.bottomPath(),
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
