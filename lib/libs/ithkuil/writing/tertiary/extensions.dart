import 'package:enthrirch/libs/ithkuil/terms/mod.dart';

sealed class TertiaryExtension {
  const TertiaryExtension();

  String id();
  String path();
}

class EffectExtension extends TertiaryExtension {
  final Effect effect;

  const EffectExtension(this.effect);

  @override
  String id() {
    return "effect_${effect.name}";
  }

  @override
  String path() {
    return effect.path();
  }
}

class PhaseExtension extends TertiaryExtension {
  final Phase phase;

  const PhaseExtension(this.phase);

  @override
  String id() {
    return "phase_${phase.name}";
  }

  @override
  String path() {
    return phase.path();
  }
}

class AspectExtension extends TertiaryExtension {
  final Aspect aspect;

  const AspectExtension(this.aspect);

  @override
  String id() {
    return "aspect_${aspect.name}";
  }

  @override
  String path() {
    return aspect.path();
  }
}
