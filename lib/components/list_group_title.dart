import 'package:flutter/material.dart';

class ListGroupTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const ListGroupTitle(this.title, {this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 0, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          trailing == null ? Container() : trailing!,
        ],
      ),
    );
  }
}
