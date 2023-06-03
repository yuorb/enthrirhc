import 'package:flutter/material.dart';

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
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
            title: Text("WIP"),
          ),
        ),
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
