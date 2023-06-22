import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ithkuil_helper/common/store.dart';

import '../common/types.dart';
import '../database/shared.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List roots = [];

  void search(Database database) async {
    final rows = await database.search();
    setState(() {
      roots = rows
          .map(
            (row) => Root(
              root: row.root,
              refers: row.refers,
              stems: [row.stem1, row.stem2, row.stem3],
              notes: row.notes,
              see: row.see,
            ),
          )
          .toList();
    });
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
                barHintText: "Search roots...",
                suggestionsBuilder: (BuildContext context, SearchController controller) {
                  return List<Widget>.generate(
                    5,
                    (int index) {
                      return ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text('Initial list item $index'),
                      );
                    },
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
