import '../../terms/mod.dart';

enum ExtLetter {
  p(
    phoneme: Phoneme.p,
    left:
        "M 4.55 0.00 L 0.00 0.00 -8.80 8.80 -18.80 -1.20 -25.95 5.95 -14.65 17.15 -7.60 10.00 -1.30 10.00 Q -5.00 5.00 4.55 0.00 Z",
    up: "M 0.35 2.10 Q 0.73 1.74 1.50 0.95 7.76 -0.15 10.00 4.75 L 10.00 -10.00 0.00 0.00 -10.00 -10.00 -17.15 -2.85 -5.85 8.35 0.00 2.45 Q 0.04 2.42 0.35 2.10 Z",
    diag:
        "M 5.00 -5.00 L 0.00 0.00 -10.00 -10.00 -17.15 -2.85 -5.85 8.35 1.15 1.25 Q 4.33 2.99 5.00 1.25 5.92 -0.04 5.00 -5.00 Z",
  ),
  t(
    phoneme: Phoneme.t,
    left:
        "M -2.35 10.00 Q -2.82 5.28 5.55 0.00 L 0.00 0.00 -17.60 17.60 -17.60 32.60 -7.60 22.60 -7.60 10.00 -2.35 10.00 Z",
    up: "M 0.00 0.00 L 0.00 5.00 Q 6.25 -4.00 10.00 0.00 L 10.00 -7.60 21.80 4.10 28.80 -2.90 15.85 -15.85 0.00 0.00 Z",
    diag:
        "M 1.20 1.20 Q 7.69 2.42 5.95 -3.80 3.03 0.09 0.00 0.00 L -8.80 8.80 -8.80 23.80 1.20 13.80 1.20 1.20 Z",
  ),
  k(
    phoneme: Phoneme.k,
    left:
        "M 12.40 -10.00 L -10.00 -10.00 -19.90 0.00 0.00 0.00 -10.00 10.00 2.65 10.00 Q -2.85 6.55 7.95 0.00 L 2.45 0.00 12.40 -10.00 Z",
    up: "M 22.40 -20.00 L 0.00 -20.00 -10.00 -9.90 9.90 -9.90 10.00 -10.00 10.00 -9.90 9.95 -9.90 0.00 0.00 0.00 5.00 Q 5.00 -0.77 10.00 0.00 L 10.00 -7.55 22.40 -20.00 Z",
    diag:
        "M 8.40 -5.90 L 19.60 -17.20 -2.80 -17.20 -12.80 -7.10 7.10 -7.10 0.00 0.00 Q 10.45 1.16 8.40 -5.90 Z",
  ),
  d(
    phoneme: Phoneme.d,
    left:
        "M 0.00 10.00 Q -2.55 5.55 5.00 0.00 L 0.00 0.00 -15.85 15.90 -2.85 28.80 4.15 21.80 -7.65 10.00 0.00 10.00 Z",
    up: "M 10.05 -7.70 L 25.05 -7.70 35.05 -17.70 17.65 -17.70 0.00 0.00 0.00 7.30 Q 5.40 2.95 10.05 4.55 L 10.05 -7.70 Z",
    diag:
        "M 6.00 -6.05 L 21.05 -6.05 31.05 -16.05 13.60 -16.05 4.85 -7.20 Q 3.10 -4.00 0.00 0.00 5.70 0.35 6.00 -6.05 Z",
  ),
  g(
    phoneme: Phoneme.g,
    left:
        "M -11.80 -11.80 L 0.00 0.00 -10.00 10.00 1.15 10.00 Q -2.60 4.80 6.95 0.00 L 2.30 0.00 8.20 -5.90 -4.80 -18.80 -11.80 -11.80 Z",
    up: "M -1.80 -21.80 L 10.00 -10.00 0.00 0.00 0.00 5.00 Q 5.19 -2.96 10.00 0.00 L 10.00 -7.70 18.20 -15.90 5.20 -28.80 -1.80 -21.80 Z",
    diag:
        "M -6.80 -16.80 L 5.00 -5.00 0.00 0.00 Q 7.68 1.69 7.10 -0.50 L 6.15 -3.85 13.20 -10.90 0.20 -23.80 -6.80 -16.80 Z",
  ),
  l(
    phoneme: Phoneme.l,
    left:
        "M -5.00 0.00 L -17.50 -12.50 -25.00 -5.00 -10.00 10.00 Q -1.35 7.25 0.00 0.00 L -5.00 0.00 Z",
    up: "M 10.00 -30.00 L 0.00 -20.00 0.00 0.00 Q 7.30 5.00 10.00 -10.00 L 10.00 -30.00 Z",
    diag: "M -7.50 -22.50 L -15.00 -15.00 0.00 0.00 Q 6.80 -0.50 7.50 -7.50 L -7.50 -22.50 Z",
  ),
  r(
    phoneme: Phoneme.r,
    left:
        "M -32.50 2.50 L -31.30 3.70 -23.80 -3.80 -10.00 10.00 Q -1.35 7.25 0.00 0.00 L -5.00 0.00 -17.50 -12.50 -32.50 2.50 Z",
    up: "M 0.00 -17.60 L 0.00 0.00 Q 7.30 5.00 10.00 -10.00 L 10.00 -30.00 -7.50 -12.50 -6.30 -11.30 0.00 -17.60 Z",
    diag:
        "M 0.00 0.00 Q 6.80 -0.50 7.50 -7.50 L -7.50 -22.50 -22.50 -7.50 -21.30 -6.30 -13.80 -13.80 0.00 0.00 Z",
  ),
  hl(
    phoneme: Phoneme.hl,
    left:
        "M 0.00 10.00 L 5.00 10.00 Q 0.85 5.40 7.45 0.00 L 0.00 0.00 -10.00 10.00 -10.00 15.00 -20.00 5.00 -27.50 12.50 -10.00 30.00 0.00 20.00 0.00 10.00 Z",
    up: "M 10.00 -10.00 L 0.00 0.00 0.00 10.00 Q 3.50 2.25 10.00 5.00 L 10.00 0.00 20.00 0.00 30.00 -10.00 10.00 -10.00 Z",
    diag:
        "M 12.45 -12.56 L 7.45 -7.56 Q 2.77 4.12 9.95 -2.56 L 22.45 -2.56 32.45 -12.56 12.45 -12.56 Z",
  ),
  s(
    phoneme: Phoneme.s,
    left:
        "M 10.00 0.00 L 0.00 0.00 -17.50 17.50 -16.30 18.70 -7.60 10.00 0.00 10.00 Q -0.83 4.60 10.00 0.00 Z",
    up: "M 0.00 8.80 Q 5.00 -3.34 10.00 -2.40 L 10.00 -12.40 -7.50 5.10 -6.30 6.30 0.00 0.00 0.00 8.80 Z",
    diag:
        "M 6.40 -4.45 Q 3.12 -2.62 0.00 0.00 L -7.50 7.50 -6.30 8.70 1.20 1.20 Q 5.31 2.89 5.75 1.55 6.35 0.10 6.40 -4.45 Z",
  ),
  z(
    phoneme: Phoneme.z,
    left:
        "M 7.50 -7.50 L 6.30 -8.70 -12.40 10.00 -2.40 10.00 Q -3.25 4.60 7.60 0.00 L 0.00 0.00 7.50 -7.50 Z",
    up: "M 17.50 -15.10 L 16.30 -16.30 0.00 0.00 0.00 7.75 Q 5.00 -1.69 10.00 1.20 L 10.00 -7.60 17.50 -15.10 Z",
    diag:
        "M 0.00 0.00 Q 1.83 -3.28 4.45 -6.40 L 11.95 -13.90 13.15 -12.70 5.65 -5.20 Q 7.34 -1.09 6.00 -0.65 4.55 -0.05 0.00 0.00 Z",
  ),
  sh(
    phoneme: Phoneme.sh,
    left:
        "M 5.00 0.00 L 0.00 0.00 -7.60 7.60 -7.60 -12.35 -17.60 -2.45 -17.60 20.00 -7.60 10.00 5.00 10.00 Q 1.50 6.00 5.00 0.00 Z",
    up: "M 10.00 2.65 L 10.00 -12.35 0.00 -2.35 0.00 -22.35 -10.00 -12.45 -10.00 9.95 0.00 0.00 0.00 5.15 Q 5.00 -0.95 10.00 2.65 Z",
    diag:
        "M 0.00 2.40 Q 4.20 3.05 6.30 -0.30 7.10 -1.30 6.30 -6.30 L 0.00 0.00 0.00 -19.95 -10.00 -9.85 -10.00 12.50 0.00 2.40 Z",
  ),
  zh(
    phoneme: Phoneme.zh,
    left:
        "M 5.00 0.00 L 0.00 0.00 -7.60 7.65 -7.60 -12.35 -17.60 -2.45 -17.60 -2.35 -25.10 5.15 -23.90 6.35 -17.60 0.05 -17.60 20.00 -7.60 10.00 5.00 10.00 Q 1.50 6.00 5.00 0.00 Z",
    up: "M 0.00 -22.35 L -10.00 -12.45 -10.00 -12.35 -17.50 -4.85 -16.30 -3.65 -10.00 -9.95 -10.00 10.00 0.00 0.00 0.00 5.15 Q 5.00 -0.95 10.00 2.65 L 10.00 -12.35 0.00 -2.35 0.00 -22.35 Z",
    diag:
        "M 6.30 -0.30 Q 7.10 -1.30 6.30 -6.30 L 0.00 0.00 0.00 -19.95 -17.50 -2.45 -16.30 -1.25 -10.00 -7.55 -10.00 12.50 0.00 2.40 Q 4.20 3.05 6.30 -0.30 Z",
  ),
  dz(
    phoneme: Phoneme.dz,
    left:
        "M -1.30 13.90 L -7.60 20.20 -7.60 10.00 5.90 10.00 Q 0.09 5.30 5.55 0.00 L 0.00 0.00 -17.60 17.60 -17.60 32.60 -0.10 15.10 -1.30 13.90 Z",
    up: "M -32.55 15.10 L -31.35 16.30 -22.65 7.60 -7.60 7.60 0.00 0.00 -0.05 5.05 Q 4.55 -1.25 9.95 1.05 L 9.95 -12.40 0.00 -2.40 -15.05 -2.40 -32.55 15.10 Z",
    diag:
        "M 0.00 0.00 L -15.05 0.00 -32.55 17.50 -31.35 18.70 -22.65 10.00 -7.60 10.00 1.15 1.20 Q 8.05 1.40 4.95 -4.95 L 0.00 0.00 Z",
  ),
  ch(
    phoneme: Phoneme.ch,
    left:
        "M -9.90 -10.00 L -10.00 -10.00 -19.90 0.00 0.00 0.00 -10.00 10.00 2.65 10.00 Q -2.85 6.55 7.95 0.00 L 2.45 0.00 12.40 -10.00 -7.50 -10.00 0.00 -17.50 -1.20 -18.70 -9.90 -10.00 Z",
    up: "M 10.00 -10.00 L 10.00 -9.90 9.95 -9.90 0.00 0.00 0.00 5.00 Q 5.00 -0.75 10.00 0.00 L 10.00 -7.55 22.40 -20.00 2.50 -20.00 9.90 -27.40 8.70 -28.60 0.10 -20.00 0.00 -20.00 -10.00 -9.90 9.90 -9.90 10.00 -10.00 Z",
    diag:
        "M -2.80 -17.20 L -12.80 -7.10 7.10 -7.10 0.00 0.00 Q 10.45 1.15 8.40 -5.90 L 19.60 -17.20 -0.30 -17.20 7.10 -24.60 5.90 -25.80 -2.70 -17.20 -2.80 -17.20 Z",
  ),
  j(
    phoneme: Phoneme.j,
    left:
        "M 12.40 -10.00 L -10.00 -10.00 -27.50 7.50 -26.30 8.70 -17.60 0.00 0.00 0.00 -10.00 10.00 2.65 10.00 Q -2.85 6.55 7.95 0.00 L 2.45 0.00 12.40 -10.00 Z",
    up: "M 10.00 -10.00 L 10.00 -9.90 9.95 -9.90 0.00 0.00 0.00 5.00 Q 5.00 -0.75 10.00 0.00 L 10.00 -7.55 22.40 -20.00 0.00 -20.00 -17.50 -2.50 -16.30 -1.30 -7.70 -9.90 9.90 -9.90 10.00 -10.00 Z",
    diag:
        "M -10.50 -7.10 L 7.10 -7.10 0.00 0.00 Q 10.45 1.15 8.40 -5.90 L 19.60 -17.20 -2.80 -17.20 -20.30 0.30 -19.10 1.50 -10.50 -7.10 Z",
  ),
  f(
    phoneme: Phoneme.f,
    left:
        "M -7.65 -10.00 Q -23.65 -0.20 -15.15 17.50 L -7.60 10.00 3.50 10.00 Q 0.45 4.75 5.00 0.00 L 0.00 0.00 -8.80 8.85 Q -14.95 1.70 -7.65 -10.00 Z",
    up: "M 10.00 3.30 L 10.00 -12.35 0.00 -2.30 Q -10.80 -4.90 -16.20 -21.15 -16.55 0.75 -6.35 6.35 L 0.00 0.00 0.00 8.10 Q 4.80 -1.40 10.00 3.30 Z",
    diag:
        "M -16.20 -18.85 Q -16.55 3.05 -6.35 8.65 L -0.05 2.30 0.00 2.35 Q 8.05 5.17 6.30 -6.35 L 0.00 0.00 Q -10.80 -2.60 -16.20 -18.85 Z",
  ),
  th(
    phoneme: Phoneme.th,
    left:
        "M -7.70 10.00 L 5.65 10.00 Q 0.95 4.80 10.45 0.00 L 0.00 0.00 -16.35 16.35 Q -13.10 27.70 -3.80 28.65 -3.00 28.75 -2.10 28.75 -1.50 28.75 -0.90 28.70 -7.60 25.30 -7.70 10.00 Z",
    up: "M 10.00 -7.70 L 10.00 5.65 Q 4.80 0.95 0.00 10.45 L 0.00 0.00 16.35 -16.35 Q 27.70 -13.10 28.65 -3.80 28.75 -3.00 28.75 -2.10 28.75 -1.50 28.70 -0.90 25.30 -7.60 10.00 -7.70 Z",
    diag:
        "M 0.00 0.00 Q 7.60 3.25 8.60 0.00 8.91 -1.95 7.30 -6.20 L 8.60 -6.35 Q 29.15 -9.55 24.70 -0.05 37.05 -14.40 14.95 -15.00 L 0.00 0.00 Z",
  ),
  x(
    phoneme: Phoneme.x,
    left:
        "M 3.65 10.00 Q 1.07 6.15 10.00 0.00 L 2.35 0.00 8.65 -6.35 Q 3.05 -16.55 -18.85 -16.20 -2.60 -10.80 0.00 0.00 L -10.00 10.00 3.65 10.00 Z",
    up: "M -10.00 -7.65 Q -0.20 -23.65 17.50 -15.15 L 10.00 -7.60 10.00 3.50 Q 4.75 0.45 0.00 5.00 L 0.00 0.00 8.85 -8.80 Q 1.70 -14.95 -10.00 -7.65 Z",
    diag:
        "M 8.55 -6.15 L 16.05 -13.70 Q -1.65 -22.20 -11.45 -6.20 0.25 -13.50 7.40 -7.35 L 3.70 -3.70 Q 5.51 -2.39 8.25 -1.60 10.05 -1.10 8.55 -6.15 Z",
  ),
  v(
    phoneme: Phoneme.v,
    left:
        "M -15.15 17.50 L -7.60 10.00 3.50 10.00 Q 0.45 4.75 5.00 0.00 L 0.00 0.00 -8.80 8.85 Q -9.25 -5.38 -27.60 -10.00 -14.61 0.70 -15.15 17.50 Z",
    up: "M 10.00 3.30 L 10.00 -12.35 0.00 -2.35 Q -9.40 -20.10 -21.20 -9.20 -8.95 -11.35 -6.35 6.30 L 0.00 0.00 0.00 8.10 Q 4.80 -1.40 10.00 3.30 Z",
    diag:
        "M 0.00 2.35 L 0.00 2.40 Q 8.10 5.20 6.35 -6.30 L 0.00 0.00 Q -9.40 -17.75 -21.20 -6.85 -8.95 -9.00 -6.35 8.65 L 0.00 2.35 Z",
  ),
  dh(
    phoneme: Phoneme.dh,
    left:
        "M 10.45 0.00 L 0.00 0.00 -16.35 16.35 Q -7.41 20.61 -8.45 31.25 -0.14 22.47 -7.70 10.00 L 5.65 10.00 Q 0.95 4.80 10.45 0.00 Z",
    up: "M 31.00 -9.25 Q 20.39 -8.54 16.35 -16.35 L 0.00 0.00 0.00 10.45 Q 4.80 0.95 10.00 5.65 L 10.00 -7.70 Q 22.79 -1.59 31.00 -9.25 Z",
    diag:
        "M 8.65 0.00 Q 9.98 -4.08 7.85 -6.70 L 8.65 -6.35 Q 27.70 2.80 32.35 -12.55 24.70 -3.15 15.00 -15.00 L 0.00 0.00 Q 4.65 1.32 8.65 0.00 Z",
  ),
  gr(
    phoneme: Phoneme.gr,
    left:
        "M 5.65 10.00 L -10.00 10.00 0.00 0.00 Q -17.75 -9.40 -6.85 -21.20 -9.00 -8.95 8.65 -6.35 L 2.35 0.00 10.45 0.00 Q 0.95 4.80 5.65 10.00 Z",
    up: "M 10.00 -7.60 L 17.50 -15.15 Q 0.70 -14.60 -10.00 -27.60 -5.40 -9.25 8.85 -8.80 L 0.00 0.00 0.00 5.00 Q 4.75 0.45 10.00 3.50 L 10.00 -7.60 Z",
    diag:
        "M 7.05 -7.05 L 0.00 0.00 Q 4.30 1.67 7.90 -0.90 8.99 -3.79 8.20 -5.85 L 15.70 -13.40 Q -1.10 -12.85 -11.80 -25.85 -7.20 -7.50 7.05 -7.05 Z",
  ),
  m(
    phoneme: Phoneme.m,
    left:
        "M 10.00 10.00 Q 3.63 6.59 10.00 0.00 L 0.00 0.00 -10.00 10.00 -10.00 25.00 0.00 15.00 0.00 10.00 10.00 10.00 Z",
    up: "M 10.00 5.00 L 10.00 -10.00 -5.00 -10.00 -15.00 0.00 0.00 0.00 0.00 10.00 Q 3.87 2.25 10.00 5.00 Z",
    diag:
        "M 10.10 2.50 Q 11.75 -0.22 7.50 -7.50 L -7.50 -7.50 -17.50 2.50 2.50 2.50 Q 9.51 5.43 10.10 2.50 Z",
  ),
  n(
    phoneme: Phoneme.n,
    left:
        "M -10.00 10.00 L 5.00 10.00 Q 2.25 3.85 10.00 0.00 L 0.00 0.00 0.00 -12.60 7.50 -20.10 6.30 -21.30 -10.00 -5.00 -10.00 10.00 Z",
    up: "M 10.00 5.00 L 10.00 -10.00 -2.60 -10.00 4.90 -17.50 3.70 -18.70 -15.00 0.00 0.00 0.00 0.00 10.00 Q 3.85 2.25 10.00 5.00 Z",
    diag:
        "M 10.10 2.50 Q 11.75 -0.20 7.50 -7.50 L -5.10 -7.50 2.40 -15.00 1.20 -16.20 -17.50 2.50 2.50 2.50 Q 9.50 5.45 10.10 2.50 Z",
  ),
  ng(
    phoneme: Phoneme.ng,
    left:
        "M -16.30 3.70 L -10.00 -2.60 -10.00 10.00 5.00 10.00 Q 2.25 3.85 10.00 0.00 L 0.00 0.00 0.00 -15.00 -17.50 2.50 -16.30 3.70 Z",
    up: "M 10.00 5.00 L 10.00 -10.00 -5.00 -10.00 -22.50 7.50 -21.30 8.70 -12.60 0.00 0.00 0.00 0.00 10.00 Q 3.85 2.25 10.00 5.00 Z",
    diag:
        "M 10.10 2.50 Q 11.75 -0.20 7.50 -7.50 L -7.50 -7.50 -25.00 10.00 -23.80 11.20 -15.10 2.50 2.50 2.50 Q 9.50 5.45 10.10 2.50 Z",
  ),
  w(
    phoneme: Phoneme.w,
    left:
        "M -1.30 -18.75 L -17.60 -2.45 -17.60 20.00 -7.60 10.00 5.00 10.00 Q 1.50 6.00 5.00 0.00 L 0.00 0.00 -7.60 7.65 -7.60 -10.05 -0.10 -17.55 -1.30 -18.75 Z",
    up: "M 6.30 -28.75 L -10.00 -12.45 -10.00 10.00 0.00 0.00 0.00 5.15 Q 5.00 -0.95 10.00 2.65 L 10.00 -12.35 0.00 -2.35 0.00 -20.05 7.50 -27.55 6.30 -28.75 Z",
    diag:
        "M 0.00 -17.45 L 7.50 -24.95 6.30 -26.15 -10.00 -9.85 -10.00 12.50 0.00 2.40 Q 4.20 3.05 6.30 -0.30 7.10 -1.30 6.30 -6.30 L 0.00 0.00 0.00 -17.45 Z",
  ),
  hs(
    phoneme: Phoneme.hs,
    left:
        "M -7.65 10.00 L 0.00 10.00 Q -2.55 5.55 5.00 0.00 L 0.00 0.00 -15.85 15.90 -4.05 27.60 -11.55 35.10 -10.35 36.30 4.15 21.80 -7.65 10.00 Z",
    up: "M 36.30 -10.40 L 35.10 -11.60 27.60 -4.10 15.85 -15.85 0.00 0.00 0.00 5.00 Q 6.25 -4.00 10.00 0.00 L 10.00 -7.60 21.80 4.10 36.30 -10.40 Z",
    diag:
        "M 38.55 -23.55 L 37.35 -24.75 28.65 -16.05 13.60 -16.05 4.85 -7.20 Q 3.10 -4.00 0.00 0.00 5.70 0.35 6.00 -6.05 L 21.05 -6.05 38.55 -23.55 Z",
  ),
  b(
    phoneme: Phoneme.b,
    left:
        "M -9.95 10.00 L -25.00 10.00 -35.00 20.00 -17.55 20.00 -7.60 10.00 0.00 10.00 Q -4.95 5.80 6.25 0.00 L 0.00 0.00 -9.95 10.00 Z",
    up: "M 0.00 -2.40 L -15.05 -2.40 -25.05 7.60 -7.60 7.60 0.00 0.00 -0.05 5.05 Q 4.55 -1.25 9.95 1.05 L 9.95 -12.40 0.00 -2.40 Z",
    diag:
        "M 0.00 0.00 L -15.05 0.00 -25.05 10.00 -7.60 10.00 1.15 1.20 Q 8.05 1.40 4.95 -4.95 L 0.00 0.00 Z",
  ),
  c(
    phoneme: Phoneme.c,
    left:
        "M -9.95 10.00 L -22.60 10.00 -15.10 2.50 -16.30 1.30 -35.00 20.00 -17.55 20.00 -7.60 10.00 0.00 10.00 Q -4.95 5.80 6.25 0.00 L 0.00 0.00 -9.95 10.00 Z",
    up: "M 0.00 0.00 L -0.05 5.05 Q 4.55 -1.25 9.95 1.05 L 9.95 -12.40 0.00 -2.40 -12.65 -2.40 -5.15 -9.90 -6.35 -11.10 -25.05 7.60 -7.60 7.60 0.00 0.00 Z",
    diag:
        "M 0.00 0.00 L -12.65 0.00 -5.15 -7.50 -6.35 -8.70 -25.05 10.00 -7.60 10.00 1.15 1.20 Q 8.05 1.40 4.95 -4.95 L 0.00 0.00 Z",
  ),
  h(
    phoneme: Phoneme.h,
    left:
        "M 17.50 -30.20 L 16.30 -31.40 0.00 -15.10 0.00 0.00 -10.00 10.00 8.30 10.00 Q 3.55 7.70 10.00 0.00 L 2.40 0.00 2.15 0.20 10.00 -7.65 10.00 -22.70 17.50 -30.20 Z",
    up: "M 0.00 0.00 L 0.00 7.30 Q 4.55 1.41 10.00 4.25 L 10.00 -7.70 25.05 -7.70 42.55 -25.20 41.35 -26.40 32.65 -17.70 17.65 -17.70 0.00 0.00 Z",
    diag:
        "M 25.00 -37.65 L 23.80 -38.85 7.50 -22.55 7.50 -7.50 0.00 0.00 Q 11.45 4.90 8.70 -6.30 L 17.50 -15.20 17.50 -30.15 25.00 -37.65 Z",
  ),
  y(
    phoneme: Phoneme.y,
    left:
        "M 0.00 0.00 L 0.00 -12.55 12.40 -25.00 -5.00 -25.00 -15.00 -14.90 -0.10 -14.90 -10.00 -5.00 -10.00 10.00 5.00 10.00 Q 2.25 3.85 10.00 0.00 L 0.00 0.00 Z",
    up: "M -20.00 -10.00 L -5.00 -10.00 -15.00 0.00 0.00 0.00 0.00 10.00 Q 3.85 2.25 10.00 5.00 L 10.00 -10.00 -2.55 -10.00 7.40 -20.00 -10.00 -20.00 -20.00 -10.00 Z",
    diag:
        "M 4.90 -17.50 L -12.50 -17.50 -22.50 -7.50 -7.50 -7.50 -17.50 2.50 2.50 2.50 Q 9.50 5.45 10.10 2.50 11.75 -0.20 7.50 -7.50 L -5.05 -7.50 4.90 -17.50 Z",
  );

