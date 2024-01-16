import 'package:enthrirhs/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhs/libs/ithkuil/writing/quarternary/utils.dart';
import 'package:enthrirhs/libs/misc.dart';

import '../../terms/mod.dart';

const String corePath = "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 10.00 25.00 10.00 -35.00 Z";

const Coord coreTopAnchor = Coord(0.00, -25.00);
const Coord coreBottomAnchor = Coord(10.00, 25.00);

class Quarternary with Character {
  final ConcatenationStatus formativeType;
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
    final String? endExtId;
    switch (formativeType) {
      case NoConcatenation(relation: final relation):
        switch (relation) {
          case Noun noun:
            startExtId = noun.case$.caseType.idQuaternary();
            endExtId = noun.case$.caseNumber.idQuaternary();
            break;
          case FramedVerb framedVerb:
            startExtId = framedVerb.case$.caseType.idQuaternary();
            endExtId = framedVerb.case$.caseNumber.idQuaternary();
            break;
          case UnframedVerb verb:
            startExtId = verb.illocution.idQuaternary();
            endExtId = verb.validation?.idQuaternary();
            break;
        }
        break;
      case Type1Concatenation(format: final format) || Type2Concatenation(format: final format):
        startExtId = format.caseType.idQuaternary();
        endExtId = format.caseNumber.idQuaternary();
        break;
    }

    final String cnId = cn.id();
    // 5 is the half width of the core path.
    final double cnX = coreX + 5;
    final double cnY = coreY + (formativeType.isCaseScope() ? 70 : -70);

    return (
      '''
        <use href="#quarternary_core" x="$coreX" y="$coreY" fill="$fillColor" />
        <use href="#$startExtId" x="$startExtX" y="$startExtY" fill="$fillColor" />
        ${endExtId != null ? '<use href="#$endExtId" x="$endExtX" y="$endExtY" fill="$fillColor" />' : ""}
        <use href="#$cnId" x="$cnX" y="$cnY" fill="$fillColor" />
      ''',
      width,
    );
  }

  const Quarternary({
    required this.formativeType,
    required this.cn,
  });
}
