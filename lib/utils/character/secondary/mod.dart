import 'package:enthrirch/utils/character/mod.dart';
import 'package:enthrirch/utils/character/secondary/core_letter.dart';
import 'package:enthrirch/utils/character/secondary/ext_letter.dart';
import 'package:enthrirch/utils/character/secondary/utils.dart';

import '../../ithkuil/terms/degree.dart';
import 'affixes.dart';

sealed class Secondary {
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
}

class Root extends Secondary with Character {
  const Root({required super.start, required super.core, required super.end});

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
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
      <use href="#${core.phoneme.defaultLetter()}_core" x="$coreX" y="$coreY" fill="$fillColor" />
      ${start != null ? '''<use
        href="#${start!.phoneme.defaultLetter()}_ext_${core.startAnchor.orientation.type}"
        x="$extStartX"
        y="$extStartY" 
        transform="rotate(${core.startAnchor.getRotation()}, $extStartX, $extStartY)"
        fill="$fillColor"
      />''' : ''}
      ${end != null ? '''<use
        href="#${end!.phoneme.defaultLetter()}_ext_${core.endAnchor.orientation.type}"
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

class CsVxAffixes extends Secondary with Character {
  final Degree degree;
  final AffixType affixType;

  const CsVxAffixes({
    required super.start,
    required super.core,
    required super.end,
    required this.degree,
    required this.affixType,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final secondaryBoundary = getSecondaryBoundary(this);
    final coreX = baseX - secondaryBoundary.$1;
    final coreY = baseY;
    final extStartX = coreX + core.startAnchor.coord.x;
    final extStartY = coreY + core.startAnchor.coord.y;
    final extEndX = coreX + core.endAnchor.coord.x + 0;
    final extEndY = coreY + core.endAnchor.coord.y + 0;
    final topX = baseX + (secondaryBoundary.$2 - secondaryBoundary.$1) / 2;
    final topY = coreY - unitHeight * 2;
    final bottomX = baseX + (secondaryBoundary.$2 - secondaryBoundary.$1) / 2;
    final bottomY = coreY + unitHeight * 2;

    final secondaryWidth = secondaryBoundary.$2 - secondaryBoundary.$1;
    return (
      '''
      <use href="#${core.phoneme.defaultLetter()}_core" x="$coreX" y="$coreY" fill="$fillColor" />
      ${start != null ? '''<use
        href="#${start!.phoneme.defaultLetter()}_ext_${core.startAnchor.orientation.type}"
        x="$extStartX"
        y="$extStartY" 
        transform="rotate(${core.startAnchor.getRotation()}, $extStartX, $extStartY)"
        fill="$fillColor"
      />''' : ''}
      ${end != null ? '''<use
        href="#${end!.phoneme.defaultLetter()}_ext_${core.endAnchor.orientation.type}"
        x="$extEndX"
        y="$extEndY"
        transform="rotate(${core.endAnchor.getRotation()}, $extEndX, $extEndY)"
        fill="$fillColor"
      />''' : ''}
      <use href="#affix_type_${affixType.name}" x="$topX" y="$topY" fill="$fillColor" />
      <use href="#degree_${degree.name}" x="$bottomX" y="$bottomY" fill="$fillColor" />
    ''',
      secondaryWidth
    );
  }
}

class VxCsAffixes extends Secondary with Character {
  final Degree degree;
  final AffixType affixType;

  const VxCsAffixes({
    required super.start,
    required super.core,
    required super.end,
    required this.degree,
    required this.affixType,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final secondaryBoundary = getSecondaryBoundary(this);
    final centerX = baseX + (secondaryBoundary.$2 - secondaryBoundary.$1) / 2;
    final centerY = baseY;
    final coreX = baseX - secondaryBoundary.$1;
    final coreY = baseY;
    final extStartX = coreX + core.startAnchor.coord.x;
    final extStartY = coreY + core.startAnchor.coord.y;
    final extEndX = coreX + core.endAnchor.coord.x + 0;
    final extEndY = coreY + core.endAnchor.coord.y + 0;
    final topY = coreY - unitHeight * 2;
    final bottomY = coreY + unitHeight * 2;

    final secondaryWidth = secondaryBoundary.$2 - secondaryBoundary.$1;
    return (
      '''
      <use href="#${core.phoneme.defaultLetter()}_core" x="$coreX" y="$coreY" transform="rotate(180 $centerX $centerY)" fill="$fillColor" />
      ${start != null ? '''<g transform="rotate(180 $centerX $centerY)">
        <use
          href="#${start!.phoneme.defaultLetter()}_ext_${core.startAnchor.orientation.type}"
          x="$extStartX"
          y="$extStartY" 
          transform="rotate(${core.startAnchor.getRotation()}, $extStartX, $extStartY)"
          fill="$fillColor"
        />
      </g>''' : ''}
      ${end != null ? '''<g transform="rotate(180 $centerX $centerY)">
        <use
          href="#${end!.phoneme.defaultLetter()}_ext_${core.endAnchor.orientation.type}"
          x="$extEndX"
          y="$extEndY"
          transform="rotate(${core.endAnchor.getRotation()}, $extEndX, $extEndY)"
          fill="$fillColor"
        />
      </g>''' : ''}
      <use href="#affix_type_${affixType.name}" x="$centerX" y="$topY" fill="$fillColor" />
      <use href="#degree_${degree.name}" x="$centerX" y="$bottomY" fill="$fillColor" />
    ''',
      secondaryWidth
    );
  }
}
