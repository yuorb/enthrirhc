import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'character/mod.dart';
import 'character/primary/bAnchor.dart';
import 'utils.dart';

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
    final String fillColor = colorToHex(Theme.of(context).textTheme.titleLarge!.color!);
    // final String fillColor = "#e6e1e6";

    final usedSpecifications =
        characters.whereType<Primary>().map((s) => s.specification).toSet().toList();
    final List<(String, String)> usedPerspectiveExtension = characters
        .whereType<Primary>()
        .map(
          (s) => (
            '${s.perspective.name}_${s.extension.name}',
            perspectiveExtensionData[s.perspective.name]![s.extension.name]!
          ),
        )
        .toSet()
        .toList();
    final List<(String, String)> usedExtensions = characters
        .whereType<Secondary>()
        .map<List<(String, String)?>>((s) {
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
      if (character is Primary) {
        final (svgString, svgWidth) = character.getSvg(leftCoord, baseHeight, fillColor);
        charImages.add(svgString);
        leftCoord += svgWidth + horizontalGap;
      } else if (character is Secondary) {
        final (svgString, svgWidth) = character.getSvg(leftCoord, baseHeight, fillColor);
        charImages.add(svgString);
        leftCoord += svgWidth + horizontalGap;
      }
    }
    final baseWidth = leftCoord - horizontalGap + horizontalPadding;

    return SvgPicture.string(
      '''<svg width="$baseWidth" height="$baseHeight">
        <defs>
          ${usedPerspectiveExtension.map(
            (e) => '<path stroke="none" id="${e.$1}" d="${e.$2}" />',
          ).join('')}
          ${usedSpecifications.map(
            (e) => '<path stroke="none" id="${e.name}" d="${e.path}" />',
          ).join('')}
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
