enum AffixType {
  type1,
  type2,
  type3;

  String path() {
    return switch (this) {
      type1 => '',
      type2 => 'M -7.50 0.00 L 0.00 7.50 7.50 0.00 0.00 -7.50 -7.50 0.00 Z',
      type3 => 'M 10.00 5.00 L 20.00 -5.00 -10.00 -5.00 -20.00 5.00 10.00 5.00 Z',
    };
  }
}
