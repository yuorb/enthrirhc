enum Case {
  // The Transrelative Cases
  thm,
  ins,
  abs,
  aff,
  stm,
  eff,
  erg,
  dat,
  ind,
  // The Appositive Cases
  pos,
  prp,
  gen,
  att,
  pdc,
  itp,
  ogn,
  idp,
  par,
  // The Associative Cases
  apl,
  pur,
  tra,
  dfr,
  crs,
  tsp,
  cmm,
  cmp,
  csd,
  // Adverbial Cases
  fun,
  tfm,
  cla,
  rsl,
  csm,
  con,
  avr,
  cvs,
  sit,
  // The Relational Cases
  prn,
  dsp,
  cor,
  cps,
  com,
  utl,
  prd,
  rlt,
  // The Affinitive Cases
  act,
  asi,
  ess,
  trm,
  sel,
  cfm,
  dep,
  voc,
  // The Spatio-Temporal Cases — Group I
  loc,
  atd,
  all,
  abl,
  ori,
  irl,
  inv,
  nav,
  // The Spatio-Temporal Cases — Group II
  cnr,
  ass,
  per,
  pro,
  pcv,
  pcr,
  elp,
  plm;

  String romanized(String charPrecedingThis) {
    return switch (this) {
      thm => "a",
      ins => "ä",
      abs => "e",
      aff => "i",
      stm => "ëi",
      eff => "ö",
      erg => "o",
      dat => "ü",
      ind => "u",
      pos => "ai",
      prp => "au",
      gen => "ei",
      att => "eu",
      pdc => "ëu",
      itp => "ou",
      ogn => "oi",
      idp => "iu",
      par => "ui",
      apl => charPrecedingThis == "y" ? "uä" : "ia",
      pur => charPrecedingThis == "y" ? "uë" : "ie",
      tra => charPrecedingThis == "y" ? "üä" : "io",
      dfr => charPrecedingThis == "y" ? "üë" : "iö",
      crs => "eë",
      tsp => charPrecedingThis == "w" ? "öë" : "uö",
      cmm => charPrecedingThis == "w" ? "öä" : "uo",
      cmp => charPrecedingThis == "w" ? "ië" : "ue",
      csd => charPrecedingThis == "w" ? "iä" : "ua",
      fun => "ao",
      tfm => "aö",
      cla => "eo",
      rsl => "eö",
      csm => "oë",
      con => "öe",
      avr => "oe",
      cvs => "öa",
      sit => "oa",
      prn => "a'a",
      dsp => "ä'ä",
      cor => "e'e",
      cps => "i'i",
      com => "ë'i",
      utl => "ö'ö",
      prd => "o'o",
      rlt => "u'u",
      act => "a'i",
      asi => "a'u",
      ess => "e'i",
      trm => "e'u",
      sel => "ë'u",
      cfm => "o'u",
      dep => "o'i",
      voc => "u'i",
      loc => charPrecedingThis == "y" ? "uä" : "i'a",
      atd => charPrecedingThis == "y" ? "uë" : "i'e",
      all => charPrecedingThis == "y" ? "üä" : "i'o",
      abl => charPrecedingThis == "y" ? "üë" : "i'ö",
      ori => "e'ë",
      irl => charPrecedingThis == "w" ? "öë" : "u'ö",
      inv => charPrecedingThis == "w" ? "öä" : "u'o",
      nav => charPrecedingThis == "w" ? "iä" : "u'a",
      cnr => "a'o",
      ass => "a'ö",
      per => "e'o",
      pro => "e'ö",
      pcv => "o'ë",
      pcr => "ö'e",
      elp => "o'e",
      plm => "o'a",
    };
  }

  /// Path for Quarternary top
  String topPath() {
    return switch (this) {
      thm || ins || abs || aff || stm || eff || erg || dat || ind => "",
      pos ||
      prp ||
      gen ||
      att ||
      pdc ||
      itp ||
      ogn ||
      idp ||
      par =>
        "M 0.00 0.00 L 0.00 7.30 Q 5.40 2.95 10.05 4.55 L 10.05 -7.70 25.05 -7.70 35.05 -17.70 17.65 -17.70 0.00 0.00 Z",
      apl ||
      pur ||
      tra ||
      dfr ||
      crs ||
      tsp ||
      cmm ||
      cmp ||
      csd =>
        "M 10.00 5.00 L 10.00 -10.00 0.00 0.00 0.00 -20.00 -10.00 -10.10 -10.00 12.30 0.00 2.35 0.00 7.50 Q 5.00 1.40 10.00 5.00 Z",
      fun ||
      tfm ||
      cla ||
      rsl ||
      csm ||
      con ||
      avr ||
      cvs ||
      sit =>
        "M -1.80 -21.80 L 10.00 -10.00 0.00 0.00 0.00 5.00 Q 5.19 -2.96 10.00 0.00 L 10.00 -7.70 18.20 -15.90 5.20 -28.80 -1.80 -21.80 Z",
      prn ||
      dsp ||
      cor ||
      cps ||
      com ||
      utl ||
      prd ||
      rlt =>
        "M 0.35 2.10 Q 0.73 1.74 1.50 0.95 7.76 -0.15 10.00 4.75 L 10.00 -10.00 0.00 0.00 -10.00 -10.00 -17.15 -2.85 -5.85 8.35 0.00 2.45 Q 0.04 2.42 0.35 2.10 Z",
      act ||
      asi ||
      ess ||
      trm ||
      sel ||
      cfm ||
      dep ||
      voc =>
        "M 0.00 0.00 L 0.00 5.00 Q 6.25 -4.00 10.00 0.00 L 10.00 -7.60 21.80 4.10 28.80 -2.90 15.85 -15.85 0.00 0.00 Z",
      loc ||
      atd ||
      all ||
      abl ||
      ori ||
      irl ||
      inv ||
      nav =>
        "M 22.40 -20.00 L 0.00 -20.00 -10.00 -9.90 9.90 -9.90 10.00 -10.00 10.00 -9.90 9.95 -9.90 0.00 0.00 0.00 5.00 Q 5.00 -0.77 10.00 0.00 L 10.00 -7.55 22.40 -20.00 Z",
      cnr ||
      ass ||
      per ||
      pro ||
      pcv ||
      pcr ||
      elp ||
      plm =>
        "M 0.00 0.00 L -15.05 0.00 -25.05 10.00 -7.60 10.00 0.00 2.40 -0.05 7.45 Q 4.55 1.15 9.95 3.45 L 9.95 -10.00 0.00 0.00 Z",
    };
  }

  /// Path for Quarternary bottom
  String bottomPath() {
    return switch (this) {
      thm || pos || apl || fun || prn || act || loc || cnr => "",
      ins ||
      prp ||
      pur ||
      tfm ||
      dsp ||
      asi ||
      atd ||
      ass =>
        "M -10.05 7.70 L -25.05 7.70 -35.05 17.70 -17.65 17.70 0.00 0.00 0.00 -7.30 Q -5.40 -2.95 -10.05 -4.55 L -10.05 7.70 Z",
      abs ||
      gen ||
      tra ||
      cla ||
      cor ||
      ess ||
      all ||
      per =>
        "M -10.00 -5.00 L -10.00 10.00 0.00 0.00 0.00 20.00 10.00 10.10 10.00 -12.30 0.00 -2.35 0.00 -7.50 Q -5.00 -1.40 -10.00 -5.00 Z",
      aff ||
      att ||
      dfr ||
      rsl ||
      cps ||
      trm ||
      abl ||
      pro =>
        "M 1.80 21.80 L -10.00 10.00 0.00 0.00 0.00 -5.00 Q -5.19 2.96 -10.00 0.00 L -10.00 7.70 -18.20 15.90 -5.20 28.80 1.80 21.80 Z",
      stm ||
      pdc ||
      crs ||
      csm ||
      com ||
      sel ||
      ori ||
      pcv =>
        "M -0.35 -2.10 Q -0.73 -1.74 -1.50 -0.95 -7.76 0.15 -10.00 -4.75 L -10.00 10.00 0.00 0.00 10.00 10.00 17.15 2.85 5.85 -8.35 0.00 -2.45 Q -0.04 -2.42 -0.35 -2.10 Z",
      eff ||
      itp ||
      tsp ||
      con ||
      utl ||
      cfm ||
      irl ||
      pcr =>
        "M 0.00 0.00 L 0.00 -5.00 Q -6.25 4.00 -10.00 0.00 L -10.00 7.60 -21.80 -4.10 -28.80 2.90 -15.85 15.85 0.00 0.00 Z",
      erg ||
      ogn ||
      cmm ||
      avr ||
      prd ||
      dep ||
      inv ||
      elp =>
        "M -22.40 20.00 L 0.00 20.00 10.00 9.90 -9.90 9.90 -10.00 10.00 -10.00 9.90 -9.95 9.90 0.00 0.00 0.00 -5.00 Q -5.00 0.77 -10.00 0.00 L -10.00 7.55 -22.40 20.00 Z",
      dat ||
      idp ||
      cmp ||
      cvs =>
        "M 0.00 0.00 L 15.05 0.00 25.05 -10.00 7.60 -10.00 0.00 -2.40 0.05 -7.45 Q -4.55 -1.15 -9.95 -3.45 L -9.95 10.00 0.00 0.00 Z",
      ind ||
      par ||
      csd ||
      sit ||
      rlt ||
      voc ||
      nav ||
      plm =>
        "M -10.00 -5.00 L -10.00 10.00 5.00 10.00 15.00 0.00 0.00 0.00 0.00 -10.00 Q -3.87 -2.25 -10.00 -5.00 Z",
    };
  }
}
