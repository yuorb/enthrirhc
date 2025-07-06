import 'case_type.dart';
import 'case_number.dart';

class Case {
  static const Case thm = Case(
    caseType: CaseType.transrelative,
    caseNumber: CaseNumber.c1,
  );

  final CaseType caseType;
  final CaseNumber caseNumber;

  const Case({required this.caseType, required this.caseNumber});

  String romanized(String charPrecedingThis, bool concatenated) {
    return switch (caseType) {
      CaseType.transrelative => switch (caseNumber) {
        CaseNumber.c1 => "a",
        CaseNumber.c2 => "ä",
        CaseNumber.c3 => "e",
        CaseNumber.c4 => "i",
        CaseNumber.c5 => "ëi",
        CaseNumber.c6 => "ö",
        CaseNumber.c7 => "o",
        CaseNumber.c8 => "ü",
        CaseNumber.c9 => "u",
      },
      CaseType.appositive => switch (caseNumber) {
        CaseNumber.c1 => "ai",
        CaseNumber.c2 => "au",
        CaseNumber.c3 => "ei",
        CaseNumber.c4 => "eu",
        CaseNumber.c5 => "ëu",
        CaseNumber.c6 => "ou",
        CaseNumber.c7 => "oi",
        CaseNumber.c8 => "iu",
        CaseNumber.c9 => "ui",
      },
      CaseType.associative => switch (caseNumber) {
        CaseNumber.c1 => charPrecedingThis == "y" ? "uä" : "ia",
        CaseNumber.c2 => charPrecedingThis == "y" ? "uë" : "ie",
        CaseNumber.c3 => charPrecedingThis == "y" ? "üä" : "io",
        CaseNumber.c4 => charPrecedingThis == "y" ? "üë" : "iö",
        CaseNumber.c5 => "eë",
        CaseNumber.c6 => charPrecedingThis == "w" ? "öë" : "uö",
        CaseNumber.c7 => charPrecedingThis == "w" ? "öä" : "uo",
        CaseNumber.c8 => charPrecedingThis == "w" ? "ië" : "ue",
        CaseNumber.c9 => charPrecedingThis == "w" ? "iä" : "ua",
      },
      CaseType.adverbial => switch (caseNumber) {
        CaseNumber.c1 => "ao",
        CaseNumber.c2 => "aö",
        CaseNumber.c3 => "eo",
        CaseNumber.c4 => "eö",
        CaseNumber.c5 => "oë",
        CaseNumber.c6 => "öe",
        CaseNumber.c7 => "oe",
        CaseNumber.c8 => "öa",
        CaseNumber.c9 => "oa",
      },
      CaseType.relational => switch (caseNumber) {
        CaseNumber.c1 => concatenated ? "aa" : "a'a",
        CaseNumber.c2 => concatenated ? "ää" : "ä'ä",
        CaseNumber.c3 => concatenated ? "ee" : "e'e",
        CaseNumber.c4 => concatenated ? "ii" : "i'i",
        CaseNumber.c5 => concatenated ? "ëi" : "ë'i",
        CaseNumber.c6 => concatenated ? "öö" : "ö'ö",
        CaseNumber.c7 => concatenated ? "oo" : "o'o",
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => concatenated ? "uu" : "u'u",
      },
      CaseType.affinitive => switch (caseNumber) {
        CaseNumber.c1 => concatenated ? "ai" : "a'i",
        CaseNumber.c2 => concatenated ? "au" : "a'u",
        CaseNumber.c3 => concatenated ? "ei" : "e'i",
        CaseNumber.c4 => concatenated ? "eu" : "e'u",
        CaseNumber.c5 => concatenated ? "ëu" : "ë'u",
        CaseNumber.c6 => concatenated ? "ou" : "o'u",
        CaseNumber.c7 => concatenated ? "oi" : "o'i",
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => concatenated ? "ui" : "u'i",
      },
      CaseType.spatioTemporal1 => switch (caseNumber) {
        CaseNumber.c1 =>
          charPrecedingThis == "y"
              ? "uä"
              : concatenated
              ? "ia"
              : "i'a",
        CaseNumber.c2 =>
          charPrecedingThis == "y"
              ? "uë"
              : concatenated
              ? "ie"
              : "i'e",
        CaseNumber.c3 =>
          charPrecedingThis == "y"
              ? "üä"
              : concatenated
              ? "io"
              : "i'o",
        CaseNumber.c4 =>
          charPrecedingThis == "y"
              ? "üë"
              : concatenated
              ? "iö"
              : "i'ö",
        CaseNumber.c5 => concatenated ? "eë" : "e'ë",
        CaseNumber.c6 =>
          charPrecedingThis == "w"
              ? "öë"
              : concatenated
              ? "uö"
              : "u'ö",
        CaseNumber.c7 =>
          charPrecedingThis == "w"
              ? "öä"
              : concatenated
              ? "uo"
              : "u'o",
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 =>
          charPrecedingThis == "w"
              ? "iä"
              : concatenated
              ? "ua"
              : "u'a",
      },
      CaseType.spatioTemporal2 => switch (caseNumber) {
        CaseNumber.c1 => concatenated ? "ao" : "a'o",
        CaseNumber.c2 => concatenated ? "aö" : "a'ö",
        CaseNumber.c3 => concatenated ? "eo" : "e'o",
        CaseNumber.c4 => concatenated ? "eö" : "e'ö",
        CaseNumber.c5 => concatenated ? "oë" : "o'ë",
        CaseNumber.c6 => concatenated ? "öe" : "ö'e",
        CaseNumber.c7 => concatenated ? "oe" : "o'e",
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => concatenated ? "oa" : "o'a",
      },
    };
  }

