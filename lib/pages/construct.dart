import 'package:enthrirch/common/character/primary/specification.dart';
import 'package:flutter/material.dart';

import 'package:enthrirch/common/character/mod.dart';
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
              specification: Specification.constitutive,
            ),
            Secondary.from("zvw")!,
            Secondary.from("zxr")!,
            Secondary.from("chç")!,
            Secondary.from("žčš")!,
          ],
        ),
      ],
    );
  }
}
