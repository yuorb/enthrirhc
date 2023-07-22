import 'dart:math';

import 'package:enthrirch/common/letters/core.dart';
import 'package:enthrirch/common/letters/extension.dart';

sealed class Character {
  const Character();

  (String, double) getSvg(double baseX, double height, String fillColor);
}

class Secondary extends Character {
  final String start;
  final String core;
  final String end;

  const Secondary({
    required this.start,
    required this.core,
    required this.end,
  });

  factory Secondary.from(String secondary) {
    assert(secondary.length == 3);
    return Secondary(
      start: secondary[0],
      core: secondary[1],
      end: secondary[2],
    );
  }

  @override
  (String, double) getSvg(double baseX, double height, String fillColor) {
    final Secondary(:core, :start, :end) = this;

    final Core? coreLetter = coreLetterCode[core];
    if (coreLetter == null) {
      const errorPlaceholderWidth = 50.0;
      return (
        '''
        <rect x="$baseX" y="0" height="$height" width="$errorPlaceholderWidth" style="fill: red" />
      ''',
        errorPlaceholderWidth
      );
    }

    final secondaryBoundary = getSecondaryBoundary(this);
    final coreX = baseX - secondaryBoundary.$1;
    final coreY = height / 2;
    final extStartX = coreX + coreLetter.top.x;
    final extStartY = coreY + coreLetter.top.y;
    final extEndX = coreX + coreLetter.bottom.x + 0;
    final extEndY = coreY + coreLetter.bottom.y + 0;

    final secondaryWidth = secondaryBoundary.$2 - secondaryBoundary.$1;
    return (
      '''
      <use href="#${core}_core" x="$coreX" y="$coreY" fill="$fillColor" />
      <use
        href="#${start}_ext_${coreLetter.top.orientation.filename}"
        x="$extStartX"
        y="$extStartY" 
        transform="rotate(${coreLetter.top.orientation.rotation}, $extStartX, $extStartY)"
        fill="$fillColor"
      />
      <use
        href="#${end}_ext_${coreLetter.bottom.orientation.filename}"
        x="$extEndX"
        y="$extEndY"
        transform="rotate(${coreLetter.bottom.orientation.rotation}, $extEndX, $extEndY)"
        fill="$fillColor"
      />
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

(double, double) getSecondaryBoundary(Secondary secondary) {
  final Secondary(core: coreStr, start: startStr, end: endStr) = secondary;
  final Core core = coreLetterCode[coreStr]!;
  final Extensions? topExts = extLetterCode[startStr];
  final Extensions? bottomExts = extLetterCode[endStr];

  final (coreLeft, coreRight) = getCoreBoundary(core.path);
  final (topExtLeft, topExtRight) = getExtensionBoundary(topExts, core.top.orientation);
  final (bottomExtLeft, bottomExtRight) = getExtensionBoundary(bottomExts, core.bottom.orientation);

  final left = [coreLeft, core.top.x + topExtLeft, core.bottom.x + bottomExtLeft].reduce(min);
  final right = [coreRight, core.top.x + topExtRight, core.bottom.x + bottomExtRight].reduce(max);

  return (left, right);
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

(double, double) getExtensionBoundary(Extensions? extensions, AnchorOrientation orientation) {
  if (extensions == null) return (0, 0);
  final path = switch (orientation) {
    AnchorOrientation.up => extensions.up,
    AnchorOrientation.down => extensions.up,
    AnchorOrientation.right => extensions.left,
    AnchorOrientation.upperLeft => extensions.diag,
    AnchorOrientation.lowerRight => extensions.diag,
  };
  final isToRotate = switch (orientation) {
    AnchorOrientation.up => false,
    AnchorOrientation.down => true,
    AnchorOrientation.right => true,
    AnchorOrientation.upperLeft => false,
    AnchorOrientation.lowerRight => true,
  };
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

  return isToRotate ? (-right, -left) : (left, right);
}

dynamic tryParseString(String str) {
  try {
    return double.parse(str);
  } catch (e) {
    return str;
  }
}
