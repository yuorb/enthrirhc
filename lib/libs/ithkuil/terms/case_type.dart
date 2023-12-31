enum CaseType {
  transrelative,
  appositive,
  associative,
  adverbial,
  relational,
  affinitive,
  spatioTemporal1,
  spatioTemporal2;

  bool hasNineCaseNumber() {
    return switch (this) {
      CaseType.transrelative => true,
      CaseType.appositive => true,
      CaseType.associative => true,
      CaseType.adverbial => true,
      CaseType.relational => false,
      CaseType.affinitive => false,
      CaseType.spatioTemporal1 => false,
      CaseType.spatioTemporal2 => false,
    };
  }

  /// ID for Quarternary top
  String idQuaternary() {
    return "quarternary_case_type_$name";
  }

  /// Path for Quarternary top
  String pathQuaternary() {
    return switch (this) {
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

  /// ID for Cr root Secondary top
  String idSecondary() {
    return "secondary_case_type_$name";
  }

  /// Path for Cr root Secondary top
  String pathSecondary() {
    return switch (this) {
      CaseType.transrelative => "",
      CaseType.appositive => "M -7.50 0.00 L 0.00 7.50 7.50 0.00 0.00 -7.50 -7.50 0.00 Z",
      CaseType.associative => "M 10.00 5.00 L 20.00 -5.00 -10.00 -5.00 -20.00 5.00 10.00 5.00 Z",
      CaseType.adverbial =>
        "M 20.25 -9.78 L 19.10 -11.03 Q 12.55 0.67 4.70 1.22 -3.10 1.72 -12.75 -8.53 L -20.25 -1.03 Q -13.70 11.02 -1.55 8.52 10.70 6.02 20.25 -9.78 Z",
      CaseType.relational =>
        "M -20.25 9.78 L -19.10 11.03 Q -12.55 -0.67 -4.70 -1.22 3.10 -1.72 12.75 8.53 L 20.25 1.03 Q 13.70 -11.02 1.55 -8.52 -10.70 -6.02 -20.25 9.78 Z",
      CaseType.affinitive =>
        "M 7.60 0.00 L -1.20 8.80 0.00 10.00 20.00 -10.00 -10.00 -10.00 -20.00 0.00 7.60 0.00 Z",
      CaseType.spatioTemporal1 =>
        "M -7.60 0.00 L 1.20 -8.80 0.00 -10.00 -20.00 10.00 10.00 10.00 20.00 0.00 -7.60 0.00 Z",
      CaseType.spatioTemporal2 =>
        "M 12.55 -5.40 Q 11.80 -10.70 7.15 -13.80 2.25 -17.10 -5.80 -17.00 L -13.30 -9.50 Q 1.60 -9.10 5.30 -0.95 9.05 7.25 -2.15 15.95 L -0.90 17.10 Q 6.45 11.90 10.00 5.70 13.30 -0.15 12.55 -5.40 Z",
    };
  }
}
