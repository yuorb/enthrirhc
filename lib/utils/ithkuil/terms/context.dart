enum Context {
  /// The Existential Context
  exs,

  /// The Functional Context
  fnc,

  /// The Representational Context
  rps,

  /// The Amalgamative Context
  amg;

  String path() {
    return switch (this) {
      exs => "",
      fnc => "M -7.50 0.00 L 0.00 7.50 7.50 0.00 0.00 -7.50 -7.50 0.00 Z",
      rps => "M 10.00 5.00 L 20.00 -5.00 -10.00 -5.00 -20.00 5.00 10.00 5.00 Z",
      amg => "M -13.75 -6.25 L 6.25 13.75 13.75 6.25 -6.25 -13.75 -13.75 -6.25 Z",
    };
  }
}
