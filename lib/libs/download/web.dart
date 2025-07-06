import 'dart:convert' show utf8;

import 'package:web/web.dart' as web;

// ignore: body_might_complete_normally_nullable
Future<String?> saveTextFile(String text, String filename) async {
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor
    ..href =
        '${Uri.dataFromString(text, mimeType: 'text/plain', encoding: utf8)}'
    ..download = filename
    ..style.display = 'none'
    ..click();
}
