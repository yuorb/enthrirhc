import 'package:flutter/material.dart';
import '../ffi.dart' if (dart.library.html) 'ffi_web.dart';

class ConstructPage extends StatefulWidget {
  const ConstructPage({super.key});

  @override
  State<ConstructPage> createState() => _ConstructPageState();
}

class _ConstructPageState extends State<ConstructPage> {
  @override
  Widget build(BuildContext context) {
    // api.
    return Column(
      children: [
        AppBar(title: const Text("Construct")),
        const SizedBox(height: 16),
        // IthkuilSvg(
        //   [
        //     const Primary(
        //       specification: Specification.cte,
        //       context: Context.fnc,
        //       essence: Essence.rpv,
        //       affiliation: Affiliation.var$,
        //       perspective: Perspective.m,
        //       extension: Extension.prx,
        //       similarity: Similarity.d,
        //       separability: Separability.s,
        //       function: Function$.sta,
        //       version: Version.prc,
        //       plexity: Plexity.um,
        //       stem: Stem.s1,
        //     ),
        //     Secondary(
        //       Phoneme.b,
        //       Phoneme.placeholder,
        //       Phoneme.c,
        //     ),
        //     const Tertiary(
        //       valence: Valence.mno,
        //       top: TertiaryExtension.aspectPrs,
        //       bottom: TertiaryExtension.aspectAtp,
        //     ),
        //     const Quarternary(
        //       top: QuarternaryTop.spatioTemporal2,
        //       bottom: QuarternaryBottom.ima,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
