import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/secondary/core.dart';
import 'package:enthrirch/common/character/secondary/extension.dart';
import 'package:enthrirch/common/character/secondary/letter.dart';
import 'package:enthrirch/common/character/secondary/utils.dart';

class Secondary with Character {
  final Letter? start;
  final Letter core;
  final Letter? end;
  final Anchor startAnchor;
  final Anchor endAnchor;

  const Secondary._({
    required this.start,
    required this.core,
    required this.end,
    required this.startAnchor,
    required this.endAnchor,
  });

  factory Secondary(
    Phoneme startPhoneme,
    Phoneme corePhoneme,
    Phoneme endPhoneme,
  ) {
    final core = CoreLetter.from(corePhoneme);
    final startExts = ExtLetter.from(startPhoneme);
    final endExts = ExtLetter.from(endPhoneme);
    final start = Letter(
        startExts.phoneme,
        switch (core.start.orientation.filename) {
          "up" => startExts.up,
          "left" => startExts.left,
          _ => startExts.diag
        });
    final end = Letter(
        endExts.phoneme,
        switch (core.end.orientation.filename) {
          "up" => endExts.up,
          "left" => endExts.left,
          _ => endExts.diag
        });
    return Secondary._(
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
