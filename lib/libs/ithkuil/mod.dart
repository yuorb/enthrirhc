import 'terms/mod.dart';
import 'romanization/mod.dart';
import 'writing/mod.dart';
import 'writing/primary/mod.dart';
import 'writing/quarternary/mod.dart';
import 'writing/secondary/mod.dart';
import 'writing/tertiary/extensions.dart';
import 'writing/tertiary/mod.dart';

class Formative {
  Stem stem;
  Root root;
  Specification specification;
  Function$ function;
  Context context;
  Version version;
  Affiliation affiliation;
  Configuration configuration;
  Extension extension;
  Perspective perspective;
  Essence essence;
  FormativeType formativeType;
  final List<Affix> csVxAffixes;
  final List<Affix> vxCsAffixes;
  final VnCn vnCn;
  final RomanizationOptions romanizationOptions;

  Formative({
    required this.stem,
    required this.root,
    required this.specification,
    required this.context,
    required this.function,
    required this.formativeType,
    required this.version,
    required this.affiliation,
    required this.configuration,
    required this.extension,
    required this.perspective,
    required this.essence,
    required this.csVxAffixes,
    required this.vxCsAffixes,
    required this.vnCn,
    required this.romanizationOptions,
  });

  bool _shortCutAvailable() {
    return function == Function$.sta &&
        specification == Specification.bsc &&
        context == Context.exs &&
        affiliation == Affiliation.csl &&
        configuration.plexity == Plexity.u &&
        ((extension == Extension.del && perspective == Perspective.m && essence == Essence.nrm) ||
            (extension == Extension.prx &&
                perspective == Perspective.m &&
                essence == Essence.nrm) ||
            (extension == Extension.del &&
                perspective == Perspective.g &&
                essence == Essence.nrm) ||
            (extension == Extension.del &&
                perspective == Perspective.m &&
                essence == Essence.rpv) ||
            (extension == Extension.del &&
                perspective == Perspective.n &&
                essence == Essence.nrm) ||
            (extension == Extension.del &&
                perspective == Perspective.a &&
                essence == Essence.nrm) ||
            (extension == Extension.del &&
                perspective == Perspective.g &&
                essence == Essence.rpv) ||
            (extension == Extension.prx && perspective == Perspective.m && essence == Essence.rpv));
  }

  String _romanizeSlotI(bool useShortCut) {
    if (useShortCut) {
      final bool isW = (extension == Extension.del &&
              perspective == Perspective.m &&
              essence == Essence.nrm) ||
          (extension == Extension.del && perspective == Perspective.g && essence == Essence.nrm) ||
          (extension == Extension.del && perspective == Perspective.n && essence == Essence.nrm) ||
          (extension == Extension.del && perspective == Perspective.g && essence == Essence.rpv);
      switch (formativeType) {
        case Standalone() || Parent():
          return isW ? 'w' : 'y';
        case Concatenated concatenated:
          switch (concatenated.concatenation) {
            case Concatenation.type1:
              return isW ? 'hl' : 'hm';
            case Concatenation.type2:
              return isW ? 'hr' : 'hn';
          }
      }
    } else {
      switch (formativeType) {
        case Standalone() || Parent():
          return '';
        case Concatenated concatenated:
          switch (concatenated.concatenation) {
            case Concatenation.type1:
              return 'h';
            case Concatenation.type2:
              return 'hw';
          }
      }
    }
  }

