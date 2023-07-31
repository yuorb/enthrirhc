import 'package:enthrirch/common/character/primary/top.dart';
import 'package:enthrirch/common/character/quarternary/mod.dart';
import 'package:flutter/material.dart';

import 'package:enthrirch/common/character/mod.dart';
import 'package:enthrirch/common/character/primary/a_anchor.dart';
import 'package:enthrirch/common/character/primary/b_anchor.dart';
import 'package:enthrirch/common/character/primary/c_anchor.dart';
import 'package:enthrirch/common/character/primary/d_anchor.dart';
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
            Secondary.from("zčw")!,
            Secondary.from("clš")!,
            const Quarternary(top: QuarternaryTop.cnj),
          ],
        ),
      ],
    );
  }
}