  String name() {
    return switch (caseType) {
      CaseType.transrelative => switch (caseNumber) {
        CaseNumber.c1 => 'THM',
        CaseNumber.c2 => 'INS',
        CaseNumber.c3 => 'ABS',
        CaseNumber.c4 => 'AFF',
        CaseNumber.c5 => 'STM',
        CaseNumber.c6 => 'EFF',
        CaseNumber.c7 => 'ERG',
        CaseNumber.c8 => 'DAT',
        CaseNumber.c9 => 'IND',
      },
      CaseType.appositive => switch (caseNumber) {
        CaseNumber.c1 => 'POS',
        CaseNumber.c2 => 'PRP',
        CaseNumber.c3 => 'GEN',
        CaseNumber.c4 => 'ATT',
        CaseNumber.c5 => 'PDC',
        CaseNumber.c6 => 'ITP',
        CaseNumber.c7 => 'OGN',
        CaseNumber.c8 => 'IDP',
        CaseNumber.c9 => 'PAR',
      },
      CaseType.associative => switch (caseNumber) {
        CaseNumber.c1 => 'APL',
        CaseNumber.c2 => 'PUR',
        CaseNumber.c3 => 'TRA',
        CaseNumber.c4 => 'DFR',
        CaseNumber.c5 => 'CRS',
        CaseNumber.c6 => 'TSP',
        CaseNumber.c7 => 'CMM',
        CaseNumber.c8 => 'CMP',
        CaseNumber.c9 => 'CSD',
      },
      CaseType.adverbial => switch (caseNumber) {
        CaseNumber.c1 => 'FUN',
        CaseNumber.c2 => 'TFM',
        CaseNumber.c3 => 'CLA',
        CaseNumber.c4 => 'RSL',
        CaseNumber.c5 => 'CSM',
        CaseNumber.c6 => 'CON',
        CaseNumber.c7 => 'AVR',
        CaseNumber.c8 => 'CVS',
        CaseNumber.c9 => 'SIT',
      },
      CaseType.relational => switch (caseNumber) {
        CaseNumber.c1 => 'PRN',
        CaseNumber.c2 => 'DSP',
        CaseNumber.c3 => 'COR',
        CaseNumber.c4 => 'CPS',
        CaseNumber.c5 => 'COM',
        CaseNumber.c6 => 'UTL',
        CaseNumber.c7 => 'PRD',
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => 'RLT',
      },
      CaseType.affinitive => switch (caseNumber) {
        CaseNumber.c1 => 'ACT',
        CaseNumber.c2 => 'ASI',
        CaseNumber.c3 => 'ESS',
        CaseNumber.c4 => 'TRM',
        CaseNumber.c5 => 'SEL',
        CaseNumber.c6 => 'CFM',
        CaseNumber.c7 => 'DEP',
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => 'VOC',
      },
      CaseType.spatioTemporal1 => switch (caseNumber) {
        CaseNumber.c1 => 'LOC',
        CaseNumber.c2 => 'ATD',
        CaseNumber.c3 => 'ALL',
        CaseNumber.c4 => 'ABL',
        CaseNumber.c5 => 'ORI',
        CaseNumber.c6 => 'IRL',
        CaseNumber.c7 => 'INV',
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => 'NAV',
      },
      CaseType.spatioTemporal2 => switch (caseNumber) {
        CaseNumber.c1 => 'CNR',
        CaseNumber.c2 => 'ASS',
        CaseNumber.c3 => 'PER',
        CaseNumber.c4 => 'PRO',
        CaseNumber.c5 => 'PCV',
        CaseNumber.c6 => 'PCR',
        CaseNumber.c7 => 'ELP',
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => 'PLM',
      },
    };
  }

