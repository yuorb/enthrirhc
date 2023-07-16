import 'package:flutter/material.dart';

import '../common/ithkuil_svg.dart';

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
            Secondary.from("bp_"),
            Secondary.from("_tn"),
            Secondary.from("_k_"),
            Secondary.from("žčš"),
          ],
        ),
      ],
    );
  }
}
