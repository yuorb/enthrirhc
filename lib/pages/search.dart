import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:enthrirch/pages/root.dart';
import 'package:provider/provider.dart';
import 'package:enthrirch/common/store.dart';

import '../common/types.dart';
import '../database/shared.dart';

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

  Future<List<Root>> search(Database database) async {
    if (controller.text.isEmpty) {
      return [];
    }

    final rows = await database.search(controller.text);
    return rows.map(
      (row) {
        final List<Stem>? stems;
        if (row.stems != null) {
          final List<dynamic> decodeStems = jsonDecode(row.stems!);
          stems = decodeStems.map((stem) => Stem.from(stem)).toList();
        } else {
          stems = null;
        }
        return Root(
          root: row.root,
          refers: row.refers,
          stems: stems,
          notes: row.notes,
          see: row.see,
        );
      },
    ).toList();
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
              child: Consumer<LexiconModel>(
                builder: (context, lexicon, child) {
                  return SearchAnchor(
                    searchController: controller,
                    suggestionsBuilder: (BuildContext context, SearchController controller) async {
                      final result = await search(lexicon.database);
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
              // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        label: const Text("Root: WIP"),
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
                        label: const Text("Affixes: 0"),
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
                const SizedBox(height: 8),
                LexiconActionButton(
                  icon: Icons.delete_forever,
                  label: "Clear the lexicon",
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                      title: Text("WIP"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
