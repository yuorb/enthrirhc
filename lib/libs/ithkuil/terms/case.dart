import 'case_type.dart';
import 'case_number.dart';

class Case {
  static const Case thm = Case(
    caseType: CaseType.transrelative,
    caseNumber: CaseNumber.c1,
  );

  final CaseType caseType;
  final CaseNumber caseNumber;

  const Case({
    required this.caseType,
    required this.caseNumber,
  });

  String romanized(String charPrecedingThis) {
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
          CaseNumber.c1 => "a'a",
          CaseNumber.c2 => "ä'ä",
          CaseNumber.c3 => "e'e",
          CaseNumber.c4 => "i'i",
          CaseNumber.c5 => "ë'i",
          CaseNumber.c6 => "ö'ö",
          CaseNumber.c7 => "o'o",
          CaseNumber.c8 => throw 'unreachable',
          CaseNumber.c9 => "u'u",
        },
      CaseType.affinitive => switch (caseNumber) {
          CaseNumber.c1 => "a'i",
          CaseNumber.c2 => "a'u",
          CaseNumber.c3 => "e'i",
          CaseNumber.c4 => "e'u",
          CaseNumber.c5 => "ë'u",
          CaseNumber.c6 => "o'u",
          CaseNumber.c7 => "o'i",
          CaseNumber.c8 => throw 'unreachable',
          CaseNumber.c9 => "u'i",
        },
      CaseType.spatioTemporal1 => switch (caseNumber) {
          CaseNumber.c1 => charPrecedingThis == "y" ? "uä" : "i'a",
          CaseNumber.c2 => charPrecedingThis == "y" ? "uë" : "i'e",
          CaseNumber.c3 => charPrecedingThis == "y" ? "üä" : "i'o",
          CaseNumber.c4 => charPrecedingThis == "y" ? "üë" : "i'ö",
          CaseNumber.c5 => "e'ë",
          CaseNumber.c6 => charPrecedingThis == "w" ? "öë" : "u'ö",
          CaseNumber.c7 => charPrecedingThis == "w" ? "öä" : "u'o",
          CaseNumber.c8 => throw 'unreachable',
          CaseNumber.c9 => charPrecedingThis == "w" ? "iä" : "u'a",
        },
      CaseType.spatioTemporal2 => switch (caseNumber) {
          CaseNumber.c1 => "a'o",
          CaseNumber.c2 => "a'ö",
          CaseNumber.c3 => "e'o",
          CaseNumber.c4 => "e'ö",
          CaseNumber.c5 => "o'ë",
          CaseNumber.c6 => "ö'e",
          CaseNumber.c7 => "o'e",
          CaseNumber.c8 => throw 'unreachable',
          CaseNumber.c9 => "o'a",
        },
    };
  }

  /// ID for Quarternary top
  String topId() {
    return "case_type_${caseType.name}";
  }

  /// Path for Quarternary top
  String topPath() {
    return switch (caseType) {
      CaseType.transrelative => "",
      CaseType.appositive =>
        "M 0.00 0.00 L 0.00 7.30 Q 5.40 2.95 10.05 4.55 L 10.05 -7.70 25.05 -7.70 35.05 -17.70 17.65 -17.70 0.00 0.00 Z",
      CaseType.associative =>
        "M 10.00 5.00 L 10.00 -10.00 0.00 0.00 0.00 -20.00 -10.00 -10.10 -10.00 12.30 0.00 2.35 0.00 7.50 Q 5.00 1.40 10.00 5.00 Z",
      CaseType.adverbial =>
        "M -1.80 -21.80 L 10.00 -10.00 0.00 0.00 0.00 5.00 Q 5.19 -2.96 10.00 0.00 L 10.00 -7.70 18.20 -15.90 5.20 -28.80 -1.80 -21.80 Z",
      CaseType.relational =>
        "M 0.35 2.10 Q 0.73 1.74 1.50 0.95 7.76 -0.15 10.00 4.75 L 10.00 -10.00 0.00 0.00 -10.00 -10.00 -17.15 -2.85 -5.85 8.35 0.00 2.45 Q 0.04 2.42 0.35 2.10 Z",
      CaseType.affinitive =>
        "M 0.00 0.00 L 0.00 5.00 Q 6.25 -4.00 10.00 0.00 L 10.00 -7.60 21.80 4.10 28.80 -2.90 15.85 -15.85 0.00 0.00 Z",
      CaseType.spatioTemporal1 =>
        "M 22.40 -20.00 L 0.00 -20.00 -10.00 -9.90 9.90 -9.90 10.00 -10.00 10.00 -9.90 9.95 -9.90 0.00 0.00 0.00 5.00 Q 5.00 -0.77 10.00 0.00 L 10.00 -7.55 22.40 -20.00 Z",
      CaseType.spatioTemporal2 =>
        "M 0.00 0.00 L -15.05 0.00 -25.05 10.00 -7.60 10.00 0.00 2.40 -0.05 7.45 Q 4.55 1.15 9.95 3.45 L 9.95 -10.00 0.00 0.00 Z",
    };
  }

  /// ID for Quarternary bottom
  String bottomId() {
    return "case_number_case${caseNumber.name}";
  }

  /// Path for Quarternary bottom
  String bottomPath() {
    return switch (caseNumber) {
      CaseNumber.c1 => "",
      CaseNumber.c2 =>
        "M -10.05 7.70 L -25.05 7.70 -35.05 17.70 -17.65 17.70 0.00 0.00 0.00 -7.30 Q -5.40 -2.95 -10.05 -4.55 L -10.05 7.70 Z",
      CaseNumber.c3 =>
        "M -10.00 -5.00 L -10.00 10.00 0.00 0.00 0.00 20.00 10.00 10.10 10.00 -12.30 0.00 -2.35 0.00 -7.50 Q -5.00 -1.40 -10.00 -5.00 Z",
      CaseNumber.c4 =>
        "M 1.80 21.80 L -10.00 10.00 0.00 0.00 0.00 -5.00 Q -5.19 2.96 -10.00 0.00 L -10.00 7.70 -18.20 15.90 -5.20 28.80 1.80 21.80 Z",
      CaseNumber.c5 =>
        "M -0.35 -2.10 Q -0.73 -1.74 -1.50 -0.95 -7.76 0.15 -10.00 -4.75 L -10.00 10.00 0.00 0.00 10.00 10.00 17.15 2.85 5.85 -8.35 0.00 -2.45 Q -0.04 -2.42 -0.35 -2.10 Z",
      CaseNumber.c6 =>
        "M 0.00 0.00 L 0.00 -5.00 Q -6.25 4.00 -10.00 0.00 L -10.00 7.60 -21.80 -4.10 -28.80 2.90 -15.85 15.85 0.00 0.00 Z",
      CaseNumber.c7 =>
        "M -22.40 20.00 L 0.00 20.00 10.00 9.90 -9.90 9.90 -10.00 10.00 -10.00 9.90 -9.95 9.90 0.00 0.00 0.00 -5.00 Q -5.00 0.77 -10.00 0.00 L -10.00 7.55 -22.40 20.00 Z",
      CaseNumber.c8 =>
        "M 0.00 0.00 L 15.05 0.00 25.05 -10.00 7.60 -10.00 0.00 -2.40 0.05 -7.45 Q -4.55 -1.15 -9.95 -3.45 L -9.95 10.00 0.00 0.00 Z",
      CaseNumber.c9 =>
        "M -10.00 -5.00 L -10.00 10.00 5.00 10.00 15.00 0.00 0.00 0.00 0.00 -10.00 Q -3.87 -2.25 -10.00 -5.00 Z",
    };
  }
}
