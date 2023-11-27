class Level {
  final Comparison comparison;
  final ComparisonOperator comparisonOperator;

  const Level({
    required this.comparison,
    required this.comparisonOperator,
  });
}

enum Comparison {
  absolute,
  relative,
}

enum ComparisonOperator {
  min,
  sbe,
  ifr,
  dft,
  equ,
  sur,
  spl,
  spq,
  max;

  String romanize() {
    return switch (this) {
      min => 'ao',
      sbe => 'aö',
      ifr => 'eo',
      dft => 'eö',
      equ => 'oë',
      sur => 'öe',
      spl => 'oe',
      spq => 'öa',
      max => 'oa'
    };
  }

  String path() {
    return switch (this) {
      min => 'M -7.50 0.00 L 0.00 7.50 7.50 0.00 0.00 -7.50 -7.50 0.00 Z',
      sbe =>
        'M 7.60 0.00 L -1.20 8.80 0.00 10.00 20.00 -10.00 -10.00 -10.00 -20.00 0.00 7.60 0.00 Z',
      ifr =>
        'M 10.00 7.50 L 10.00 -17.50 -10.00 2.50 -8.80 3.70 0.00 -5.10 0.00 17.50 10.00 7.50 Z',
      dft =>
        'M 12.55 -5.40 Q 11.80 -10.70 7.15 -13.80 2.25 -17.10 -5.80 -17.00 L -13.30 -9.50 Q 1.60 -9.10 5.30 -0.95 9.05 7.25 -2.15 15.95 L -0.90 17.10 Q 6.45 11.90 10.00 5.70 13.30 -0.15 12.55 -5.40 Z',
      equ => 'M 5.00 -17.50 L -5.00 -7.50 -5.00 17.50 5.00 7.50 5.00 -17.50 Z',
      sur =>
        'M 12.55 -5.40 Q 11.80 -10.70 7.15 -13.80 2.25 -17.10 -5.80 -17.00 L -13.30 -9.50 Q 1.60 -9.10 5.30 -0.95 9.05 7.25 -2.15 15.95 L -0.90 17.10 Q 6.45 11.90 10.00 5.70 13.30 -0.15 12.55 -5.40 Z',
      spl =>
        'M 10.00 7.50 L 10.00 -17.50 -10.00 2.50 -8.80 3.70 0.00 -5.10 0.00 17.50 10.00 7.50 Z',
      spq =>
        'M 7.60 0.00 L -1.20 8.80 0.00 10.00 20.00 -10.00 -10.00 -10.00 -20.00 0.00 7.60 0.00 Z',
      max => "M 10.00 5.00 L 20.00 -5.00 -10.00 -5.00 -20.00 5.00 10.00 5.00 Z",
    };
  }
}
