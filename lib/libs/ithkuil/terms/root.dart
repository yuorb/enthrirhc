import 'package:enthrirhs/libs/ithkuil/writing/secondary/core_letter.dart';
import 'package:enthrirhs/libs/ithkuil/writing/secondary/mod.dart';

import '../writing/secondary/ext_letter.dart';
import 'phoneme.dart';

class Root {
  final List<Phoneme> phonemes;

  const Root(this.phonemes);

  @override
  String toString() {
    return phonemes.map((phoneme) => phoneme.defaultLetter()).join('');
  }

  List<RootSecondary> toRootSecondaries() {
    List<RootSecondary> secondaries = [];

    int i = 0;
    while (i < phonemes.length) {
      if (i + 1 == phonemes.length) {
        if (phonemes[i] != Phoneme.w && phonemes[i] != Phoneme.y) {
          secondaries.add(RootSecondary(
            start: null,
            core: CoreLetter.from(phonemes[i])!,
            end: null,
          ));
        } else {
          secondaries.add(RootSecondary(
            start: ExtLetter.from(phonemes[i]),
            core: CoreLetter.placeholder,
            end: null,
          ));
        }
        i += 1;
      } else if (i + 2 == phonemes.length) {
        secondaries.add(RootSecondary(
          start: ExtLetter.from(phonemes[i]),
          core: CoreLetter.placeholder,
          end: ExtLetter.from(phonemes[i + 1]),
        ));
        i += 2;
      } else if (i + 3 <= phonemes.length) {
        if (phonemes[i + 1] != Phoneme.w && phonemes[i + 1] != Phoneme.y) {
          secondaries.add(RootSecondary(
            start: ExtLetter.from(phonemes[i]),
            core: CoreLetter.from(phonemes[i + 1])!,
            end: ExtLetter.from(phonemes[i + 2]),
          ));
          i += 3;
        } else {
          secondaries.add(RootSecondary(
            start: ExtLetter.from(phonemes[i]),
            core: CoreLetter.placeholder,
            end: ExtLetter.from(phonemes[i + 1]),
          ));
          i += 2;
        }
      }
    }

    return secondaries;
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