  String _romanizeSlotII(bool useShortCut) {
    if (useShortCut) {
      if ((extension == Extension.del && perspective == Perspective.m && essence == Essence.nrm) ||
          (extension == Extension.prx && perspective == Perspective.m && essence == Essence.nrm)) {
        return switch (stem) {
          Stem.s1 => switch (version) {
              Version.prc => 'a',
              Version.cpt => 'ä',
            },
          Stem.s2 => switch (version) {
              Version.prc => 'e',
              Version.cpt => 'i',
            },
          Stem.s3 => switch (version) {
              Version.prc => 'u',
              Version.cpt => 'ü',
            },
          Stem.s0 => switch (version) {
              Version.prc => 'o',
              Version.cpt => 'ö',
            },
        };
      } else if ((extension == Extension.del &&
              perspective == Perspective.g &&
              essence == Essence.nrm) ||
          (extension == Extension.del && perspective == Perspective.m && essence == Essence.rpv)) {
        return switch (stem) {
          Stem.s1 => switch (version) {
              Version.prc => 'ai',
              Version.cpt => 'au',
            },
          Stem.s2 => switch (version) {
              Version.prc => 'ei',
              Version.cpt => 'eu',
            },
          Stem.s3 => switch (version) {
              Version.prc => 'ui',
              Version.cpt => 'iu',
            },
          Stem.s0 => switch (version) {
              Version.prc => 'oi',
              Version.cpt => 'ou',
            },
        };
      } else if (extension == Extension.del &&
          perspective == Perspective.n &&
          essence == Essence.nrm) {
        return switch (stem) {
          Stem.s1 => switch (version) {
              Version.prc => 'ia',
              Version.cpt => 'ie',
            },
          Stem.s2 => switch (version) {
              Version.prc => 'io',
              Version.cpt => 'iö',
            },
          Stem.s3 => switch (version) {
              Version.prc => 'iä',
              Version.cpt => 'ië',
            },
          Stem.s0 => switch (version) {
              Version.prc => 'öä',
              Version.cpt => 'öë',
            },
        };
      } else if (extension == Extension.del &&
          perspective == Perspective.a &&
          essence == Essence.nrm) {
        return switch (stem) {
          Stem.s1 => switch (version) {
              Version.prc => 'uä',
              Version.cpt => 'uë',
            },
          Stem.s2 => switch (version) {
              Version.prc => 'üä',
              Version.cpt => 'üë',
            },
          Stem.s3 => switch (version) {
              Version.prc => 'ua',
              Version.cpt => 'ue',
            },
          Stem.s0 => switch (version) {
              Version.prc => 'uo',
              Version.cpt => 'uö',
            },
        };
      } else if ((extension == Extension.del &&
              perspective == Perspective.g &&
              essence == Essence.rpv) ||
          (extension == Extension.prx && perspective == Perspective.m && essence == Essence.rpv)) {
        return switch (stem) {
          Stem.s1 => switch (version) {
              Version.prc => 'ao',
              Version.cpt => 'aö',
            },
          Stem.s2 => switch (version) {
              Version.prc => 'eo',
              Version.cpt => 'eö',
            },
          Stem.s3 => switch (version) {
              Version.prc => 'oa',
              Version.cpt => 'öa',
            },
          Stem.s0 => switch (version) {
              Version.prc => 'oe',
              Version.cpt => 'öe',
            },
        };
      } else {
        throw "Unreachable";
      }
    } else {
      return switch (stem) {
        Stem.s1 => switch (version) {
            Version.prc => romanizationOptions.omitOptionalAffixes ? '' : 'a',
            Version.cpt => 'ä',
          },
        Stem.s2 => switch (version) {
            Version.prc => 'e',
            Version.cpt => 'i',
          },
        Stem.s3 => switch (version) {
            Version.prc => 'u',
            Version.cpt => 'ü',
          },
        Stem.s0 => switch (version) {
            Version.prc => 'o',
            Version.cpt => 'ö',
          },
      };
    }
  }

