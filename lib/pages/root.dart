import 'package:enthrirhc/libs/misc.dart';
import 'package:flutter/material.dart';
import 'package:enthrirhc/utils/types.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../utils/store.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.root.root),
        actions: [
          seeAlso != null
              ? IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RootPage(seeAlso!)),
                  ),
                  icon: const Icon(Icons.emoji_objects),
                  tooltip: "See Also",
                )
              : Container(),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: widget.root.refers != null
                  ? Container(
                      margin: const EdgeInsets.all(12),
                      child: Wrap(
                        spacing: 12,
                        children: widget.root.refers!
                            .split(' / ')
                            .map(
                              (refer) => ActionChip(
                                label: Text(refer),
                                onPressed: () => showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Meaning"),
                                    content: Text(refer),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : Container(),
            ),
            SliverToBoxAdapter(
              child: widget.root.notes != null
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: MarkdownBody(data: widget.root.notes!),
                    )
                  : Container(),
            ),
            SliverToBoxAdapter(
              child: widget.root.stems != null
                  ? TabBar(
                      controller: _tabController,
                      tabs: const <Widget>[
                        Tab(text: "Stem 1"),
                        Tab(text: "Stem 2"),
                        Tab(text: "Stem 3"),
                      ],
                    )
                  : Container(),
            ),
          ];
        },
        body: widget.root.stems != null
            ? TabBarView(
                controller: _tabController,
                children: widget.root.stems!
                    .map(
                      (stem) => switch (stem) {
                        Specs() => ListView(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.menu_book),
                              title: const Text("BSC"),
                              isThreeLine: true,
                              subtitle: MarkdownBody(
                                data: stem.bsc,
                                styleSheet: MarkdownStyleSheet(
                                  p: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  strong: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  em: const TextStyle(
                                    fontFamily: "NotoSansItalic",
                                  ),
                                ),
                              ),
                              onLongPress: () =>
                                  copyToClipboard(stem.bsc, context),
                            ),
                            ListTile(
                              leading: const Icon(Icons.subject),
                              title: const Text("CTE"),
                              isThreeLine: true,
                              subtitle: MarkdownBody(
                                data: stem.cte,
                                styleSheet: MarkdownStyleSheet(
                                  p: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  strong: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  em: const TextStyle(
                                    fontFamily: "NotoSansItalic",
                                  ),
                                ),
                              ),
                              onLongPress: () =>
                                  copyToClipboard(stem.cte, context),
                            ),
                            ListTile(
                              leading: const Icon(Icons.import_contacts),
                              title: const Text("CSV"),
                              isThreeLine: true,
                              subtitle: MarkdownBody(
                                data: stem.csv,
                                styleSheet: MarkdownStyleSheet(
                                  p: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  strong: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  em: const TextStyle(
                                    fontFamily: "NotoSansItalic",
                                  ),
                                ),
                              ),
                              onLongPress: () =>
                                  copyToClipboard(stem.csv, context),
                            ),
                            ListTile(
                              leading: const Icon(Icons.book),
                              title: const Text("OBJ"),
                              isThreeLine: true,
                              subtitle: MarkdownBody(
                                data: stem.obj,
                                styleSheet: MarkdownStyleSheet(
                                  p: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  strong: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  em: const TextStyle(
                                    fontFamily: "NotoSansItalic",
                                  ),
                                ),
                              ),
                              onLongPress: () =>
                                  copyToClipboard(stem.obj, context),
                            ),
                          ],
                        ),
                        StrStem() => ListView(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.info),
                              title: const Text("General"),
                              subtitle: MarkdownBody(
                                data: stem.value,
                                styleSheet: MarkdownStyleSheet(
                                  p: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  strong: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  em: const TextStyle(
                                    fontFamily: "NotoSansItalic",
                                  ),
                                ),
                              ),
                              onLongPress: () =>
                                  copyToClipboard(stem.value, context),
                            ),
                          ],
                        ),
                      },
                    )
                    .toList(),
              )
            : Container(),
      ),
    );
  }
}
