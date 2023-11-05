import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/tertiary/extensions.dart';
import 'package:enthrirch/common/character/tertiary/utils.dart';
import 'package:enthrirch/common/character/tertiary/valence.dart';

class Tertiary with Character {
  final Valence valence;
  final TertiaryExtension top;
  final TertiaryExtension bottom;

  const Tertiary({
    required this.valence,
    required this.top,
    required this.bottom,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getTertiaryBoundary(this);
    final width = right - left;
    final valenceX = baseX - left;
    final valenceY = baseY;
    final topX = valenceX;
    final topY = valenceY - 12 - getExtensionBottom(top);
    final bottomX = valenceX;
    final bottomY = valenceY + 12 - getExtensionTop(bottom);
    return (
      '''
        <use href="#${valence.name}" x="$valenceX" y="$valenceY" fill="$fillColor" />
        <use href="#${top.name}" x="$topX" y="$topY" fill="$fillColor" />
        <use href="#${bottom.name}" x="$bottomX" y="$bottomY" fill="$fillColor" />
      ''',
      width,
    );
  }
}
