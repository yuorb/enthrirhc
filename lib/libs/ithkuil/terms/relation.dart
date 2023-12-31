import 'case.dart';
import 'illocution.dart';
import 'validation.dart';

sealed class Relation {
  const Relation();

  String id();
  String path();
}

class Noun extends Relation {
  final Case case$;

  const Noun(this.case$);

  @override
  String id() {
    return 'relation_noun';
  }

  @override
  String path() {
    return '';
  }
}

class FramedVerb extends Relation {
  final Illocution illocution;
  final Validation? validation;

  const FramedVerb({
    required this.illocution,
    required this.validation,
  });

  @override
  String id() {
    return 'relation_framedVerb';
  }

  String romanized(bool omitOptionalAffixes) {
    return switch (illocution) {
      Illocution.asr => switch (validation!) {
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

  @override
  String path() {
    return 'M 10.00 5.00 L 20.00 -5.00 -10.00 -5.00 -20.00 5.00 10.00 5.00 Z';
  }
}

class UnframedVerb extends Relation {
  final Illocution illocution;
  final Validation? validation;

  const UnframedVerb({
    required this.illocution,
    required this.validation,
  });

  @override
  String id() {
    return 'relation_unframedVerb';
  }

  String romanized(bool omitOptionalAffixes) {
    return switch (illocution) {
      Illocution.asr => switch (validation!) {
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

  @override
  String path() {
    return 'M -7.50 0.00 L 0.00 7.50 7.50 0.00 0.00 -7.50 -7.50 0.00 Z';
  }
}
