import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

import 'package:enthrirhs/libs/misc.dart';
import '../../components/list_group_title.dart';
import '../../libs/ithkuil/mod.dart';
import '../../libs/ithkuil/terms/mod.dart';

class FormativeEditor extends StatefulWidget {
  final Formative formative;
  final void Function(void Function(Formative)) updateFormative;
  final void Function() removeFormative;

  const FormativeEditor({
    required this.formative,
    required this.updateFormative,
    required this.removeFormative,
    super.key,
  });

  @override
  State<FormativeEditor> createState() => _FormativeEditorState();
}

class _FormativeEditorState extends State<FormativeEditor> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const ListGroupTitle("Definition"),
      ListTile(
        leading: const Icon(Icons.abc),
        title: const Text("Root"),
        subtitle: Text("-${widget.formative.root.toString().toUpperCase()}-"),
        onTap: () async {
          final rootStr = await prompt(
            context,
            title: const Text("Please enter the new root"),
          );
          if (rootStr != null) {
            final root = Root.from(rootStr);
            if (root != null) {
              if (!context.mounted) return;
              widget.updateFormative((Formative f) {
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
        initialValue: widget.formative.stem,
        onSelected: (Stem stem) {
          widget.updateFormative((f) {
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
            switch (widget.formative.stem) {
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
      PopupMenuButton<Specification>(
        initialValue: widget.formative.specification,
        onSelected: (Specification specification) {
          widget.updateFormative((f) {
            f.specification = specification;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Specification>>[
          PopupMenuItem(
            value: Specification.bsc,
            child: Text('BSC (Basic)'),
          ),
          PopupMenuItem(
            value: Specification.cte,
            child: Text('CTE (Contential)'),
          ),
          PopupMenuItem(
            value: Specification.csv,
            child: Text('CSV (Constitutive)'),
          ),
          PopupMenuItem(
            value: Specification.obj,
            child: Text('OBJ (Objective)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: const Text("Specification"),
          subtitle: Text(
            switch (widget.formative.specification) {
              Specification.bsc => 'BSC (Basic)',
              Specification.cte => 'CTE (Contential)',
              Specification.csv => 'CSV (Constitutive)',
              Specification.obj => 'OBJ (Objective)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
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
                    widget.removeFormative();
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
  }
}
