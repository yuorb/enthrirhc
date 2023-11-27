import '../../../libs/mod.dart';

enum Specification {
  /// Basic Specification
  bsc,

  /// Contential Specification
  cte,

  /// Constitutive Specification
  csv,

  /// Objective Specification
  obj;

  String path() {
    return switch (this) {
      bsc => "M 7.50 -35.00 L 0.00 -27.50 57.50 35.00 65.00 27.50 7.50 -35.00 Z",
      cte =>
        "M 32.50 5.00 L 40.00 -2.50 7.50 -35.00 0.00 -27.50 32.50 5.00 M 15.00 -5.00 L 7.50 2.50 40.00 35.00 47.50 27.50 15.00 -5.00 Z",
      csv =>
        "M 28.00 8.10 L 35.45 0.60 62.50 35.00 70.00 27.50 42.20 -8.50 34.45 -0.70 7.50 -35.00 0.00 -27.50 28.00 8.10 Z",
      obj =>
        "M 47.50 35.00 L 55.00 27.50 28.10 0.60 35.55 -6.95 7.50 -35.00 0.00 -27.50 26.90 -0.60 19.40 6.90 47.50 35.00 Z",
    };
  }

  double centerX() {
    return switch (this) {
      bsc => 32.50,
      cte => 23.75,
      csv => 35.00,
      obj => 27.50,
    };
  }

  Coord bAnchor() {
    return const Coord(0, -27.50);
  }

  Coord dAnchor() {
    return switch (this) {
      bsc => const Coord(65.00, 27.50),
      cte => const Coord(47.50, 27.50),
      csv => const Coord(70.00, 27.50),
      obj => const Coord(55.00, 27.50),
    };
  }
}
