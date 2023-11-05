import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/primary/a_anchor.dart';
import 'package:enthrirch/common/character/primary/b_anchor.dart';
import 'package:enthrirch/common/character/primary/c_anchor.dart';
import 'package:enthrirch/common/character/primary/d_anchor.dart';
import 'package:enthrirch/common/character/primary/specification.dart';
import 'package:enthrirch/common/character/primary/top.dart';
import 'package:enthrirch/common/character/primary/utils.dart';

class Primary with Character {
  final Specification specification;
  final Context context;
  // Properties for A Anchor
  final Essence essence;
  final Affiliation affiliation;
  // Properties for B Anchor
  final Perspective perspective;
  final Extension extension;
  // Properties for C Anchor
  final Separability separability;
  final Similarity similarity;
  // Properties for D Anchor
  final Function$ function;
  final Version version;
  final Plexity plexity;
  final Stem stem;

  const Primary({
    required this.specification,
    required this.context,
    required this.essence,
    required this.affiliation,
    required this.perspective,
    required this.extension,
    required this.separability,
    required this.similarity,
    required this.function,
    required this.version,
    required this.plexity,
    required this.stem,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getPrimaryBoundary(this);
    final width = right - left;
    final topName = context.name;
    final aAnchorName = '${essence.name}_${affiliation.name}';
    final bAnchorName = '${perspective.name}_${extension.name}';
    final cAnchorName = '${separability.name}_${similarity.name}';
    final dAnchorName = '${function.name}_${version.name}_${plexity.name}_${stem.name}';
    final specificationX = baseX - left;
    final specificationY = baseY;
    final topX = specificationX + specification.centerX;
    final topY = specificationY;
    final aAnchorX = specificationX + specification.centerX;
    final aAnchorY = specificationY;
    final bAnchorX = specificationX + specification.bAnchor.x;
    final bAnchorY = specificationY + specification.bAnchor.y;
    final cAnchorX = specificationX + specification.centerX;
    final cAnchorY = specificationY;
    final dAnchorX = specificationX + specification.dAnchor.x;
    final dAnchorY = specificationY + specification.dAnchor.y;
    return (
      '''
        <use href="#${specification.name}" x="$specificationX" y="$specificationY" fill="$fillColor" />
        <use href="#$topName" x="$topX" y="$topY" fill="$fillColor" />
        <use href="#$aAnchorName" x="$aAnchorX" y="$aAnchorY" fill="$fillColor" />
        <use href="#$bAnchorName" x="$bAnchorX" y="$bAnchorY" fill="$fillColor" />
        <use href="#$cAnchorName" x="$cAnchorX" y="$cAnchorY" fill="$fillColor" />
        <use href="#$dAnchorName" x="$dAnchorX" y="$dAnchorY" fill="$fillColor" />
      ''',
      width,
    );
  }
}
