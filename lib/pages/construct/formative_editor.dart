import 'dart:ui';

import 'package:enthrirhs/libs/option/mod.dart';
import 'package:enthrirhs/libs/result/mod.dart';
import 'package:enthrirhs/pages/construct/degree_dialog.dart';
import 'package:enthrirhs/utils/mod.dart';
import 'package:enthrirhs/utils/store.dart';
import 'package:enthrirhs/utils/types.dart' as database;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

import 'package:enthrirhs/libs/misc.dart';
import 'package:provider/provider.dart';
import '../../components/list_group_title.dart';
import '../../libs/ithkuil/mod.dart';
import '../../libs/ithkuil/terms/mod.dart';
import 'affix_type_dialog.dart';

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
      if (mounted) {
        setState(() {
          definition = newDefinition;
        });
      }
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
        child: MarkdownBody(
          data: definition,
          styleSheet: MarkdownStyleSheet(
            p: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            strong: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
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
            if (f.vn.runtimeType == newVn.runtimeType) {
              return;
            }
            f.vn = newVn;
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
            switch (widget.formative.vn) {
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
      switch (widget.formative.vn) {
        ValenceVn(valence: final valence) => PopupMenuButton<Valence>(
            onSelected: (Valence newValence) {
              widget.updateFormative((f) {
                f.vn = ValenceVn(newValence);
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
                f.vn = PhaseVn(newPhase);
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
        EffectVn(effect: final effect) => PopupMenuButton<Effect>(
            onSelected: (Effect newEffect) {
              widget.updateFormative((f) {
                f.vn = EffectVn(newEffect);
              });
            },
            offset: const Offset(1, 0),
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<Effect>>[
              PopupMenuItem(
                value: Effect.ben1,
                child: Text('1:BEN'),
              ),
              PopupMenuItem(
                value: Effect.ben2,
                child: Text('2:BEN'),
              ),
              PopupMenuItem(
                value: Effect.ben3,
                child: Text('3:BEN'),
              ),
              PopupMenuItem(
                value: Effect.benSlf,
                child: Text('SLF:BEN'),
              ),
              PopupMenuItem(
                value: Effect.unk,
                child: Text('UNK'),
              ),
              PopupMenuItem(
                value: Effect.detSlf,
                child: Text('SLF:DET'),
              ),
              PopupMenuItem(
                value: Effect.det3,
                child: Text('3:DET'),
              ),
              PopupMenuItem(
                value: Effect.det2,
                child: Text('2:DET'),
              ),
              PopupMenuItem(
                value: Effect.det1,
                child: Text('1:DET'),
              ),
            ],
            child: ListTile(
              leading: const Icon(Icons.sports_kabaddi_outlined),
              title: const Text("Effect"),
              subtitle: Text(
                switch (effect) {
                  Effect.ben1 => '1:BEN (Beneficial to Speaker)',
                  Effect.ben2 => '2:BEN (Beneficial to Addressee)',
                  Effect.ben3 => '3:BEN (Beneficial to Third Party)',
                  Effect.benSlf => 'SLF:BEN (Beneficial to Self)',
                  Effect.unk => 'UNK (Unknown Benefit)',
                  Effect.detSlf => 'SLF:DET (Detrimental to Self)',
                  Effect.det3 => '3:DET (Detrimental to Third Party)',
                  Effect.det2 => '2:DET (Detrimental to Addressee)',
                  Effect.det1 => '1:DET (Detrimental to Speaker)',
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        LevelVn(level: final level) => PopupMenuButton<ComparisonOperator>(
            onSelected: (ComparisonOperator newComparisonOperator) {
              widget.updateFormative((f) {
                f.vn = LevelVn(newComparisonOperator);
              });
            },
            offset: const Offset(1, 0),
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<ComparisonOperator>>[
              PopupMenuItem(
                value: ComparisonOperator.min,
                child: Text('MIN (Minimal)'),
              ),
              PopupMenuItem(
                value: ComparisonOperator.sbe,
                child: Text('SBE (Subequative)'),
              ),
              PopupMenuItem(
                value: ComparisonOperator.ifr,
                child: Text('IFR (Inferior)'),
              ),
              PopupMenuItem(
                value: ComparisonOperator.dft,
                child: Text('DFT (Deficient)'),
              ),
              PopupMenuItem(
                value: ComparisonOperator.equ,
                child: Text('EQU (Equative)'),
              ),
              PopupMenuItem(
                value: ComparisonOperator.sur,
                child: Text('SUR (Surpassive)'),
              ),
              PopupMenuItem(
                value: ComparisonOperator.spl,
                child: Text('SPL (Superlative)'),
              ),
              PopupMenuItem(
                value: ComparisonOperator.spq,
                child: Text('SPQ (Superequative)'),
              ),
              PopupMenuItem(
                value: ComparisonOperator.max,
                child: Text('MAX (Maximal)'),
              ),
            ],
            child: ListTile(
              leading: const Icon(Icons.sports_kabaddi_outlined),
              title: const Text("Level"),
              subtitle: Text(
                switch (level) {
                  ComparisonOperator.min => 'MIN (Minimal)',
                  ComparisonOperator.sbe => 'SBE (Subequative)',
                  ComparisonOperator.ifr => 'IFR (Inferior)',
                  ComparisonOperator.dft => 'DFT (Deficient)',
                  ComparisonOperator.equ => 'EQU (Equative)',
                  ComparisonOperator.sur => 'SUR (Surpassive)',
                  ComparisonOperator.spl => 'SPL (Superlative)',
                  ComparisonOperator.spq => 'SPQ (Superequative)',
                  ComparisonOperator.max => 'MAX (Maximal)',
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        AspectVn(aspect: final aspect) => PopupMenuButton<Aspect>(
            onSelected: (Aspect newAspect) {
              widget.updateFormative((f) {
                f.vn = AspectVn(newAspect);
              });
            },
            offset: const Offset(1, 0),
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<Aspect>>[
              PopupMenuItem(
                value: Aspect.rtr,
                child: Text('RTR (Retrospective)'),
              ),
              PopupMenuItem(
                value: Aspect.prs,
                child: Text('PRS (Prospective)'),
              ),
              PopupMenuItem(
                value: Aspect.hab,
                child: Text('HAB (Habitual)'),
              ),
              PopupMenuItem(
                value: Aspect.prg,
                child: Text('PRG (Progressive)'),
              ),
              PopupMenuItem(
                value: Aspect.imm,
                child: Text('IMM (Imminent)'),
              ),
              PopupMenuItem(
                value: Aspect.pcs,
                child: Text('PCS (Precessive)'),
              ),
              PopupMenuItem(
                value: Aspect.reg,
                child: Text('REG (Regulative)'),
              ),
              PopupMenuItem(
                value: Aspect.smm,
                child: Text('SMM (Summative)'),
              ),
              PopupMenuItem(
                value: Aspect.atp,
                child: Text('ATP (Anticipatory)'),
              ),
              PopupMenuItem(
                value: Aspect.rsm,
                child: Text('RSM (Resumptive)'),
              ),
              PopupMenuItem(
                value: Aspect.css,
                child: Text('CSS (Cessative)'),
              ),
              PopupMenuItem(
                value: Aspect.pau,
                child: Text('PAU (Pausal)'),
              ),
              PopupMenuItem(
                value: Aspect.rgr,
                child: Text('RGR (Regressive)'),
              ),
              PopupMenuItem(
                value: Aspect.pcl,
                child: Text('PCL (Preclusive)'),
              ),
              PopupMenuItem(
                value: Aspect.cnt,
                child: Text('CNT (Continuative)'),
              ),
              PopupMenuItem(
                value: Aspect.ics,
                child: Text('ICS (Incessative)'),
              ),
              PopupMenuItem(
                value: Aspect.exp,
                child: Text('EXP (Experiential)'),
              ),
              PopupMenuItem(
                value: Aspect.irp,
                child: Text('IRP (Interruptive)'),
              ),
              PopupMenuItem(
                value: Aspect.pmp,
                child: Text('PMP (Preemptive)'),
              ),
              PopupMenuItem(
                value: Aspect.clm,
                child: Text('CLM (Climactic)'),
              ),
              PopupMenuItem(
                value: Aspect.dlt,
                child: Text('DLT (Dilatory)'),
              ),
              PopupMenuItem(
                value: Aspect.tmp,
                child: Text('TMP (Temporary)'),
              ),
              PopupMenuItem(
                value: Aspect.xpd,
                child: Text('XPD (Expenditive)'),
              ),
              PopupMenuItem(
                value: Aspect.lim,
                child: Text('LIM (Limitative)'),
              ),
              PopupMenuItem(
                value: Aspect.epd,
                child: Text('EPD (Expeditive)'),
              ),
              PopupMenuItem(
                value: Aspect.ptc,
                child: Text('PTC (Protractive)'),
              ),
              PopupMenuItem(
                value: Aspect.ppr,
                child: Text('PPR (Preparatory)'),
              ),
              PopupMenuItem(
                value: Aspect.dcl,
                child: Text('DCL (Disclusive)'),
              ),
              PopupMenuItem(
                value: Aspect.ccl,
                child: Text('CCL (Conclusive)'),
              ),
              PopupMenuItem(
                value: Aspect.cul,
                child: Text('CUL (Culminative)'),
              ),
              PopupMenuItem(
                value: Aspect.imd,
                child: Text('IMD (Intermediative)'),
              ),
              PopupMenuItem(
                value: Aspect.trd,
                child: Text('TRD (Tardative)'),
              ),
              PopupMenuItem(
                value: Aspect.tns,
                child: Text('TNS (Transitional)'),
              ),
              PopupMenuItem(
                value: Aspect.itc,
                child: Text('ITC (Intercommutative)'),
              ),
              PopupMenuItem(
                value: Aspect.mtv,
                child: Text('MTV (Motive)'),
              ),
              PopupMenuItem(
                value: Aspect.sqn,
                child: Text('SQN (Sequential)'),
              ),
            ],
            child: ListTile(
              leading: const Icon(Icons.sports_kabaddi_outlined),
              title: const Text("Aspect"),
              subtitle: Text(
                switch (aspect) {
                  Aspect.rtr => 'RTR (Retrospective)',
                  Aspect.prs => 'PRS (Prospective)',
                  Aspect.hab => 'HAB (Habitual)',
                  Aspect.prg => 'PRG (Progressive)',
                  Aspect.imm => 'IMM (Imminent)',
                  Aspect.pcs => 'PCS (Precessive)',
                  Aspect.reg => 'REG (Regulative)',
                  Aspect.smm => 'SMM (Summative)',
                  Aspect.atp => 'ATP (Anticipatory)',
                  Aspect.rsm => 'RSM (Resumptive)',
                  Aspect.css => 'CSS (Cessative)',
                  Aspect.pau => 'PAU (Pausal)',
                  Aspect.rgr => 'RGR (Regressive)',
                  Aspect.pcl => 'PCL (Preclusive)',
                  Aspect.cnt => 'CNT (Continuative)',
                  Aspect.ics => 'ICS (Incessative)',
                  Aspect.exp => 'EXP (Experiential)',
                  Aspect.irp => 'IRP (Interruptive)',
                  Aspect.pmp => 'PMP (Preemptive)',
                  Aspect.clm => 'CLM (Climactic)',
                  Aspect.dlt => 'DLT (Dilatory)',
                  Aspect.tmp => 'TMP (Temporary)',
                  Aspect.xpd => 'XPD (Expenditive)',
                  Aspect.lim => 'LIM (Limitative)',
                  Aspect.epd => 'EPD (Expeditive)',
                  Aspect.ptc => 'PTC (Protractive)',
                  Aspect.ppr => 'PPR (Preparatory)',
                  Aspect.dcl => 'DCL (Disclusive)',
                  Aspect.ccl => 'CCL (Conclusive)',
                  Aspect.cul => 'CUL (Culminative)',
                  Aspect.imd => 'IMD (Intermediative)',
                  Aspect.trd => 'TRD (Tardative)',
                  Aspect.tns => 'TNS (Transitional)',
                  Aspect.itc => 'ITC (Intercommutative)',
                  Aspect.mtv => 'MTV (Motive)',
                  Aspect.sqn => 'SQN (Sequential)',
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
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
      widget.formative.formativeType.isCaseScope()
          ? PopupMenuButton<Cn>(
              onSelected: (Cn newCn) {
                widget.updateFormative((f) {
                  f.cn = newCn;
                });
              },
              offset: const Offset(1, 0),
              itemBuilder: (BuildContext context) => const <PopupMenuEntry<Cn>>[
                PopupMenuItem(
                  value: Cn.cn1,
                  child: Text('CCN (Natural)'),
                ),
                PopupMenuItem(
                  value: Cn.cn2,
                  child: Text('CCA (Antecedent)'),
                ),
                PopupMenuItem(
                  value: Cn.cn3,
                  child: Text('CCS (Subaltern)'),
                ),
                PopupMenuItem(
                  value: Cn.cn4,
                  child: Text('CCQ (Qualifier)'),
                ),
                PopupMenuItem(
                  value: Cn.cn5,
                  child: Text('CCP (Precedent)'),
                ),
                PopupMenuItem(
                  value: Cn.cn6,
                  child: Text('CCV (Successive)'),
                ),
              ],
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("Case Scope"),
                subtitle: Text(
                  switch (widget.formative.cn) {
                    Cn.cn1 => 'CCN (Natural)',
                    Cn.cn2 => 'CCA (Antecedent)',
                    Cn.cn3 => 'CCS (Subaltern)',
                    Cn.cn4 => 'CCQ (Qualifier)',
                    Cn.cn5 => 'CCP (Precedent)',
                    Cn.cn6 => 'CCV (Successive)',
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          : PopupMenuButton<Cn>(
              onSelected: (Cn newCn) {
                widget.updateFormative((f) {
                  f.cn = newCn;
                });
              },
              offset: const Offset(1, 0),
              itemBuilder: (BuildContext context) => const <PopupMenuEntry<Cn>>[
                PopupMenuItem(
                  value: Cn.cn1,
                  child: Text('FAC (Factual)'),
                ),
                PopupMenuItem(
                  value: Cn.cn2,
                  child: Text('SUB (Subjunctive)'),
                ),
                PopupMenuItem(
                  value: Cn.cn3,
                  child: Text('ASM (Assumptive)'),
                ),
                PopupMenuItem(
                  value: Cn.cn4,
                  child: Text('SPC (Speculative)'),
                ),
                PopupMenuItem(
                  value: Cn.cn5,
                  child: Text('COU (Counterfactive)'),
                ),
                PopupMenuItem(
                  value: Cn.cn6,
                  child: Text('HYP (Hypothetical)'),
                ),
              ],
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("Mood"),
                subtitle: Text(
                  switch (widget.formative.cn) {
                    Cn.cn1 => 'FAC (Factual)',
                    Cn.cn2 => 'SUB (Subjunctive)',
                    Cn.cn3 => 'ASM (Assumptive)',
                    Cn.cn4 => 'SPC (Speculative)',
                    Cn.cn5 => 'COU (Counterfactive)',
                    Cn.cn6 => 'HYP (Hypothetical)',
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
      ListGroupTitle(
        "Affixes CsVx",
        trailing: IconButton(
            onPressed: () async {
              final cs = await prompt(
                context,
                initialValue: "",
                title: const Text("Enter Affix Cs"),
              );

              if (cs != null) {
                switch (CommonAffix.from(
                  affixType: AffixType.type1,
                  degree: Degree.d1,
                  cs: cs,
                )) {
                  case Ok(value: final affix):
                    widget.updateFormative((f) {
                      f.csVxAffixes.add(affix);
                    });
                    break;
                  case Err(value: final value):
                    if (context.mounted) {
                      showErrorDialog(context, value);
                    }
                }
              }
            },
            icon: const Icon(Icons.add)),
      ),
      ReorderableListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              final double animValue = Curves.easeInOut.transform(animation.value);
              final double elevation = lerpDouble(0, 6, animValue)!;
              return Material(
                elevation: elevation,
                color: Theme.of(context).colorScheme.secondary,
                shadowColor: Theme.of(context).colorScheme.secondary,
                child: child,
              );
            },
            child: child,
          );
        },
        children: <Widget>[
          for (int index = 0; index < widget.formative.csVxAffixes.length; index += 1)
            Dismissible(
              key: Key('$index'),
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                final isConfirmed = await showConfirmDialog(
                  context,
                  "Are you sure to delete this affix?",
                );
                return isConfirmed;
              },
              onDismissed: (direction) {
                widget.updateFormative((f) {
                  f.csVxAffixes.removeAt(index);
                });
              },
              child: Padding(
                padding: switch (Platform.get()) {
                  Platform.android => const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  Platform.webMobile ||
                  Platform.webDesktop ||
                  Platform.windows =>
                    const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  Platform.linux => throw UnimplementedError(),
                  Platform.unadapted => throw UnimplementedError(),
                },
                child: ListTile(
                  leading: const Icon(Icons.segment),
                  title: Text("-${widget.formative.csVxAffixes[index].cs.toLowerCase()}"),
                  onTap: () async {
                    final newCs = await prompt(
                      context,
                      initialValue: "",
                      title: const Text("Enter New Affix Cs"),
                    );

                    if (newCs == null) return;
                    final affix = switch (widget.formative.csVxAffixes[index]) {
                      CommonAffix(affixType: final affixType, degree: final degree) =>
                        CommonAffix.from(
                          cs: newCs,
                          affixType: affixType,
                          degree: degree,
                        ),
                      CaStackingAffix() => CaStackingAffix.from(newCs)
                    };
                    switch (affix) {
                      case Ok(value: final affix):
                        widget.updateFormative((f) {
                          f.csVxAffixes[index] = affix;
                        });
                        break;
                      case Err(value: final value):
                        if (!context.mounted) return;
                        showErrorDialog(context, value);
                    }
                  },
                  subtitle: Text(switch (widget.formative.csVxAffixes[index]) {
                    CommonAffix(affixType: final affixType, degree: final degree) =>
                      "Type ${switch (affixType) {
                        AffixType.type1 => '1',
                        AffixType.type2 => '2',
                        AffixType.type3 => '3'
                      }}, Degree ${switch (degree) {
                        Degree.d0 => '0',
                        Degree.d1 => '1',
                        Degree.d2 => '2',
                        Degree.d3 => '3',
                        Degree.d4 => '4',
                        Degree.d5 => '5',
                        Degree.d6 => '6',
                        Degree.d7 => '7',
                        Degree.d8 => '8',
                        Degree.d9 => '9',
                      }}",
                    CaStackingAffix() => "Ca Stacking Affix",
                  }),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: switch (widget.formative.csVxAffixes[index]) {
                      CommonAffix(
                        cs: final cs,
                        degree: final degree,
                        affixType: final affixType,
                      ) =>
                        [
                          IconButton(
                            onPressed: () async {
                              final newAffixType = await showAffixTypeDialog(context, affixType);
                              if (newAffixType != null) {
                                widget.updateFormative((f) {
                                  f.csVxAffixes[index] = CommonAffix.from(
                                    affixType: newAffixType,
                                    degree: degree,
                                    cs: cs,
                                  ).unwrap();
                                });
                              }
                            },
                            icon: const Icon(Icons.type_specimen),
                            tooltip: "Change Affix Type",
                          ),
                          IconButton(
                            onPressed: () async {
                              final newDegree = await showDegreeDialog(context, degree);
                              if (newDegree != null) {
                                widget.updateFormative((f) {
                                  f.csVxAffixes[index] = CommonAffix.from(
                                    affixType: affixType,
                                    degree: newDegree,
                                    cs: cs,
                                  ).unwrap();
                                });
                              }
                            },
                            icon: const Icon(Icons.thermostat),
                            tooltip: "Change Degree",
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (newValue) {
                              widget.updateFormative((f) {
                                f.csVxAffixes[index] = CaStackingAffix.from(cs).unwrap();
                              });
                            },
                          )
                        ],
                      CaStackingAffix(cs: final cs) => [
                          Checkbox(
                            value: true,
                            onChanged: (newValue) {
                              widget.updateFormative((f) {
                                f.csVxAffixes[index] = CommonAffix.from(
                                  affixType: AffixType.type1,
                                  degree: Degree.d1,
                                  cs: cs,
                                ).unwrap();
                              });
                            },
                          )
                        ]
                    },
                  ),
                ),
              ),
            )
        ],
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          widget.updateFormative((f) {
            final item = f.csVxAffixes.removeAt(oldIndex);
            f.csVxAffixes.insert(newIndex, item);
          });
        },
      ),
      ListGroupTitle(
        "Affixes VxCs",
        trailing: IconButton(
            onPressed: () async {
              final cs = await prompt(
                context,
                initialValue: "",
                title: const Text("Enter Affix Cs"),
              );

              if (cs != null) {
                switch (CommonAffix.from(
                  affixType: AffixType.type1,
                  degree: Degree.d1,
                  cs: cs,
                )) {
                  case Ok(value: final affix):
                    widget.updateFormative((f) {
                      f.vxCsAffixes.add(affix);
                    });
                    break;
                  case Err(value: final value):
                    if (context.mounted) {
                      showErrorDialog(context, value);
                    }
                }
              }
            },
            icon: const Icon(Icons.add)),
      ),
      ReorderableListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              final double animValue = Curves.easeInOut.transform(animation.value);
              final double elevation = lerpDouble(0, 6, animValue)!;
              return Material(
                elevation: elevation,
                color: Theme.of(context).colorScheme.secondary,
                shadowColor: Theme.of(context).colorScheme.secondary,
                child: child,
              );
            },
            child: child,
          );
        },
        children: <Widget>[
          for (int index = 0; index < widget.formative.vxCsAffixes.length; index += 1)
            Dismissible(
              key: Key('$index'),
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                final isConfirmed = await showConfirmDialog(
                  context,
                  "Are you sure to delete this affix?",
                );
                return isConfirmed;
              },
              onDismissed: (direction) {
                widget.updateFormative((f) {
                  f.vxCsAffixes.removeAt(index);
                });
              },
              child: Padding(
                padding: switch (Platform.get()) {
                  Platform.android => const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  Platform.webMobile ||
                  Platform.webDesktop ||
                  Platform.windows =>
                    const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  Platform.linux => throw UnimplementedError(),
                  Platform.unadapted => throw UnimplementedError(),
                },
                child: ListTile(
                  leading: const Icon(Icons.segment),
                  title: Text("-${widget.formative.vxCsAffixes[index].cs.toLowerCase()}"),
                  onTap: () async {
                    final newCs = await prompt(
                      context,
                      initialValue: "",
                      title: const Text("Enter New Affix Cs"),
                    );

                    if (newCs == null) return;
                    final affix = switch (widget.formative.vxCsAffixes[index]) {
                      CommonAffix(affixType: final affixType, degree: final degree) =>
                        CommonAffix.from(
                          cs: newCs,
                          affixType: affixType,
                          degree: degree,
                        ),
                      CaStackingAffix() => CaStackingAffix.from(newCs)
                    };
                    switch (affix) {
                      case Ok(value: final affix):
                        widget.updateFormative((f) {
                          f.vxCsAffixes[index] = affix;
                        });
                        break;
                      case Err(value: final value):
                        if (!context.mounted) return;
                        showErrorDialog(context, value);
                    }
                  },
                  subtitle: Text(switch (widget.formative.vxCsAffixes[index]) {
                    CommonAffix(affixType: final affixType, degree: final degree) =>
                      "Type ${switch (affixType) {
                        AffixType.type1 => '1',
                        AffixType.type2 => '2',
                        AffixType.type3 => '3'
                      }}, Degree ${switch (degree) {
                        Degree.d0 => '0',
                        Degree.d1 => '1',
                        Degree.d2 => '2',
                        Degree.d3 => '3',
                        Degree.d4 => '4',
                        Degree.d5 => '5',
                        Degree.d6 => '6',
                        Degree.d7 => '7',
                        Degree.d8 => '8',
                        Degree.d9 => '9',
                      }}",
                    CaStackingAffix() => "Ca Stacking Affix",
                  }),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: switch (widget.formative.vxCsAffixes[index]) {
                      CommonAffix(
                        cs: final cs,
                        degree: final degree,
                        affixType: final affixType,
                      ) =>
                        [
                          IconButton(
                            onPressed: () async {
                              final newAffixType = await showAffixTypeDialog(context, affixType);
                              if (newAffixType != null) {
                                widget.updateFormative((f) {
                                  f.vxCsAffixes[index] = CommonAffix.from(
                                    affixType: newAffixType,
                                    degree: degree,
                                    cs: cs,
                                  ).unwrap();
                                });
                              }
                            },
                            icon: const Icon(Icons.type_specimen),
                            tooltip: "Change Affix Type",
                          ),
                          IconButton(
                            onPressed: () async {
                              final newDegree = await showDegreeDialog(context, degree);
                              if (newDegree != null) {
                                widget.updateFormative((f) {
                                  f.vxCsAffixes[index] = CommonAffix.from(
                                    affixType: affixType,
                                    degree: newDegree,
                                    cs: cs,
                                  ).unwrap();
                                });
                              }
                            },
                            icon: const Icon(Icons.thermostat),
                            tooltip: "Change Degree",
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (newValue) {
                              widget.updateFormative((f) {
                                f.vxCsAffixes[index] = CaStackingAffix.from(cs).unwrap();
                              });
                            },
                          )
                        ],
                      CaStackingAffix(cs: final cs) => [
                          Checkbox(
                            value: true,
                            onChanged: (newValue) {
                              widget.updateFormative((f) {
                                f.vxCsAffixes[index] = CommonAffix.from(
                                  affixType: AffixType.type1,
                                  degree: Degree.d1,
                                  cs: cs,
                                ).unwrap();
                              });
                            },
                          )
                        ]
                    },
                  ),
                ),
              ),
            )
        ],
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          widget.updateFormative((f) {
            final item = f.vxCsAffixes.removeAt(oldIndex);
            f.vxCsAffixes.insert(newIndex, item);
          });
        },
      ),
      const ListGroupTitle("Romanization Options"),
      SwitchListTile(
        value: widget.formative.romanizationOptions.preferShortCut,
        title: const Text("Prefer Short Cut"),
        onChanged: (newValue) {
          widget.updateFormative((f) {
            f.romanizationOptions.preferShortCut = newValue;
          });
        },
      ),
      SwitchListTile(
        value: widget.formative.romanizationOptions.omitOptionalAffixes,
        title: const Text("Omit Optional Affixes"),
        onChanged: (newValue) {
          widget.updateFormative((f) {
            f.romanizationOptions.omitOptionalAffixes = newValue;
          });
        },
      ),
      const ListGroupTitle("Operation"),
      ListTile(
        leading: const Icon(Icons.delete),
        title: const Text("Delete"),
        subtitle: const Text("Delete this formative"),
        onTap: () async {
          final isConfirmed = await showConfirmDialog(
            context,
            "Are you sure to remove this formative?",
          );
          if (isConfirmed) {
            widget.removeFormative();
          }
        },
        textColor: Colors.white,
        iconColor: Colors.white,
        tileColor: Colors.red,
      ),
    ]);
  }
}
