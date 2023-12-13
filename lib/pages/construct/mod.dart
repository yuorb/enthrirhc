import 'package:enthrirhs/libs/download/mod.dart';
import 'package:enthrirhs/libs/ithkuil/romanization/mod.dart';
import 'package:enthrirhs/libs/ithkuil/writing/mod.dart';
import 'package:enthrirhs/libs/misc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enthrirhs/components/ithkuil_svg.dart';
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
                IconButton(
                  onPressed: formatives.isEmpty
                      ? null
                      : () async {
                          final data = ithkuilWriting(
                            formatives
                                .map((formative) => formative.toCharacters())
                                .expand((element) => element)
                                .toList(),
                            "#000000",
                            "#cccccc",
                          );
                          final path = await saveTextFile(data, 'writing.svg');
                          if (!context.mounted) {
                            return;
                          }
                          if (path != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Successfully downloaded "$path"'),
                            ));
                          }
                        },
                  tooltip: "Download the writing image as SVG",
                  icon: const Icon(Icons.download),
                ),
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
