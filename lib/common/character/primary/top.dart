enum Context {
  /// The Existential Context
  exs,

  /// The Functional Context
  fnc,

  /// The Representational Context
  rps,

  /// The Amalgamative Context
  amg;

  String getSvg() {
    return switch (this) {
      Context.exs => "",
      Context.fnc => "M -7.50 -40.00 L 0.00 -32.50 7.50 -40.00 0.00 -47.50 -7.50 -40.00 Z",
      Context.rps => "M 10.00 -40.00 L 20.00 -50.00 -10.00 -50.00 -20.00 -40.00 10.00 -40.00 Z",
      Context.amg => "M -13.75 -51.25 L 6.25 -31.25 13.75 -38.75 -6.25 -58.75 -13.75 -51.25 Z",
    };
  }
}
