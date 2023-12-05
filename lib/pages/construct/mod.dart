import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:provider/provider.dart';

import 'package:enthrirhs/components/ithkuil_svg.dart';
import 'package:enthrirhs/libs/ithkuil/writing/primary/mod.dart';
import 'package:enthrirhs/libs/ithkuil/writing/quarternary/mod.dart';
import 'package:enthrirhs/libs/ithkuil/writing/secondary/core_letter.dart';
import 'package:enthrirhs/libs/ithkuil/writing/secondary/ext_letter.dart';
import 'package:enthrirhs/libs/ithkuil/writing/secondary/mod.dart';
import 'package:enthrirhs/libs/ithkuil/writing/tertiary/extensions.dart';
import 'package:enthrirhs/libs/ithkuil/writing/tertiary/mod.dart';
import 'package:enthrirhs/libs/misc.dart';
import '../../components/list_group_title.dart';
import '../../libs/ithkuil/terms/mod.dart';
import 'store.dart';

class ConstructPage extends StatefulWidget {
  const ConstructPage({super.key});

  @override
  State<ConstructPage> createState() => _ConstructPageState();
}

class _ConstructPageState extends State<ConstructPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: context.watch<ConstructPageRoots>().formatives.length,
      child: Builder(
        builder: (context) => Column(
          children: [
            AppBar(title: const Text("Construct")),
            const SizedBox(height: 16),
            // TODO: Implement this component with dynamic formatives
            const IthkuilSvg(
              [
                Primary(
                  specification: Specification.cte,
                  context: Context.rps,
                  formativeType: Concatenated(
                    concatenation: Concatenation.type2,
                    format: Case.abl,
                  ),
                  essence: Essence.rpv,
                  affiliation: Affiliation.csl,
                  perspective: Perspective.m,
                  extension: Extension.prx,
                  similarity: Similarity.d,
                  separability: Separability.s,
                  function: Function$.sta,
                  version: Version.prc,
                  plexity: Plexity.u,
                  stem: Stem.s1,
                ),
                RootSecondary(
                  start: ExtLetter.b,
                  core: CoreLetter.placeholder,
                  end: ExtLetter.c,
                ),
                CsVxAffixes(
                  start: ExtLetter.d,
                  core: CoreLetter.s,
                  end: ExtLetter.k,
                  degree: Degree.d1,
                  affixType: AffixType.type2,
                ),
                VxCsAffixes(
                  start: ExtLetter.d,
                  core: CoreLetter.s,
                  end: ExtLetter.k,
                  degree: Degree.d2,
                  affixType: AffixType.type3,
                ),
                Tertiary(
                  valence: Valence.mno,
                  top: AspectExtension(Aspect.atp),
                  bottom: AspectExtension(Aspect.atp),
                  level: Level(
                    comparison: Comparison.absolute,
                    comparisonOperator: ComparisonOperator.equ,
                  ),
                ),
                Quarternary(
                  formativeType: Concatenated(
                    concatenation: Concatenation.type2,
                    format: Case.abl,
                  ),
                  cn: MoodCn(Mood.sub),
                ),
              ],
            ),
            Text(
              context
                  .watch<ConstructPageRoots>()
                  .formatives
                  // TODO: Implement arguments for `formative.romanize`
                  .map((formative) => formative.romanize(true, true))
                  .join(' ')
                  .capitalize()
                  .addPeriod(),
            ),
            TabBar(
              isScrollable: true,
              tabs: context
                  .watch<ConstructPageRoots>()
                  .formatives
                  .map((formative) =>
                      Tab(child: Text("-${formative.root.toString().toUpperCase()}-")))
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                children: context.watch<ConstructPageRoots>().formatives.indexed.map((it) {
                  final index = it.$1;
                  final formative = it.$2;
                  return ListView(children: [
                    const ListGroupTitle("Definition"),
                    ListTile(
                      leading: const Icon(Icons.abc),
                      title: const Text("Root"),
                      subtitle: Text("-${formative.root.toString().toUpperCase()}-"),
                      onTap: () async {
                        final rootStr = await prompt(
                          context,
                          title: const Text("Please enter the new root"),
                        );
                        if (rootStr != null) {
                          final root = Root.from(rootStr);
                          if (root != null) {
                            if (!context.mounted) return;
                            context.read<ConstructPageRoots>().updateFormative(index, (f) {
                              f.root = root;
                            });
                          } else {
                            if (!context.mounted) return;
                            await showErrorDialog(context, "Invalid new root.");
                          }
                        }
                      },
                    ),
                    PopupMenuButton<Stem>(
                      initialValue: formative.stem,
                      onSelected: (Stem stem) {
                        context.read<ConstructPageRoots>().updateFormative(index, (f) {
                          f.stem = stem;
                        });
                      },
                      offset: const Offset(1, 0),
                      itemBuilder: (BuildContext context) => const <PopupMenuEntry<Stem>>[
                        PopupMenuItem(
                          value: Stem.s1,
                          child: Text('Stem 1'),
                        ),
                        PopupMenuItem(
                          value: Stem.s2,
                          child: Text('Stem 2'),
                        ),
                        PopupMenuItem(
                          value: Stem.s3,
                          child: Text('Stem 3'),
                        ),
                        PopupMenuItem(
                          value: Stem.s0,
                          child: Text('Stem 0'),
                        ),
                      ],
                      child: ListTile(
                        leading: const Icon(Icons.library_books),
                        title: const Text("Stem"),
                        subtitle: Text(
                          switch (formative.stem) {
                            Stem.s1 => 'Stem 1',
                            Stem.s2 => 'Stem 2',
                            Stem.s3 => 'Stem 3',
                            Stem.s0 => 'Stem 0',
                          },
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Specification"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      // TODO: Implement this option.
                      child: Text(
                        "(to be ontologically the) self-same entity (as) (i.e., [to be] simply another name for the self-same entity)",
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    const ListGroupTitle("Basic"),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Version"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Function"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Context"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    const ListGroupTitle("Ca"),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Affiliation"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Plexity"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Similarity"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Separability"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Extension"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Perspective"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Essence"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    const ListGroupTitle("Relation etc."),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Essence"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Case"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    // ListTile(
                    //   leading: const Icon(Icons.library_books),
                    //   title: const Text("Illocution"),
                    //   subtitle: const Text("BSC"),
                    //   onTap: () {},
                    // ),
                    // TODO: Implement this option.
                    // ListTile(
                    //   leading: const Icon(Icons.library_books),
                    //   title: const Text("Validation"),
                    //   subtitle: const Text("BSC"),
                    //   onTap: () {},
                    // ),
                    const ListGroupTitle("VnCn"),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Vn"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Cn"),
                      subtitle: const Text("BSC"),
                      onTap: () {},
                    ),
                    // TODO: Implement this option.
                    ListGroupTitle(
                      "Affixes CsVx",
                      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                    ),
                    // TODO: Implement this option.
                    ListGroupTitle(
                      "Affixes VxCs",
                      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                    ),
                    const ListGroupTitle("Operation"),
                    ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text("Delete"),
                      subtitle: const Text("Delete this formative"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) => AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text("Are you sure to remove this formative?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(dialogContext);
                                  final index = DefaultTabController.of(context).index;
                                  context.read<ConstructPageRoots>().removeAt(index);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          ),
                        );
                      },
                      tileColor: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
