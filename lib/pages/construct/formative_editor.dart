import 'package:enthrirhs/libs/option/mod.dart';
import 'package:enthrirhs/utils/store.dart';
import 'package:enthrirhs/utils/types.dart' as database;
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

import 'package:enthrirhs/libs/misc.dart';
import 'package:provider/provider.dart';
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
  String definition = 'Searching definition...';

  @override
  void initState() {
    super.initState();
    updateDefinition();
  }

  Future<String> getDefinition() async {
    final rootStr = widget.formative.root.toString().toUpperCase();
    final root = await context.read<LexiconModel>().database.exactSearch(rootStr);
    if (root == null) {
      return 'Cannot find this root in your local lexicon. Please try to import the latest lexicon or use a valid root.';
    }
    final stems = root.stems;
    if (stems != null) {
      return switch (widget.formative.stem) {
        Stem.s1 => switch (stems[0]) {
            database.Specs specs => switch (widget.formative.specification) {
                Specification.bsc => specs.bsc,
                Specification.cte => specs.cte,
                Specification.csv => specs.csv,
                Specification.obj => specs.obj
              },
            database.StrStem(value: final value) => value
          },
        Stem.s2 => switch (stems[1]) {
            database.Specs specs => switch (widget.formative.specification) {
                Specification.bsc => specs.bsc,
                Specification.cte => specs.cte,
                Specification.csv => specs.csv,
                Specification.obj => specs.obj
              },
            database.StrStem(value: final value) => value
          },
        Stem.s3 => switch (stems[2]) {
            database.Specs specs => switch (widget.formative.specification) {
                Specification.bsc => specs.bsc,
                Specification.cte => specs.cte,
                Specification.csv => specs.csv,
                Specification.obj => specs.obj
              },
            database.StrStem(value: final value) => value
          },
        Stem.s0 => root.refers != null
            ? root.refers!
            : 'Unavailable because you selected `Stem 0` but this root does not have the `refers` field in lexicon.'
      };
    }
    if (root.refers != null) {
      return root.refers!;
    }

    return 'Unavailable because this root has neither the `stems` nor the `refers` field in lexicon.';
  }

  void updateDefinition() {
    getDefinition().then((newDefinition) {
      setState(() {
        definition = newDefinition;
      });
    });
  }

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
            initialValue: "",
          );
          if (rootStr != null) {
            final root = Root.from(rootStr);
            if (root != null && root.phonemes.isNotEmpty) {
              if (!context.mounted) return;
              widget.updateFormative((Formative f) {
                f.root = root;
              });
              updateDefinition();
            } else {
              if (!context.mounted) return;
              await showErrorDialog(context, "Invalid new root.");
            }
          }
        },
      ),
      PopupMenuButton<Stem>(
        onSelected: (Stem stem) {
          widget.updateFormative((f) {
            f.stem = stem;
          });
          updateDefinition();
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
          leading: const Icon(Icons.info_outline),
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
        onSelected: (Specification specification) {
          widget.updateFormative((f) {
            f.specification = specification;
          });
          updateDefinition();
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
          leading: const Icon(Icons.info_outline),
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
        child: Text(
          definition,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      const ListGroupTitle("Basic"),
      PopupMenuButton<Version>(
        onSelected: (Version version) {
          widget.updateFormative((f) {
            f.version = version;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Version>>[
          PopupMenuItem(
            value: Version.prc,
            child: Text('PRC (Processual)'),
          ),
          PopupMenuItem(
            value: Version.cpt,
            child: Text('CPT (Completive)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Version"),
          subtitle: Text(
            switch (widget.formative.version) {
              Version.prc => 'PRC (Processual)',
              Version.cpt => 'CPT (Completive)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Function$>(
        onSelected: (Function$ function) {
          widget.updateFormative((f) {
            f.function = function;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Function$>>[
          PopupMenuItem(
            value: Function$.sta,
            child: Text('STA (Stative)'),
          ),
          PopupMenuItem(
            value: Function$.dyn,
            child: Text('DYN (Dynamic)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Function"),
          subtitle: Text(
            switch (widget.formative.function) {
              Function$.sta => 'STA (Stative)',
              Function$.dyn => 'DYN (Dynamic)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Context>(
        onSelected: (Context thisContext) {
          widget.updateFormative((f) {
            f.context = thisContext;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Context>>[
          PopupMenuItem(
            value: Context.exs,
            child: Text('EXS (Existential)'),
          ),
          PopupMenuItem(
            value: Context.fnc,
            child: Text('FNC (Functional)'),
          ),
          PopupMenuItem(
            value: Context.rps,
            child: Text('RPS (Representational)'),
          ),
          PopupMenuItem(
            value: Context.amg,
            child: Text('AMG (Amalgamative)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Context"),
          subtitle: Text(
            switch (widget.formative.context) {
              Context.exs => 'EXS (Existential)',
              Context.fnc => 'FNC (Functional)',
              Context.rps => 'RPS (Representational)',
              Context.amg => 'AMG (Amalgamative)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Vn>(
        onSelected: (Vn newVn) {
          widget.updateFormative((f) {
            if (f.vnCn.vn.runtimeType == newVn.runtimeType) {
              return;
            }
            f.vnCn.vn = newVn;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Vn>>[
          PopupMenuItem(
            value: ValenceVn(Valence.mno),
            child: Text('Valence'),
          ),
          PopupMenuItem(
            value: PhaseVn(Phase.pct),
            child: Text('Phase'),
          ),
          PopupMenuItem(
            value: EffectVn(Effect.unk),
            child: Text('Effect'),
          ),
          PopupMenuItem(
            value: LevelVn(ComparisonOperator.equ),
            child: Text('Level'),
          ),
          PopupMenuItem(
            value: AspectVn(Aspect.rtr),
            child: Text('Aspect'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.sports_kabaddi_outlined),
          title: const Text("Vn Type"),
          subtitle: Text(
            switch (widget.formative.vnCn.vn) {
              ValenceVn() => 'Valence',
              PhaseVn() => 'Phase',
              EffectVn() => 'Effect',
              LevelVn() => 'Level',
              AspectVn() => 'Aspect',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      switch (widget.formative.vnCn.vn) {
        ValenceVn(valence: final valence) => PopupMenuButton<Valence>(
            onSelected: (Valence newValence) {
              widget.updateFormative((f) {
                f.vnCn.vn = ValenceVn(newValence);
              });
            },
            offset: const Offset(1, 0),
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<Valence>>[
              PopupMenuItem(
                value: Valence.mno,
                child: Text('MNO (Monoactive)'),
              ),
              PopupMenuItem(
                value: Valence.prl,
                child: Text('PRL (Parallel)'),
              ),
              PopupMenuItem(
                value: Valence.cro,
                child: Text('CRO (Corollary)'),
              ),
              PopupMenuItem(
                value: Valence.rcp,
                child: Text('RCP (Reciprocal)'),
              ),
              PopupMenuItem(
                value: Valence.cpl,
                child: Text('CPL (Complementary)'),
              ),
              PopupMenuItem(
                value: Valence.dup,
                child: Text('DUP (Duplicative)'),
              ),
              PopupMenuItem(
                value: Valence.dem,
                child: Text('DEM (Demonstrative)'),
              ),
              PopupMenuItem(
                value: Valence.cng,
                child: Text('CNG (Contingent)'),
              ),
              PopupMenuItem(
                value: Valence.pti,
                child: Text('PTI (Participative)'),
              ),
            ],
            child: ListTile(
              leading: const Icon(Icons.sports_kabaddi_outlined),
              title: const Text("Valence"),
              subtitle: Text(
                switch (valence) {
                  Valence.mno => 'MNO (Monoactive)',
                  Valence.prl => 'PRL (Parallel)',
                  Valence.cro => 'CRO (Corollary)',
                  Valence.rcp => 'RCP (Reciprocal)',
                  Valence.cpl => 'CPL (Complementary)',
                  Valence.dup => 'DUP (Duplicative)',
                  Valence.dem => 'DEM (Demonstrative)',
                  Valence.cng => 'CNG (Contingent)',
                  Valence.pti => 'PTI (Participative)',
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        PhaseVn(phase: final phase) => PopupMenuButton<Phase>(
            onSelected: (Phase newPhase) {
              widget.updateFormative((f) {
                f.vnCn.vn = PhaseVn(newPhase);
              });
            },
            offset: const Offset(1, 0),
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<Phase>>[
              PopupMenuItem(
                value: Phase.pct,
                child: Text('PCT (Punctual)'),
              ),
              PopupMenuItem(
                value: Phase.itr,
                child: Text('ITR (Iterative)'),
              ),
              PopupMenuItem(
                value: Phase.rep,
                child: Text('REP (Repetitive)'),
              ),
              PopupMenuItem(
                value: Phase.itm,
                child: Text('ITM (Intermittent)'),
              ),
              PopupMenuItem(
                value: Phase.rct,
                child: Text('RCT (Recurrent)'),
              ),
              PopupMenuItem(
                value: Phase.fre,
                child: Text('FRE (Frequentative)'),
              ),
              PopupMenuItem(
                value: Phase.frg,
                child: Text('FRG (Fragmentative)'),
              ),
              PopupMenuItem(
                value: Phase.vac,
                child: Text('VAC (Vacillitative)'),
              ),
              PopupMenuItem(
                value: Phase.flc,
                child: Text('FLC (Fluctuative)'),
              ),
            ],
            child: ListTile(
              leading: const Icon(Icons.sports_kabaddi_outlined),
              title: const Text("Phase"),
              subtitle: Text(
                switch (phase) {
                  Phase.pct => 'PCT (Punctual)',
                  Phase.itr => 'ITR (Iterative)',
                  Phase.rep => 'REP (Repetitive)',
                  Phase.itm => 'ITM (Intermittent)',
                  Phase.rct => 'RCT (Recurrent)',
                  Phase.fre => 'FRE (Frequentative)',
                  Phase.frg => 'FRG (Fragmentative)',
                  Phase.vac => 'VAC (Vacillitative)',
                  Phase.flc => 'FLC (Fluctuative)',
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        // TODO: Handle this case.
        EffectVn() => ListTile(
            leading: const Icon(Icons.sports_kabaddi_outlined),
            title: const Text("Effect"),
            subtitle: const Text("TODO"),
            onTap: () {},
          ),
        // TODO: Handle this case.
        LevelVn() => ListTile(
            leading: const Icon(Icons.sports_kabaddi_outlined),
            title: const Text("Level"),
            subtitle: const Text("TODO"),
            onTap: () {},
          ),
        // TODO: Handle this case.
        AspectVn() => ListTile(
            leading: const Icon(Icons.sports_kabaddi_outlined),
            title: const Text("Aspect"),
            subtitle: const Text("TODO"),
            onTap: () {},
          ),
      },
      const ListGroupTitle("Ca"),
      PopupMenuButton<Affiliation>(
        onSelected: (Affiliation affiliation) {
          widget.updateFormative((f) {
            f.affiliation = affiliation;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Affiliation>>[
          PopupMenuItem(
            value: Affiliation.csl,
            child: Text('CSL (Consolidative)'),
          ),
          PopupMenuItem(
            value: Affiliation.aso,
            child: Text('ASO (Associative)'),
          ),
          PopupMenuItem(
            value: Affiliation.coa,
            child: Text('COA (Coalescent)'),
          ),
          PopupMenuItem(
            value: Affiliation.var$,
            child: Text('VAR (Variative)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Affiliation"),
          subtitle: Text(
            switch (widget.formative.affiliation) {
              Affiliation.csl => 'CSL (Consolidative)',
              Affiliation.aso => 'ASO (Associative)',
              Affiliation.coa => 'COA (Coalescent)',
              Affiliation.var$ => 'VAR (Variative)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Plexity>(
        onSelected: (Plexity newPlexity) {
          widget.updateFormative((f) {
            final similarity = f.configuration.similarity;
            final separability = f.configuration.separability;
            if (similarity == null && separability == null && newPlexity == Plexity.m) {
              f.configuration = Configuration.from(Plexity.m, Similarity.s, Separability.s)!;
            } else if (similarity != null && separability != null && newPlexity == Plexity.u) {
              f.configuration = Configuration.from(Plexity.u, null, null)!;
            } else {
              f.configuration.plexity = newPlexity;
            }
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Plexity>>[
          PopupMenuItem(
            value: Plexity.u,
            child: Text('U (Uniplex)'),
          ),
          PopupMenuItem(
            value: Plexity.d,
            child: Text('D (Duplex)'),
          ),
          PopupMenuItem(
            value: Plexity.m,
            child: Text('M (Multiplex)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.animation),
          title: const Text("Plexity"),
          subtitle: Text(
            switch (widget.formative.configuration.plexity) {
              Plexity.u => 'U (Uniplex)',
              Plexity.d => 'D (Duplex)',
              Plexity.m => 'M (Multiplex)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      widget.formative.configuration.plexity != Plexity.u
          ? PopupMenuButton<Option<Similarity>>(
              onSelected: (Option<Similarity> newSimilarity) {
                widget.updateFormative((f) {
                  final plexity = widget.formative.configuration.plexity;
                  final similarity = widget.formative.configuration.similarity;
                  if (similarity == null && newSimilarity.isSome()) {
                    widget.formative.configuration =
                        Configuration.from(plexity, newSimilarity.into(), Separability.s)!;
                  } else if (similarity != null && newSimilarity.isNone()) {
                    widget.formative.configuration =
                        Configuration.from(plexity, newSimilarity.into(), null)!;
                  } else {
                    widget.formative.configuration.similarity = newSimilarity.into();
                  }
                });
              },
              offset: const Offset(1, 0),
              itemBuilder: (BuildContext context) => const <PopupMenuEntry<Option<Similarity>>>[
                PopupMenuItem(
                  value: None(),
                  child: Text('None'),
                ),
                PopupMenuItem(
                  value: Some(Similarity.s),
                  child: Text('S (Similar)'),
                ),
                PopupMenuItem(
                  value: Some(Similarity.d),
                  child: Text('D (Dissimilar)'),
                ),
                PopupMenuItem(
                  value: Some(Similarity.f),
                  child: Text('F (Fuzzy)'),
                ),
              ],
              child: ListTile(
                leading: const Icon(Icons.animation),
                title: const Text("Similarity"),
                subtitle: Text(
                  switch (widget.formative.configuration.similarity) {
                    Similarity.s => 'S (Similar)',
                    Similarity.d => 'D (Dissimilar)',
                    Similarity.f => 'F (Fuzzy)',
                    null => 'None'
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          : Container(),
      widget.formative.configuration.plexity != Plexity.u
          ? PopupMenuButton<Option<Separability>>(
              onSelected: (Option<Separability> newSeparability) {
                widget.updateFormative((f) {
                  final plexity = widget.formative.configuration.plexity;
                  final separability = widget.formative.configuration.separability;
                  if (separability == null && newSeparability.isSome()) {
                    widget.formative.configuration =
                        Configuration.from(plexity, Similarity.s, newSeparability.into())!;
                  } else if (separability != null && newSeparability.isNone()) {
                    widget.formative.configuration =
                        Configuration.from(plexity, null, newSeparability.into())!;
                  } else {
                    widget.formative.configuration.separability = newSeparability.into();
                  }
                });
              },
              offset: const Offset(1, 0),
              itemBuilder: (BuildContext context) => const <PopupMenuEntry<Option<Separability>>>[
                PopupMenuItem(
                  value: None(),
                  child: Text('None'),
                ),
                PopupMenuItem(
                  value: Some(Separability.s),
                  child: Text('S (Separate)'),
                ),
                PopupMenuItem(
                  value: Some(Separability.c),
                  child: Text('C (Connected)'),
                ),
                PopupMenuItem(
                  value: Some(Separability.f),
                  child: Text('F (Fused)'),
                ),
              ],
              child: ListTile(
                leading: const Icon(Icons.animation),
                title: const Text("Separability"),
                subtitle: Text(
                  switch (widget.formative.configuration.separability) {
                    Separability.s => 'S (Separate)',
                    Separability.c => 'C (Connected)',
                    Separability.f => 'F (Fused)',
                    null => 'None'
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          : Container(),
      PopupMenuButton<Extension>(
        onSelected: (Extension extension) {
          widget.updateFormative((f) {
            f.extension = extension;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Extension>>[
          PopupMenuItem(
            value: Extension.del,
            child: Text('DEL (Delimitive)'),
          ),
          PopupMenuItem(
            value: Extension.prx,
            child: Text('PRX (Proximal)'),
          ),
          PopupMenuItem(
            value: Extension.icp,
            child: Text('ICP (Inceptive)'),
          ),
          PopupMenuItem(
            value: Extension.atv,
            child: Text('ATV (Attenuative)'),
          ),
          PopupMenuItem(
            value: Extension.gra,
            child: Text('GRA (Graduative)'),
          ),
          PopupMenuItem(
            value: Extension.dpl,
            child: Text('DPL (Depletive)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Extension"),
          subtitle: Text(
            switch (widget.formative.extension) {
              Extension.del => 'DEL (Delimitive)',
              Extension.prx => 'PRX (Proximal)',
              Extension.icp => 'ICP (Inceptive)',
              Extension.atv => 'ATV (Attenuative)',
              Extension.gra => 'GRA (Graduative)',
              Extension.dpl => 'DPL (Depletive)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Perspective>(
        onSelected: (Perspective perspective) {
          widget.updateFormative((f) {
            f.perspective = perspective;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Perspective>>[
          PopupMenuItem(
            value: Perspective.m,
            child: Text('M (Monadic)'),
          ),
          PopupMenuItem(
            value: Perspective.g,
            child: Text('G (Agglomerative)'),
          ),
          PopupMenuItem(
            value: Perspective.n,
            child: Text('N (Nomic)'),
          ),
          PopupMenuItem(
            value: Perspective.a,
            child: Text('A (Abstract)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Perspective"),
          subtitle: Text(
            switch (widget.formative.perspective) {
              Perspective.m => 'M (Monadic)',
              Perspective.g => 'G (Agglomerative)',
              Perspective.n => 'N (Nomic)',
              Perspective.a => 'A (Abstract)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Essence>(
        onSelected: (Essence essence) {
          widget.updateFormative((f) {
            f.essence = essence;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Essence>>[
          PopupMenuItem(
            value: Essence.nrm,
            child: Text('NRM (Normal)'),
          ),
          PopupMenuItem(
            value: Essence.rpv,
            child: Text('RPV (Representative)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Essence"),
          subtitle: Text(
            switch (widget.formative.essence) {
              Essence.nrm => 'NRM (Normal)',
              Essence.rpv => 'RPV (Representative)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      const ListGroupTitle("Formative Type etc."),
      PopupMenuButton<FormativeType>(
        onSelected: (FormativeType newFormativeType) {
          widget.updateFormative((f) {
            if (f.formativeType.runtimeType == newFormativeType.runtimeType) {
              return;
            }
            f.formativeType = switch (f.formativeType) {
              Standalone(relation: final relation) => switch (newFormativeType) {
                  Standalone() => throw 'unreachable',
                  Parent() => Parent(relation),
                  Concatenated() => Concatenated(
                      format: switch (relation) {
                        Noun(case$: final case$) => case$,
                        FramedVerb() => Case.thm,
                        UnframedVerb() => Case.thm,
                      },
                      concatenation: Concatenation.type1,
                    ),
                },
              Parent(relation: final relation) => switch (newFormativeType) {
                  Standalone() => Standalone(relation),
                  Parent() => throw 'unreachable',
                  Concatenated() => Concatenated(
                      format: switch (relation) {
                        Noun(case$: final case$) => case$,
                        FramedVerb() => Case.thm,
                        UnframedVerb() => Case.thm,
                      },
                      concatenation: Concatenation.type1,
                    ),
                },
              Concatenated(format: final format) => switch (newFormativeType) {
                  Standalone() => Standalone(Noun(format)),
                  Parent() => Parent(Noun(format)),
                  Concatenated() => throw 'unreachable',
                }
            };
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<FormativeType>>[
          // The arguments inside the FormativeType class below are all just placeholders.
          PopupMenuItem(
            value: Standalone(Noun(Case.thm)),
            child: Text('Standalone'),
          ),
          PopupMenuItem(
            value: Parent(Noun(Case.thm)),
            child: Text('Parent'),
          ),
          PopupMenuItem(
            value: Concatenated(
              format: Case.thm,
              concatenation: Concatenation.type1,
            ),
            child: Text('Concatenated'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Formative Type"),
          subtitle: Text(
            switch (widget.formative.formativeType) {
              Standalone() => 'Standalone',
              Parent() => 'Parent',
              Concatenated() => 'Concatenated',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      switch (widget.formative.formativeType) {
        Standalone(relation: Relation relation) ||
        Parent(relation: Relation relation) =>
          PopupMenuButton<Relation>(
            onSelected: (Relation newRelation) {
              widget.updateFormative((f) {
                widget.formative.formativeType = switch (widget.formative.formativeType) {
                  Standalone() => Standalone(newRelation),
                  Parent() => Parent(newRelation),
                  Concatenated() => throw "unreachable",
                };
              });
            },
            offset: const Offset(1, 0),
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<Relation>>[
              PopupMenuItem(
                value: Noun(Case.thm),
                child: Text('Noun'),
              ),
              PopupMenuItem(
                value: UnframedVerb(
                  illocution: Illocution.asr,
                  validation: Validation.usp,
                ),
                child: Text('Unframed Verb'),
              ),
              PopupMenuItem(
                value: FramedVerb(
                  illocution: Illocution.asr,
                  validation: Validation.usp,
                ),
                child: Text('Framed Verb'),
              ),
            ],
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("Relation"),
              subtitle: Text(
                switch (relation) {
                  Noun() => 'Noun',
                  UnframedVerb() => 'Unframed Verb',
                  FramedVerb() => 'Framed Verb',
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        Concatenated(format: final format, concatenation: final concatenation) =>
          PopupMenuButton<Concatenation>(
            onSelected: (Concatenation newConcatenation) {
              widget.updateFormative((f) {
                f.formativeType = switch (f.formativeType) {
                  Standalone() => throw 'unreachable',
                  Parent() => throw 'unreachable',
                  Concatenated() => Concatenated(
                      format: format,
                      concatenation: newConcatenation,
                    ),
                };
              });
            },
            offset: const Offset(1, 0),
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<Concatenation>>[
              PopupMenuItem(
                value: Concatenation.type1,
                child: Text("Type 1"),
              ),
              PopupMenuItem(
                value: Concatenation.type2,
                child: Text("Type 2"),
              ),
            ],
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("Concatenation"),
              subtitle: Text(
                switch (concatenation) {
                  Concatenation.type1 => "Type 1",
                  Concatenation.type2 => "Type 2",
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
      },
      ...(switch (widget.formative.formativeType) {
        Standalone(relation: final relation) || Parent(relation: final relation) => switch (
              relation) {
            Noun(case$: final case$) => [
                PopupMenuButton<CaseType>(
                  onSelected: (CaseType caseType) {
                    widget.updateFormative((f) {
                      f.formativeType = switch (f.formativeType) {
                        Standalone() => Standalone(Noun(Case(
                            caseType: caseType,
                            caseNumber: CaseNumber.c1,
                          ))),
                        Parent() => Parent(Noun(Case(
                            caseType: caseType,
                            caseNumber: CaseNumber.c1,
                          ))),
                        Concatenated() => throw 'unreachable',
                      };
                    });
                  },
                  offset: const Offset(1, 0),
                  itemBuilder: (BuildContext context) => const <PopupMenuEntry<CaseType>>[
                    PopupMenuItem(
                      value: CaseType.transrelative,
                      child: Text('Transrelative'),
                    ),
                    PopupMenuItem(
                      value: CaseType.appositive,
                      child: Text('Appositive'),
                    ),
                    PopupMenuItem(
                      value: CaseType.associative,
                      child: Text('Associative'),
                    ),
                    PopupMenuItem(
                      value: CaseType.adverbial,
                      child: Text('Adverbial'),
                    ),
                    PopupMenuItem(
                      value: CaseType.relational,
                      child: Text('Relational'),
                    ),
                    PopupMenuItem(
                      value: CaseType.affinitive,
                      child: Text('Affinitive'),
                    ),
                    PopupMenuItem(
                      value: CaseType.spatioTemporal1,
                      child: Text('Spatio Temporal I'),
                    ),
                    PopupMenuItem(
                      value: CaseType.spatioTemporal2,
                      child: Text('Spatio Temporal II'),
                    ),
                  ],
                  child: ListTile(
                    leading: const Icon(Icons.group_outlined),
                    title: const Text("Case Type"),
                    subtitle: Text(
                      switch (case$.caseType) {
                        CaseType.transrelative => 'Transrelative Cases',
                        CaseType.appositive => 'Appositive Cases',
                        CaseType.associative => 'Associative Cases',
                        CaseType.adverbial => 'Adverbial Cases',
                        CaseType.relational => 'Relational Cases',
                        CaseType.affinitive => 'Affinitive Cases',
                        CaseType.spatioTemporal1 => 'Spatio Temporal Cases - Group I',
                        CaseType.spatioTemporal2 => 'Spatio Temporal Cases - Group II',
                      },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                PopupMenuButton<CaseNumber>(
                  onSelected: (CaseNumber caseNumber) {
                    widget.updateFormative((f) {
                      f.formativeType = switch (f.formativeType) {
                        Standalone() => Standalone(Noun(Case(
                            caseType: case$.caseType,
                            caseNumber: caseNumber,
                          ))),
                        Parent() => Parent(Noun(Case(
                            caseType: case$.caseType,
                            caseNumber: caseNumber,
                          ))),
                        Concatenated() => throw 'unreachable',
                      };
                    });
                  },
                  offset: const Offset(1, 0),
                  itemBuilder: (BuildContext context) {
                    final case1 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c1);
                    final case2 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c2);
                    final case3 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c3);
                    final case4 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c4);
                    final case5 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c5);
                    final case6 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c6);
                    final case7 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c7);
                    final case8 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c8);
                    final case9 = Case(caseType: case$.caseType, caseNumber: CaseNumber.c9);
                    return <PopupMenuEntry<CaseNumber>>[
                      PopupMenuItem(
                        value: CaseNumber.c1,
                        child: Text("${case1.name()} (${case1.fullName()})"),
                      ),
                      PopupMenuItem(
                        value: CaseNumber.c2,
                        child: Text("${case2.name()} (${case2.fullName()})"),
                      ),
                      PopupMenuItem(
                        value: CaseNumber.c3,
                        child: Text("${case3.name()} (${case3.fullName()})"),
                      ),
                      PopupMenuItem(
                        value: CaseNumber.c4,
                        child: Text("${case4.name()} (${case4.fullName()})"),
                      ),
                      PopupMenuItem(
                        value: CaseNumber.c5,
                        child: Text("${case5.name()} (${case5.fullName()})"),
                      ),
                      PopupMenuItem(
                        value: CaseNumber.c6,
                        child: Text("${case6.name()} (${case6.fullName()})"),
                      ),
                      PopupMenuItem(
                        value: CaseNumber.c7,
                        child: Text("${case7.name()} (${case7.fullName()})"),
                      ),
                      ...(case$.caseType.hasNineCaseNumber()
                          ? [
                              PopupMenuItem(
                                value: CaseNumber.c8,
                                child: Text("${case8.name()} (${case8.fullName()})"),
                              ),
                            ]
                          : []),
                      PopupMenuItem(
                        value: CaseNumber.c9,
                        child: Text("${case9.name()} (${case9.fullName()})"),
                      ),
                    ];
                  },
                  child: ListTile(
                    leading: const Icon(Icons.group_outlined),
                    title: const Text("Case"),
                    subtitle: Text(
                      "${case$.name()} (${case$.fullName()})",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            FramedVerb(
              illocution: final illocution,
              validation: final validation,
            ) ||
            UnframedVerb(
              illocution: final illocution,
              validation: final validation,
            ) =>
              [
                PopupMenuButton<Illocution>(
                  onSelected: (Illocution newIllocution) {
                    widget.updateFormative((f) {
                      f.formativeType = switch (f.formativeType) {
                        Standalone() => Standalone(switch (relation) {
                            Noun() => throw 'unreachable',
                            FramedVerb() => FramedVerb(
                                illocution: newIllocution,
                                validation: validation,
                              ),
                            UnframedVerb() => UnframedVerb(
                                illocution: newIllocution,
                                validation: validation,
                              ),
                          }),
                        Parent() => Parent(switch (relation) {
                            Noun() => throw 'unreachable',
                            FramedVerb() => FramedVerb(
                                illocution: newIllocution,
                                validation: validation,
                              ),
                            UnframedVerb() => UnframedVerb(
                                illocution: newIllocution,
                                validation: validation,
                              ),
                          }),
                        Concatenated() => throw 'unreachable',
                      };
                    });
                  },
                  offset: const Offset(1, 0),
                  itemBuilder: (BuildContext context) => const <PopupMenuEntry<Illocution>>[
                    PopupMenuItem(
                      value: Illocution.asr,
                      child: Text('ASR (Assertive)'),
                    ),
                    PopupMenuItem(
                      value: Illocution.dir,
                      child: Text('DIR (Directive)'),
                    ),
                    PopupMenuItem(
                      value: Illocution.dec,
                      child: Text('DEC (Declarative)'),
                    ),
                    PopupMenuItem(
                      value: Illocution.irg,
                      child: Text('IRG (Interrogative)'),
                    ),
                    PopupMenuItem(
                      value: Illocution.ver,
                      child: Text('VER (Verificative)'),
                    ),
                    PopupMenuItem(
                      value: Illocution.adm,
                      child: Text('ADM (Admonitive)'),
                    ),
                    PopupMenuItem(
                      value: Illocution.pot,
                      child: Text('POT (Potentiative)'),
                    ),
                    PopupMenuItem(
                      value: Illocution.hor,
                      child: Text('HOR (Hortative)'),
                    ),
                    PopupMenuItem(
                      value: Illocution.cnj,
                      child: Text('CNJ (Conjectural)'),
                    ),
                  ],
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text("Illocution"),
                    subtitle: Text(
                      switch (illocution) {
                        Illocution.asr => 'ASR (Assertive)',
                        Illocution.dir => 'DIR (Directive)',
                        Illocution.dec => 'DEC (Declarative)',
                        Illocution.irg => 'IRG (Interrogative)',
                        Illocution.ver => 'VER (Verificative)',
                        Illocution.adm => 'ADM (Admonitive)',
                        Illocution.pot => 'POT (Potentiative)',
                        Illocution.hor => 'HOR (Hortative)',
                        Illocution.cnj => 'CNJ (Conjectural)',
                      },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                PopupMenuButton<Validation>(
                  onSelected: (Validation newValidation) {
                    widget.updateFormative((f) {
                      f.formativeType = switch (f.formativeType) {
                        Standalone() => Standalone(switch (relation) {
                            Noun() => throw 'unreachable',
                            FramedVerb() => FramedVerb(
                                illocution: illocution,
                                validation: newValidation,
                              ),
                            UnframedVerb() => UnframedVerb(
                                illocution: illocution,
                                validation: newValidation,
                              ),
                          }),
                        Parent() => Parent(switch (relation) {
                            Noun() => throw 'unreachable',
                            FramedVerb() => FramedVerb(
                                illocution: illocution,
                                validation: newValidation,
                              ),
                            UnframedVerb() => UnframedVerb(
                                illocution: illocution,
                                validation: newValidation,
                              ),
                          }),
                        Concatenated() => throw 'unreachable',
                      };
                    });
                  },
                  offset: const Offset(1, 0),
                  itemBuilder: (BuildContext context) => const <PopupMenuEntry<Validation>>[
                    PopupMenuItem(
                      value: Validation.obs,
                      child: Text('OBS (Observational)'),
                    ),
                    PopupMenuItem(
                      value: Validation.rec,
                      child: Text('REC (Recollective)'),
                    ),
                    PopupMenuItem(
                      value: Validation.pup,
                      child: Text('PUP (Purportive)'),
                    ),
                    PopupMenuItem(
                      value: Validation.rpr,
                      child: Text('RPR (Reportive)'),
                    ),
                    PopupMenuItem(
                      value: Validation.usp,
                      child: Text('USP (Unspecified)'),
                    ),
                    PopupMenuItem(
                      value: Validation.ima,
                      child: Text('IMA (Imaginary)'),
                    ),
                    PopupMenuItem(
                      value: Validation.cvn,
                      child: Text('CVN (Conventional)'),
                    ),
                    PopupMenuItem(
                      value: Validation.itu,
                      child: Text('ITU (Intuitive)'),
                    ),
                    PopupMenuItem(
                      value: Validation.inf,
                      child: Text('INF (Inferential)'),
                    ),
                  ],
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text("Validation"),
                    subtitle: Text(
                      switch (validation) {
                        Validation.obs => 'OBS (Observational)',
                        Validation.rec => 'REC (Recollective)',
                        Validation.pup => 'PUP (Purportive)',
                        Validation.rpr => 'RPR (Reportive)',
                        Validation.usp => 'USP (Unspecified)',
                        Validation.ima => 'IMA (Imaginary)',
                        Validation.cvn => 'CVN (Conventional)',
                        Validation.itu => 'ITU (Intuitive)',
                        Validation.inf => 'INF (Inferential)',
                      },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
          },
        Concatenated(format: final format, concatenation: final concatenation) => [
            PopupMenuButton<CaseType>(
              onSelected: (CaseType newCaseType) {
                widget.updateFormative((f) {
                  f.formativeType = switch (f.formativeType) {
                    Standalone() => throw 'unreachable',
                    Parent() => throw 'unreachable',
                    Concatenated() => Concatenated(
                        format: Case(
                          caseType: newCaseType,
                          caseNumber: format.caseNumber,
                        ),
                        concatenation: concatenation,
                      ),
                  };
                });
              },
              offset: const Offset(1, 0),
              itemBuilder: (BuildContext context) => const <PopupMenuEntry<CaseType>>[
                PopupMenuItem(
                  value: CaseType.transrelative,
                  child: Text('Transrelative'),
                ),
                PopupMenuItem(
                  value: CaseType.appositive,
                  child: Text('Appositive'),
                ),
                PopupMenuItem(
                  value: CaseType.associative,
                  child: Text('Associative'),
                ),
                PopupMenuItem(
                  value: CaseType.adverbial,
                  child: Text('Adverbial'),
                ),
                PopupMenuItem(
                  value: CaseType.relational,
                  child: Text('Relational'),
                ),
                PopupMenuItem(
                  value: CaseType.affinitive,
                  child: Text('Affinitive'),
                ),
                PopupMenuItem(
                  value: CaseType.spatioTemporal1,
                  child: Text('Spatio Temporal I'),
                ),
                PopupMenuItem(
                  value: CaseType.spatioTemporal2,
                  child: Text('Spatio Temporal II'),
                ),
              ],
              child: ListTile(
                leading: const Icon(Icons.group_outlined),
                title: const Text("Format Type"),
                subtitle: Text(
                  switch (format.caseType) {
                    CaseType.transrelative => 'Transrelative Formats',
                    CaseType.appositive => 'Appositive Formats',
                    CaseType.associative => 'Associative Formats',
                    CaseType.adverbial => 'Adverbial Formats',
                    CaseType.relational => 'Relational Formats',
                    CaseType.affinitive => 'Affinitive Formats',
                    CaseType.spatioTemporal1 => 'Spatio Temporal Formats - Group I',
                    CaseType.spatioTemporal2 => 'Spatio Temporal Formats - Group II',
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            PopupMenuButton<CaseNumber>(
              onSelected: (CaseNumber newCaseNumber) {
                widget.updateFormative((f) {
                  f.formativeType = switch (f.formativeType) {
                    Standalone() => throw 'unreachable',
                    Parent() => throw 'unreachable',
                    Concatenated() => Concatenated(
                        format: Case(
                          caseType: format.caseType,
                          caseNumber: newCaseNumber,
                        ),
                        concatenation: concatenation,
                      ),
                  };
                });
              },
              offset: const Offset(1, 0),
              itemBuilder: (BuildContext context) {
                final case1 = Case(caseType: format.caseType, caseNumber: CaseNumber.c1);
                final case2 = Case(caseType: format.caseType, caseNumber: CaseNumber.c2);
                final case3 = Case(caseType: format.caseType, caseNumber: CaseNumber.c3);
                final case4 = Case(caseType: format.caseType, caseNumber: CaseNumber.c4);
                final case5 = Case(caseType: format.caseType, caseNumber: CaseNumber.c5);
                final case6 = Case(caseType: format.caseType, caseNumber: CaseNumber.c6);
                final case7 = Case(caseType: format.caseType, caseNumber: CaseNumber.c7);
                final case8 = Case(caseType: format.caseType, caseNumber: CaseNumber.c8);
                final case9 = Case(caseType: format.caseType, caseNumber: CaseNumber.c9);
                return <PopupMenuEntry<CaseNumber>>[
                  PopupMenuItem(
                    value: CaseNumber.c1,
                    child: Text("${case1.name()} (${case1.fullName()})"),
                  ),
                  PopupMenuItem(
                    value: CaseNumber.c2,
                    child: Text("${case2.name()} (${case2.fullName()})"),
                  ),
                  PopupMenuItem(
                    value: CaseNumber.c3,
                    child: Text("${case3.name()} (${case3.fullName()})"),
                  ),
                  PopupMenuItem(
                    value: CaseNumber.c4,
                    child: Text("${case4.name()} (${case4.fullName()})"),
                  ),
                  PopupMenuItem(
                    value: CaseNumber.c5,
                    child: Text("${case5.name()} (${case5.fullName()})"),
                  ),
                  PopupMenuItem(
                    value: CaseNumber.c6,
                    child: Text("${case6.name()} (${case6.fullName()})"),
                  ),
                  PopupMenuItem(
                    value: CaseNumber.c7,
                    child: Text("${case7.name()} (${case7.fullName()})"),
                  ),
                  ...(format.caseType.hasNineCaseNumber()
                      ? [
                          PopupMenuItem(
                            value: CaseNumber.c8,
                            child: Text("${case8.name()} (${case8.fullName()})"),
                          ),
                        ]
                      : []),
                  PopupMenuItem(
                    value: CaseNumber.c9,
                    child: Text("${case9.name()} (${case9.fullName()})"),
                  ),
                ];
              },
              child: ListTile(
                leading: const Icon(Icons.group_outlined),
                title: const Text("Format"),
                subtitle: Text(
                  "${format.name()} (${format.fullName()})",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
      }),
      (switch (widget.formative.formativeType) {
        Standalone(relation: final relation) || Parent(relation: final relation) => switch (
              relation) {
            Noun() => true,
            FramedVerb() => false,
            UnframedVerb() => false,
          },
        Concatenated() => true,
      })
          ? ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("CaseScope"),
              subtitle: const Text("TODO"),
              onTap: () {},
            )
          : ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("Mood"),
              subtitle: const Text("TODO"),
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
