import 'package:enthrirch/utils/character/primary/formative.dart';
import 'package:enthrirch/utils/character/primary/mod.dart';
import 'package:enthrirch/utils/character/quarternary/bottom.dart';
import 'package:enthrirch/utils/character/quarternary/mod.dart';
import 'package:enthrirch/utils/character/quarternary/top.dart';
import 'package:enthrirch/utils/character/secondary/affixes.dart';
import 'package:enthrirch/utils/character/secondary/core_letter.dart';
import 'package:enthrirch/utils/character/secondary/ext_letter.dart';
import 'package:enthrirch/utils/character/secondary/mod.dart';
import 'package:enthrirch/utils/character/tertiary/extensions.dart';
import 'package:enthrirch/utils/character/tertiary/level.dart';
import 'package:enthrirch/utils/character/tertiary/mod.dart';
import 'package:enthrirch/utils/character/tertiary/valence.dart';
import 'package:flutter/material.dart';

import 'package:enthrirch/utils/character/primary/component_d.dart';
import 'package:enthrirch/utils/character/primary/specification.dart';
import 'package:enthrirch/components/ithkuil_svg.dart';

import '../utils/ithkuil/terms/affiliation.dart';
import '../utils/ithkuil/terms/context.dart';
import '../utils/ithkuil/terms/degree.dart';
import '../utils/ithkuil/terms/essence.dart';
import '../utils/ithkuil/terms/extension.dart';
import '../utils/ithkuil/terms/function.dart';
import '../utils/ithkuil/terms/perspective.dart';
import '../utils/ithkuil/terms/separability.dart';
import '../utils/ithkuil/terms/similarity.dart';
import '../utils/ithkuil/terms/stem.dart';
import '../utils/ithkuil/terms/version.dart';

class ConstructPage extends StatefulWidget {
  const ConstructPage({super.key});

  @override
  State<ConstructPage> createState() => _ConstructPageState();
}

class _ConstructPageState extends State<ConstructPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: const Text("Construct")),
        const SizedBox(height: 16),
        const IthkuilSvg(
          [
            Primary(
              specification: Specification.cte,
              context: Context.rps,
              formativeType: Concatenated(Concatenation.type2),
              essence: Essence.rpv,
              affiliation: Affiliation.csl,
              perspective: Perspective.m,
              extension: Extension.prx,
              similarity: Similarity.d,
              separability: Separability.s,
              function: Function$.sta,
              version: Version.prc,
              plexity: Plexity.um,
              stem: Stem.s1,
            ),
            Root(
              start: ExtLetter.b,
              core: CoreLetter.placeholder,
              end: ExtLetter.c,
            ),
            CsVxAffixes(
              start: ExtLetter.d,
              core: CoreLetter.s,
              end: ExtLetter.k,
              degree: Degree.d1,
              affixType: AffixType.type2,
            ),
            VxCsAffixes(
              start: ExtLetter.d,
              core: CoreLetter.s,
              end: ExtLetter.k,
              degree: Degree.d2,
              affixType: AffixType.type3,
            ),
            Tertiary(
              valence: Valence.mno,
              top: TertiaryExtension.aspectAtp,
              bottom: TertiaryExtension.aspectAtp,
              level: Level(
                comparison: Comparison.absolute,
                comparisonOperator: ComparisonOperator.equ,
              ),
            ),
            Quarternary(
              top: QuarternaryTop.spatioTemporal2,
              bottom: QuarternaryBottom.ima,
            ),
          ],
        ),
      ],
    );
  }
}
