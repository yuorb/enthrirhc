import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/primary/component_a.dart';
import 'package:enthrirch/common/character/primary/component_b.dart';
import 'package:enthrirch/common/character/primary/component_c.dart';
import 'package:enthrirch/common/character/primary/component_d.dart';
import 'package:enthrirch/common/character/primary/formative.dart';
import 'package:enthrirch/common/character/primary/specification.dart';
import 'package:enthrirch/common/character/primary/top.dart';
import 'package:enthrirch/common/character/primary/utils.dart';

class Primary with Character {
  final Specification specification;
  final Context context;
  final Formative formativeType;
  // Properties for A Anchor
  final Essence essence;
  final Affiliation affiliation;
  // Properties for B Anchor
  final Perspective perspective;
  final Extension extension;
  // Properties for C Anchor
  final Separability separability;
  final Similarity similarity;
  // Properties for D Anchor
  final Function$ function;
  final Version version;
  final Plexity plexity;
  final Stem stem;

  const Primary({
    required this.specification,
    required this.context,
    required this.formativeType,
    required this.essence,
    required this.affiliation,
    required this.perspective,
    required this.extension,
    required this.separability,
    required this.similarity,
    required this.function,
    required this.version,
    required this.plexity,
    required this.stem,
  });

  ComponentA componentA() {
    return ComponentA(
      essence: essence,
      affiliation: affiliation,
    );
  }

  ComponentB componentB() {
    return ComponentB(
      perspective: perspective,
      extension: extension,
    );
  }

  ComponentC componentC() {
    return ComponentC(
      separability: separability,
      similarity: similarity,
    );
  }

  ComponentD componentD() {
    return ComponentD(
      function: function,
      version: version,
      plexity: plexity,
      stem: stem,
    );
  }

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getPrimaryBoundary(this);
    final width = right - left;
    final topId = context.name;
    final bottomId = formativeType.id();
    final specificationX = baseX - left;
    final specificationY = baseY;
    final topX = specificationX + specification.centerX;
    final topY = specificationY - unitHeight * 2;
    final bottomX = specificationX + specification.centerX;
    final bottomY = specificationY + unitHeight * 2;
    final anchorAX = specificationX + specification.centerX;
    final anchorAY = specificationY - 5;
    final anchorBX = specificationX + specification.bAnchor.x;
    final anchorBY = specificationY + specification.bAnchor.y;
    final anchorCX = specificationX + specification.centerX;
    final anchorCY = specificationY + 5;
    final anchorDX = specificationX + specification.dAnchor.x;
    final anchorDY = specificationY + specification.dAnchor.y;
    return (
      '''
        <use href="#${specification.name}" x="$specificationX" y="$specificationY" fill="$fillColor" />
        <use href="#$topId" x="$topX" y="$topY" fill="$fillColor" />
        <use href="#$bottomId" x="$bottomX" y="$bottomY" fill="$fillColor" />
        <use href="#${componentA().id()}" x="$anchorAX" y="$anchorAY" fill="$fillColor" />
        <use href="#${componentB().id()}" x="$anchorBX" y="$anchorBY" fill="$fillColor" />
        <use href="#${componentC().id()}" x="$anchorCX" y="$anchorCY" fill="$fillColor" />
        <use href="#${componentD().id()}" x="$anchorDX" y="$anchorDY" fill="$fillColor" />
      ''',
      width,
    );
  }
}
