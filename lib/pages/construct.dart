import 'package:flutter/material.dart';

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
        const SizedBox(height: 268),
        const Text("Work In Progress"),
      ],
    );
  }
}
