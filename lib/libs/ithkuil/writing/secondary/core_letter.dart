import 'package:enthrirhs/libs/misc.dart';

import '../../terms/mod.dart';

enum AnchorType {
  up,
  left,
  diag,
}

enum AnchorOrientation {
  up(AnchorType.up, false),
  down(AnchorType.up, true),
  right(AnchorType.left, true),
  upperLeft(AnchorType.diag, false),
  lowerRight(AnchorType.diag, true);

  final AnchorType type;
  final bool reversed;

  const AnchorOrientation(this.type, this.reversed);
}

class Anchor {
  final Coord coord;
  final AnchorOrientation orientation;

  int getRotation() {
    if (orientation.reversed) {
      return 180;
    } else {
      return 0;
    }
  }

  const Anchor(this.orientation, this.coord);
}

enum CoreLetter {
  placeholder(
    phoneme: null,
    path:
        "M 20.00 -11.15 L 10.00 -1.15 10.00 -35.00 0.00 -25.00 0.00 11.20 10.00 1.25 10.00 35.00 20.00 25.00 20.00 -11.15 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(0, -25)),
    endAnchor: Anchor(AnchorOrientation.down, Coord(20, 25)),
  ),
  f(
    phoneme: Phoneme.f,
    path:
        "M 50.00 -25.00 L 60.00 -35.00 10.00 -35.00 0.00 -25.00 0.00 5.00 30.00 5.00 30.00 35.00 40.00 25.00 40.00 -5.00 10.00 -5.00 10.00 -25.00 50.00 -25.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(50, -25)),
    endAnchor: Anchor(AnchorOrientation.down, Coord(40, 25)),
  ),
  v(
    phoneme: Phoneme.v,
    path:
        "M 50.00 -25.00 L 60.00 -35.00 10.00 -35.00 0.00 -25.00 0.00 10.00 10.00 0.00 25.00 0.00 25.00 35.00 35.00 25.00 35.00 -10.00 17.65 -10.00 10.00 -2.40 10.00 -25.00 50.00 -25.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(50, -25)),
    endAnchor: Anchor(AnchorOrientation.down, Coord(35, 25)),
  ),
  c(
    phoneme: Phoneme.c,
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 40.00 35.00 50.00 25.00 10.00 25.00 10.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(0.00, -25.00)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(40, 35)),
  ),
  dz(
    phoneme: Phoneme.dz,
    path:
        "M 20.00 -35.00 L 10.00 -25.00 10.00 25.00 0.00 35.00 45.00 35.00 55.00 25.00 12.40 25.00 20.00 17.40 20.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(10, -25)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(45, 35)),
  ),
  t(
    phoneme: Phoneme.t,
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 10.00 25.00 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(40, -25)),
    endAnchor: Anchor(AnchorOrientation.down, Coord(10, 25)),
  ),
  d(
    phoneme: Phoneme.d,
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 11.30 10.00 1.25 10.00 35.00 20.00 25.00 20.00 -11.15 10.00 -1.15 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(40, -25)),
    endAnchor: Anchor(AnchorOrientation.down, Coord(20, 25)),
  ),
  sh(
    phoneme: Phoneme.sh,
    path:
        "M 40.00 -35.00 L 30.00 -25.00 30.00 -5.00 10.00 -5.00 0.00 5.00 0.00 35.00 30.00 35.00 40.00 25.00 10.00 25.00 10.00 5.00 30.00 5.00 40.00 -5.00 40.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(30, -25)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(30, 35)),
  ),
  ch(
    phoneme: Phoneme.ch,
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 40.00 35.00 50.00 25.00 10.00 25.00 10.00 -25.00 40.00 -25.00 50.00 -35.00 10.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(40, -25)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(40, 35)),
  ),

  j(
    phoneme: Phoneme.j,
    path:
        "M 20.00 -35.00 L 10.00 -25.00 10.00 25.00 0.00 35.00 45.00 35.00 55.00 25.00 12.40 25.00 20.00 17.40 20.00 -25.00 50.00 -25.00 60.00 -35.00 20.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(50, -25)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(45, 35)),
  ),
  l(
    phoneme: Phoneme.l,
    path:
        "M 15.00 -35.00 L 5.00 -25.00 5.00 10.00 24.95 10.00 0.00 35.00 40.00 35.00 50.00 25.00 12.40 25.00 37.25 0.00 15.00 0.00 15.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(5, -25)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(40, 35)),
  ),
  m(
    phoneme: Phoneme.m,
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 5.00 30.00 35.00 37.50 27.50 10.00 0.00 10.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(0, -25)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(37.50, 27.50)),
  ),
  hs(
    phoneme: Phoneme.hs,
    path:
        "M 23.70 -35.00 13.70 -25.00 31.20 -7.50 16.20 -7.50 0.00 8.65 26.35 35.00 33.85 27.50 8.85 2.50 41.20 2.50 48.70 -5.00 28.70 -25.00 63.70 -25.00 73.70 -35.00 23.70 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(63.7, -25)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(33.85, 27.50)),
  ),
  h(
    phoneme: Phoneme.h,
    path:
        "M 10.00 -35.00 0.00 -25.00 0.00 10.00 26.30 10.00 35.00 1.25 35.00 35.00 45.00 25.00 45.00 -11.15 33.85 0.00 10.00 0.00 10.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(0, -25)),
    endAnchor: Anchor(AnchorOrientation.down, Coord(45, 25)),
  ),
  p(
    phoneme: Phoneme.p,
    path:
        "M 15.05 -25.00 L 50.00 -25.00 60.00 -35.00 10.00 -35.00 0.00 -25.00 25.00 0.00 25.00 35.00 35.00 25.00 35.00 -5.05 15.05 -25.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(50, -25)),
    endAnchor: Anchor(AnchorOrientation.down, Coord(35, 25)),
  ),
  k(
    phoneme: Phoneme.k,
    path:
        "M 9.90 -35.03 L 0.00 -25.08 47.35 33.27 47.40 33.27 48.80 35.02 56.30 27.52 13.60 -25.03 65.65 -25.03 75.65 -35.03 9.90 -35.03 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(65.65, -25.03)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(56.30, 27.52)),
  ),
  b(
    phoneme: Phoneme.b,
    path:
        "M 59.40 -35.00 L 9.40 -35.00 0.00 -25.60 23.20 7.45 29.40 1.20 29.40 35.00 39.40 25.00 39.40 -11.15 38.30 -10.05 Q 35.33 -7.07 32.35 -4.10 L 30.40 -2.10 30.35 -2.15 29.70 -1.50 13.20 -25.00 49.40 -25.00 59.40 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(49.4, -25)),
    endAnchor: Anchor(AnchorOrientation.down, Coord(39.4, 25)),
  ),
  dh(
    phoneme: Phoneme.dh,
    path:
        "M 60.00 -34.92 L 10.00 -34.92 0.00 -24.92 0.00 15.08 9.55 5.53 30.20 34.93 37.85 27.28 16.20 -3.52 10.00 2.68 10.00 -24.92 50.00 -24.92 60.00 -34.92 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(50, -24.92)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(37.85, 27.28)),
  ),
  g(
    phoneme: Phoneme.g,
    path:
        "M 65.65 -24.93 L 75.65 -34.93 9.90 -34.93 0.00 -24.98 30.45 12.57 37.70 5.27 61.85 34.92 69.30 27.52 44.10 -3.53 36.60 3.92 13.50 -24.93 65.65 -24.93 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(65.65, -24.93)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(69.30, 27.52)),
  ),
  hl(
    phoneme: Phoneme.hl,
    path:
        "M 10.00 -35.00 L 0.00 -25.00 0.00 5.00 17.70 5.00 11.35 11.40 35.00 35.00 42.45 27.50 19.95 5.00 30.00 -5.00 10.00 -5.00 10.00 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(0, -25)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(42.45, 27.50)),
  ),
  n(
    phoneme: Phoneme.n,
    path:
        "M 10.00 -34.92 L 0.00 -24.92 0.00 15.08 9.55 5.52 30.20 34.92 37.70 27.42 16.10 -3.42 10.00 2.67 10.00 -34.92 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(0, -24.92)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(37.70, 27.42)),
  ),
  ng(
    phoneme: Phoneme.ng,
    path:
        "M 8.45 -25.05 L 8.45 -0.05 0.00 8.40 26.70 35.05 34.20 27.55 8.70 2.05 18.45 -7.65 18.45 -35.05 8.45 -25.05 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(8.45, -25.05)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(34.20, 27.55)),
  ),
  r(
    phoneme: Phoneme.r,
    path:
        "M 7.50 -35.00 L 0.00 -27.50 31.25 3.75 0.00 35.00 40.00 35.00 50.00 25.00 12.40 25.00 39.90 -2.60 7.50 -35.00 Z",
    startAnchor: Anchor(AnchorOrientation.upperLeft, Coord(0, -27.50)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(40, 35)),
  ),
  gr(
    phoneme: Phoneme.gr,
    path:
        "M 7.45 -35.03 L 0.00 -27.47 22.75 -4.78 13.00 5.03 13.00 35.03 38.00 35.03 48.00 25.03 23.00 25.03 22.90 -2.53 31.45 -11.03 7.45 -35.03 Z",
    startAnchor: Anchor(AnchorOrientation.upperLeft, Coord(0, -27.47)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(38, 35.03)),
  ),
  s(
    phoneme: Phoneme.s,
    path:
        "M 55.00 -34.97 L 45.00 -24.97 45.00 -4.97 10.00 -4.97 0.00 5.03 29.95 34.97 37.45 27.47 15.00 5.03 45.00 5.03 55.00 -4.97 55.00 -34.97 Z",
    startAnchor: Anchor(AnchorOrientation.up, Coord(45, -24.97)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(37.45, 27.47)),
  ),
  th(
    phoneme: Phoneme.th,
    path:
        "M 60.00 -35.05 L 10.00 -35.05 0.00 -25.05 0.00 1.95 33.10 35.05 40.60 27.55 10.00 -3.05 10.00 -25.05 50.00 -25.05 60.00 -35.05 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(50, -25.05)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(40.60, 27.55)),
  ),
  x(
    phoneme: Phoneme.x,
    path:
        "M 75.65 -35.03 L 9.90 -35.03 0.00 -25.08 25.70 0.63 18.20 8.13 45.10 35.02 52.60 27.52 26.90 1.82 34.35 -5.73 15.05 -25.03 65.65 -25.03 75.65 -35.03 Z",
    startAnchor: Anchor(AnchorOrientation.right, Coord(65.65, -25.03)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(52.60, 27.52)),
  ),
  z(
    phoneme: Phoneme.z,
    path:
        "M 40.00 4.63 L 50.00 -5.38 20.15 -35.22 12.65 -27.72 35.00 -5.38 15.00 -5.38 0.00 9.63 25.60 35.22 33.10 27.72 10.00 4.63 40.00 4.63 Z",
    startAnchor: Anchor(AnchorOrientation.upperLeft, Coord(12.65, -27.72)),
    endAnchor: Anchor(AnchorOrientation.lowerRight, Coord(33.10, 27.72)),
  ),
  zh(
    phoneme: Phoneme.zh,
    path:
        "M 16.95 -35.03 L 9.45 -27.53 32.00 -4.97 17.60 -4.97 0.00 12.68 0.00 35.03 40.00 35.03 50.00 25.03 10.00 25.03 10.00 5.03 40.00 5.03 48.50 -3.47 16.95 -35.03 Z",
    startAnchor: Anchor(AnchorOrientation.upperLeft, Coord(9.45, -27.53)),
    endAnchor: Anchor(AnchorOrientation.right, Coord(40.00, 35.03)),
  );

  final Phoneme? phoneme;
  final String path;
  final Anchor startAnchor;
  final Anchor endAnchor;

  const CoreLetter({
    required this.phoneme,
    required this.path,
    required this.startAnchor,
    required this.endAnchor,
  });

  String id() {
    if (phoneme != null) {
      return "core_${phoneme!.defaultLetter()}";
    } else {
      return "core_placeholder";
    }
  }

  static CoreLetter? from(Phoneme phoneme) {
    return switch (phoneme) {
      Phoneme.f => CoreLetter.f,
      Phoneme.v => CoreLetter.v,
      Phoneme.c => CoreLetter.c,
      Phoneme.dz => CoreLetter.dz,
      Phoneme.t => CoreLetter.t,
      Phoneme.d => CoreLetter.d,
      Phoneme.sh => CoreLetter.sh,
      Phoneme.ch => CoreLetter.ch,
      Phoneme.j => CoreLetter.j,
      Phoneme.l => CoreLetter.l,
      Phoneme.m => CoreLetter.m,
      Phoneme.hs => CoreLetter.hs,
      Phoneme.h => CoreLetter.h,
      Phoneme.p => CoreLetter.p,
      Phoneme.k => CoreLetter.k,
      Phoneme.b => CoreLetter.b,
      Phoneme.dh => CoreLetter.dh,
      Phoneme.g => CoreLetter.g,
      Phoneme.hl => CoreLetter.hl,
      Phoneme.n => CoreLetter.n,
      Phoneme.ng => CoreLetter.ng,
      Phoneme.r => CoreLetter.r,
      Phoneme.gr => CoreLetter.gr,
      Phoneme.s => CoreLetter.s,
      Phoneme.th => CoreLetter.th,
      Phoneme.x => CoreLetter.x,
      Phoneme.z => CoreLetter.z,
      Phoneme.zh => CoreLetter.zh,
      Phoneme.w => null,
      Phoneme.y => null,
    };
  }
}