  String _romanizeSlotIV(bool useShortCut) {
    return useShortCut
        ? ''
        : switch (function) {
            Function$.sta => switch (specification) {
                Specification.bsc => switch (context) {
                    Context.exs => 'a',
                    Context.fnc => 'ai',
                    Context.rps => root.phonemes.last == Phoneme.y ? 'uä' : 'ia',
                    Context.amg => 'ao',
                  },
                Specification.cte => switch (context) {
                    Context.exs => 'ä',
                    Context.fnc => 'au',
                    Context.rps => root.phonemes.last == Phoneme.y ? 'uë' : 'ie',
                    Context.amg => 'aö',
                  },
                Specification.csv => switch (context) {
                    Context.exs => 'e',
                    Context.fnc => 'ei',
                    Context.rps => root.phonemes.last == Phoneme.y ? 'üä' : 'io',
                    Context.amg => 'eo',
                  },
                Specification.obj => switch (context) {
                    Context.exs => 'i',
                    Context.fnc => 'eu',
                    Context.rps => root.phonemes.last == Phoneme.y ? 'üë' : 'iö',
                    Context.amg => 'eö',
                  },
              },
            Function$.dyn => switch (specification) {
                Specification.bsc => switch (context) {
                    Context.exs => 'u',
                    Context.fnc => 'ui',
                    Context.rps => root.phonemes.last == Phoneme.w ? 'iä' : 'ua',
                    Context.amg => 'oa',
                  },
                Specification.cte => switch (context) {
                    Context.exs => 'ü',
                    Context.fnc => 'iu',
                    Context.rps => root.phonemes.last == Phoneme.w ? 'ië' : 'ue',
                    Context.amg => 'öa',
                  },
                Specification.csv => switch (context) {
                    Context.exs => 'o',
                    Context.fnc => 'oi',
                    Context.rps => root.phonemes.last == Phoneme.w ? 'öä' : 'uo',
                    Context.amg => 'oe',
                  },
                Specification.obj => switch (context) {
                    Context.exs => 'ö',
                    Context.fnc => 'ou',
                    Context.rps => root.phonemes.last == Phoneme.w ? 'öë' : 'uö',
                    Context.amg => 'öe',
                  },
              },
          };
  }

  String _romanizeSlotV() {
    String slot5 = '';
    for (final affix in csVxAffixes) {
      final lastCharOfCs = affix.cs[affix.cs.length - 1];
      slot5 += affix.cs.toLowerCase() + affix.getVx(lastCharOfCs);
    }
    return slot5;
  }

