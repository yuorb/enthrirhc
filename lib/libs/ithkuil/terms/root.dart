import 'phoneme.dart';

class Root {
  final List<Phoneme> phonemes;

  const Root(this.phonemes);

  @override
  String toString() {
    return phonemes.map((phoneme) => phoneme.defaultLetter()).join('');
  }

  static Root? from(String root) {
    List<Phoneme> phonemes = [];
    for (final char in root.split('')) {
      final phoneme = Phoneme.fromChar(char);
      if (phoneme == null) return null;
      phonemes.add(phoneme);
    }
    return Root(phonemes);
  }
}
