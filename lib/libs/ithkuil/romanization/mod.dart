// TODO: Add `bool moveCnToCa` parameter
import 'package:enthrirhs/libs/ithkuil/mod.dart';
import 'package:enthrirhs/libs/ithkuil/terms/formative_type.dart';
import 'package:enthrirhs/libs/misc.dart';

class RomanizationOptions {
  bool preferShortCut;
  bool omitOptionalAffixes;

  RomanizationOptions({
    required this.preferShortCut,
    required this.omitOptionalAffixes,
  });
}

String? romanizeFormatives(List<Formative> formatives) {
  if (formatives.isEmpty) {
    return null;
  }
  String sentence = formatives[0].romanize().capitalize();
  for (int i = 1; i < formatives.length; i++) {
    switch (formatives[i - 1].formativeType) {
      case Standalone():
        sentence = "$sentence ${formatives[i].romanize()}";
        break;
      case Parent():
        sentence = "$sentence ${formatives[i].romanize()}";
        break;
      case Concatenated():
        if (formatives[i].formativeType is Parent) {
          sentence = "$sentence-${formatives[i].romanize()}";
        }
    }
  }
  return sentence.addPeriod();
}
