use crate::api::utils::Coord;

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub(crate) enum Specification {
    /// Basic Specification
    Bsc,

    /// Contential Specification
    Cte,

    /// Constitutive Specification
    Csv,

    /// Objective Specification
    Obj,
}

impl Specification {
    pub(crate) fn center_x(&self) -> f64 {
        use Specification::*;
        match self {
            Bsc => 32.50,
            Cte => 23.75,
            Csv => 35.00,
            Obj => 27.50,
        }
    }

    pub(crate) fn anchor_b(&self) -> Coord {
        use Specification::*;
        match self {
            Bsc => Coord::new(0.00, -27.50),
            Cte => Coord::new(0.00, -27.50),
            Csv => Coord::new(0.00, -27.50),
            Obj => Coord::new(0.00, -27.50),
        }
    }

    pub(crate) fn anchor_d(&self) -> Coord {
        use Specification::*;
        match self {
            Bsc => Coord::new(65.00, 27.50),
            Cte => Coord::new(47.50, 27.50),
            Csv => Coord::new(70.00, 27.50),
            Obj => Coord::new(55.00, 27.50),
        }
    }

    pub(crate) fn path(&self) -> &'static str {
        use Specification::*;
        match self {
            Bsc => "M 7.50 -35.00 L 0.00 -27.50 57.50 35.00 65.00 27.50 7.50 -35.00 Z",
            Cte => "M 32.50 5.00 L 40.00 -2.50 7.50 -35.00 0.00 -27.50 32.50 5.00 M 15.00 -5.00 L 7.50 2.50 40.00 35.00 47.50 27.50 15.00 -5.00 Z",
            Csv => "M 28.00 8.10 L 35.45 0.60 62.50 35.00 70.00 27.50 42.20 -8.50 34.45 -0.70 7.50 -35.00 0.00 -27.50 28.00 8.10 Z",
            Obj => "M 47.50 35.00 L 55.00 27.50 28.10 0.60 35.55 -6.95 7.50 -35.00 0.00 -27.50 26.90 -0.60 19.40 6.90 47.50 35.00 Z",
        }
    }
    
}
