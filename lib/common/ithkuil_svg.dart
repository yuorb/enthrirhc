import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'character/mod.dart';

class IthkuilSvg extends StatelessWidget {
  final List<Character> characters;

  const IthkuilSvg(this.characters, {super.key});

  @override
  Widget build(BuildContext context) {
    // 1 unit height = 35
    // core letter height = 2 unit height = 70
    // full letter height = 4 unit height = 140
    // full letter with padding height = 6 unit height = 210
    const double baseHeight = 140;
    const double horizontalPadding = 20;
    const double horizontalGap = 10;
    const String fillColor = "white";

    final List<(String, String)> usedExtensions = characters
        .map<List<(String, String)?>>((s) {
          if (s is Secondary) {
            final start = s.start;
            final end = s.end;
            return [
              start != null
                  ? (
                      "${start.phoneme.romanizedLetters[0]}_ext_${s.startAnchor.orientation.filename}",
                      start.path
                    )
                  : null,
              end != null
                  ? (
                      "${end.phoneme.romanizedLetters[0]}_ext_${s.endAnchor.orientation.filename}",
                      end.path
                    )
                  : null
            ];
          } else {
            return [];
          }
        })
        .expand((element) => element)
        .whereType<(String, String)>()
        .toSet()
        .toList();
    final usedCores = characters.whereType<Secondary>().map((s) => s.core).toSet().toList();

    List<String> charImages = [];
    double leftCoord = horizontalPadding;
    for (int i = 0; i < characters.length; i++) {
      final character = characters[i];
      if (character is Secondary) {
        final (svgString, svgWidth) = character.getSvg(leftCoord, baseHeight, fillColor);
        charImages.add(svgString);
        leftCoord += svgWidth + horizontalGap;
      }
    }
    final baseWidth = leftCoord - horizontalGap + horizontalPadding;

    return SvgPicture.string(
      '''<svg width="$baseWidth" height="$baseHeight">
        <defs>
          ${usedCores.map(
            (e) =>
                '<path stroke="none" id="${e.phoneme.romanizedLetters[0]}_core" d="${e.path}" />',
          ).join('')}
          ${usedExtensions.map(
            (e) => '<path stroke="none" id="${e.$1}" d="${e.$2}" />',
          ).join('')}
        </defs>
        <rect x="0" y="0" height="$baseHeight" width="$baseWidth" style="fill: transparent" />
        ${charImages.join('\n')}
      </svg>''',
      width: MediaQuery.of(context).size.width - 32,
    );
  }
}
