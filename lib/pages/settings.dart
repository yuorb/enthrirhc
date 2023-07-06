import 'package:flutter/material.dart';
import 'package:enthrirch/pages/communities.dart';

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