  String _romanizeSlotVI(
    bool shortCut,
    String strPrecedingThis,
  ) {
    if (shortCut) {
      return '';
    } else {
      if (affiliation == Affiliation.csl &&
          configuration.plexity == Plexity.u &&
          extension == Extension.del &&
          perspective == Perspective.m &&
          essence == Essence.nrm) {
        return 'l';
      }
      if (configuration.plexity == Plexity.u &&
          extension == Extension.del &&
          perspective == Perspective.m &&
          essence == Essence.nrm) {
        return switch (affiliation) {
          Affiliation.csl => 'l',
          Affiliation.aso => 'nļ',
          Affiliation.coa => 'rļ',
          Affiliation.var$ => 'ň',
        };
      }
      if (affiliation == Affiliation.csl &&
          configuration.plexity == Plexity.u &&
          extension == Extension.del) {
        return switch (perspective) {
          Perspective.m => switch (essence) {
              Essence.nrm => 'l',
              Essence.rpv => 'tļ',
            },
          Perspective.g => switch (essence) {
              Essence.nrm => 'r',
              Essence.rpv => 'ř',
            },
          Perspective.n => switch (essence) {
              Essence.nrm => 'v',
              Essence.rpv =>
                RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw][tpk]\$").hasMatch(strPrecedingThis)
                    ? 'h'
                    : 'm',
            },
          Perspective.a => switch (essence) {
              Essence.nrm => 'j',
              Essence.rpv =>
                RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw][tpk]\$").hasMatch(strPrecedingThis)
                    ? 'ç'
                    : 'n',
            },
        };
      }
      final romanizedAffiliation = switch (affiliation) {
        Affiliation.csl => '',
        Affiliation.aso => 'l',
        Affiliation.coa => 'r',
        Affiliation.var$ => 'ř',
      };
      final romanizedConfiguration = configuration.romanize();
      final romanizedExtension = switch (extension) {
        Extension.del => '',
        Extension.prx => configuration.plexity == Plexity.u ? 'd' : 't',
        Extension.icp => configuration.plexity == Plexity.u ? 'g' : 'k',
        Extension.atv => configuration.plexity == Plexity.u ? 'b' : 'p',
        Extension.gra => configuration.plexity == Plexity.u ? 'gz' : 'g',
        Extension.dpl => configuration.plexity == Plexity.u ? 'bz' : 'b',
      };
      final romanizedPerspectiveAndEssence = switch (perspective) {
        Perspective.m => switch (essence) {
            Essence.nrm => '',
            Essence.rpv => 'l',
          },
        Perspective.g => switch (essence) {
            Essence.nrm => 'r',
            Essence.rpv => 'ř',
          },
        Perspective.n => switch (essence) {
            Essence.nrm => 'w',
            Essence.rpv => RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw][tpk]\$").hasMatch(
                strPrecedingThis +
                    romanizedAffiliation +
                    romanizedConfiguration +
                    romanizedExtension,
              )
                  ? 'h'
                  : 'm',
          },
        Perspective.a => switch (essence) {
            Essence.nrm => 'y',
            Essence.rpv => RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw][tpk]\$").hasMatch(
                strPrecedingThis +
                    romanizedAffiliation +
                    romanizedConfiguration +
                    romanizedExtension,
              )
                  ? 'ç'
                  : 'n',
          },
      };
      final String romanizedSlotVI = romanizedAffiliation +
          romanizedConfiguration +
          romanizedExtension +
          romanizedPerspectiveAndEssence;
      return romanizedSlotVI
          .replaceAll('pp', 'mp')
          .replaceAll('pb', 'mb')
          .replaceAll('rr', 'ns')
          .replaceAllMapped(
            RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw]gm"),
            (match) => '${match.group(0)}x',
          )
          .replaceAllMapped(
            RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw]bm"),
            (match) => '${match.group(0)}v',
          )
          .replaceAll('tt', 'nt')
          .replaceAll('kg', 'ng')
          .replaceAll('rř', 'nš')
          .replaceAllMapped(
            RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw]gn"),
            (match) => '${match.group(0)}ň',
          )
          .replaceAllMapped(
            RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw]bn"),
            (match) => '${match.group(0)}ḑ',
          )
          .replaceAll('kk', 'nk')
          .replaceAll('çy', 'nd')
          .replaceAll('řr', 'ňs')
          .replaceAll('ngn', 'ňn')
          .replaceAll('fbm', 'vw')
          .replaceAll('ll', 'pļ')
          .replaceAll('řř', 'ňš')
          .replaceAllMapped(
            RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw]çx"),
            (match) => '${match.group(0)}xw',
          )
          .replaceAll('ţbn', 'ḑy');
    }
  }

  String _romanizeSlotVII(String strPrecedingThis) {
    String slot7 = '';
    for (int i = 0; i < vxCsAffixes.length; i++) {
      final affix = vxCsAffixes[i];
      if (i == 0) {
        final charPrecedingThis = strPrecedingThis[strPrecedingThis.length - 1];
        slot7 += affix.getVx(charPrecedingThis) + affix.cs.toLowerCase();
      } else {
        final previousAffix = vxCsAffixes[i - 1].cs;
        final charPrecedingThis = previousAffix[previousAffix.length - 1];
        slot7 += affix.getVx(charPrecedingThis) + affix.cs.toLowerCase();
      }
    }
    return slot7;
  }

  String _romanizeSlotVIII(String strPrecedingThis) {
    return vnCn.romanize(
      romanizationOptions.omitOptionalAffixes,
      strPrecedingThis,
    );
  }

  String _romanizeSlotIX(String strPrecedingThis) {
    switch (formativeType) {
      case Standalone standalone:
        switch (standalone.relation) {
          case Noun noun:
            final charPrecedingThis = strPrecedingThis[strPrecedingThis.length - 1];
            return noun.case$.romanized(charPrecedingThis);
          case FramedVerb verb:
            return verb.romanized(romanizationOptions.omitOptionalAffixes);
          case UnframedVerb verb:
            return verb.romanized(romanizationOptions.omitOptionalAffixes);
        }
      case Parent parent:
        switch (parent.relation) {
          case Noun noun:
            final charPrecedingThis = strPrecedingThis[strPrecedingThis.length - 1];
            return noun.case$.romanized(charPrecedingThis);
          case FramedVerb verb:
            return verb.romanized(romanizationOptions.omitOptionalAffixes);
          case UnframedVerb verb:
            return verb.romanized(romanizationOptions.omitOptionalAffixes);
        }
      case Concatenated concatenated:
        final charPrecedingThis = strPrecedingThis[strPrecedingThis.length - 1];
        return concatenated.format.romanized(charPrecedingThis);
    }
  }

  String romanize() {
    final useShortCut = romanizationOptions.preferShortCut && _shortCutAvailable();

    final String slot1 = _romanizeSlotI(useShortCut);
    final String slot2 = _romanizeSlotII(useShortCut);
    final String slot3 = root.toString();
    final String slot4 = _romanizeSlotIV(useShortCut);
    final String slot5 = _romanizeSlotV();
    final String slot6 = _romanizeSlotVI(useShortCut, "$slot1$slot2$slot3$slot4$slot5");
    final String slot7 = _romanizeSlotVII("$slot1$slot2$slot3$slot4$slot5$slot6");
    final String slot8 = _romanizeSlotVIII("$slot1$slot2$slot3$slot4$slot5$slot6$slot7");
    final String slot9 = _romanizeSlotIX("$slot1$slot2$slot3$slot4$slot5$slot6$slot7$slot8");

    return "$slot1$slot2$slot3$slot4$slot5$slot6$slot7$slot8$slot9";
  }

  List<Character> toCharacters() {
    final List<Character> characters = [
      Primary(
        specification: specification,
        context: context,
        formativeType: formativeType,
        essence: essence,
        affiliation: affiliation,
        perspective: perspective,
        extension: extension,
        similarity: configuration.similarity,
        separability: configuration.separability,
        function: function,
        version: version,
        plexity: configuration.plexity,
        stem: stem,
      ),
      ...root.toRootSecondaries(),
      ...csVxAffixes.map(
        (affix) {
          final (startLetter, coreLetter, endLetter) = affix.getSecondaryComponents();
          return CsVxAffix(
            start: startLetter,
            core: coreLetter,
            end: endLetter,
            affix: affix,
          );
        },
      ),
      ...vxCsAffixes.map(
        (affix) {
          final (startLetter, coreLetter, endLetter) = affix.getSecondaryComponents();
          return VxCsAffix(
            start: startLetter,
            core: coreLetter,
            end: endLetter,
            affix: affix,
          );
        },
      ),
    ];

    final hasTertiary = switch (vnCn.vn) {
      ValenceVn(valence: final valence) => valence != Valence.mno,
      _ => true,
    };

    if (hasTertiary) {
      characters.add(
        Tertiary(
          valence: switch (vnCn.vn) {
            ValenceVn(valence: final valence) => valence,
            _ => Valence.mno,
          },
          top: switch (vnCn.vn) {
            PhaseVn(phase: final phase) => PhaseExtension(phase),
            EffectVn(effect: final effect) => EffectExtension(effect),
            AspectVn(aspect: final aspect) => AspectExtension(aspect),
            _ => null,
          },
          // TODO: Parse affixes as bottom component.
          bottom: null,
          level: switch (vnCn.vn) {
            LevelVn(level: final level) => Level(
                // TODO: Parse affixes as absolute level.
                comparison: Comparison.relative,
                comparisonOperator: level,
              ),
            _ => null,
          },
        ),
      );
    }

    final hasQuarternary = !(vnCn.cn == Cn.cn1 &&
        switch (formativeType) {
          Standalone(relation: final relation) || Parent(relation: final relation) => switch (
                relation) {
              Noun(case$: final case$) => case$ == Case.thm,
              FramedVerb(illocution: final illocution, validation: final validation) ||
              UnframedVerb(illocution: final illocution, validation: final validation) =>
                illocution == Illocution.asr && validation == Validation.obs,
            },
          Concatenated(format: final format) => format == Case.thm,
        });

    if (hasQuarternary) {
      characters.add(
        Quarternary(
          formativeType: formativeType,
          cn: vnCn.cn,
        ),
      );
    }

    return characters;
  }
}
