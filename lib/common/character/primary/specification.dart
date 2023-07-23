enum Specification {
  basic(
    path: "M 7.50 -35.00 L 0.00 -27.50 57.50 35.00 65.00 27.50 7.50 -35.00 Z",
    abbr: "BSC",
  ),
  contential(
    path:
        "M 32.50 5.00 L 40.00 -2.50 7.50 -35.00 0.00 -27.50 32.50 5.00 M 15.00 -5.00 L 7.50 2.50 40.00 35.00 47.50 27.50 15.00 -5.00 Z",
    abbr: "CTE",
  ),
  constitutive(
    path:
        "M 28.00 8.10 L 35.45 0.60 62.50 35.00 70.00 27.50 42.20 -8.50 34.45 -0.70 7.50 -35.00 0.00 -27.50 28.00 8.10 Z",
    abbr: "CSV",
  ),
  objective(
    path:
        "M 47.50 35.00 L 55.00 27.50 28.10 0.60 35.55 -6.95 7.50 -35.00 0.00 -27.50 26.90 -0.60 19.40 6.90 47.50 35.00 Z",
    abbr: "OBJ",
  );

  final String path;
  final String abbr;

  const Specification({
    required this.path,
    required this.abbr,
  });
}
