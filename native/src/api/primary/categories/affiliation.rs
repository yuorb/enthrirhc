#[derive(Debug, Clone, Copy)]
pub(crate) enum Affiliation {
    /// The Consolidative Affiliation
    Csl,

    /// The Associative Affiliation
    Aso,

    /// The Coalescent Affiliation
    Coa,

    /// The Variative Affiliation
    Var,
}
