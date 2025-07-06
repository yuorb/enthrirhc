import 'dart:math';

import 'package:enthrirhc/libs/ithkuil/writing/quarternary/mod.dart';

import '../../terms/mod.dart';
import '../utils.dart';

(double, double) getQuarternaryBoundary(Quarternary quarternary) {
  final topPath = switch (quarternary.formativeType) {
    NoConcatenation(relation: final relation) => switch (relation) {
      Noun noun => noun.case$.caseType.pathQuaternary(),
      FramedVerb framedVerb => framedVerb.case$.caseType.pathQuaternary(),
      UnframedVerb verb => verb.illocution.pathQuaternary(),
    },
    Type1Concatenation(format: final format) ||
    Type2Concatenation(
      format: final format,
    ) => format.caseType.pathQuaternary(),
  };
  final bottomPath = switch (quarternary.formativeType) {
    NoConcatenation(relation: final relation) => switch (relation) {
      Noun noun => noun.case$.caseNumber.pathQuaternary(),
      FramedVerb framedVerb => framedVerb.case$.caseNumber.pathQuaternary(),
      UnframedVerb verb => verb.validation?.pathQuaternary() ?? '',
    },
    Type1Concatenation(format: final format) ||
    Type2Concatenation(
      format: final format,
    ) => format.caseNumber.pathQuaternary(),
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
