import 'package:flutter/material.dart';
import 'package:enthrirch/common/types.dart';
import 'package:provider/provider.dart';

import '../common/store.dart';

class RootPage extends StatefulWidget {
  final Root root;

  const RootPage(this.root, {super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  Root? seeAlso;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (widget.root.seeAlso != null) {
      context
          .read<LexiconModel>()
          .database
          .exactSearch(widget.root.seeAlso!)
          .then((value) => setState(() => seeAlso = value));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LexiconModel>();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.root.root),
          actions: [
            seeAlso != null
                ? IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider<LexiconModel>.value(
                          value: provider,
                          builder: (context, child) => RootPage(seeAlso!),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.emoji_objects),
                    tooltip: "See Also",
                  )
                : Container()
          ],
        ),
        body: Column(children: [
          widget.root.refers != null
              ? Container(
                  margin: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 12,
                    children: widget.root.refers!
                        .split(' / ')
                        .map((refer) => Chip(label: Text(refer)))
                        .toList(),
                  ),
                )
              : Container(),
          widget.root.stems != null
              ? TabBar(
                  controller: _tabController,
                  tabs: const <Widget>[
                    Tab(text: "Stem 1"),
                    Tab(text: "Stem 2"),
                    Tab(text: "Stem 3"),
                  ],
                )
              : Container(),
          widget.root.stems != null
              ? Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: widget.root.stems!
                        .map((stem) => switch (stem) {
                              Specs() => ListView(children: [
                                  ListTile(
                                    leading: const Icon(Icons.menu_book),
                                    title: const Text("BSC"),
                                    isThreeLine: true,
                                    subtitle: Text(stem.bsc),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.subject),
                                    title: const Text("CTE"),
                                    isThreeLine: true,
                                    subtitle: Text(stem.cte),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.import_contacts),
                                    title: const Text("CSV"),
                                    isThreeLine: true,
                                    subtitle: Text(stem.csv),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.book),
                                    title: const Text("OBJ"),
                                    isThreeLine: true,
                                    subtitle: Text(stem.obj),
                                  ),
                                ]),
                              StrStem() => ListView(children: [
                                  ListTile(
                                    leading: const Icon(Icons.info),
                                    title: const Text("General"),
                                    subtitle: Text(stem.value),
                                  )
                                ])
                            })
                        .toList(),
                  ),
                )
              : Container()
        ]));
  }
}
