import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enthrirhs/components/ithkuil_svg.dart';
import 'package:enthrirhs/libs/misc.dart';
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
            AppBar(title: const Text("Construct")),
            IthkuilSvg(
              formatives
                  .map((formative) => formative.toCharacters())
                  .expand((element) => element)
                  .toList(),
            ),
            Text(
              formatives.isEmpty
                  ? 'NO FORMATIVES'
                  : formatives
                      .map((formative) => formative.romanize())
                      .join(' ')
                      .capitalize()
                      .addPeriod(),
            ),
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
