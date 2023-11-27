import 'package:enthrirch/utils/character/mod.dart';
import 'package:enthrirch/utils/character/tertiary/extensions.dart';
import 'package:enthrirch/utils/character/tertiary/utils.dart';

import '../../ithkuil/terms/mod.dart';

class Tertiary with Character {
  final Valence valence;
  final TertiaryExtension top;
  final TertiaryExtension bottom;
  final Level level;

  const Tertiary({
    required this.valence,
    required this.top,
    required this.bottom,
    required this.level,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getTertiaryBoundary(this);
    final width = right - left;
    final valenceX = baseX - left;
    final valenceY = baseY;
    final topX = valenceX;
    final topY = valenceY - 8 - getExtensionBottom(top);
    final bottomX = valenceX;
    final bottomY = valenceY + 8 - getExtensionTop(bottom);
    final levelX = valenceX;
    final isAbsolute = level.comparison == Comparison.relative;
    final levelY = valenceY + unitHeight * 2 * (isAbsolute ? 1 : -1);
    return (
      '''
        <use href="#${top.name}" x="$topX" y="$topY" fill="$fillColor" />
        <use href="#${bottom.name}" x="$bottomX" y="$bottomY" fill="$fillColor" />
        <use href="#valence_${valence.name}" x="$valenceX" y="$valenceY" fill="$fillColor" />
        <use href="#level_${level.comparisonOperator.name}" x="$levelX" y="$levelY" fill="$fillColor" />
      ''',
      width,
    );
  }
}
