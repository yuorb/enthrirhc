import 'package:enthrirch/utils/character/primary/mod.dart';
import 'package:enthrirch/utils/character/secondary/mod.dart';
import 'package:enthrirch/utils/character/tertiary/mod.dart';
import 'package:enthrirch/utils/character/quarternary/mod.dart';
import 'package:enthrirch/libs/mod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/character/mod.dart';

const double verticalPadding = unitHeight;
const double horizontalPadding = 20;
const double horizontalGap = 10;

class IthkuilSvg extends StatelessWidget {
  final List<Character> characters;

  const IthkuilSvg(this.characters, {super.key});

  @override
  Widget build(BuildContext context) {
    final String fillColor = colorToHex(Theme.of(context).textTheme.titleLarge!.color!);
    // final String fillColor = "#e6e1e6";

    return SvgPicture.string(
      _generate(characters, fillColor),
      width: MediaQuery.of(context).size.width - 32,
    );
  }

  String _generate(List<Character> characters, String fillColor) {
    // 1 unit height = 35
    // core letter height = 2 unit height = 70
    // full letter height = 4 unit height = 140
    // full letter with padding height = 6 unit height = 210

    final Map<String, String> usedRadicals = {};
    for (final p in characters.whereType<Primary>()) {
      usedRadicals[p.specification.name] = p.specification.path();
      usedRadicals[p.context.name] = p.context.path();
      usedRadicals[p.formativeType.id()] = p.formativeType.path();
      usedRadicals[p.componentA().id()] = p.componentA().path();
      usedRadicals[p.componentB().id()] = p.componentB().path();
      usedRadicals[p.componentC().id()] = p.componentC().path();
      usedRadicals[p.componentD().id()] = p.componentD().path();
    }
    final secondaries = characters.whereType<Secondary>();
    for (final s in secondaries) {
      usedRadicals["${s.core.phoneme.defaultLetter()}_core"] = s.core.path;
      if (s.start != null) {
        usedRadicals[s.getStartExtId()!] = s.getStartExtPath()!;
      }
      if (s.end != null) {
        usedRadicals[s.getEndExtId()!] = s.getEndExtPath()!;
      }
    }
    for (final s in secondaries.whereType<CsVxAffixes>()) {
      usedRadicals["degree_${s.degree.name}"] = s.degree.path();
      usedRadicals["affix_type_${s.affixType.name}"] = s.affixType.path;
    }
    for (final s in secondaries.whereType<VxCsAffixes>()) {
      usedRadicals["degree_${s.degree.name}"] = s.degree.path();
      usedRadicals["affix_type_${s.affixType.name}"] = s.affixType.path;
    }
    for (final t in characters.whereType<Tertiary>()) {
      usedRadicals[t.top.name] = t.top.path;
      usedRadicals[t.bottom.name] = t.bottom.path;
      usedRadicals["valence_${t.valence.name}"] = t.valence.path();
      usedRadicals["level_${t.level.comparisonOperator.name}"] = t.level.comparisonOperator.path;
    }
    final quarternaries = characters.whereType<Quarternary>();
    for (final q in quarternaries) {
      usedRadicals["quarternary_${q.top.name}"] = q.top.path;
      usedRadicals["quarternary_${q.bottom.name}"] = q.bottom.path;
    }
    if (quarternaries.isNotEmpty) {
      usedRadicals["quarternary_core"] = corePath;
    }

    List<String> charImages = [];
    double leftCoord = horizontalPadding;
    for (final character in characters) {
      const centerY = verticalPadding + unitHeight * 2;
      final (svgString, svgWidth) = character.getSvg(leftCoord, centerY, fillColor);
      charImages.add(svgString);
      leftCoord += svgWidth + horizontalGap;
    }
    final baseWidth = leftCoord - horizontalGap + horizontalPadding;

    return '''<svg width="$baseWidth" height="${unitHeight * 6}">
      <defs>
        ${usedRadicals.entries.map(
              (e) => '<path stroke="none" id="${e.key}" d="${e.value}" />',
            ).join('\n')}
      </defs>
      <rect x="0" y="0" height="${unitHeight * 6}" width="$baseWidth" style="fill: transparent" />
      <line x1="0" y1="${unitHeight * 1}" x2="600" y2="${unitHeight * 1}" stroke="red" />
      <line x1="0" y1="${unitHeight * 2}" x2="600" y2="${unitHeight * 2}" stroke="red" />
      <line x1="0" y1="${unitHeight * 3}" x2="600" y2="${unitHeight * 3}" stroke="red" />
      <line x1="0" y1="${unitHeight * 4}" x2="600" y2="${unitHeight * 4}" stroke="red" />
      <line x1="0" y1="${unitHeight * 5}" x2="600" y2="${unitHeight * 5}" stroke="red" />
      ${charImages.join('\n')}
    </svg>''';
  }
}
