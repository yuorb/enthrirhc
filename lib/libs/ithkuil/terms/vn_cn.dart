import 'mod.dart';

sealed class VnCn {
  final Cn cn;

  const VnCn({required this.cn});

  String romanize(bool omitOptionalAffixes, String charPrecedingThis);
}

class Pattern1 extends VnCn {
  final VnPattern1 vn;

  const Pattern1({
    required this.vn,
    required super.cn,
  });

  @override
  String romanize(bool omitOptionalAffixes, String charPrecedingThis) {
    final vnRomanized = vn.romanize(omitOptionalAffixes, charPrecedingThis);
    final cnRomanized = cn.romanize(omitOptionalAffixes, true);

    return "$vnRomanized$cnRomanized";
  }
}

class Pattern2 extends VnCn {
  final Aspect vn;

  const Pattern2({
    required this.vn,
    required super.cn,
  });

  @override
  String romanize(bool omitOptionalAffixes, String charPrecedingThis) {
    final vnRomanized = vn.romanize(charPrecedingThis);
    final cnRomanized = cn.romanize(omitOptionalAffixes, false);

    return "$vnRomanized$cnRomanized";
  }
}

sealed class VnPattern1 {
  const VnPattern1();

  String romanize(bool omitOptionalAffixes, String charPrecedingThis);
}

class ValenceVn extends VnPattern1 {
  final Valence valence;
  const ValenceVn(this.valence);

  @override
  String romanize(bool omitOptionalAffixes, String charPrecedingThis) {
    return valence.romanize(omitOptionalAffixes);
  }
}

class PhaseVn extends VnPattern1 {
  final Phase phase;
  const PhaseVn(this.phase);

  @override
  String romanize(bool omitOptionalAffixes, String charPrecedingThis) {
    return phase.romanize();
  }
}

class EffectVn extends VnPattern1 {
  final Effect effect;
  const EffectVn(this.effect);

  @override
  String romanize(bool omitOptionalAffixes, String charPrecedingThis) {
    return effect.romanize(charPrecedingThis);
  }
}

class LevelVn extends VnPattern1 {
  final ComparisonOperator level;
  const LevelVn(this.level);

  @override
  String romanize(bool omitOptionalAffixes, String charPrecedingThis) {
    return level.romanize();
  }
}
