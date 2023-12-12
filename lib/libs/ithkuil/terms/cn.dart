enum Cn {
  cn1,
  cn2,
  cn3,
  cn4,
  cn5,
  cn6;

  String romanize(bool omitOptionalAffixes, bool isPattern1) {
    return isPattern1
        ? switch (this) {
            cn1 => omitOptionalAffixes ? '' : 'h',
            cn2 => 'hl',
            cn3 => 'hr',
            cn4 => 'hm',
            cn5 => 'hn',
            cn6 => 'hň',
          }
        : switch (this) {
            // `y` is also okay here.
            cn1 => 'w',
            cn2 => 'hw',
            cn3 => 'hrw',
            cn4 => 'hmw',
            cn5 => 'hnw',
            cn6 => 'hňw',
          };
  }

  String id() {
    return "Cn_$name";
  }

  String path() {
    return switch (this) {
      cn1 => "",
      cn2 => "M -7.50 0.00 L 0.00 7.50 7.50 0.00 0.00 -7.50 -7.50 0.00 Z",
      cn3 => "M 5.00 -17.50 L -5.00 -7.50 -5.00 17.50 5.00 7.50 5.00 -17.50 Z",
      cn4 =>
        "M 12.55 -5.40 Q 11.80 -10.70 7.15 -13.80 2.25 -17.10 -5.80 -17.00 L -13.30 -9.50 Q 1.60 -9.10 5.30 -0.95 9.05 7.25 -2.15 15.95 L -0.90 17.10 Q 6.45 11.90 10.00 5.70 13.30 -0.15 12.55 -5.40 Z",
      cn5 =>
        "M 12.55 -5.40 Q 11.80 -10.70 7.15 -13.80 2.25 -17.10 -5.80 -17.00 L -13.30 -9.50 Q 1.60 -9.10 5.30 -0.95 9.05 7.25 -2.15 15.95 L -0.90 17.10 Q 6.45 11.90 10.00 5.70 13.30 -0.15 12.55 -5.40 Z",
      cn6 => "M 10.00 5.00 L 20.00 -5.00 -10.00 -5.00 -20.00 5.00 10.00 5.00 Z"
    };
  }
}
