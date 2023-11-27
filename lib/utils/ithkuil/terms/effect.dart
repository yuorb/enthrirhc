enum Effect {
  ben1,
  ben2,
  ben3,
  benSlf,
  unk,
  detSlf,
  det3,
  det2,
  det1;

  String romanize(String charPrecedingThis) {
    return switch (this) {
      ben1 => charPrecedingThis == 'y' ? 'uä' : 'ia',
      ben2 => charPrecedingThis == 'y' ? 'uë' : 'ie',
      ben3 => charPrecedingThis == 'y' ? 'üä' : 'io',
      benSlf => charPrecedingThis == 'y' ? 'üë' : 'iö',
      unk => 'eë',
      detSlf => charPrecedingThis == 'w' ? 'öë' : 'uö',
      det3 => charPrecedingThis == 'w' ? 'öä' : 'uo',
      det2 => charPrecedingThis == 'w' ? 'ië' : 'ue',
      det1 => charPrecedingThis == 'w' ? 'iä' : 'ua',
    };
  }
}
