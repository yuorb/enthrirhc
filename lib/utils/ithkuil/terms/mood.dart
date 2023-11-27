enum Mood {
  fac,
  sub,
  asm,
  spc,
  cou,
  hyp;

  String romanize(bool tryShortCut, bool isPattern1) {
    return isPattern1
        ? switch (this) {
            fac => tryShortCut ? '' : 'a',
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
}
