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

  String? getStartExtId() {
    if (start != null) {
      return "${start!.phoneme.defaultLetter()}_ext_${core.startAnchor.orientation.type}";
    } else {
      return null;
    }
  }

  String? getStartExtPath() {
    return switch (core.startAnchor.orientation.type) {
      AnchorType.up => start?.up,
      AnchorType.left => start?.left,
      AnchorType.diag => start?.diag
    };
  }

  String? getEndExtId() {
    if (end != null) {
      return "${end!.phoneme.defaultLetter()}_ext_${core.endAnchor.orientation.type}";
    } else {
      return null;
    }
  }

  String? getEndExtPath() {
    return switch (core.endAnchor.orientation.type) {
      AnchorType.up => end?.up,
      AnchorType.left => end?.left,
      AnchorType.diag => end?.diag
    };
  }

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final Secondary(:core, :start, :end) = this;

    final secondaryBoundary = getSecondaryBoundary(this);
    final coreX = baseX - secondaryBoundary.$1;
    final coreY = baseY;
    final extStartX = coreX + core.startAnchor.coord.x;
    final extStartY = coreY + core.startAnchor.coord.y;
    final extEndX = coreX + core.endAnchor.coord.x + 0;
    final extEndY = coreY + core.endAnchor.coord.y + 0;

    final secondaryWidth = secondaryBoundary.$2 - secondaryBoundary.$1;
    return (
      '''
      <use href="#${core.phoneme.romanizedLetters[0]}_core" x="$coreX" y="$coreY" fill="$fillColor" />
      ${start != null ? '''<use
        href="#${start.phoneme.romanizedLetters[0]}_ext_${core.startAnchor.orientation.type}"
        x="$extStartX"
        y="$extStartY" 
        transform="rotate(${core.startAnchor.getRotation()}, $extStartX, $extStartY)"
        fill="$fillColor"
      />''' : ''}
      ${end != null ? '''<use
        href="#${end.phoneme.romanizedLetters[0]}_ext_${core.endAnchor.orientation.type}"
        x="$extEndX"
        y="$extEndY"
        transform="rotate(${core.endAnchor.getRotation()}, $extEndX, $extEndY)"
        fill="$fillColor"
      />''' : ''}
    ''',
      secondaryWidth
    );
  }
}
