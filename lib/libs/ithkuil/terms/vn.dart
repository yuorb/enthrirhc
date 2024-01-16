import 'aspect.dart';
import 'effect.dart';
import 'level.dart';
import 'phase.dart';
import 'valence.dart';

sealed class Vn {
  const Vn();

  String romanize(String charPrecedingThis);
}

class ValenceVn extends Vn {
  final Valence valence;
  const ValenceVn(this.valence);

  @override
  String romanize(String charPrecedingThis) {
    return valence.romanize();
  }
}

class PhaseVn extends Vn {
  final Phase phase;
  const PhaseVn(this.phase);

  @override
  String romanize(String charPrecedingThis) {
    return phase.romanize();
  }
}

class EffectVn extends Vn {
  final Effect effect;
  const EffectVn(this.effect);

  @override
  String romanize(String charPrecedingThis) {
    return effect.romanize(charPrecedingThis);
  }
}

class LevelVn extends Vn {
  final ComparisonOperator level;
  const LevelVn(this.level);

  @override
  String romanize(String charPrecedingThis) {
    return level.romanize();
  }
}

class AspectVn extends Vn {
  final Aspect aspect;
  const AspectVn(this.aspect);

  @override
  String romanize(String charPrecedingThis) {
    return aspect.romanize(charPrecedingThis);
  }
}
