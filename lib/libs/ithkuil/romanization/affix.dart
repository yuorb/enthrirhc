import '../terms/mod.dart';

class Affix {
  AffixType affixType;
  final Degree degree;
  final String affix;

  Affix({
    required this.affixType,
    required this.degree,
    required this.affix,
  });

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
          Degree.ca => 'üö',
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
          Degree.ca => 'üö',
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
          Degree.ca => 'üö',
          Degree.d0 => 'üo',
        },
    };
  }
}
