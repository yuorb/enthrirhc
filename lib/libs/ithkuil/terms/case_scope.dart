enum CaseScope {
  ccn,
  cca,
  ccs,
  ccq,
  ccp,
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
}
