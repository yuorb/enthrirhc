import 'package:enthrirhs/libs/ithkuil/writing/secondary/core_letter.dart';
import 'package:enthrirhs/libs/ithkuil/writing/secondary/ext_letter.dart';
import 'package:enthrirhs/libs/result/mod.dart';

import '../terms/mod.dart';

sealed class Affix {
  final String cs;

  const Affix({required this.cs});

  String getVx(String charPrecedingThis);
  String topId();
  String topPath();
  String bottomId();
  String bottomPath();

  Result<(ExtLetter?, CoreLetter, ExtLetter?), String> getSecondaryComponents() {
    if (cs.length == 1) {
      final phoneme = Phoneme.fromChar(cs[0]);
      if (phoneme == null) {
        return Err('The first letter "${cs[0]} is invalid."');
      }
      final coreLetter = CoreLetter.from(phoneme);
      if (coreLetter != null) {
        return Ok((null, coreLetter, null));
      }
      final extLetter = ExtLetter.from(phoneme);
      return Ok((extLetter, CoreLetter.placeholder, null));
    }
    if (cs.length == 2) {
      final phoneme1 = Phoneme.fromChar(cs[0]);
      if (phoneme1 == null) {
        return Err('The first letter "${cs[0]} is invalid."');
      }
      final phoneme2 = Phoneme.fromChar(cs[1]);
      if (phoneme2 == null) {
        return Err('The second letter "${cs[1]} is invalid."');
      }
      final extLetter1 = ExtLetter.from(phoneme1);
      final extLetter2 = ExtLetter.from(phoneme2);
      return Ok((extLetter1, CoreLetter.placeholder, extLetter2));
    }
    if (cs.length == 3) {
      final phoneme1 = Phoneme.fromChar(cs[0]);
      if (phoneme1 == null) {
        return Err('The first letter "${cs[0]} is invalid."');
      }
      final phoneme2 = Phoneme.fromChar(cs[1]);
      if (phoneme2 == null) {
        return Err('The second letter "${cs[1]} is invalid."');
      }
      final phoneme3 = Phoneme.fromChar(cs[2]);
      if (phoneme3 == null) {
        return Err('The third letter "${cs[2]} is invalid."');
      }
      final startLetter = ExtLetter.from(phoneme1);
      final coreLetter = CoreLetter.from(phoneme2);
      if (coreLetter == null) {
        return Err('The second letter "${cs[1]}" cannot be converted into a core letter.');
      }
      final endLetter = ExtLetter.from(phoneme3);
      return Ok((startLetter, coreLetter, endLetter));
    }
    return const Err('The affix Cs length is more than 3.');
  }
}

class CommonAffix extends Affix {
  final AffixType affixType;
  final Degree degree;

  const CommonAffix({
    required this.affixType,
    required this.degree,
    required super.cs,
  });

  @override
  String getVx(String charPrecedingThis) {
    return switch (affixType) {
      AffixType.type1 => switch (degree) {
          Degree.d1 => 'a',
          Degree.d2 => 'ä',
          Degree.d3 => 'e',
          Degree.d4 => 'i',
          Degree.d5 => 'ëi',
          Degree.d6 => 'ö',
          Degree.d7 => 'o',
          Degree.d8 => 'ü',
          Degree.d9 => 'u',
          Degree.d0 => 'ae',
        },
      AffixType.type2 => switch (degree) {
          Degree.d1 => 'ai',
          Degree.d2 => 'au',
          Degree.d3 => 'ei',
          Degree.d4 => 'eu',
          Degree.d5 => 'ëu',
          Degree.d6 => 'ou',
          Degree.d7 => 'oi',
          Degree.d8 => 'iu',
          Degree.d9 => 'ui',
          Degree.d0 => 'ea',
        },
      AffixType.type3 => switch (degree) {
          Degree.d1 => charPrecedingThis == 'y' ? 'uä' : 'ia',
          Degree.d2 => charPrecedingThis == 'y' ? 'uë' : 'ie',
          Degree.d3 => charPrecedingThis == 'y' ? 'üä' : 'io',
          Degree.d4 => charPrecedingThis == 'y' ? 'üë' : 'iö',
          Degree.d5 => 'eë',
          Degree.d6 => charPrecedingThis == 'w' ? 'öë' : 'uö',
          Degree.d7 => charPrecedingThis == 'w' ? 'öä' : 'uo',
          Degree.d8 => charPrecedingThis == 'w' ? 'ië' : 'ue',
          Degree.d9 => charPrecedingThis == 'w' ? 'iä' : 'ua',
          Degree.d0 => 'üo',
        },
    };
  }

  @override
  String topId() {
    return 'affix_type_${affixType.name}';
  }

  @override
  String topPath() {
    return affixType.path();
  }

  @override
  String bottomId() {
    return 'affix_degree_${degree.name}';
  }

  @override
  String bottomPath() {
    return degree.path();
  }
}

class CaStackingAffix extends Affix {
  const CaStackingAffix({required super.cs});

  @override
  String getVx(String charPrecedingThis) {
    return 'üö';
  }

  @override
  String topId() {
    return 'affix_ca_stacking_top';
  }

  @override
  String topPath() {
    return '';
  }

  @override
  String bottomId() {
    return 'affix_ca_stacking_bottom';
  }

  @override
  String bottomPath() {
    return 'M 20.25 -9.78 L 19.10 -11.03 Q 12.55 0.67 4.70 1.22 -3.10 1.72 -12.75 -8.53 L -20.25 -1.03 Q -13.70 11.02 -1.55 8.52 10.70 6.02 20.25 -9.78 Z';
  }
}
