import 'secondary/core.dart';
import 'secondary/extension.dart';
import 'secondary/letter.dart';
import 'secondary/mod.dart';

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
    final extStartX = coreX + startAnchor.x;
    final extStartY = coreY + startAnchor.y;
    final extEndX = coreX + endAnchor.x + 0;
    final extEndY = coreY + endAnchor.y + 0;

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
  @override
  (String, double) getSvg(double baseX, double height, String fillColor) {
    return ('', 0.0);
  }
}
