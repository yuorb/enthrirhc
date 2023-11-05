#[derive(Debug, Clone, Copy)]
pub(crate) enum Similarity {
    /// The Similar Similarity
    S,

    /// The Dissimilar Similarity
    D,

    /// The Fuzzy  Similarity
    F,
}
