enum AnchorOrientation {
  up('up', 0),
  down('up', 180),
  right('left', 180),
  upperLeft('diag', 0),
  lowerRight('diag', 180);

  final String filename;
  final int rotation;

  const AnchorOrientation(this.filename, this.rotation);
}

class Anchor {
  final double x;
  final double y;
  final AnchorOrientation orientation;

  const Anchor(
    this.orientation,
    this.x,
    this.y,
  );
}

enum CoreLetter {
  f(
    romanizedLetters: ["f"],
    path:
        "M 50.00 -25.00 L 60.00 -35.00 10.00 -35.00 0.00 -25.00 0.00 5.00 30.00 5.00 30.00 35.00 40.00 25.00 40.00 -5.00 10.00 -5.00 10.00 -25.00 50.00 -25.00 Z",
    top: Anchor(AnchorOrientation.right, 50, -25),
    bottom: Anchor(AnchorOrientation.down, 40, 25),
  ),
  v(
    romanizedLetters: ["v"],
    path:
        "M 50.00 -25.00 L 60.00 -35.00 10.00 -35.00 0.00 -25.00 0.00 10.00 10.00 0.00 25.00 0.00 25.00 35.00 35.00 25.00 35.00 -10.00 17.65 -10.00 10.00 -2.40 10.00 -25.00 50.00 -25.00 Z",
    top: Anchor(AnchorOrientation.right, 50, -25),
    bottom: Anchor(AnchorOrientation.down, 35, 25),
  ),
  c(
    romanizedLetters: ["c"],
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 40.00 35.00 50.00 25.00 10.00 25.00 10.00 -35.00 Z",
    top: Anchor(AnchorOrientation.up, 0.00, -25.00),
    bottom: Anchor(AnchorOrientation.right, 40, 35),
  ),
  dz(
    romanizedLetters: ["ẓ", "ż"],
    path:
        "M 20.00 -35.00 L 10.00 -25.00 10.00 25.00 0.00 35.00 45.00 35.00 55.00 25.00 12.40 25.00 20.00 17.40 20.00 -35.00 Z",
    top: Anchor(AnchorOrientation.up, 10, -25),
    bottom: Anchor(AnchorOrientation.right, 45, 35),
  ),
  t(
    romanizedLetters: ["t"],
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 10.00 25.00 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    top: Anchor(AnchorOrientation.right, 40, -25),
    bottom: Anchor(AnchorOrientation.down, 10, 25),
  ),
  d(
    romanizedLetters: ["d"],
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 11.30 10.00 1.25 10.00 35.00 20.00 25.00 20.00 -11.15 10.00 -1.15 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    top: Anchor(AnchorOrientation.right, 40, -25),
    bottom: Anchor(AnchorOrientation.down, 20, 25),
  ),
  sh(
    romanizedLetters: ["š"],
    path:
        "M 40.00 -35.00 L 30.00 -25.00 30.00 -5.00 10.00 -5.00 0.00 5.00 0.00 35.00 30.00 35.00 40.00 25.00 10.00 25.00 10.00 5.00 30.00 5.00 40.00 -5.00 40.00 -35.00 Z",
    top: Anchor(AnchorOrientation.up, 30, -25),
    bottom: Anchor(AnchorOrientation.right, 30, 35),
  ),
  ch(
    romanizedLetters: ["č"],
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 40.00 35.00 50.00 25.00 10.00 25.00 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    top: Anchor(AnchorOrientation.right, 40, -25),
    bottom: Anchor(AnchorOrientation.right, 40, 35),
  ),

