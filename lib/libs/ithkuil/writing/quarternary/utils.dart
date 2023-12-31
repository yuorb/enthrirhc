import 'dart:math';

import 'package:enthrirhs/libs/ithkuil/writing/quarternary/mod.dart';

import '../../terms/mod.dart';
import '../utils.dart';

(double, double) getQuarternaryBoundary(Quarternary quarternary) {
  final topPath = switch (quarternary.formativeType) {
    Standalone(relation: final relation) || Parent(relation: final relation) => switch (relation) {
        Noun noun => noun.case$.caseType.pathQuaternary(),
        FramedVerb verb => verb.illocution.pathQuaternary(),
        UnframedVerb verb => verb.illocution.pathQuaternary(),
      },
    Concatenated(format: final format) => format.caseType.pathQuaternary(),
  };
  final bottomPath = switch (quarternary.formativeType) {
    Standalone(relation: final relation) || Parent(relation: final relation) => switch (relation) {
        Noun noun => noun.case$.caseNumber.pathQuaternary(),
        FramedVerb verb => verb.validation?.pathQuaternary() ?? '',
        UnframedVerb verb => verb.validation?.pathQuaternary() ?? '',
      },
    Concatenated(format: final format) => format.caseNumber.pathQuaternary(),
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
