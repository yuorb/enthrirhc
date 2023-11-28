import 'package:enthrirch/libs/ithkuil/writing/primary/formative.dart';
import 'package:enthrirch/libs/ithkuil/writing/primary/mod.dart';
import 'package:enthrirch/libs/ithkuil/writing/quarternary/slot_ix.dart';
import 'package:enthrirch/libs/ithkuil/writing/quarternary/mod.dart';
import 'package:enthrirch/libs/ithkuil/writing/secondary/affixes.dart';
import 'package:enthrirch/libs/ithkuil/writing/secondary/core_letter.dart';
import 'package:enthrirch/libs/ithkuil/writing/secondary/ext_letter.dart';
import 'package:enthrirch/libs/ithkuil/writing/secondary/mod.dart';
import 'package:enthrirch/libs/ithkuil/writing/tertiary/extensions.dart';
import 'package:enthrirch/libs/ithkuil/writing/tertiary/mod.dart';
import 'package:flutter/material.dart';

import 'package:enthrirch/components/ithkuil_svg.dart';

import '../libs/ithkuil/terms/mod.dart';

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
              plexity: Plexity.u,
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
              top: AspectExtension(Aspect.atp),
              bottom: AspectExtension(Aspect.atp),
              level: Level(
                comparison: Comparison.absolute,
                comparisonOperator: ComparisonOperator.equ,
              ),
            ),
            Quarternary(VerbSlotIX(
              illocution: Illocution.dec,
              validation: Validation.ima,
            )),
          ],
        ),
      ],
    );
  }
}
