import 'package:enthrirhs/utils/store.dart';
import 'package:enthrirhs/components/list_group_title.dart';
import 'package:flutter/material.dart';
import 'package:enthrirhs/pages/communities.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'about.dart';

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
        const ListGroupTitle("General"),
        Consumer<SettingsProvider>(
          builder: (context, theme, child) {
            return PopupMenuButton(
              initialValue: theme.darkTheme,
              onSelected: (int index) => theme.darkTheme = index,
              offset: const Offset(1, 0),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem(
                  value: 1,
                  child: Text('Default'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Pure Black'),
                ),
              ],
              child: ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text("Dark Theme"),
                subtitle: Text(
                  ['', 'Default', 'Pure Black'][theme.darkTheme],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                // onTap: () {},
              ),
            );
          },
        ),
        const ListGroupTitle("Construct"),
        Consumer<SettingsProvider>(
          builder: (context, settings, child) {
            return SwitchListTile(
              title: const Text("Prefer Short Cut"),
              secondary: const Icon(Icons.abc),
              value: settings.preferShortCut,
              onChanged: (bool value) => settings.preferShortCut = value,
            );
          },
        ),
        Consumer<SettingsProvider>(
          builder: (context, settings, child) {
            return SwitchListTile(
              title: const Text("Omit Optional Affixes"),
              secondary: const Icon(Icons.abc),
              value: settings.omitOptionalAffixes,
              onChanged: (bool value) => settings.omitOptionalAffixes = value,
            );
          },
        ),
        Consumer<SettingsProvider>(
          builder: (context, settings, child) {
            return SwitchListTile(
              title: const Text("Omit Optional Characters"),
              secondary: const Icon(Icons.abc),
              value: settings.omitOptionalCharacters,
              onChanged: (bool value) => settings.omitOptionalCharacters = value,
            );
          },
        ),
        const ListGroupTitle("Others"),
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
          subtitle: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  snapshot.hasError
                      ? "Error: ${snapshot.error}"
                      : "Version: ${snapshot.data!.version}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutPage()),
          ),
        ),
      ],
    );
  }
}
