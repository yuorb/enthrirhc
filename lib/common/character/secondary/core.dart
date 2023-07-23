import 'package:enthrirch/common/utils.dart';

import 'letter.dart';

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
  final Coord coord;
  final AnchorOrientation orientation;

  const Anchor(this.orientation, this.coord);
}

enum CoreLetter {
  f(
    letter: Letter(
      Phoneme.f,
      "M 50.00 -25.00 L 60.00 -35.00 10.00 -35.00 0.00 -25.00 0.00 5.00 30.00 5.00 30.00 35.00 40.00 25.00 40.00 -5.00 10.00 -5.00 10.00 -25.00 50.00 -25.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(50, -25)),
    end: Anchor(AnchorOrientation.down, Coord(40, 25)),
  ),
  v(
    letter: Letter(
      Phoneme.v,
      "M 50.00 -25.00 L 60.00 -35.00 10.00 -35.00 0.00 -25.00 0.00 10.00 10.00 0.00 25.00 0.00 25.00 35.00 35.00 25.00 35.00 -10.00 17.65 -10.00 10.00 -2.40 10.00 -25.00 50.00 -25.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(50, -25)),
    end: Anchor(AnchorOrientation.down, Coord(35, 25)),
  ),
  c(
    letter: Letter(
      Phoneme.c,
      "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 40.00 35.00 50.00 25.00 10.00 25.00 10.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(0.00, -25.00)),
    end: Anchor(AnchorOrientation.right, Coord(40, 35)),
  ),
  dz(
    letter: Letter(
      Phoneme.dz,
      "M 20.00 -35.00 L 10.00 -25.00 10.00 25.00 0.00 35.00 45.00 35.00 55.00 25.00 12.40 25.00 20.00 17.40 20.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(10, -25)),
    end: Anchor(AnchorOrientation.right, Coord(45, 35)),
  ),
  t(
    letter: Letter(
      Phoneme.t,
      "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 10.00 25.00 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(40, -25)),
    end: Anchor(AnchorOrientation.down, Coord(10, 25)),
  ),
  d(
    letter: Letter(
      Phoneme.d,
      "M 10.00 -35.00 L 0.00 -25.00 0.00 11.30 10.00 1.25 10.00 35.00 20.00 25.00 20.00 -11.15 10.00 -1.15 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(40, -25)),
    end: Anchor(AnchorOrientation.down, Coord(20, 25)),
  ),
  sh(
    letter: Letter(
      Phoneme.sh,
      "M 40.00 -35.00 L 30.00 -25.00 30.00 -5.00 10.00 -5.00 0.00 5.00 0.00 35.00 30.00 35.00 40.00 25.00 10.00 25.00 10.00 5.00 30.00 5.00 40.00 -5.00 40.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(30, -25)),
    end: Anchor(AnchorOrientation.right, Coord(30, 35)),
  ),
  ch(
    letter: Letter(
      Phoneme.ch,
      "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 40.00 35.00 50.00 25.00 10.00 25.00 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(40, -25)),
    end: Anchor(AnchorOrientation.right, Coord(40, 35)),
  ),

  j(
    letter: Letter(
      Phoneme.j,
      "M 20.00 -35.00 L 10.00 -25.00 10.00 25.00 0.00 35.00 45.00 35.00 55.00 25.00 12.40 25.00 20.00 17.40 20.00 -25.00 50.00 -25.00 60.00 -35.00 20.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(50, -25)),
    end: Anchor(AnchorOrientation.right, Coord(45, 35)),
  ),
  l(
    letter: Letter(
      Phoneme.l,
      "M 15.00 -35.00 L 5.00 -25.00 5.00 10.00 24.95 10.00 0.00 35.00 40.00 35.00 50.00 25.00 12.40 25.00 37.25 0.00 15.00 0.00 15.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(5, -25)),
    end: Anchor(AnchorOrientation.right, Coord(40, 35)),
  ),
  m(
    letter: Letter(
      Phoneme.m,
      "M 10.00 -35.00 L 0.00 -25.00 0.00 5.00 30.00 35.00 37.50 27.50 10.00 0.00 10.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(0, -25)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(37.50, 27.50)),
  ),
  hs(
    letter: Letter(
      Phoneme.hs,
      "M 23.70 -35.00 13.70 -25.00 31.20 -7.50 16.20 -7.50 0.00 8.65 26.35 35.00 33.85 27.50 8.85 2.50 41.20 2.50 48.70 -5.00 28.70 -25.00 63.70 -25.00 73.70 -35.00 23.70 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(63.7, -25)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(33.85, 27.50)),
  ),
  h(
    letter: Letter(
      Phoneme.h,
      "M 10.00 -35.00 0.00 -25.00 0.00 10.00 26.30 10.00 35.00 1.25 35.00 35.00 45.00 25.00 45.00 -11.15 33.85 0.00 10.00 0.00 10.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(0, -25)),
    end: Anchor(AnchorOrientation.down, Coord(45, 25)),
  ),
  p(
    letter: Letter(
      Phoneme.p,
      "M 15.05 -25.00 L 50.00 -25.00 60.00 -35.00 10.00 -35.00 0.00 -25.00 25.00 0.00 25.00 35.00 35.00 25.00 35.00 -5.05 15.05 -25.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(50, -25)),
    end: Anchor(AnchorOrientation.down, Coord(35, 25)),
  ),
  k(
    letter: Letter(
      Phoneme.k,
      "M 9.90 -35.03 L 0.00 -25.08 47.35 33.27 47.40 33.27 48.80 35.02 56.30 27.52 13.60 -25.03 65.65 -25.03 75.65 -35.03 9.90 -35.03 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(65.65, -25.03)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(56.30, 27.52)),
  ),
  b(
    letter: Letter(
      Phoneme.b,
      "M 59.40 -35.00 L 9.40 -35.00 0.00 -25.60 23.20 7.45 29.40 1.20 29.40 35.00 39.40 25.00 39.40 -11.15 38.30 -10.05 Q 35.33 -7.07 32.35 -4.10 L 30.40 -2.10 30.35 -2.15 29.70 -1.50 13.20 -25.00 49.40 -25.00 59.40 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(49.4, -25)),
    end: Anchor(AnchorOrientation.down, Coord(39.4, 25)),
  ),
  dh(
    letter: Letter(
      Phoneme.dh,
      "M 60.00 -34.92 L 10.00 -34.92 0.00 -24.92 0.00 15.08 9.55 5.53 30.20 34.93 37.85 27.28 16.20 -3.52 10.00 2.68 10.00 -24.92 50.00 -24.92 60.00 -34.92 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(50, -24.92)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(37.85, 27.28)),
  ),
  g(
    letter: Letter(
      Phoneme.g,
      "M 65.65 -24.93 L 75.65 -34.93 9.90 -34.93 0.00 -24.98 30.45 12.57 37.70 5.27 61.85 34.92 69.30 27.52 44.10 -3.53 36.60 3.92 13.50 -24.93 65.65 -24.93 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(65.65, -24.93)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(69.30, 27.52)),
  ),
  hl(
    letter: Letter(
      Phoneme.hl,
      "M 10.00 -35.00 L 0.00 -25.00 0.00 5.00 17.70 5.00 11.35 11.40 35.00 35.00 42.45 27.50 19.95 5.00 30.00 -5.00 10.00 -5.00 10.00 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(0, -25)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(42.45, 27.50)),
  ),
  n(
    letter: Letter(
      Phoneme.n,
      "M 10.00 -34.92 L 0.00 -24.92 0.00 15.08 9.55 5.52 30.20 34.92 37.70 27.42 16.10 -3.42 10.00 2.67 10.00 -34.92 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(0, -24.92)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(37.70, 27.42)),
  ),
  ng(
    letter: Letter(
      Phoneme.ng,
      "M 8.45 -25.05 L 8.45 -0.05 0.00 8.40 26.70 35.05 34.20 27.55 8.70 2.05 18.45 -7.65 18.45 -35.05 8.45 -25.05 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(8.45, -25.05)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(34.20, 27.55)),
  ),
  r(
    letter: Letter(
      Phoneme.r,
      "M 7.50 -35.00 L 0.00 -27.50 31.25 3.75 0.00 35.00 40.00 35.00 50.00 25.00 12.40 25.00 39.90 -2.60 7.50 -35.00 Z",
    ),
    start: Anchor(AnchorOrientation.upperLeft, Coord(0, -27.50)),
    end: Anchor(AnchorOrientation.right, Coord(40, 35)),
  ),
  gr(
    letter: Letter(
      Phoneme.gr,
      "M 7.45 -35.03 L 0.00 -27.47 22.75 -4.78 13.00 5.03 13.00 35.03 38.00 35.03 48.00 25.03 23.00 25.03 22.90 -2.53 31.45 -11.03 7.45 -35.03 Z",
    ),
    start: Anchor(AnchorOrientation.upperLeft, Coord(0, -27.47)),
    end: Anchor(AnchorOrientation.right, Coord(38, 35.03)),
  ),
  s(
    letter: Letter(
      Phoneme.s,
      "M 55.00 -34.97 L 45.00 -24.97 45.00 -4.97 10.00 -4.97 0.00 5.03 29.95 34.97 37.45 27.47 15.00 5.03 45.00 5.03 55.00 -4.97 55.00 -34.97 Z",
    ),
    start: Anchor(AnchorOrientation.up, Coord(45, -24.97)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(37.45, 27.47)),
  ),
  th(
    letter: Letter(
      Phoneme.th,
      "M 60.00 -35.05 L 10.00 -35.05 0.00 -25.05 0.00 1.95 33.10 35.05 40.60 27.55 10.00 -3.05 10.00 -25.05 50.00 -25.05 60.00 -35.05 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(50, -25.05)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(40.60, 27.55)),
  ),
  x(
    letter: Letter(
      Phoneme.x,
      "M 75.65 -35.03 L 9.90 -35.03 0.00 -25.08 25.70 0.63 18.20 8.13 45.10 35.02 52.60 27.52 26.90 1.82 34.35 -5.73 15.05 -25.03 65.65 -25.03 75.65 -35.03 Z",
    ),
    start: Anchor(AnchorOrientation.right, Coord(65.65, -25.03)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(52.60, 27.52)),
  ),
  z(
    letter: Letter(
      Phoneme.z,
      "M 40.00 4.63 L 50.00 -5.38 20.15 -35.22 12.65 -27.72 35.00 -5.38 15.00 -5.38 0.00 9.63 25.60 35.22 33.10 27.72 10.00 4.63 40.00 4.63 Z",
    ),
    start: Anchor(AnchorOrientation.upperLeft, Coord(12.65, -27.72)),
    end: Anchor(AnchorOrientation.lowerRight, Coord(33.10, 27.72)),
  ),
  zh(
    letter: Letter(
      Phoneme.zh,
      "M 16.95 -35.03 L 9.45 -27.53 32.00 -4.97 17.60 -4.97 0.00 12.68 0.00 35.03 40.00 35.03 50.00 25.03 10.00 25.03 10.00 5.03 40.00 5.03 48.50 -3.47 16.95 -35.03 Z",
    ),
    start: Anchor(AnchorOrientation.upperLeft, Coord(9.45, -27.53)),
    end: Anchor(AnchorOrientation.right, Coord(40.00, 35.03)),
  );

  final Letter letter;
  final Anchor start;
  final Anchor end;

  const CoreLetter({
    required this.letter,
    required this.start,
    required this.end,
  });

  static CoreLetter? from(String letter) {
    for (final value in CoreLetter.values) {
      if (value.letter.phoneme.romanizedLetters.contains(letter)) {
        return value;
      }
    }
    return null;
  }
}
