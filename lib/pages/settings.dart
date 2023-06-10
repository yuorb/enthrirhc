import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../common/store.dart';
import '../common/types.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: const Icon(Icons.cloud_download),
        title: const Text("Fetch Lexicon JSON"),
        subtitle: const Text("Recommended"),
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
            title: Text("WIP"),
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.upload_file),
        title: const Text("Import Lexicon JSON"),
        subtitle: const Text("Alternative for users with Internet issues"),
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result == null) return;
          final bytes = result.files.single.bytes;
          if (bytes == null) return;
          final text = String.fromCharCodes(bytes);
          List<Root> lexicon = (jsonDecode(text) as List<dynamic>)
              .map((root) => Root.fromJson(root))
              .toList();
          if (context.mounted) {
            await Provider.of<LexiconModel>(context, listen: false)
                .database
                .init(lexicon);
          }
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Success"),
                content: Text(
                  "Imported ${lexicon.length.toString()} roots successfully.",
                ),
              ),
            );
          }
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text("About"),
        subtitle: const Text("1.0.0 (dev)"),
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
            title: Text("WIP"),
          ),
        ),
      ),
    ]);
  }
}
