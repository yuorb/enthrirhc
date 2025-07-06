import 'dart:ui';

import 'package:enthrirhc/libs/download/mod.dart';
import 'package:enthrirhc/libs/ithkuil/romanization/mod.dart';
import 'package:enthrirhc/libs/ithkuil/terms/mod.dart';
import 'package:enthrirhc/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhc/libs/misc.dart';
import 'package:enthrirhc/utils/mod.dart';
import 'package:enthrirhc/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:provider/provider.dart';

import 'package:enthrirhc/components/ithkuil_svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../libs/ithkuil/mod.dart';
import 'formative_editor.dart';

class ConstructPage extends StatefulWidget {
  const ConstructPage({super.key});

  @override
  State<ConstructPage> createState() => _ConstructPageState();
}

class _ConstructPageState extends State<ConstructPage>
    with TickerProviderStateMixin {
  List<Formative> formatives = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SettingsProvider settings = context.watch<SettingsProvider>();

    final characters = formatives
        .map(
          (formative) =>
              formative.toCharacters(settings.omitOptionalCharacters),
        )
        .expand((element) => element)
        .toList()
        .omitPrimaryCharacter(settings.omitOptionalCharacters);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Construct"),
        actions: [
          switch (Platform.get()) {
            Platform.android || Platform.webMobile => IconButton(
              icon: const Icon(Icons.share),
              tooltip: "Share the writing image",
              onPressed: formatives.isEmpty
                  ? null
                  : () async {
                      final (rawSvg, (width, height)) = ithkuilWriting(
                        characters,
                        backgroundColor: "white",
                      );
                      final pictureInfo = await vg.loadPicture(
                        SvgStringLoader(rawSvg),
                        null,
                      );
                      final image = await pictureInfo.picture.toImage(
                        width.toInt(),
                        height.toInt(),
                      );
                      final byteData = (await image.toByteData(
                        format: ImageByteFormat.png,
                      ))!;
                      final bytes = byteData.buffer.asUint8List();
                      Share.shareXFiles([
                        XFile.fromData(
                          bytes,
                          name: 'writing.png',
                          mimeType: 'image/png',
                        ),
                      ]);
                    },
            ),
            Platform.windows ||
            Platform.linux ||
            Platform.webDesktop => IconButton(
              icon: const Icon(Icons.download),
              tooltip: "Download the writing image as SVG",
              onPressed: formatives.isEmpty
                  ? null
                  : () async {
                      final (rawSvg, (_, _)) = ithkuilWriting(characters);
                      final path = await saveTextFile(rawSvg, 'writing.svg');
                      if (!context.mounted) {
                        return;
                      }
                      if (path != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Successfully downloaded "$path"'),
                          ),
                        );
                      }
                    },
            ),
            Platform.unadapted => throw UnimplementedError(),
          },
          IconButton(
            onPressed: formatives.isEmpty
                ? null
                : () {
                    final sentence = romanizeFormatives(
                      formatives,
                      context.read<SettingsProvider>().preferShortCut,
                      context.read<SettingsProvider>().omitOptionalAffixes,
                    )!;
                    copyToClipboard(sentence, context);
                  },
            tooltip: "Copy the romanized sentence",
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
      body: Column(
        children: [
          IthkuilSvg(characters),
          Text(
            romanizeFormatives(
                  formatives,
                  settings.preferShortCut,
                  settings.omitOptionalAffixes,
                ) ??
                'NO FORMATIVES',
          ),
          TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            controller: _tabController,
            tabs: formatives
                .map(
                  (formative) => Tab(
                    child: Text("-${formative.root.toString().toUpperCase()}-"),
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: formatives.indexed.map((it) {
                final index = it.$1;
                final formative = it.$2;
                return FormativeEditor(
                  formative: formative,
                  updateFormative: (void Function(Formative) callback) {
                    setState(() {
                      callback(formatives[index]);
                    });
                  },
                  removeFormative: () {
                    final newIndex = _tabController.index < index
                        ? _tabController.index
                        : _tabController.index - 1;
                    setState(() {
                      formatives.removeAt(index);
                      _tabController = TabController(
                        vsync: this,
                        length: formatives.length,
                        initialIndex: newIndex < 0 ? 0 : newIndex,
                      );
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final rootStr = await prompt(
            context,
            title: const Text("Please enter the root"),
            initialValue: "",
          );
          if (rootStr != null) {
            final root = Root.from(rootStr);
            if (root != null && root.phonemes.isNotEmpty) {
              final oldIndex = _tabController.index;
              final newIndex = formatives.isEmpty ? 0 : oldIndex + 1;
              setState(() {
                formatives.insert(
                  newIndex,
                  Formative(
                    stem: Stem.s1,
                    root: root,
                    specification: Specification.bsc,
                    context: Context.exs,
                    function: Function$.sta,
                    concatenationStatus: const NoConcatenation(Noun(Case.thm)),
                    version: Version.prc,
                    affiliation: Affiliation.csl,
                    configuration: Configuration.from(Plexity.u, null, null)!,
                    extension: Extension.del,
                    perspective: Perspective.m,
                    essence: Essence.nrm,
                    csVxAffixes: [],
                    vxCsAffixes: [],
                    vn: const ValenceVn(Valence.mno),
                    cn: Cn.cn1,
                  ),
                );
                _tabController = TabController(
                  vsync: this,
                  length: formatives.length,
                  initialIndex: oldIndex,
                );
              });
              _tabController.animateTo(newIndex);
            } else {
              if (!context.mounted) return;
              await showErrorDialog(context, "Invalid root.");
            }
          }
        },
        heroTag: null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