  j(
    romanizedLetters: ["j"],
    path:
        "M 20.00 -35.00 L 10.00 -25.00 10.00 25.00 0.00 35.00 45.00 35.00 55.00 25.00 12.40 25.00 20.00 17.40 20.00 -25.00 50.00 -25.00 60.00 -35.00 20.00 -35.00 Z",
    top: Anchor(AnchorOrientation.right, 50, -25),
    bottom: Anchor(AnchorOrientation.right, 45, 35),
  ),
  l(
    romanizedLetters: ["l"],
    path:
        "M 15.00 -35.00 L 5.00 -25.00 5.00 10.00 24.95 10.00 0.00 35.00 40.00 35.00 50.00 25.00 12.40 25.00 37.25 0.00 15.00 0.00 15.00 -35.00 Z",
    top: Anchor(AnchorOrientation.up, 5, -25),
    bottom: Anchor(AnchorOrientation.right, 40, 35),
  ),
  m(
    romanizedLetters: ["m"],
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 5.00 30.00 35.00 37.50 27.50 10.00 0.00 10.00 -35.00 Z",
    top: Anchor(AnchorOrientation.up, 0, -25),
    bottom: Anchor(AnchorOrientation.lowerRight, 37.50, 27.50),
  ),
  hs(
    romanizedLetters: ["ç"],
    path:
        "M 23.70 -35.00 13.70 -25.00 31.20 -7.50 16.20 -7.50 0.00 8.65 26.35 35.00 33.85 27.50 8.85 2.50 41.20 2.50 48.70 -5.00 28.70 -25.00 63.70 -25.00 73.70 -35.00 23.70 -35.00 Z",
    top: Anchor(AnchorOrientation.right, 63.7, -25),
    bottom: Anchor(AnchorOrientation.lowerRight, 33.85, 27.50),
  ),
  h(
    romanizedLetters: ["h"],
    path:
        "M 10.00 -35.00 0.00 -25.00 0.00 10.00 26.30 10.00 35.00 1.25 35.00 35.00 45.00 25.00 45.00 -11.15 33.85 0.00 10.00 0.00 10.00 -35.00 Z",
    top: Anchor(AnchorOrientation.up, 0, -25),
    bottom: Anchor(AnchorOrientation.down, 45, 25),
  ),
  p(
    romanizedLetters: ["p"],
    path:
        "M 15.05 -25.00 L 50.00 -25.00 60.00 -35.00 10.00 -35.00 0.00 -25.00 25.00 0.00 25.00 35.00 35.00 25.00 35.00 -5.05 15.05 -25.00 Z",
    top: Anchor(AnchorOrientation.right, 50, -25),
    bottom: Anchor(AnchorOrientation.down, 35, 25),
  ),
  k(
    romanizedLetters: ["k"],
    path:
        "M 9.90 -35.03 L 0.00 -25.08 47.35 33.27 47.40 33.27 48.80 35.02 56.30 27.52 13.60 -25.03 65.65 -25.03 75.65 -35.03 9.90 -35.03 Z",
    top: Anchor(AnchorOrientation.right, 65.65, -25.03),
    bottom: Anchor(AnchorOrientation.lowerRight, 56.30, 27.52),
  ),
  b(
    romanizedLetters: ["b"],
    path:
        "M 59.40 -35.00 L 9.40 -35.00 0.00 -25.60 23.20 7.45 29.40 1.20 29.40 35.00 39.40 25.00 39.40 -11.15 38.30 -10.05 Q 35.33 -7.07 32.35 -4.10 L 30.40 -2.10 30.35 -2.15 29.70 -1.50 13.20 -25.00 49.40 -25.00 59.40 -35.00 Z",
    top: Anchor(AnchorOrientation.right, 49.4, -25),
    bottom: Anchor(AnchorOrientation.down, 39.4, 25),
  ),
  dh(
    romanizedLetters: ["ḍ", 'ḑ', 'đ'],
    path:
        "M 60.00 -34.92 L 10.00 -34.92 0.00 -24.92 0.00 15.08 9.55 5.53 30.20 34.93 37.85 27.28 16.20 -3.52 10.00 2.68 10.00 -24.92 50.00 -24.92 60.00 -34.92 Z",
    top: Anchor(AnchorOrientation.right, 50, -24.92),
    bottom: Anchor(AnchorOrientation.lowerRight, 37.85, 27.28),
  ),
  g(
    romanizedLetters: ["g"],
    path:
        "M 65.65 -24.93 L 75.65 -34.93 9.90 -34.93 0.00 -24.98 30.45 12.57 37.70 5.27 61.85 34.92 69.30 27.52 44.10 -3.53 36.60 3.92 13.50 -24.93 65.65 -24.93 Z",
    top: Anchor(AnchorOrientation.right, 65.65, -24.93),
    bottom: Anchor(AnchorOrientation.lowerRight, 69.30, 27.52),
  ),
  hl(
    romanizedLetters: ['ḷ', "ļ", 'ł'],
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 5.00 17.70 5.00 11.35 11.40 35.00 35.00 42.45 27.50 19.95 5.00 30.00 -5.00 10.00 -5.00 10.00 -35.00 Z",
    top: Anchor(AnchorOrientation.up, 0, -25),
    bottom: Anchor(AnchorOrientation.lowerRight, 42.45, 27.50),
  ),
  n(
    romanizedLetters: ["n"],
    path:
        "M 10.00 -34.92 L 0.00 -24.92 0.00 15.08 9.55 5.52 30.20 34.92 37.70 27.42 16.10 -3.42 10.00 2.67 10.00 -34.92 Z",
    top: Anchor(AnchorOrientation.up, 0, -24.92),
    bottom: Anchor(AnchorOrientation.lowerRight, 37.70, 27.42),
  ),
  ng(
    romanizedLetters: ["ň", 'ņ', 'ṇ'],
    path:
        "M 8.45 -25.05 L 8.45 -0.05 0.00 8.40 26.70 35.05 34.20 27.55 8.70 2.05 18.45 -7.65 18.45 -35.05 8.45 -25.05 Z",
    top: Anchor(AnchorOrientation.up, 8.45, -25.05),
    bottom: Anchor(AnchorOrientation.lowerRight, 34.20, 27.55),
  ),
  r(
    romanizedLetters: ["r"],
    path:
        "M 7.50 -35.00 L 0.00 -27.50 31.25 3.75 0.00 35.00 40.00 35.00 50.00 25.00 12.40 25.00 39.90 -2.60 7.50 -35.00 Z",
    top: Anchor(AnchorOrientation.upperLeft, 0, -27.50),
    bottom: Anchor(AnchorOrientation.right, 40, 35),
  ),
  gr(
    romanizedLetters: ["ř", 'ŗ', 'ṛ'],
    path:
        "M 7.45 -35.03 L 0.00 -27.47 22.75 -4.78 13.00 5.03 13.00 35.03 38.00 35.03 48.00 25.03 23.00 25.03 22.90 -2.53 31.45 -11.03 7.45 -35.03 Z",
    top: Anchor(AnchorOrientation.upperLeft, 0, -27.47),
    bottom: Anchor(AnchorOrientation.right, 38, 35.03),
  ),
  s(
    romanizedLetters: ["s"],
    path:
        "M 55.00 -34.97 L 45.00 -24.97 45.00 -4.97 10.00 -4.97 0.00 5.03 29.95 34.97 37.45 27.47 15.00 5.03 45.00 5.03 55.00 -4.97 55.00 -34.97 Z",
    top: Anchor(AnchorOrientation.up, 45, -24.97),
    bottom: Anchor(AnchorOrientation.lowerRight, 37.45, 27.47),
  ),
  th(
    romanizedLetters: ['ṭ', "ţ", 'ŧ'],
    path:
        "M 60.00 -35.05 L 10.00 -35.05 0.00 -25.05 0.00 1.95 33.10 35.05 40.60 27.55 10.00 -3.05 10.00 -25.05 50.00 -25.05 60.00 -35.05 Z",
    top: Anchor(AnchorOrientation.right, 50, -25.05),
    bottom: Anchor(AnchorOrientation.lowerRight, 40.60, 27.55),
  ),
  x(
    romanizedLetters: ["x"],
    path:
        "M 75.65 -35.03 L 9.90 -35.03 0.00 -25.08 25.70 0.63 18.20 8.13 45.10 35.02 52.60 27.52 26.90 1.82 34.35 -5.73 15.05 -25.03 65.65 -25.03 75.65 -35.03 Z",
    top: Anchor(AnchorOrientation.right, 65.65, -25.03),
    bottom: Anchor(AnchorOrientation.lowerRight, 52.60, 27.52),
  ),
  z(
    romanizedLetters: ["z"],
    path:
        "M 40.00 4.63 L 50.00 -5.38 20.15 -35.22 12.65 -27.72 35.00 -5.38 15.00 -5.38 0.00 9.63 25.60 35.22 33.10 27.72 10.00 4.63 40.00 4.63 Z",
    top: Anchor(AnchorOrientation.upperLeft, 12.65, -27.72),
    bottom: Anchor(AnchorOrientation.lowerRight, 33.10, 27.72),
  ),
  zh(
    romanizedLetters: ["ž"],
    path:
        "M 16.95 -35.03 L 9.45 -27.53 32.00 -4.97 17.60 -4.97 0.00 12.68 0.00 35.03 40.00 35.03 50.00 25.03 10.00 25.03 10.00 5.03 40.00 5.03 48.50 -3.47 16.95 -35.03 Z",
    top: Anchor(AnchorOrientation.upperLeft, 9.45, -27.53),
    bottom: Anchor(AnchorOrientation.right, 40.00, 35.03),
  );

  final List<String> romanizedLetters;
  final String path;
  final Anchor top;
  final Anchor bottom;

  const CoreLetter({
    required this.romanizedLetters,
    required this.path,
    required this.top,
    required this.bottom,
  });

  static CoreLetter? from(String letter) {
    for (final value in CoreLetter.values) {
      if (value.romanizedLetters.contains(letter)) {
        return value;
      }
    }
    return null;
  }
}
