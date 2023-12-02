import 'package:enthrirhs/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhs/libs/ithkuil/writing/quarternary/utils.dart';
import 'package:enthrirhs/libs/misc.dart';

import '../../terms/mod.dart';

const String corePath = "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 10.00 25.00 10.00 -35.00 Z";

const Coord coreTopAnchor = Coord(0.00, -25.00);
const Coord coreBottomAnchor = Coord(10.00, 25.00);

class Quarternary with Character {
  final Relation relation;

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getQuarternaryBoundary(this);
    final width = right - left;
    final coreX = baseX - left;
    final coreY = baseY;
    final topX = coreX + coreTopAnchor.x;
    final topY = coreY + coreTopAnchor.y;
    final bottomX = coreX + coreBottomAnchor.x;
    final bottomY = coreY + coreBottomAnchor.y;
    final topId = switch (relation) {
      Noun noun => noun.case$.topId(),
      FramedVerb verb => "illocution_${verb.illocution.name}",
      UnframedVerb verb => "illocution_${verb.illocution.name}",
    };
    final bottomId = switch (relation) {
      Noun noun => noun.case$.bottomId(),
      FramedVerb verb => "validation_${verb.validation.name}",
      UnframedVerb verb => "validation_${verb.validation.name}",
    };
    return (
      '''
        <use href="#quarternary_core" x="$coreX" y="$coreY" fill="$fillColor" />
        <use href="#$topId" x="$topX" y="$topY" fill="$fillColor" />
        <use href="#$bottomId" x="$bottomX" y="$bottomY" fill="$fillColor" />
      ''',
      width,
    );
  }

  const Quarternary(this.relation);
}
