import 'package:enthrirch/common/character/primary/mod.dart';
import 'package:enthrirch/common/character/primary/top.dart';
import 'package:enthrirch/common/character/quarternary/bottom.dart';
import 'package:enthrirch/common/character/quarternary/mod.dart';
import 'package:enthrirch/common/character/quarternary/top.dart';
import 'package:enthrirch/common/character/secondary/letter.dart';
import 'package:enthrirch/common/character/secondary/mod.dart';
import 'package:enthrirch/common/character/tertiary/extensions.dart';
import 'package:enthrirch/common/character/tertiary/mod.dart';
import 'package:enthrirch/common/character/tertiary/valence.dart';
import 'package:flutter/material.dart';

import 'package:enthrirch/common/character/primary/component_a.dart';
import 'package:enthrirch/common/character/primary/component_b.dart';
import 'package:enthrirch/common/character/primary/component_c.dart';
import 'package:enthrirch/common/character/primary/component_d.dart';
import 'package:enthrirch/common/character/primary/specification.dart';
import 'package:enthrirch/common/ithkuil_svg.dart';

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
        IthkuilSvg(
          [
            const Primary(
              specification: Specification.cte,
              context: Context.fnc,
              essence: Essence.rpv,
              affiliation: Affiliation.var$,
              perspective: Perspective.m,
              extension: Extension.prx,
              similarity: Similarity.d,
              separability: Separability.s,
              function: Function$.sta,
              version: Version.prc,
              plexity: Plexity.um,
              stem: Stem.s1,
            ),
            Secondary(
              Phoneme.b,
              Phoneme.placeholder,
              Phoneme.c,
            ),
            const Tertiary(
              valence: Valence.mno,
              top: TertiaryExtension.aspectPrs,
              bottom: TertiaryExtension.aspectAtp,
            ),
            const Quarternary(
              top: QuarternaryTop.spatioTemporal2,
              bottom: QuarternaryBottom.ima,
            ),
          ],
        ),
      ],
    );
  }
}
