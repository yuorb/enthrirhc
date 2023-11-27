enum Phase {
  pct,
  itr,
  rep,
  itm,
  rct,
  fre,
  frg,
  vac,
  flc;

  String romanize() {
    return switch (this) {
      pct => 'ai',
      itr => 'au',
      rep => 'ei',
      itm => 'eu',
      rct => 'ëu',
      fre => 'ou',
      frg => 'oi',
      vac => 'iu',
      flc => 'ui',
    };
  }
}
