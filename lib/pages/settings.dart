import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ithkuil_helper/pages/communities.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(title: const Text("Settings")),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 0, 8),
          child: Text(
            "Import Lexicon",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.cloud_download),
          title: const Text("Github"),
          subtitle: Text(
            "Fetch from the repository on Github",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const AlertDialog(
              title: Text("WIP"),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.upload_file),
          title: const Text("File"),
          subtitle: Text(
            "Import from local files",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['json'],
              withData: true,
            );

            if (result == null) return;
            final bytes = result.files.single.bytes;
            if (bytes == null) return;
            final text = utf8.decode(bytes);
            List<dynamic> decodedJson;
            try {
              decodedJson = jsonDecode(text);
            } catch (e) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Error"),
                    content: Text("Invalid JSON file (${e.runtimeType})"),
                  ),
                );
              }
              return;
            }
            List<Root> lexicon = decodedJson.map((root) => Root.fromJson(root)).toList();
            if (context.mounted) {
              await Provider.of<LexiconModel>(context, listen: false).database.init(lexicon);
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
        Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 0, 8),
          child: Text(
            "Others",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text("Communities"),
          subtitle: Text(
            "List of Ithkuil communities",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CommunitiesPage()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text("About"),
          subtitle: Text(
            "1.0.0 (dev)",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const AlertDialog(
              title: Text("WIP"),
            ),
          ),
        ),
      ],
    );
  }
}
