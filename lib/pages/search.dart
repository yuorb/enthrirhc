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
  final SearchController controller = SearchController();

  Future<List<Root>> search(Database database) async {
    final rows = await database.search(controller.text);
    return rows
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
                // TODO: https://github.com/flutter/flutter/issues/126531
                suggestionsBuilder: (BuildContext context, SearchController controller) {
                  final searchFuture = search(lexicon.database);
                  return [
                    FutureBuilder(
                      future: searchFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final list = snapshot.data;
                          if (list != null) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  titleAlignment: ListTileTitleAlignment.center,
                                  title: Text(list[index].root),
                                );
                              },
                            );
                          }
                        }
                        return const LinearProgressIndicator();
                      },
                    )
                  ];
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
