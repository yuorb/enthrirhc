// TODO: Add `bool moveCnToCa` parameter
import 'package:enthrirhs/libs/ithkuil/mod.dart';
import 'package:enthrirhs/libs/ithkuil/terms/formative_type.dart';
import 'package:enthrirhs/libs/misc.dart';
import 'package:enthrirhs/libs/result/mod.dart';

String? romanizeFormatives(
  List<Formative> formatives,
  bool preferShortCut,
  bool omitOptionalAffixes,
) {
  if (formatives.isEmpty) {
    return null;
  }
  final romanizedInitialFormative =
      formatives[0].romanize(preferShortCut, omitOptionalAffixes).capitalize();
  String sentence = switch (formatives[0].concatenationStatus) {
    NoConcatenation() => '$romanizedInitialFormative ',
    Type1Concatenation() || Type2Concatenation() => '$romanizedInitialFormative-',
  };
  for (int i = 1; i < formatives.length; i++) {
    final thisFormative = formatives[i].romanize(preferShortCut, omitOptionalAffixes);
    sentence = switch (formatives[i].concatenationStatus) {
      NoConcatenation() => "$sentence$thisFormative ",
      Type1Concatenation() || Type2Concatenation() => "$sentence$thisFormative-"
    };
  }
  if (sentence[sentence.length - 1] == ' ') {
    sentence = sentence.substring(0, sentence.length - 1);
  }
  return "$sentence.";
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

bool isVowel(String char) {
  return switch (char.toLowerCase()) {
    'a' || 'ä' || 'e' || 'ë' || 'i' || 'o' || 'ö' || 'u' || 'ü' => true,
    _ => false,
  };
}

bool isDiphthong(String str) {
  return switch (str.toLowerCase()) {
    "ai" || "ei" || "ëi" || "oi" || "ui" || "au" || "eu" || "ëu" || "ou" || "iu" => true,
    _ => false,
  };
}

/// Get the vowel indexes of a formative. For the diphthong, only the first vowel index of it
/// will be added into the list.
List<int> getVowelIndexList(String formative) {
  final List<int> vowelList = [];
  int i = 0;
  while (i < formative.length) {
    if (isVowel(formative[i])) {
      vowelList.add(i);
      if (i + 1 < formative.length) {
        final potentialDiphthong = "${formative[i]}${formative[i + 1]}".toLowerCase();
        if (isDiphthong(potentialDiphthong)) {
          i += 1;
        }
      }
    }
    i += 1;
  }
  return vowelList;
}

Result<String, ()> addAccentMark(String char) {
  return switch (char) {
    'A' => const Ok('Á'),
    'Ä' => const Ok('Â'),
    'E' => const Ok('É'),
    'Ë' => const Ok('Ê'),
    'I' => const Ok('Í'),
    'O' => const Ok('Ó'),
    'Ö' => const Ok('Ô'),
    'U' => const Ok('Ú'),
    'Ü' => const Ok('Û'),
    'a' => const Ok('á'),
    'ä' => const Ok('â'),
    'e' => const Ok('é'),
    'ë' => const Ok('ê'),
    'i' => const Ok('í'),
    'o' => const Ok('ó'),
    'ö' => const Ok('ô'),
    'u' => const Ok('ú'),
    'ü' => const Ok('û'),
    _ => const Err(()),
  };
}
