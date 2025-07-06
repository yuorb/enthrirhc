import 'package:enthrirhc/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhc/libs/ithkuil/writing/secondary/core_letter.dart';
import 'package:enthrirhc/libs/ithkuil/writing/secondary/ext_letter.dart';
import 'package:enthrirhc/libs/ithkuil/writing/secondary/utils.dart';
import 'package:enthrirhc/libs/ithkuil/terms/mod.dart';

import '../utils.dart';

sealed class Secondary {
  final ExtLetter? start;
  final CoreLetter core;
  final ExtLetter? end;

  const Secondary({required this.start, required this.core, required this.end});

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
      AnchorType.diag => start?.diag,
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
      AnchorType.diag => end?.diag,
    };
  }
}

class RootSecondary extends Secondary with Character {
  ConcatenationStatus? formativeType;
  RootSecondary({
    required super.start,
    required super.core,
    required super.end,
    this.formativeType,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getSecondaryBoundary(this);
    final coreX = baseX - left;
    final coreY = baseY;
    final extStartX = coreX + core.startAnchor.coord.x;
    final extStartY = coreY + core.startAnchor.coord.y;
    final extEndX = coreX + core.endAnchor.coord.x + 0;
    final extEndY = coreY + core.endAnchor.coord.y + 0;

    final topId = formativeType?.idTopSecondary();
    final bottomId = formativeType?.idBottomSecondary();
    final secondaryWidth = right - left;

    final (coreLeft, coreRight) = getCoreBoundary(core.path);
    final coreWidth = coreRight - coreLeft;
    final centerX = coreX + coreWidth / 2;

    return (
      [
        '<use href="#${core.id()}" x="$coreX" y="$coreY" fill="$fillColor" />',
        start != null
            ? '''<use
              href="#${start!.phoneme.defaultLetter()}_ext_${core.startAnchor.orientation.type}"
              x="$extStartX"
              y="$extStartY" 
              transform="rotate(${core.startAnchor.getRotation()}, $extStartX, $extStartY)"
              fill="$fillColor"
            />'''
            : '',
        end != null
            ? '''<use
              href="#${end!.phoneme.defaultLetter()}_ext_${core.endAnchor.orientation.type}"
              x="$extEndX"
              y="$extEndY"
              transform="rotate(${core.endAnchor.getRotation()}, $extEndX, $extEndY)"
              fill="$fillColor"
            />'''
            : '',
        topId != null
            ? '<use href="#$topId" x="$centerX" y="${coreY - unitHeight * 2}" fill="$fillColor" />'
            : '',
        bottomId != null
            ? '<use href="#$bottomId" x="$centerX" y="${coreY + unitHeight * 2}" fill="$fillColor" />'
            : '',
      ].join(''),
      secondaryWidth,
    );
  }
}

class CsVxAffix extends Secondary with Character {
  final Affix affix;

  const CsVxAffix({
    required super.start,
    required super.core,
    required super.end,
    required this.affix,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (secondaryLeft, secondaryRight) = getSecondaryBoundary(this);
    final (coreLeft, coreRight) = getCoreBoundary(core.path);
    final coreX = baseX - secondaryLeft;
    final coreY = baseY;
    final extStartX = coreX + core.startAnchor.coord.x;
    final extStartY = coreY + core.startAnchor.coord.y;
    final extEndX = coreX + core.endAnchor.coord.x + 0;
    final extEndY = coreY + core.endAnchor.coord.y + 0;
    final topY = coreY - unitHeight * 2;
    final bottomY = coreY + unitHeight * 2;
    final secondaryWidth = secondaryRight - secondaryLeft;
    final coreWidth = coreRight - coreLeft;
    final coreCenterX = coreX + coreWidth / 2;

    return (
      '''
      <use href="#${core.id()}" x="$coreX" y="$coreY" fill="$fillColor" />
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
      <use href="#${affix.topId()}" x="$coreCenterX" y="$topY" fill="$fillColor" />
      <use href="#${affix.bottomId()}" x="$coreCenterX" y="$bottomY" fill="$fillColor" />
    ''',
      secondaryWidth,
    );
  }
}

class VxCsAffix extends Secondary with Character {
  final Affix affix;

  const VxCsAffix({
    required super.start,
    required super.core,
    required super.end,
    required this.affix,
  });

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (secondaryLeft, secondaryRight) = getSecondaryBoundary(this);
    final (coreLeft, coreRight) = getCoreBoundary(core.path);
    final coreWidth = coreRight - coreLeft;
    final centerX = baseX + (secondaryRight - secondaryLeft) / 2;
    final centerY = baseY;
    final coreX = baseX - secondaryLeft;
    final coreY = baseY;
    final extStartX = coreX + core.startAnchor.coord.x;
    final extStartY = coreY + core.startAnchor.coord.y;
    final extEndX = coreX + core.endAnchor.coord.x + 0;
    final extEndY = coreY + core.endAnchor.coord.y + 0;
    final topY = coreY - unitHeight * 2;
    final bottomY = coreY + unitHeight * 2;
    final secondaryWidth = secondaryRight - secondaryLeft;

    // Below variable is without transform, therefore it should be used outside the
    //`<g transform="180 xxx xxx">`.
    final coreCenterX = baseX + secondaryRight - coreWidth / 2;

    return (
      '''
      <g transform="rotate(180 $centerX $centerY)">
        <use href="#${core.id()}" x="$coreX" y="$coreY" fill="$fillColor" />
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
      </g>
      <use href="#${affix.topId()}" x="$coreCenterX" y="$topY" fill="$fillColor" />
      <use href="#${affix.bottomId()}" x="$coreCenterX" y="$bottomY" fill="$fillColor" />
    ''',
      secondaryWidth,
    );
  }
}
