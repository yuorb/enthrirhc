import 'package:enthrirhs/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhs/libs/ithkuil/writing/quarternary/utils.dart';
import 'package:enthrirhs/libs/misc.dart';

import '../../terms/mod.dart';

const String corePath = "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 10.00 25.00 10.00 -35.00 Z";

const Coord coreTopAnchor = Coord(0.00, -25.00);
const Coord coreBottomAnchor = Coord(10.00, 25.00);

class Quarternary with Character {
  final Relation relation;
  final Cn cn;

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getQuarternaryBoundary(this);
    final width = right - left;
    final coreX = baseX - left;
    final coreY = baseY;
    final startExtX = coreX + coreTopAnchor.x;
    final startExtY = coreY + coreTopAnchor.y;
    final endExtX = coreX + coreBottomAnchor.x;
    final endExtY = coreY + coreBottomAnchor.y;

    final String startExtId;
    final String endExtId;
    switch (relation) {
      case Noun noun:
        startExtId = noun.case$.topId();
        endExtId = noun.case$.bottomId();
      case FramedVerb verb:
        startExtId = "illocution_${verb.illocution.name}";
        endExtId = "validation_${verb.validation.name}";
      case UnframedVerb verb:
        startExtId = "illocution_${verb.illocution.name}";
        endExtId = "validation_${verb.validation.name}";
    }

    final String cnId = switch (cn) {
      MoodCn(mood: final mood) => mood.id(),
      CaseScopeCn(caseScope: final caseScope) => caseScope.id(),
    };

    return (
      '''
        <use href="#quarternary_core" x="$coreX" y="$coreY" fill="$fillColor" />
        <use href="#$startExtId" x="$startExtX" y="$startExtY" fill="$fillColor" />
        <use href="#$endExtId" x="$endExtX" y="$endExtY" fill="$fillColor" />
        <use href="#$cnId" x="$coreX" y="$coreY" fill="$fillColor" />
      ''',
      width,
    );
  }

  const Quarternary({
    required this.relation,
    required this.cn,
  });
}
