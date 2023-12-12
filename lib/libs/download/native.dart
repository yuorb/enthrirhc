import 'dart:io' hide Platform;

import 'package:enthrirhs/utils/mod.dart';
import 'package:path_provider/path_provider.dart';

import 'utils.dart';

Future<String?> saveTextFile(String text, String filename) async {
  final (name, ext) = parseFilename(filename);
  final path = Platform.get() == Platform.android
      ? '/storage/emulated/0/Download'
      : (await getDownloadsDirectory())!.path;
  File file;
  final file0 = File('$path/$filename');
  if (!await file0.exists()) {
    file = file0;
  } else {
    int i = 1;
    while (true) {
      final thisFile = File('$path/$name ($i).$ext');
      if (await thisFile.exists()) {
        i++;
        continue;
      } else {
        file = thisFile;
        break;
      }
    }
  }
  await file.create();
  await file.writeAsString(text);
  return file.path;
}
