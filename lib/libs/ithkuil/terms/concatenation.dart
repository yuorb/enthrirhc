enum Concatenation {
  type1('M 5.00 -17.50 L -5.00 -7.50 -5.00 17.50 5.00 7.50 5.00 -17.50 Z'),
  type2('M 7.60 0.00 L -1.20 8.80 0.00 10.00 20.00 -10.00 -10.00 -10.00 -20.00 0.00 7.60 0.00 Z');

  final String path;
  const Concatenation(this.path);
}
