import 'package:enthrirhc/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhc/libs/ithkuil/writing/tertiary/extensions.dart';
import 'package:enthrirhc/libs/ithkuil/writing/tertiary/utils.dart';

import '../../terms/mod.dart';

class Tertiary with Character {
  final Valence valence;
  final TertiaryExtension? top;
  final TertiaryExtension? bottom;
  final Level? level;

  const Tertiary({
    required this.valence,
    this.top,
    this.bottom,
    this.level,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getTertiaryBoundary(this);
    final double width = right - left;
    final double valenceX = baseX - left;
    final double valenceY = baseY;
    final double topX = valenceX;
    final double? topY = top != null ? (valenceY - 8 - getExtensionBottom(top!)) : null;
    final double bottomX = valenceX;
    final double? bottomY = bottom != null ? (valenceY + 8 - getExtensionTop(bottom!)) : null;
    final double? levelX = level != null ? valenceX : null;
    final bool? isAbsolute = level != null ? level!.comparison == Comparison.relative : null;
    final double? levelY =
        level != null ? (valenceY + unitHeight * 2 * (isAbsolute! ? 1 : -1)) : null;
    return (
      [
        '<use href="#valence_${valence.name}" x="$valenceX" y="$valenceY" fill="$fillColor" />',
        top != null ? '<use href="#${top!.id()}" x="$topX" y="$topY" fill="$fillColor" />' : '',
        bottom != null
            ? '<use href="#${bottom!.id()}" x="$bottomX" y="$bottomY" fill="$fillColor" />'
            : '',
        level != null
            ? '<use href="#level_${level!.comparisonOperator.name}" x="$levelX" y="$levelY" fill="$fillColor" />'
            : ''
      ].join('\n'),
      width,
    );
  }
}
