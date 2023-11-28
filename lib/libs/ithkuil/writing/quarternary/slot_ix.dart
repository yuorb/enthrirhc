import '../../terms/mod.dart';

sealed class SlotIX {
  const SlotIX();

  String topId();
  String topPath();
  String bottomId();
  String bottomPath();
}

class NounSlotIX extends SlotIX {
  final Case case$;

  const NounSlotIX(this.case$);

  @override
  String topId() {
    return "quarternary_top_case_${case$.name}";
  }

  @override
  String bottomId() {
    return "quarternary_bottom_case_${case$.name}";
  }

  @override
  String topPath() {
    return case$.topPath();
  }

  @override
  String bottomPath() {
    return case$.bottomPath();
  }
}

class VerbSlotIX extends SlotIX {
  final Validation validation;
  final Illocution illocution;

  const VerbSlotIX({
    required this.validation,
    required this.illocution,
  });

  @override
  String topId() {
    return "quarternary_illocution_${illocution.name}";
  }

  @override
  String bottomId() {
    return "quarternary_validation_${validation.name}";
  }

  @override
  String topPath() {
    return illocution.path();
  }

  @override
  String bottomPath() {
    return validation.path();
  }
}
