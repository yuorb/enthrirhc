import 'cn.dart';
import 'vn.dart';

class VnCn {
  Cn cn;
  Vn vn;

  VnCn({
    required this.cn,
    required this.vn,
  });

  String romanize(bool omitOptionalAffixes, String charPrecedingThis) {
    final isPattern1 = switch (vn) {
      ValenceVn() || PhaseVn() || EffectVn() || LevelVn() => true,
      AspectVn() => false,
    };
    final vnRomanized = vn.romanize(omitOptionalAffixes, charPrecedingThis);
    final cnRomanized = cn.romanize(omitOptionalAffixes, isPattern1);

    return "$vnRomanized$cnRomanized";
  }
}
