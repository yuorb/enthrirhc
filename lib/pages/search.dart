import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:enthrirch/pages/root.dart';
import 'package:provider/provider.dart';
import 'package:enthrirch/common/store.dart';

import '../common/types.dart';

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
  int rootCount = 0;
  int affixCount = 0;

  Future<List<Root>?> pickLexiconFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );

    if (result == null) return null;
    final bytes = result.files.single.bytes;
    if (bytes == null) return null;
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
      return null;
    }
    return decodedJson.map((root) => Root.fromJson(root)).toList();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<LexiconModel>(context, listen: false)
        .database
        .rootCount()
        .then((count) => setState(() => rootCount = count));
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
                suggestionsBuilder: (BuildContext context, SearchController controller) async {
                  final result = await Provider.of<LexiconModel>(context, listen: false)
                      .database
                      .search(controller.text);
                  return result.map(
                    (root) => ListTile(
                      leading: const Icon(Icons.article),
                      title: Text(root.root),
                      subtitle: Text(
                        root.refers ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RootPage(root)),
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
                        label: Text("Root: $rootCount"),
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
                    // Pick lexicon JSON file
                    List<Root>? lexicon = await pickLexiconFile();
                    if (lexicon == null) return;

                    // Save and update the lexicon data
                    if (!context.mounted) return;
                    await Provider.of<LexiconModel>(context, listen: false).database.init(lexicon);
                    setState(() => rootCount += lexicon.length);

                    // Pop up the success dialog
                    if (!context.mounted) return;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Success"),
                        content: Text(
                          "Imported ${lexicon.length.toString()} roots successfully.",
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) => AlertDialog(
                          title: const Text("Warning"),
                          content: const Text(
                              "Are you sure to clear all the roots and affixes from your device?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(dialogContext);
                                final count =
                                    await Provider.of<LexiconModel>(context, listen: false)
                                        .database
                                        .clearRoots();
                                setState(() => rootCount -= count);
                                if (!context.mounted) return;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text("Success"),
                                    content: Text("$count roots have been cleared."),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text("Ok"),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        )
      ],
    );
  }
}
