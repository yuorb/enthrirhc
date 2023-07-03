import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:enthrirch/pages/root.dart';
import 'package:provider/provider.dart';
import 'package:enthrirch/common/store.dart';

import '../common/types.dart';
import '../database/shared.dart';

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
        const SliverToBoxAdapter(
          child: SizedBox(height: 12),
        ),
        SliverAppBar(
          clipBehavior: Clip.none,
          shape: const StadiumBorder(),
          // scrolledUnderElevation: 0.0,
          // titleSpacing: 0.0,
          title: Consumer<LexiconModel>(
            builder: (context, lexicon, child) {
              return SearchAnchor.bar(
                searchController: controller,
                barHintText: "Search roots...",
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
              );
            },
          ),
        ),
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 256),
              Text("Work In Progress"),
            ],
          ),
        )
      ],
    );
  }
}
