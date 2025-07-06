import 'dart:convert' show utf8;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show AnchorElement;

// ignore: body_might_complete_normally_nullable
Future<String?> saveTextFile(String text, String filename) async {
  AnchorElement()
    ..href =
        '${Uri.dataFromString(text, mimeType: 'text/plain', encoding: utf8)}'
    ..download = filename
    ..style.display = 'none'
    ..click();
}