  String fullName() {
    return switch (caseType) {
      CaseType.transrelative => switch (caseNumber) {
        CaseNumber.c1 => 'Thematic',
        CaseNumber.c2 => 'Instrumental',
        CaseNumber.c3 => 'Absolutive',
        CaseNumber.c4 => 'Affective',
        CaseNumber.c5 => 'Stimulative',
        CaseNumber.c6 => 'Effectuative',
        CaseNumber.c7 => 'Ergative',
        CaseNumber.c8 => 'Dative',
        CaseNumber.c9 => 'Inducive',
      },
      CaseType.appositive => switch (caseNumber) {
        CaseNumber.c1 => 'Possessive',
        CaseNumber.c2 => 'Proprietive',
        CaseNumber.c3 => 'Genitive',
        CaseNumber.c4 => 'Attributive',
        CaseNumber.c5 => 'Productive',
        CaseNumber.c6 => 'Interpretative',
        CaseNumber.c7 => 'Originative',
        CaseNumber.c8 => 'Interdependent',
        CaseNumber.c9 => 'Partitive',
      },
      CaseType.associative => switch (caseNumber) {
        CaseNumber.c1 => 'Applicative',
        CaseNumber.c2 => 'Purposive',
        CaseNumber.c3 => 'Transmissive',
        CaseNumber.c4 => 'Deferential',
        CaseNumber.c5 => 'Contrastive',
        CaseNumber.c6 => 'Transpositive',
        CaseNumber.c7 => 'Commutative',
        CaseNumber.c8 => 'Comparative',
        CaseNumber.c9 => 'Considerative',
      },
      CaseType.adverbial => switch (caseNumber) {
        CaseNumber.c1 => 'Functive',
        CaseNumber.c2 => 'Transformative',
        CaseNumber.c3 => 'Classificative',
        CaseNumber.c4 => 'Resultative',
        CaseNumber.c5 => 'Consumptive',
        CaseNumber.c6 => 'Concessive',
        CaseNumber.c7 => 'Aversive',
        CaseNumber.c8 => 'Conversive',
        CaseNumber.c9 => 'Situative',
      },
      CaseType.relational => switch (caseNumber) {
        CaseNumber.c1 => 'Pertinential',
        CaseNumber.c2 => 'Descriptive',
        CaseNumber.c3 => 'Correlative',
        CaseNumber.c4 => 'Compositive',
        CaseNumber.c5 => 'Comitative',
        CaseNumber.c6 => 'Utilitative',
        CaseNumber.c7 => 'Predicative',
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => 'Relative',
      },
      CaseType.affinitive => switch (caseNumber) {
        CaseNumber.c1 => 'Activative',
        CaseNumber.c2 => 'Assimilative',
        CaseNumber.c3 => 'Essive',
        CaseNumber.c4 => 'Terminative',
        CaseNumber.c5 => 'Selective',
        CaseNumber.c6 => 'Conformative',
        CaseNumber.c7 => 'Dependent',
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => 'Vocative',
      },
      CaseType.spatioTemporal1 => switch (caseNumber) {
        CaseNumber.c1 => 'Locative',
        CaseNumber.c2 => 'Attendant',
        CaseNumber.c3 => 'Allative',
        CaseNumber.c4 => 'Ablative',
        CaseNumber.c5 => 'Orientative',
        CaseNumber.c6 => 'Interrelative',
        CaseNumber.c7 => 'Intrative',
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => 'Navigative',
      },
      CaseType.spatioTemporal2 => switch (caseNumber) {
        CaseNumber.c1 => 'Concursive',
        CaseNumber.c2 => 'Assessive',
        CaseNumber.c3 => 'Periodic',
        CaseNumber.c4 => 'Prolapsive',
        CaseNumber.c5 => 'Precursive',
        CaseNumber.c6 => 'Postcursive',
        CaseNumber.c7 => 'Elapsive',
        CaseNumber.c8 => throw 'unreachable',
        CaseNumber.c9 => 'Prolimitive',
      },
    };
  }
}
