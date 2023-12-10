enum Valence {
  /// Monoactive
  mno,

  /// Parallel
  prl,

  /// Corollary
  cro,

  /// Reciprocal
  rcp,

  /// Complementary
  cpl,

  /// Duplicative
  dup,

  /// Demonstrative
  dem,

  /// Contingent
  cng,

  /// Participative
  pti;

  String romanize(bool omitOptionalAffixes) {
    return switch (this) {
      mno => omitOptionalAffixes ? '' : 'a',
      prl => 'ä',
      cro => 'e',
      rcp => 'i',
      cpl => 'ëi',
      dup => 'ö',
      dem => 'o',
      cng => 'ü',
      pti => 'u',
    };
  }

  String path() {
    return switch (this) {
      mno => "M -20.00 -5.00 L -30.00 5.00 20.00 5.00 30.00 -5.00 -20.00 -5.00 Z",
      prl =>
        "M -20.00 -5.00 L -30.00 5.00 17.60 5.00 11.30 11.30 12.50 12.50 30.00 -5.00 -20.00 -5.00 Z",
      cro =>
        "M -17.60 -5.00 L -11.30 -11.30 -12.50 -12.50 -30.00 5.00 20.00 5.00 30.00 -5.00 -17.60 -5.00 Z",
      rcp =>
        "M -17.60 -5.00 L -11.30 -11.30 -12.50 -12.50 -30.00 5.00 17.60 5.00 11.30 11.30 12.50 12.50 30.00 -5.00 -17.60 -5.00 Z",
      cpl =>
        "M -20.00 -5.00 L -37.50 12.50 -36.30 13.70 -27.60 5.00 20.00 5.00 30.00 -5.00 -20.00 -5.00 Z",
      dup =>
        "M -20.00 -5.00 L -30.00 5.00 20.00 5.00 37.50 -12.50 36.30 -13.70 27.60 -5.00 -20.00 -5.00 Z",
      dem =>
        "M -20.00 -5.00 L -30.00 5.00 20.00 5.00 Q 23.30 1.69 26.60 -1.65 L 28.85 -3.85 Q 36.55 -2.59 37.75 1.90 38.85 6.15 34.25 13.80 44.95 6.25 44.85 -2.35 44.80 -10.70 35.15 -12.50 L 27.60 -5.00 -20.00 -5.00 Z",
      cng =>
        "M 20.00 5.00 L 28.80 -3.80 Q 31.17 6.15 39.15 7.35 47.15 8.55 54.50 0.25 41.70 7.45 35.15 -12.50 L 27.60 -5.00 -20.00 -5.00 -30.00 5.00 20.00 5.00 Z",
      pti =>
        "M -37.50 12.50 L -36.30 13.70 -27.60 5.00 20.00 5.00 28.85 -3.85 Q 36.55 -2.59 37.75 1.90 38.85 6.15 34.25 13.80 44.95 6.25 44.85 -2.35 44.80 -10.70 35.15 -12.50 L 27.60 -5.00 -20.00 -5.00 -37.50 12.50 Z"
    };
  }
}
