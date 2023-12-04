import 'mod.dart';

sealed class Cn {
  const Cn();

  String romanize(bool omitOptionalAffixes, bool isPattern1);
}

class MoodCn extends Cn {
  final Mood mood;

  const MoodCn(this.mood);

  @override
  String romanize(bool omitOptionalAffixes, bool isPattern1) {
    return mood.romanize(omitOptionalAffixes, isPattern1);
  }
}

class CaseScopeCn extends Cn {
  final CaseScope caseScope;

  const CaseScopeCn(this.caseScope);

  @override
  String romanize(bool omitOptionalAffixes, bool isPattern1) {
    return caseScope.romanize(omitOptionalAffixes, isPattern1);
  }
}
