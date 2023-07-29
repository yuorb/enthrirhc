import 'package:enthrirch/common/character/primary/specification.dart';
import 'package:enthrirch/common/utils.dart';

import 'primary/b_anchor.dart';
import 'primary/c_anchor.dart';
import 'primary/d_anchor.dart';
import 'primary/utils.dart';
import 'secondary/core.dart';
import 'secondary/extension.dart';
import 'secondary/letter.dart';
import 'secondary/utils.dart';

sealed class Character {
  const Character();

  (String, double) getSvg(double baseX, double height, String fillColor);
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
  (String, double) getSvg(double baseX, double height, String fillColor) {
    final Secondary(:core, :start, :end, :startAnchor, :endAnchor) = this;

    final secondaryBoundary = getSecondaryBoundary(this);
    final coreX = baseX - secondaryBoundary.$1;
    final coreY = height / 2;
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
  (String, double) getSvg(double baseX, double height, String fillColor) {
    final (left, right) = getPrimaryBoundary(this);
    final width = right - left;
    final bAnchorName = '${perspective.name}_${extension.name}';
    final cAnchorName = '${separability.name}_${similarity.name}';
    final dAnchorName = '${function.name}_${version.name}_${plexity.name}_${stem.name}';
    final specificationX = baseX - left;
    final specificationY = height / 2;
    final bAnchorX = specificationX + specification.bAnchor.x;
    final bAnchorY = specificationY + specification.bAnchor.y;
    final cAnchorX = specificationX + specification.cAnchor.x;
    final cAnchorY = specificationY + specification.cAnchor.y;
    final dAnchorX = specificationX + specification.dAnchor.x;
    final dAnchorY = specificationY + specification.dAnchor.y;
    return (
      '''
        <use href="#${specification.name}" x="$specificationX" y="$specificationY" fill="$fillColor" />
        <use href="#$bAnchorName" x="$bAnchorX" y="$bAnchorY" fill="$fillColor" />
        <use href="#$cAnchorName" x="$cAnchorX" y="$cAnchorY" fill="$fillColor" />
        <use href="#$dAnchorName" x="$dAnchorX" y="$dAnchorY" fill="$fillColor" />
      ''',
      width,
    );
  }
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
