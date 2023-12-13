import 'dart:ui';

import 'package:enthrirhs/libs/download/mod.dart';
import 'package:enthrirhs/libs/ithkuil/romanization/mod.dart';
import 'package:enthrirhs/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhs/libs/misc.dart';
import 'package:enthrirhs/utils/mod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:enthrirhs/components/ithkuil_svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../libs/ithkuil/mod.dart';
import 'formative_editor.dart';
import 'store.dart';

class ConstructPage extends StatefulWidget {
  const ConstructPage({super.key});

  @override
  State<ConstructPage> createState() => _ConstructPageState();
}

class _ConstructPageState extends State<ConstructPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final List<Formative> formatives = context.watch<ConstructPageRoots>().formatives;

    return DefaultTabController(
      length: formatives.length,
      child: Builder(
        builder: (context) => Column(
          children: [
            AppBar(
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
                                formatives
                                    .map((formative) => formative.toCharacters())
                                    .expand((element) => element)
                                    .toList(),
                                backgroundColor: "white",
                              );
                              final pictureInfo =
                                  await vg.loadPicture(SvgStringLoader(rawSvg), null);
                              final image = await pictureInfo.picture.toImage(
                                width.toInt(),
                                height.toInt(),
                              );
                              final byteData =
                                  (await image.toByteData(format: ImageByteFormat.png))!;
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
                  Platform.windows || Platform.linux || Platform.webDesktop => IconButton(
                      icon: const Icon(Icons.download),
                      tooltip: "Download the writing image as SVG",
                      onPressed: formatives.isEmpty
                          ? null
                          : () async {
                              final (rawSvg, (_, _)) = ithkuilWriting(
                                formatives
                                    .map((formative) => formative.toCharacters())
                                    .expand((element) => element)
                                    .toList(),
                              );
                              final path = await saveTextFile(rawSvg, 'writing.svg');
                              if (!context.mounted) {
                                return;
                              }
                              if (path != null) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Successfully downloaded "$path"'),
                                ));
                              }
                            },
                    ),
                  Platform.unadapted => throw UnimplementedError(),
                },
                IconButton(
                  onPressed: formatives.isEmpty
                      ? null
                      : () {
                          final sentence = romanizeFormatives(formatives)!;
                          copyToClipboard(sentence, context);
                        },
                  tooltip: "Copy the romanized sentence",
                  icon: const Icon(Icons.copy),
                ),
              ],
            ),
            IthkuilSvg(
              formatives
                  .map((formative) => formative.toCharacters())
                  .expand((element) => element)
                  .toList(),
            ),
            Text(romanizeFormatives(formatives) ?? 'NO FORMATIVES'),
            TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              tabs: formatives
                  .map((formative) =>
                      Tab(child: Text("-${formative.root.toString().toUpperCase()}-")))
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                children: formatives.indexed.map((it) {
                  final index = it.$1;
                  final formative = it.$2;
                  return FormativeEditor(
                    formative: formative,
                    updateFormative: (void Function(Formative) callback) {
                      context.read<ConstructPageRoots>().updateFormative(index, callback);
                    },
                    removeFormative: () {
                      context.read<ConstructPageRoots>().removeAt(index);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
