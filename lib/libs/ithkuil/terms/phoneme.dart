enum Phoneme {
  f(["f"]),
  v(["v"]),
  c(["c"]),
  dz(["ẓ", "ż"]),
  t(["t"]),
  d(["d"]),
  sh(["š"]),
  ch(["č"]),
  j(["j"]),
  l(["l"]),
  m(["m"]),
  hs(["ç"]),
  h(["h"]),
  p(["p"]),
  k(["k"]),
  b(["b"]),
  dh(['ḑ', "ḍ", 'đ']),
  g(["g"]),
  hl(['ḷ', "ļ", 'ł']),
  n(["n"]),
  ng(["ň", 'ņ', 'ṇ']),
  r(["r"]),
  gr(["ř", 'ŗ', 'ṛ']),
  s(["s"]),
  th(['ţ', "ṭ", 'ŧ']),
  x(["x"]),
  z(["z"]),
  zh(["ž"]),
  w(["w"]),
  y(["y"]);

  final List<String> romanizedLetters;

  const Phoneme(this.romanizedLetters);

  static Phoneme? fromChar(String letter) {
    for (final value in Phoneme.values) {
      if (value.romanizedLetters.contains(letter.toLowerCase())) {
        return value;
      }
    }
    return null;
  }

  String defaultLetter() {
    return romanizedLetters[0];
  }
}
