import '../terms/mod.dart';

import 'primary/mod.dart';
import 'quarternary/mod.dart';
import 'secondary/mod.dart';
import 'tertiary/mod.dart';

const double unitHeight = 35;

mixin Character {
  (String, double) getSvg(double baseX, double baseY, String fillColor);
}

const double verticalPadding = unitHeight;
const double horizontalPadding = 20;
const double horizontalGap = 10;

(String, (double, double)) ithkuilWriting(
  List<Character> characters, {
  String fillColor = "#000000",
  String staffColor = "#cccccc",
  String backgroundColor = "transparent",
}) {
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
  for (final p in characters.whereType<PrimaryOmitted>()) {
    usedRadicals[p.relation.id()] = p.relation.path();
  }
  final secondaries = characters.whereType<Secondary>();
  for (final s in secondaries) {
    usedRadicals[s.core.id()] = s.core.path;
    if (s.start != null) {
      usedRadicals[s.getStartExtId()!] = s.getStartExtPath()!;
    }
    if (s.end != null) {
      usedRadicals[s.getEndExtId()!] = s.getEndExtPath()!;
    }
  }
  for (final s in secondaries.whereType<RootSecondary>()) {
    final formativeType = s.formativeType;
    if (formativeType != null) {
      usedRadicals[formativeType.idTopSecondary()] = formativeType
          .pathTopSecondary();
      final bottomId = formativeType.idBottomSecondary();
      if (bottomId != null) {
        usedRadicals[bottomId] = formativeType.pathBottomSecondary()!;
      }
    }
  }
  for (final s in secondaries.whereType<CsVxAffix>()) {
    usedRadicals[s.affix.bottomId()] = s.affix.bottomPath();
    usedRadicals[s.affix.topId()] = s.affix.topPath();
  }
  for (final s in secondaries.whereType<VxCsAffix>()) {
    usedRadicals[s.affix.bottomId()] = s.affix.bottomPath();
    usedRadicals[s.affix.topId()] = s.affix.topPath();
  }
  for (final t in characters.whereType<Tertiary>()) {
    usedRadicals["valence_${t.valence.name}"] = t.valence.path();
    if (t.top != null) {
      usedRadicals[t.top!.id()] = t.top!.path();
    }
    if (t.bottom != null) {
      usedRadicals[t.bottom!.id()] = t.bottom!.path();
    }
    if (t.level != null) {
      final id = "level_${t.level!.comparisonOperator.name}";
      final path = t.level!.comparisonOperator.path();
      usedRadicals[id] = path;
    }
  }
  final quarternaries = characters.whereType<Quarternary>();
  for (final q in quarternaries) {
    switch (q.formativeType) {
      case NoConcatenation(relation: final relation):
        switch (relation) {
          case Noun noun:
            usedRadicals[noun.case$.caseType.idQuaternary()] = noun
                .case$
                .caseType
                .pathQuaternary();
            usedRadicals[noun.case$.caseNumber.idQuaternary()] = noun
                .case$
                .caseNumber
                .pathQuaternary();
          case FramedVerb framedVerb:
            usedRadicals[framedVerb.case$.caseType.idQuaternary()] = framedVerb
                .case$
                .caseType
                .pathQuaternary();
            usedRadicals[framedVerb.case$.caseNumber.idQuaternary()] =
                framedVerb.case$.caseNumber.pathQuaternary();
          case UnframedVerb verb:
            usedRadicals[verb.illocution.idQuaternary()] = verb.illocution
                .pathQuaternary();
            if (verb.validation != null) {
              usedRadicals[verb.validation!.idQuaternary()] = verb.validation!
                  .pathQuaternary();
            }
        }
      case Type1Concatenation(format: final format) ||
          Type2Concatenation(format: final format):
        usedRadicals[format.caseType.idQuaternary()] = format.caseType
            .pathQuaternary();
        usedRadicals[format.caseNumber.idQuaternary()] = format.caseNumber
            .pathQuaternary();
    }

    usedRadicals[q.cn.id()] = q.cn.path();
  }
  if (quarternaries.isNotEmpty) {
    usedRadicals["quarternary_core"] = corePath;
  }

  List<String> charImages = [];
  double leftCoord = horizontalPadding;
  for (final character in characters) {
    const centerY = verticalPadding + unitHeight * 2;
    final (svgString, svgWidth) = character.getSvg(
      leftCoord,
      centerY,
      fillColor,
    );
    charImages.add(svgString);
    leftCoord += svgWidth + horizontalGap;
  }
  final baseWidth = leftCoord - horizontalGap + horizontalPadding;
  const minWidth = 210;

  const double scaleRatio = 2.0;
  final double width =
      (baseWidth < minWidth ? minWidth : baseWidth) * scaleRatio;
  const double height = (unitHeight * 6) * scaleRatio;

  return (
    '''<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="$height">
      <defs>
        ${usedRadicals.entries.map((e) => '<path stroke="none" id="${e.key}" d="${e.value}" />').join('\n')}
      </defs>
      <g transform="scale($scaleRatio $scaleRatio)">
        <rect x="0" y="0" height="${unitHeight * 6}" width="$width" style="fill: $backgroundColor" />
        <line x1="0" y1="${unitHeight * 1}" x2="$width" y2="${unitHeight * 1}" stroke="$staffColor" />
        <line x1="0" y1="${unitHeight * 2}" x2="$width" y2="${unitHeight * 2}" stroke="$staffColor" />
        <line x1="0" y1="${unitHeight * 3}" x2="$width" y2="${unitHeight * 3}" stroke="$staffColor" />
        <line x1="0" y1="${unitHeight * 4}" x2="$width" y2="${unitHeight * 4}" stroke="$staffColor" />
        <line x1="0" y1="${unitHeight * 5}" x2="$width" y2="${unitHeight * 5}" stroke="$staffColor" />
        <g transform="translate(${baseWidth < minWidth ? (minWidth - baseWidth) / 2 : 0} 0)">
          ${charImages.join('\n')}
        </g>
      </g>
    </svg>''',
    (width, height),
  );
}

extension OmitPrimaryCharacter on List<Character> {
  List<Character> omitPrimaryCharacter(bool omitOptionalCharacters) {
    if (omitOptionalCharacters && isNotEmpty) {
      switch (this[0]) {
        case Primary primary:
          if (primary.isOmittable()) {
            switch (primary.formativeType) {
              case NoConcatenation(relation: final relation):
                this[0] = PrimaryOmitted(relation);
                break;
              case _:
            }
          }
      }
    }
    return this;
  }
}
