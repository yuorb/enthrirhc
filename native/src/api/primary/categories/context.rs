#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub(crate) enum Context {
    /// The Existential Context
    Exs,

    /// The Functional Context
    Fnc,

    /// The Representational Context
    Rps,

    /// The Amalgamative Context
    Amg,
}

impl Context {
    pub(crate) fn path(&self) -> &'static str {
        use Context::*;
        match self {
            Exs => "",
            Fnc => "M -7.50 -40.00 L 0.00 -32.50 7.50 -40.00 0.00 -47.50 -7.50 -40.00 Z",
            Rps => "M 10.00 -40.00 L 20.00 -50.00 -10.00 -50.00 -20.00 -40.00 10.00 -40.00 Z",
            Amg => "M -13.75 -51.25 L 6.25 -31.25 13.75 -38.75 -6.25 -58.75 -13.75 -51.25 Z",
        }
    }
}
