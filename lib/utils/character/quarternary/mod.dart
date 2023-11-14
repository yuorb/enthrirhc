import 'package:enthrirch/utils/character/mod.dart';
import 'package:enthrirch/utils/character/quarternary/bottom.dart';
import 'package:enthrirch/utils/character/quarternary/top.dart';
import 'package:enthrirch/utils/character/quarternary/utils.dart';
import 'package:enthrirch/libs/mod.dart';

const String corePath = "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 10.00 25.00 10.00 -35.00 Z";

const Coord coreTopAnchor = Coord(0.00, -25.00);
const Coord coreBottomAnchor = Coord(10.00, 25.00);

class Quarternary with Character {
  final QuarternaryTop top;
  final QuarternaryBottom bottom;

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
    return (
      '''
        <use href="#quarternary_core" x="$coreX" y="$coreY" fill="$fillColor" />
        <use href="#quarternary_${top.name}" x="$topX" y="$topY" fill="$fillColor" />
        <use href="#quarternary_${bottom.name}" x="$bottomX" y="$bottomY" fill="$fillColor" />
      ''',
      width,
    );
  }

  const Quarternary({required this.top, required this.bottom});
}
