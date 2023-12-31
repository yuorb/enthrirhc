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
  Cn cn;
  Vn vn;
  final List<Affix> csVxAffixes;
  final List<Affix> vxCsAffixes;

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
    required this.cn,
    required this.vn,
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

  String _getRawVv(bool useShortCut, bool omitOptionalAffixes, bool requireVv) {
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
            Version.prc => requireVv ? 'a' : (omitOptionalAffixes ? '' : 'a'),
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

  String _romanizeSlotII(bool useShortCut, bool omitOptionalAffixes) {
    if (csVxAffixes.length > 1) {
      final rawVv = _getRawVv(useShortCut, omitOptionalAffixes, true);
      return insertGlottalStop(rawVv, false);
    } else {
      final rawVv = _getRawVv(useShortCut, omitOptionalAffixes, false);
      return rawVv;
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

  String _romanizeSlotV(bool useShortCut, String strPrecedingThis) {
    String slot5 = '';
    if (useShortCut) {
      for (int i = 0; i < csVxAffixes.length; i++) {
        final affix = csVxAffixes[i];
        final String charPrecedingThis;
        if (i == 0) {
          charPrecedingThis = strPrecedingThis[strPrecedingThis.length - 1];
        } else {
          final previousAffix = csVxAffixes[i - 1].cs;
          charPrecedingThis = previousAffix[previousAffix.length - 1];
        }
        final String vx;
        // See document 7.3.2
        if (i == csVxAffixes.length - 1) {
          vx = insertGlottalStop(affix.getVx(charPrecedingThis), false);
        } else {
          vx = affix.getVx(charPrecedingThis);
        }
        final cs = affix.cs.toLowerCase();
        slot5 += vx + cs;
      }
    } else {
      for (final affix in csVxAffixes) {
        final lastCharOfCs = affix.cs[affix.cs.length - 1];
        slot5 += affix.cs.toLowerCase() + affix.getVx(lastCharOfCs);
      }
    }
    return slot5;
  }

  String _getRawCa(
    String strPrecedingThis,
  ) {
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
              strPrecedingThis + romanizedAffiliation + romanizedConfiguration + romanizedExtension,
            )
                ? 'h'
                : 'm',
        },
      Perspective.a => switch (essence) {
          Essence.nrm => 'y',
          Essence.rpv => RegExp("[pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw][tpk]\$").hasMatch(
              strPrecedingThis + romanizedAffiliation + romanizedConfiguration + romanizedExtension,
            )
                ? 'ç'
                : 'n',
        },
    };
    final String rawCa = romanizedAffiliation +
        romanizedConfiguration +
        romanizedExtension +
        romanizedPerspectiveAndEssence;
    return rawCa;
  }

  String _geminate(String allomorphicSubstitutedCa) {
    // Rule 1
    if (allomorphicSubstitutedCa.length == 1) {
      if (allomorphicSubstitutedCa == "y" || allomorphicSubstitutedCa == "w") {
        return '[ERROR]';
      }
      return "$allomorphicSubstitutedCa$allomorphicSubstitutedCa";
    }
    // Rule 2
    if (allomorphicSubstitutedCa == 'tļ') {
      return 'ttļ';
    }
    // Rule 3
    if (RegExp('^[tkpdgb][lrřwy]').hasMatch(allomorphicSubstitutedCa)) {
      return allomorphicSubstitutedCa.replaceFirstMapped(
        RegExp('^([tkpdgb])([lrřwy])'),
        (match) => '${match.group(1)}${match.group(1)}${match.group(2)}',
      );
    }
    // Rule 4
    if (RegExp('[sšzžẓçcč]').hasMatch(allomorphicSubstitutedCa)) {
      return allomorphicSubstitutedCa.replaceFirstMapped(
        RegExp('[sšzžẓçcč]'),
        (match) => '${match.group(0)}${match.group(0)}',
      );
    }
    // Rule 5
    if (RegExp('^[fţvd͕nmň]').hasMatch(allomorphicSubstitutedCa)) {
      return allomorphicSubstitutedCa.replaceFirstMapped(
        RegExp('^[fţvd͕nmň]'),
        (match) => '${match.group(0)}${match.group(0)}',
      );
    }
    // Rule 6
    if (RegExp('^[tkp][sšfţç]').hasMatch(allomorphicSubstitutedCa)) {
      return allomorphicSubstitutedCa.replaceFirstMapped(
        RegExp('^([tkp])([sšfţç])'),
        (match) => '${match.group(1)}${match.group(2)}${match.group(2)}',
      );
    }
    // Rule 7
    if (allomorphicSubstitutedCa.endsWith('pt')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'pt$'), 'bbd͕');
    }
    if (allomorphicSubstitutedCa.endsWith('pk')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'pk$'), 'bbv');
    }
    if (allomorphicSubstitutedCa.endsWith('kt')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'kt$'), 'ggd͕');
    }
    if (allomorphicSubstitutedCa.endsWith('kp')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'kp$'), 'ggv');
    }
    if (allomorphicSubstitutedCa.endsWith('tk')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'tk$'), 'd͕vv');
    }
    if (allomorphicSubstitutedCa.endsWith('tp')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'tp$'), 'ddv');
    }
    // Rule 8
    if (allomorphicSubstitutedCa.endsWith('pm')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'pm$'), 'vvm');
    }
    if (allomorphicSubstitutedCa.endsWith('pn')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'pn$'), 'vvn');
    }
    if (allomorphicSubstitutedCa.endsWith('km')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'km$'), 'xxm');
    }
    if (allomorphicSubstitutedCa.endsWith('kn')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'kn$'), 'xxn');
    }
    if (allomorphicSubstitutedCa.endsWith('tm')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'tm$'), 'd͕d͕m');
    }
    if (allomorphicSubstitutedCa.endsWith('tn')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'tn$'), 'd͕d͕n');
    }
    if (allomorphicSubstitutedCa.endsWith('bm')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'bm$'), 'mmw');
    }
    if (allomorphicSubstitutedCa.endsWith('bn')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'bn$'), 'mml');
    }
    if (allomorphicSubstitutedCa.endsWith('gm')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'gm$'), 'ňňw');
    }
    if (allomorphicSubstitutedCa.endsWith('gn')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'gn$'), 'ňňl');
    }
    if (allomorphicSubstitutedCa.endsWith('dm')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'dm$'), 'nnw');
    }
    if (allomorphicSubstitutedCa.endsWith('dn')) {
      return allomorphicSubstitutedCa.replaceFirst(RegExp(r'dn$'), 'nnl');
    }
    // Rule 9
    if (RegExp('^[lrř]').hasMatch(allomorphicSubstitutedCa)) {
      final t = _geminate(allomorphicSubstitutedCa.substring(1));
      return t != '[ERROR]'
          ? "${allomorphicSubstitutedCa[0]}${_geminate(allomorphicSubstitutedCa.substring(1))}"
          : "${allomorphicSubstitutedCa[0]}$allomorphicSubstitutedCa";
    }
    return '[ERROR]';
  }

  String _romanizeSlotVI(
    bool shortCut,
    String strPrecedingThis,
  ) {
    if (shortCut) {
      return '';
    }
    final rawCa = _getRawCa(strPrecedingThis);
    final allomorphicSubstitutedCa = rawCa
        .replaceAll('pp', 'mp')
        .replaceAll('pb', 'mb')
        .replaceAll('rr', 'ns')
        .replaceAll('tt', 'nt')
        .replaceAll('kg', 'ng')
        .replaceAll('rř', 'nš')
        .replaceAll('kk', 'nk')
        .replaceAll('çy', 'nd')
        .replaceAll('řr', 'ňs')
        .replaceAll('ll', 'pļ')
        .replaceAll('řř', 'ňš')
        .replaceAll('fv', 'vw')
        .replaceAll('ţd͕', 'd͕y')
        .replaceAll('ngn', 'ňn')
        .replaceAll('fbm', 'vw')
        .replaceAll('ţbn', 'd͕y')
        .replaceAllMapped(
          RegExp("([pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw])gm"),
          (match) => '${match.group(1)}x',
        )
        .replaceAllMapped(
          RegExp("([pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw])bm"),
          (match) => '${match.group(1)}v',
        )
        .replaceAllMapped(
          RegExp("([pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw])gn"),
          (match) => '${match.group(1)}ň',
        )
        .replaceAllMapped(
          RegExp("([pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw])bn"),
          (match) => '${match.group(1)}d͕',
        )
        .replaceAllMapped(
          RegExp("([pbfvtdţd͕kgcẓszčjšžmnňçxhll͕rřyw])çx"),
          (match) => '${match.group(1)}xw',
        );
    if (csVxAffixes.isEmpty) {
      return allomorphicSubstitutedCa;
    }
    final geminatedCa = _geminate(allomorphicSubstitutedCa);
    return geminatedCa;
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

  String _romanizeSlotVIII(String strPrecedingThis, bool omitOptionalAffixes) {
    final isPattern1 = switch (vn) {
      ValenceVn() || PhaseVn() || EffectVn() || LevelVn() => true,
      AspectVn() => false,
    };
    final vnRomanized = vn.romanize(
      omitOptionalAffixes,
      strPrecedingThis[strPrecedingThis.length - 1],
    );
    final cnRomanized = cn.romanize(omitOptionalAffixes, isPattern1);

    return "$vnRomanized$cnRomanized";
  }

  String _romanizeSlotIX(String strPrecedingThis, bool omitOptionalAffixes) {
    switch (formativeType) {
      case Standalone standalone:
        switch (standalone.relation) {
          case Noun noun:
            final charPrecedingThis = strPrecedingThis[strPrecedingThis.length - 1];
            return noun.case$.romanized(charPrecedingThis);
          case FramedVerb verb:
            return verb.romanized(omitOptionalAffixes);
          case UnframedVerb verb:
            return verb.romanized(omitOptionalAffixes);
        }
      case Parent parent:
        switch (parent.relation) {
          case Noun noun:
            final charPrecedingThis = strPrecedingThis[strPrecedingThis.length - 1];
            return noun.case$.romanized(charPrecedingThis);
          case FramedVerb verb:
            return verb.romanized(omitOptionalAffixes);
          case UnframedVerb verb:
            return verb.romanized(omitOptionalAffixes);
        }
      case Concatenated concatenated:
        final charPrecedingThis = strPrecedingThis[strPrecedingThis.length - 1];
        return concatenated.format.romanized(charPrecedingThis);
    }
  }

  String romanize(bool preferShortCut, bool omitOptionalAffixes) {
    final useShortCut = preferShortCut && _shortCutAvailable();

    final String slot1 = _romanizeSlotI(useShortCut);
    final String slot2 = _romanizeSlotII(useShortCut, omitOptionalAffixes);
    final String slot3 = root.toString();
    final String slot4 = _romanizeSlotIV(useShortCut);
    final String slot5 = _romanizeSlotV(useShortCut, "$slot1$slot2$slot3$slot4");
    final String slot6 = _romanizeSlotVI(useShortCut, "$slot1$slot2$slot3$slot4$slot5");
    final String slot7 = _romanizeSlotVII("$slot1$slot2$slot3$slot4$slot5$slot6");
    final String slot8 = _romanizeSlotVIII(
      "$slot1$slot2$slot3$slot4$slot5$slot6$slot7",
      omitOptionalAffixes,
    );
    final String slot9 = _romanizeSlotIX(
      "$slot1$slot2$slot3$slot4$slot5$slot6$slot7$slot8",
      omitOptionalAffixes,
    );

    return "$slot1$slot2$slot3$slot4$slot5$slot6$slot7$slot8$slot9";
  }

  List<Character> toCharacters(bool omitOptionalCharacters) {
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

    final tertiaryOmittable = switch (vn) {
      ValenceVn(valence: final valence) => valence == Valence.mno,
      _ => false,
    };

    if (!(omitOptionalCharacters && tertiaryOmittable)) {
      characters.add(
        Tertiary(
          valence: switch (vn) {
            ValenceVn(valence: final valence) => valence,
            _ => Valence.mno,
          },
          top: switch (vn) {
            PhaseVn(phase: final phase) => PhaseExtension(phase),
            EffectVn(effect: final effect) => EffectExtension(effect),
            AspectVn(aspect: final aspect) => AspectExtension(aspect),
            _ => null,
          },
          // TODO: Parse affixes as bottom component.
          bottom: null,
          level: switch (vn) {
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

    final quarternaryOmittable = cn == Cn.cn1;

    if (omitOptionalCharacters && quarternaryOmittable) {
      (characters[1] as RootSecondary).formativeType = formativeType;
    } else {
      characters.add(
        Quarternary(
          formativeType: formativeType,
          cn: cn,
        ),
      );
    }

    return characters;
  }
}