  final Phoneme phoneme;
  final String left;
  final String diag;
  final String up;

  const ExtLetter({
    required this.phoneme,
    required this.left,
    required this.diag,
    required this.up,
  });

  static ExtLetter from(Phoneme phoneme) {
    return switch (phoneme) {
      Phoneme.f => ExtLetter.f,
      Phoneme.v => ExtLetter.v,
      Phoneme.c => ExtLetter.c,
      Phoneme.dz => ExtLetter.dz,
      Phoneme.t => ExtLetter.t,
      Phoneme.d => ExtLetter.d,
      Phoneme.sh => ExtLetter.sh,
      Phoneme.ch => ExtLetter.ch,
      Phoneme.j => ExtLetter.j,
      Phoneme.l => ExtLetter.l,
      Phoneme.m => ExtLetter.m,
      Phoneme.hs => ExtLetter.hs,
      Phoneme.h => ExtLetter.h,
      Phoneme.p => ExtLetter.p,
      Phoneme.k => ExtLetter.k,
      Phoneme.b => ExtLetter.b,
      Phoneme.dh => ExtLetter.dh,
      Phoneme.g => ExtLetter.g,
      Phoneme.hl => ExtLetter.hl,
      Phoneme.n => ExtLetter.n,
      Phoneme.ng => ExtLetter.ng,
      Phoneme.r => ExtLetter.r,
      Phoneme.gr => ExtLetter.gr,
      Phoneme.s => ExtLetter.s,
      Phoneme.th => ExtLetter.th,
      Phoneme.x => ExtLetter.x,
      Phoneme.z => ExtLetter.z,
      Phoneme.zh => ExtLetter.zh,
      Phoneme.w => ExtLetter.w,
      Phoneme.y => ExtLetter.y,
    };
  }
}
