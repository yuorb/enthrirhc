import 'package:flutter/material.dart';
import 'package:ithkuil_helper/common/types.dart';

class RootPage extends StatefulWidget {
  final Root root;

  const RootPage(this.root, {super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.root.root),
      ),
      body: const Center(
        child: Text('Work In Progress'),
      ),
    );
  }
}
