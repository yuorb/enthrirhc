import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic tryParseString(String str) {
  try {
    return double.parse(str);
  } catch (e) {
    return str;
  }
}

String colorToHex(Color color) {
  return "#${color.value.toRadixString(16).substring(2)}";
}

extension StringExtension on String {
  String capitalize() =>
      this == '' ? '' : "${this[0].toUpperCase()}${substring(1)}";
}

Future<void> showInfoDialog(BuildContext context, String content) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: const Text("Info"),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Ok"),
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String content) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      title: const Text("Error"),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.errorContainer,
            ),
          ),
          child: Text(
            "Ok",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    ),
  );
}

Future<bool> showConfirmDialog(BuildContext context, String content) async {
  final res = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      title: const Text("Confirm"),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text("Ok"),
        ),
      ],
    ),
  );
  if (res == null) {
    return false;
  }
  return res;
}

String escapeRegExp(String text) {
  return text.replaceAllMapped(
    RegExp(r"[-[\]{}()*+?.,\\^$|#\s]"),
    (m) => "\\${m[0]}",
  );
}

void copyToClipboard(String text, BuildContext context) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) return;
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('Copied to Clipboard')));
}

class Coord {
  final double x;
  final double y;

  const Coord(this.x, this.y);
}
