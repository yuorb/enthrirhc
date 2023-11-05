#[derive(Debug, Clone, Copy)]
pub(crate) enum Separability {
    /// The Separate Separability
    S,

    /// The Connected Separability
    C,

    /// The Fused Separability
    F,
}
