import 'package:flutter/material.dart';

class ListGroupTitle extends StatelessWidget {
  final String title;
  const ListGroupTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 0, 8),
      child: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
