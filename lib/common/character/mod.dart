import 'package:enthrirch/common/character/primary/specification.dart';
import 'package:enthrirch/common/utils.dart';

import 'primary/a_anchor.dart';
import 'primary/b_anchor.dart';
import 'primary/c_anchor.dart';
import 'primary/d_anchor.dart';
import 'primary/top.dart';
import 'primary/utils.dart';
import 'quarternary/bottom.dart';
import 'quarternary/mod.dart';
import 'quarternary/top.dart';
import 'quarternary/utils.dart';
import 'secondary/core.dart';
import 'secondary/extension.dart';
import 'secondary/letter.dart';
import 'secondary/utils.dart';

sealed class Character {
  const Character();

  (String, double) getSvg(double baseX, double baseY, String fillColor);
}

class Secondary extends Character {
  final Letter? start;
  final Letter core;
  final Letter? end;
  final Anchor startAnchor;
  final Anchor endAnchor;

  const Secondary({
    required this.start,
    required this.core,
    required this.end,
    required this.startAnchor,
    required this.endAnchor,
  });

  static Secondary? from(String secondary) {
    if (secondary.length != 3) {
      return null;
    }
    final core = CoreLetter.from(secondary[1]);
    if (core == null) {
      return null;
    }
    final startExts = ExtLetter.from(secondary[0]);
    final endExts = ExtLetter.from(secondary[2]);
    final start = startExts != null
        ? Letter(
            startExts.phoneme,
            switch (core.start.orientation.filename) {
              "up" => startExts.up,
              "left" => startExts.left,
              _ => startExts.diag
            })
        : null;
    final end = endExts != null
        ? Letter(
            endExts.phoneme,
            switch (core.end.orientation.filename) {
              "up" => endExts.up,
              "left" => endExts.left,
              _ => endExts.diag
            })
        : null;
    return Secondary(
      start: start,
      core: core.letter,
      end: end,
      startAnchor: core.start,
      endAnchor: core.end,
    );
  }

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final Secondary(:core, :start, :end, :startAnchor, :endAnchor) = this;

    final secondaryBoundary = getSecondaryBoundary(this);
    final coreX = baseX - secondaryBoundary.$1;
    final coreY = baseY;
    final extStartX = coreX + startAnchor.coord.x;
    final extStartY = coreY + startAnchor.coord.y;
    final extEndX = coreX + endAnchor.coord.x + 0;
    final extEndY = coreY + endAnchor.coord.y + 0;

    final secondaryWidth = secondaryBoundary.$2 - secondaryBoundary.$1;
    return (
      '''
      <use href="#${core.phoneme.romanizedLetters[0]}_core" x="$coreX" y="$coreY" fill="$fillColor" />
      ${start != null ? '''<use
        href="#${start.phoneme.romanizedLetters[0]}_ext_${startAnchor.orientation.filename}"
        x="$extStartX"
        y="$extStartY" 
        transform="rotate(${startAnchor.orientation.rotation}, $extStartX, $extStartY)"
        fill="$fillColor"
      />''' : ''}
      ${end != null ? '''<use
        href="#${end.phoneme.romanizedLetters[0]}_ext_${endAnchor.orientation.filename}"
        x="$extEndX"
        y="$extEndY"
        transform="rotate(${endAnchor.orientation.rotation}, $extEndX, $extEndY)"
        fill="$fillColor"
      />''' : ''}
    ''',
      secondaryWidth
    );
  }
}

class Primary extends Character {
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

class Quarternary extends Character {
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

(double, double) getCoreBoundary(String path) {
  final list = path.split(" ").map((v) => tryParseString(v)).toList();
  double right = -double.infinity;
  for (int i = 1, index = 0; index < list.length; index++) {
    if (list[index] is String) continue;
    if (i % 2 != 0) {
      double coordX = list[index];
      if (coordX > right) right = coordX;
    }
    i++;
  }
  // Core must start from axis `x = 0`;
  return (0, right);
}

(double, double) getExtensionBoundary(String path) {
  final list = path.split(" ").map((v) => tryParseString(v)).toList();
  double left = double.infinity;
  double right = -double.infinity;
  for (int i = 1, index = 0; index < list.length; index++) {
    if (list[index] is String) continue;
    if (i % 2 != 0) {
      double coordX = list[index];
      if (coordX < left) left = coordX;
      if (coordX > right) right = coordX;
    }
    i++;
  }

  return (left, right);
}
