import 'case.dart';
import 'illocution.dart';
import 'validation.dart';

sealed class Relation {
  const Relation();
}

class Noun extends Relation {
  final Case case$;

  const Noun(this.case$);
}

// TODO: Distinguish framedVerb & unframedVerb

class Verb extends Relation {
  final Illocution illocution;
  final Validation validation;

  const Verb({
    required this.illocution,
    required this.validation,
  });

  String romanized(bool omitOptionalAffixes) {
    return switch (illocution) {
      Illocution.asr => switch (validation) {
          Validation.obs => omitOptionalAffixes ? '' : 'á',
          Validation.rec => 'â',
          Validation.pup => 'é',
          Validation.rpr => 'í',
          Validation.usp => 'êi',
          Validation.ima => 'ô',
          Validation.cvn => 'ó',
          Validation.itu => 'û',
          Validation.inf => 'ú',
        },
      Illocution.dir => 'ái',
      Illocution.dec => 'áu',
      Illocution.irg => 'éi',
      Illocution.ver => 'éu',
      Illocution.adm => 'óu',
      Illocution.pot => 'ói',
      Illocution.hor => 'íu',
      Illocution.cnj => 'úi'
    };
  }
}
