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
}
