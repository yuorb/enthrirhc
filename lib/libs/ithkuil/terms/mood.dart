enum Mood {
  fac,
  sub,
  asm,
  spc,
  cou,
  hyp;

  String romanize(bool omitOptionalAffixes, bool isPattern1) {
    return isPattern1
        ? switch (this) {
            fac => omitOptionalAffixes ? '' : 'a',
            sub => 'hl',
            asm => 'hr',
            spc => 'hm',
            cou => 'hn',
            hyp => 'hň',
          }
        : switch (this) {
            // `y` is also okay here.
            fac => 'w',
            sub => 'hw',
            asm => 'hrw',
            spc => 'hmw',
            cou => 'hnw',
            hyp => 'hňw',
          };
  }

  String id() {
    return "mood_$name";
  }

  String path() {
    return switch (this) {
      fac => "",
      sub => "M -7.50 -70.00 L 0.00 -62.50 7.50 -70.00 0.00 -77.50 -7.50 -70.00 Z",
      asm => "M 5.00 -87.50 L -5.00 -77.50 -5.00 -52.50 5.00 -62.50 5.00 -87.50 Z",
      spc =>
        "M 12.55 -75.40 Q 11.80 -80.70 7.15 -83.80 2.25 -87.10 -5.80 -87.00 L -13.30 -79.50 Q 1.60 -79.10 5.30 -70.95 9.05 -62.75 -2.15 -54.05 L -0.90 -52.90 Q 6.45 -58.10 10.00 -64.30 13.30 -70.15 12.55 -75.40 Z",
      cou =>
        "M 12.55 -75.40 Q 11.80 -80.70 7.15 -83.80 2.25 -87.10 -5.80 -87.00 L -13.30 -79.50 Q 1.60 -79.10 5.30 -70.95 9.05 -62.75 -2.15 -54.05 L -0.90 -52.90 Q 6.45 -58.10 10.00 -64.30 13.30 -70.15 12.55 -75.40 Z",
      hyp => "M 10.00 -65.00 L 20.00 -75.00 -10.00 -75.00 -20.00 -65.00 10.00 -65.00 Z"
    };
  }
}
