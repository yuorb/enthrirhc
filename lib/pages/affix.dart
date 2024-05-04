import 'package:enthrirhc/libs/misc.dart';
import 'package:flutter/material.dart';
import 'package:enthrirhc/utils/types.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

import '../utils/store.dart';
import 'root.dart';

class AffixPage extends StatefulWidget {
  final StandardAffix affix;

  const AffixPage(this.affix, {super.key});

  @override
  State<AffixPage> createState() => _AffixPageState();
}

class _AffixPageState extends State<AffixPage> with TickerProviderStateMixin {
  Root? associatedRoot;

  @override
  void initState() {
    super.initState();
    if (widget.affix.associatedRoot) {
      context
          .read<LexiconModel>()
          .database
          .exactSearch(widget.affix.cs.toUpperCase())
          .then((value) => setState(() => associatedRoot = value));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LexiconModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text("-${widget.affix.cs}"),
        actions: [
          associatedRoot != null
              ? IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider<LexiconModel>.value(
                        value: provider,
                        builder: (context, child) => RootPage(associatedRoot!),
                      ),
                    ),
                  ),
                  icon: SvgPicture(
                    const AssetBytesLoader('assets/icons_compiled/sweep.svg.vec'),
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurfaceVariant,
                      BlendMode.srcIn,
                    ),
                    width: 24,
                  ),
                  tooltip: "See Associated Root",
                )
              : Container()
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 12,
                  children: [
                    Chip(
                      label: Text(widget.affix.name),
                      avatar: const Icon(Icons.badge),
                    ),
                    Chip(
                      label: Text(widget.affix.gradientType.toString()),
                      avatar: const Icon(Icons.gradient),
                    ),
                    Chip(
                      label: Text(widget.affix.description),
                      avatar: const Icon(Icons.description),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: widget.affix.notes != null
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: MarkdownBody(data: widget.affix.notes!),
                    )
                  : Container(),
            ),
          ];
        },
        body: ListView(
          children: widget.affix.degrees.indexed
              .map<List<ListTile>>((entry) {
                final icon = SvgPicture(
                  AssetBytesLoader('assets/icons_compiled/counter_${entry.$1}.svg.vec'),
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                );
                return switch (entry.$2) {
                  MergedDegree(degree: final degree) => [
                      ListTile(
                        leading: icon,
                        title: Text("Degree ${entry.$1}"),
                        isThreeLine: true,
                        subtitle: MarkdownBody(
                          data: degree,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            strong: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        onLongPress: () => copyToClipboard(degree, context),
                      ),
                    ],
                  SeparatedDegree(type1: final type1, type2: final type2) => [
                      ListTile(
                        leading: icon,
                        title: Text("Degree ${entry.$1} Type-1"),
                        isThreeLine: true,
                        subtitle: MarkdownBody(
                          data: type1,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            strong: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        onLongPress: () => copyToClipboard(type1, context),
                      ),
                      ListTile(
                        leading: const Icon(null),
                        title: Text("Degree ${entry.$1} Type-2"),
                        isThreeLine: true,
                        subtitle: MarkdownBody(
                          data: type2,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            strong: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        onLongPress: () => copyToClipboard(type2, context),
                      ),
                    ],
                  null => []
                };
              })
              .expand((element) => element)
              .toList(),
        ),
      ),
    );
  }
}
