import 'package:flutter/material.dart';

dynamic tryParseString(String str) {
  try {
    return double.parse(str);
  } catch (e) {
    return str;
  }
}

String colorToHex(Color color) {
  return "#${color.toString().substring(10, 16)}";
}

extension StringExtension on String {
  String capitalize() => this == '' ? '' : "${this[0].toUpperCase()}${substring(1)}";
  String addPeriod() => "$this.";
}

Future<void> showErrorDialog(BuildContext context, String title) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      title: const Text("Error"),
      content: Text(title),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.errorContainer,
            ),
          ),
          child: Text(
            "Ok",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        )
      ],
    ),
  );
}

class Coord {
  final double x;
  final double y;

  const Coord(this.x, this.y);
}
