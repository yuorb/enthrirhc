import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ithkuil_helper/common/store.dart';

import '../common/types.dart';
import '../database/lexicon.dart';

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
                see: row.see),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Consumer<LexiconModel>(
      builder: (context, lexicon, child) {
        return Column(
          children: [
            Text('Total length: ${roots.length.toString()}'),
            OutlinedButton(
              onPressed: () {
                search(lexicon.database);
              },
              child: const Text("update"),
            )
          ],
        );
      },
    ));
  }
}
