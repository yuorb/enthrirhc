// TODO: Add `bool moveCnToCa` parameter
import 'package:enthrirhs/libs/ithkuil/mod.dart';
import 'package:enthrirhs/libs/ithkuil/terms/formative_type.dart';
import 'package:enthrirhs/libs/misc.dart';

String? romanizeFormatives(
  List<Formative> formatives,
  bool preferShortCut,
  bool omitOptionalAffixes,
) {
  if (formatives.isEmpty) {
    return null;
  }
  String sentence = formatives[0].romanize(preferShortCut, omitOptionalAffixes).capitalize();
  for (int i = 1; i < formatives.length; i++) {
    switch (formatives[i - 1].formativeType) {
      case Standalone():
        sentence = "$sentence ${formatives[i].romanize(preferShortCut, omitOptionalAffixes)}";
        break;
      case Parent():
        sentence = "$sentence ${formatives[i].romanize(preferShortCut, omitOptionalAffixes)}";
        break;
      case Concatenated():
        if (formatives[i].formativeType is Parent) {
          sentence = "$sentence-${formatives[i].romanize(preferShortCut, omitOptionalAffixes)}";
        }
    }
  }
  return sentence.addPeriod();
}

/// See official document [2.2 Rules for Inserting a Glottal-Stop Into a Vowel-Form](https://ithkuil.net/newithkuil_02_morpho-phonology.htm)
String insertGlottalStop(String vowel, bool isAtEndOfWord) {
  if (vowel.length == 1) {
    if (isAtEndOfWord) {
      return "$vowel'$vowel";
    } else {
      return "$vowel'";
    }
  }
  if (vowel == "ai" ||
      vowel == "ei" ||
      vowel == "ëi" ||
      vowel == "oi" ||
      vowel == "ui" ||
      vowel == "au" ||
      vowel == "eu" ||
      vowel == "ëu" ||
      vowel == "ou" ||
      vowel == "iu") {
    if (isAtEndOfWord) {
      return "${vowel[0]}'${vowel[1]}";
    } else {
      return "$vowel'";
    }
  }
  if (vowel.length == 2) {
    return "${vowel[0]}'${vowel[1]}";
  }
  throw 'unreachable';
}
