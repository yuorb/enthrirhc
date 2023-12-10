enum CaseScope {
  /// Natural
  ccn,

  /// Antecedent
  cca,

  /// Subaltern
  ccs,

  /// Qualifier
  ccq,

  /// Precedent
  ccp,

  /// Successive
  ccv;

  String romanize(bool omitOptionalAffixes, bool isPattern1) {
    return isPattern1
        ? switch (this) {
            ccn => omitOptionalAffixes ? '' : 'a',
            cca => 'hl',
            ccs => 'hr',
            ccq => 'hm',
            ccp => 'hn',
            ccv => 'hň',
          }
        : switch (this) {
            // `y` is also okay here.
            ccn => 'w',
            cca => 'hw',
            ccs => 'hrw',
            ccq => 'hmw',
            ccp => 'hnw',
            ccv => 'hňw',
          };
  }

  String id() {
    return "caseScope_$name";
  }

  String path() {
    return switch (this) {
      ccn => "",
      cca => "M -7.50 70.00 L 0.00 77.50 7.50 70.00 0.00 62.50 -7.50 70.00 Z",
      ccs => "M 5.00 52.50 L -5.00 62.50 -5.00 87.50 5.00 77.50 5.00 52.50 Z",
      ccq =>
        "M 12.55 64.60 Q 11.80 59.30 7.15 56.20 2.25 52.90 -5.80 53.00 L -13.30 60.50 Q 1.60 60.90 5.30 69.05 9.05 77.25 -2.15 85.95 L -0.90 87.10 Q 6.45 81.90 10.00 75.70 13.30 69.85 12.55 64.60 Z",
      ccp =>
        "M 12.55 64.60 Q 11.80 59.30 7.15 56.20 2.25 52.90 -5.80 53.00 L -13.30 60.50 Q 1.60 60.90 5.30 69.05 9.05 77.25 -2.15 85.95 L -0.90 87.10 Q 6.45 81.90 10.00 75.70 13.30 69.85 12.55 64.60 Z",
      ccv => "M 10.00 75.00 L 20.00 65.00 -10.00 65.00 -20.00 75.00 10.00 75.00 Z"
    };
  }
}
