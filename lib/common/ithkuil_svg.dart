import 'dart:math';

import 'package:enthrirch/common/letters/core.dart';
import 'package:enthrirch/common/letters/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Secondary {
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
}

class IthkuilSvg extends StatelessWidget {
  final List<Secondary> secondaries;

  const IthkuilSvg(this.secondaries, {super.key});

  @override
  Widget build(BuildContext context) {
    // 1 unit height = 35
    // core letter height = 2 unit height = 70
    // full letter height = 4 unit height = 140
    // full letter with padding height = 6 unit height = 210
    const int baseHeight = 140;
    const double horizontalPadding = 20;
    const double horizontalGap = 10;
    const String fillColor = "white";

    final List<String> usedExtensions =
        secondaries.map((s) => [s.start, s.end]).expand((element) => element).toSet().toList();
    final List<String> usedCores = secondaries.map((s) => s.core).toSet().toList();

    var charImages = [];
    var leftCoord = horizontalPadding;
    for (var i = 0; i < secondaries.length; i++) {
      final Secondary(:core, :start, :end) = secondaries[i];

      final Core? coreLetter = coreLetterCode[core];
      if (coreLetter == null) {
        const errorPlaceholderWidth = 50;
        charImages.add('''
          <rect x="$leftCoord" y="0" height="$baseHeight" width="$errorPlaceholderWidth" style="fill: red" />
        ''');
        leftCoord += errorPlaceholderWidth + horizontalGap;
        continue;
      }
      final Anchor coreTopAnchor = coreLetter.top;
      final Anchor coreBottomAnchor = coreLetter.bottom;

      final coreX = leftCoord;
      const coreY = baseHeight / 2;
      final extStartX = coreX + coreTopAnchor.x;
      final extStartY = coreY + coreTopAnchor.y;
      final extEndX = coreX + coreBottomAnchor.x + 0;
      final extEndY = coreY + coreBottomAnchor.y + 0;
      leftCoord += getSecondaryWidth(secondaries[i]) + horizontalGap;

      charImages.add('''
        <use href="#${core}_core" x="$coreX" y="$coreY" fill="$fillColor" />
        <use
          href="#${start}_ext_${coreTopAnchor.orientation.filename()}"
          x="$extStartX"
          y="$extStartY" 
          transform="rotate(${coreTopAnchor.orientation.rotation()}, $extStartX, $extStartY)"
          fill="$fillColor"
        />
        <use
          href="#${end}_ext_${coreBottomAnchor.orientation.filename()}"
          x="$extEndX"
          y="$extEndY"
          transform="rotate(${coreBottomAnchor.orientation.rotation()}, $extEndX, $extEndY)"
          fill="$fillColor"
        />
      ''');
    }
    final baseWidth = leftCoord - horizontalGap + horizontalPadding;

    return SvgPicture.string(
      '''<svg width="$baseWidth" height="$baseHeight">
        <defs>
          ${usedCores.map(
            (e) => coreLetterCode.containsKey(e)
                ? '<path stroke="none" id="${e}_core" d="${coreLetterCode[e]!.path}" />'
                : '',
          ).join('')}
          ${usedExtensions.map(
            (e) => extLetterCode.containsKey(e)
                ? [
                    '<path stroke="none" id="${e}_ext_up" d="${extLetterCode[e]!.up}" />',
                    '<path stroke="none" id="${e}_ext_diag" d="${extLetterCode[e]!.diag}" />',
                    '<path stroke="none" id="${e}_ext_left" d="${extLetterCode[e]!.left}" />',
                  ].join('')
                : '',
          ).join('')}
        </defs>
        <rect x="0" y="0" height="$baseHeight" width="$baseWidth" style="fill: transparent" />
        ${charImages.join('\n')}
      </svg>''',
      width: MediaQuery.of(context).size.width - 32,
    );
  }
}

double getSecondaryWidth(Secondary secondary) {
  final Secondary(core: coreStr, start: startStr, end: endStr) = secondary;
  final Core core = coreLetterCode[coreStr]!;
  final Extensions? topExts = extLetterCode[startStr];
  final Extensions? bottomExts = extLetterCode[endStr];

  final (coreLeft, coreRight) = getCoreBoundary(core.path);
  final (topExtLeft, topExtRight) = getExtensionBoundary(topExts, core.top.orientation);
  final (bottomExtLeft, bottomExtRight) = getExtensionBoundary(bottomExts, core.bottom.orientation);

  final left = [coreLeft, core.top.x + topExtLeft, core.top.x + bottomExtLeft].reduce(min);
  final right = [coreRight, core.top.x + topExtRight, core.top.x + bottomExtRight].reduce(max);

  return right - left;
}

(double, double) getCoreBoundary(String path) {
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
