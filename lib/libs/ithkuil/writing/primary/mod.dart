import 'package:enthrirhc/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhc/libs/ithkuil/writing/primary/component_a.dart';
import 'package:enthrirhc/libs/ithkuil/writing/primary/component_b.dart';
import 'package:enthrirhc/libs/ithkuil/writing/primary/component_c.dart';
import 'package:enthrirhc/libs/ithkuil/writing/primary/component_d.dart';
import 'package:enthrirhc/libs/ithkuil/writing/primary/utils.dart';

import '../../terms/mod.dart';
import '../utils.dart';

class Primary with Character {
  final Specification specification;
  final Context context;
  final ConcatenationStatus formativeType;
  // Properties for A Anchor
  final Essence essence;
  final Affiliation affiliation;
  // Properties for B Anchor
  final Perspective perspective;
  final Extension extension;
  // Properties for C Anchor
  final Separability? separability;
  final Similarity? similarity;
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
    this.separability,
    this.similarity,
    required this.function,
    required this.version,
    required this.plexity,
    required this.stem,
  });

  ComponentA componentA() {
    return ComponentA(essence: essence, affiliation: affiliation);
  }

  ComponentB componentB() {
    return ComponentB(perspective: perspective, extension: extension);
  }

  ComponentC componentC() {
    return ComponentC(separability: separability, similarity: similarity);
  }

  ComponentD componentD() {
    return ComponentD(
      function: function,
      version: version,
      plexity: plexity,
      stem: stem,
    );
  }

  bool isOmittable() {
    return specification == Specification.bsc &&
        context == Context.exs &&
        essence == Essence.nrm &&
        affiliation == Affiliation.csl &&
        perspective == Perspective.m &&
        extension == Extension.del &&
        separability == null &&
        similarity == null &&
        plexity == Plexity.u &&
        function == Function$.sta &&
        version == Version.prc &&
        stem == Stem.s1;
  }

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getPrimaryBoundary(this);
    final double width = right - left;
    final String topId = context.name;
    final String bottomId = formativeType.id();
    final double specificationX = baseX - left;
    final double specificationY = baseY;
    final double topX = specificationX + specification.centerX();
    final double topY = specificationY - unitHeight * 2;
    final double bottomX = specificationX + specification.centerX();
    final double bottomY = specificationY + unitHeight * 2;
    final double anchorAX = specificationX + specification.centerX();
    final double anchorAY = specificationY - 5;
    final double anchorBX = specificationX + specification.bAnchor().x;
    final double anchorBY = specificationY + specification.bAnchor().y;
    final double anchorCX = specificationX + specification.centerX();
    final double anchorCY = specificationY + 5;
    final double anchorDX = specificationX + specification.dAnchor().x;
    final double anchorDY = specificationY + specification.dAnchor().y;
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

class PrimaryOmitted with Character {
  final Relation relation;

  const PrimaryOmitted(this.relation);

  @override
  (String, double) getSvg(double baseX, double baseY, String fillColor) {
    final (left, right) = getExtensionBoundary(relation.path());
    final double width = right - left;
    final String id = relation.id();
    final double relationX = baseX - left;
    final double relationY = baseY;
    return (
      '''
        <use href="#$id" x="$relationX" y="$relationY" fill="$fillColor" />
      ''',
      width,
    );
  }
}
