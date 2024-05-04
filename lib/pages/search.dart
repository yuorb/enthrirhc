import 'dart:convert';

import 'package:enthrirhc/database/shared.dart';
import 'package:enthrirhc/libs/result/mod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:enthrirhc/libs/misc.dart';
import 'package:enthrirhc/pages/root.dart';
import 'package:enthrirhc/utils/store.dart';
import 'package:enthrirhc/utils/types.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

import 'affix.dart';

class LexiconActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const LexiconActionButton(
      {super.key, required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(64),
        alignment: const Alignment(-1, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
      label: Text("   $label"),
      icon: Icon(icon),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchController controller = SearchController();
  int? rootCount;
  int? affixCount;

  Future<Lexicon?> pickLexiconFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );

    if (result == null) return null;
    final bytes = result.files.single.bytes;
    if (bytes == null) return null;
    final text = utf8.decode(bytes);
    Map<String, dynamic> decodedJson;
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
      return null;
    }

    switch (Lexicon.fromJson(decodedJson)) {
      case Ok(value: final value):
        return value;
      case Err(value: final err):
        if (context.mounted) {
          result.files[0].name;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Error"),
              content: Text("Parsing ${result.files[0].name}: $err"),
            ),
          );
        }
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    final database = context.read<LexiconModel>().database;
    database.rootCount().then((count) => setState(() => rootCount = count));
    database.affixCount().then((count) => setState(() => affixCount = count));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverAppBar(
          title: Container(
            margin: const EdgeInsets.all(12),
            child: const Text("Search"),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(12),
              child: SearchAnchor(
                searchController: controller,
                suggestionsBuilder: (suggestionsContext, controller) async {
                  final provider = context.read<LexiconModel>();
                  final result = await provider.database.search(controller.text);
                  return result.map(
                    (item) => ListTile(
                      leading: switch (item) {
                        RootSRI() => SvgPicture(
                            const AssetBytesLoader('assets/icons_compiled/sweep.svg.vec'),
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onSurfaceVariant,
                              BlendMode.srcIn,
                            ),
                            width: 24,
                          ),
                        AffixSRI() => SvgPicture(
                            const AssetBytesLoader('assets/icons_compiled/list_alt_add.svg.vec'),
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onSurfaceVariant,
                              BlendMode.srcIn,
                            ),
                            width: 24,
                          ),
                      },
                      title: Text(switch (item) {
                        RootSRI(root: final root) => root.root,
                        AffixSRI(affix: final affix) => "${affix.cs} (${affix.name})",
                      }),
                      subtitle: Text(
                        switch (item) {
                          RootSRI(root: final root) => root.refers ?? '',
                          AffixSRI(affix: final affix) => affix.description,
                        },
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(suggestionsContext).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          suggestionsContext,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider<LexiconModel>.value(
                              value: provider,
                              builder: (context, child) => switch (item) {
                                RootSRI(root: final root) => RootPage(root),
                                AffixSRI(affix: final affix) => AffixPage(affix),
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                builder: (BuildContext context, SearchController controller) {
                  return IconButton(
                    onPressed: () {
                      controller.openView();
                    },
                    icon: const Icon(Icons.search),
                  );
                },
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: null,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(64),
                          alignment: const Alignment(-1, 0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                        ),
                        label: Text("Root: ${rootCount ?? "Loading..."}"),
                        icon: const Icon(Icons.article),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: null,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(64),
                          alignment: const Alignment(-1, 0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                        ),
                        label: Text("Affixes: $affixCount"),
                        icon: const Icon(Icons.article),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                LexiconActionButton(
                  icon: Icons.cloud_download,
                  label: "Fetch lexicon from Github repository",
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                      title: Text("WIP"),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                LexiconActionButton(
                  icon: Icons.upload_file,
                  label: "Import lexicon from local files",
                  onPressed: () async {
                    if (rootCount == null) {
                      await showInfoDialog(
                          context, "Please wait until roots and affixes are loaded first.");
                      return;
                    }
                    // Pick lexicon JSON file
                    Lexicon? lexicon = await pickLexiconFile();
                    if (lexicon == null) return;

                    // Save and update the lexicon data
                    if (!context.mounted) return;
                    await context.read<LexiconModel>().database.insert(lexicon);
                    setState(() {
                      rootCount = rootCount! + lexicon.roots.length;
                      affixCount = affixCount! + lexicon.standardAffixes.length;
                    });

                    // Pop up the success dialog
                    if (!context.mounted) return;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Info"),
                        content: Text(
                          """Imported successfully.

- Roots: ${lexicon.roots.length.toString()}
- Standard Affixes:  ${lexicon.standardAffixes.length.toString()}
- Case Accessor Affixes:  ${lexicon.caseAccessorAffixes.length.toString()}
- Case Stacking Affixes:  ${lexicon.caseStackingAffixes.length.toString()}""",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                LexiconActionButton(
                  icon: Icons.delete_forever,
                  label: "Clear the lexicon",
                  onPressed: () async {
                    if (rootCount == null) {
                      await showInfoDialog(
                          context, "Please wait until roots and affixes are loaded first.");
                      return;
                    }

                    final isConfirmed = await showConfirmDialog(
                      context,
                      "Are you sure to clear all the roots and affixes from your device?",
                    );

                    if (isConfirmed) {
                      if (!context.mounted) return;
                      await context.read<LexiconModel>().database.clearLexicon();
                      setState(() {
                        rootCount = 0;
                        affixCount = 0;
                      });
                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Success"),
                          content: const Text("All roots and affixes have been cleared."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Ok"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
