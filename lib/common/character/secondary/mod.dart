import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/secondary/core_letter.dart';
import 'package:enthrirch/common/character/secondary/ext_letter.dart';
import 'package:enthrirch/common/character/secondary/utils.dart';

class Secondary with Character {
  final ExtLetter? start;
  final CoreLetter core;
  final ExtLetter? end;

  const Secondary({
    required this.start,
    required this.core,
    required this.end,
  });

  String? getStartExtPath() {
    return switch (core.start.orientation.filename) {
      "up" => start?.up,
      "left" => start?.left,
      _ => start?.diag
    };
  }

  String? getEndExtPath() {
    return switch (core.end.orientation.filename) {
      "up" => end?.up,
      "left" => end?.left,
      _ => end?.diag
    };
  }

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final Secondary(:core, :start, :end) = this;

    final secondaryBoundary = getSecondaryBoundary(this);
    final coreX = baseX - secondaryBoundary.$1;
    final coreY = baseY;
    final extStartX = coreX + core.start.coord.x;
    final extStartY = coreY + core.start.coord.y;
    final extEndX = coreX + core.end.coord.x + 0;
    final extEndY = coreY + core.end.coord.y + 0;

    final secondaryWidth = secondaryBoundary.$2 - secondaryBoundary.$1;
    return (
      '''
      <use href="#${core.phoneme.romanizedLetters[0]}_core" x="$coreX" y="$coreY" fill="$fillColor" />
      ${start != null ? '''<use
        href="#${start.phoneme.romanizedLetters[0]}_ext_${core.start.orientation.filename}"
        x="$extStartX"
        y="$extStartY" 
        transform="rotate(${core.start.orientation.rotation}, $extStartX, $extStartY)"
        fill="$fillColor"
      />''' : ''}
      ${end != null ? '''<use
        href="#${end.phoneme.romanizedLetters[0]}_ext_${core.end.orientation.filename}"
        x="$extEndX"
        y="$extEndY"
        transform="rotate(${core.end.orientation.rotation}, $extEndX, $extEndY)"
        fill="$fillColor"
      />''' : ''}
    ''',
      secondaryWidth
    );
  }
}
