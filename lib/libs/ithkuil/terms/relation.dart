import 'case.dart';
import 'illocution.dart';
import 'validation.dart';

sealed class Relation {
  const Relation();

  String id();
  String path();
  String idTopSecondary();
  String? idBottomSecondary();
  String pathTopSecondary();
  String? pathBottomSecondary();
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

  @override
  String idTopSecondary() => case$.caseType.idSecondary();

  @override
  String? idBottomSecondary() => case$.caseNumber.idSecondary();

  @override
  String pathTopSecondary() => case$.caseType.pathSecondary();

  @override
  String? pathBottomSecondary() => case$.caseNumber.pathSecondary();
}

class FramedVerb extends Relation {
  final Case case$;

  const FramedVerb(this.case$);

  @override
  String id() {
    return 'relation_framedVerb';
  }

  @override
  String path() {
    return 'M 10.00 5.00 L 20.00 -5.00 -10.00 -5.00 -20.00 5.00 10.00 5.00 Z';
  }

  @override
  String idTopSecondary() => case$.caseType.idSecondary();

  @override
  String? idBottomSecondary() => case$.caseNumber.idSecondary();

  @override
  String pathTopSecondary() => case$.caseType.pathSecondary();

  @override
  String? pathBottomSecondary() => case$.caseNumber.pathSecondary();
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
          Validation.obs => omitOptionalAffixes ? '' : 'a',
          Validation.rec => 'ä',
          Validation.pup => 'e',
          Validation.rpr => 'i',
          Validation.usp => 'ëi',
          Validation.ima => 'ö',
          Validation.cvn => 'o',
          Validation.itu => 'ü',
          Validation.inf => 'u',
        },
      Illocution.dir => 'ai',
      Illocution.dec => 'au',
      Illocution.irg => 'ei',
      Illocution.ver => 'eu',
      Illocution.adm => 'ou',
      Illocution.pot => 'oi',
      Illocution.hor => 'iu',
      Illocution.cnj => 'ui'
    };
  }

  @override
  String path() {
    return 'M -7.50 0.00 L 0.00 7.50 7.50 0.00 0.00 -7.50 -7.50 0.00 Z';
  }

  @override
  String idTopSecondary() => illocution.idSecondary();

  @override
  String? idBottomSecondary() => validation?.idSecondary();

  @override
  String pathTopSecondary() => illocution.pathSecondary();

  @override
  String? pathBottomSecondary() => validation?.pathSecondary();
}
