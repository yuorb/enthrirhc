use crate::api::utils::Coord;

use super::phoneme_core::PhonemeCore;

#[derive(Debug)]
pub(crate) enum Orientation {
    Vertical,
    Diagonal,
    Horizontal,
}

pub(crate) struct Anchor {
    pub(crate) coord: Coord,
    pub(crate) orientation: Orientation,
    pub(crate) reversed: bool,
}

impl Anchor {
    pub(crate) fn rotation(&self) -> usize {
        match self.reversed {
            false => 0,
            true => 180
        }
    }
}

pub(crate) fn get_start_ext_anchor(phoneme: &PhonemeCore) -> Anchor {
    use Orientation::*;
    use PhonemeCore::*;
    match phoneme {
        Placeholder => Anchor {
            coord: Coord::new(0.00, -25.00),
            orientation: Vertical,
            reversed: false,
        },
        F => Anchor {
            coord: Coord::new(50.00, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        V => Anchor {
            coord: Coord::new(50.00, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        C => Anchor {
            coord: Coord::new(0.00, -25.00),
            orientation: Vertical,
            reversed: false,
        },
        Dz => Anchor {
            coord: Coord::new(10.00, -25.00),
            orientation: Vertical,
            reversed: false,
        },
        T => Anchor {
            coord: Coord::new(40.00, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        D => Anchor {
            coord: Coord::new(40.00, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        Sh => Anchor {
            coord: Coord::new(30.00, -25.00),
            orientation: Vertical,
            reversed: false,
        },
        Ch => Anchor {
            coord: Coord::new(40.00, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        J => Anchor {
            coord: Coord::new(50.00, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        L => Anchor {
            coord: Coord::new(5.00, -25.00),
            orientation: Vertical,
            reversed: false,
        },
        M => Anchor {
            coord: Coord::new(0.00, -25.00),
            orientation: Vertical,
            reversed: false,
        },
        Hs => Anchor {
            coord: Coord::new(63.7, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        H => Anchor {
            coord: Coord::new(0.00, -25.00),
            orientation: Vertical,
            reversed: false,
        },
        P => Anchor {
            coord: Coord::new(50.00, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        K => Anchor {
            coord: Coord::new(65.65, -25.03),
            orientation: Horizontal,
            reversed: true,
        },
        B => Anchor {
            coord: Coord::new(49.4, -25.00),
            orientation: Horizontal,
            reversed: true,
        },
        Dh => Anchor {
            coord: Coord::new(50.00, -24.92),
            orientation: Horizontal,
            reversed: true,
        },
        G => Anchor {
            coord: Coord::new(65.65, -24.93),
            orientation: Horizontal,
            reversed: true,
        },
        Hl => Anchor {
            coord: Coord::new(0.00, -25.00),
            orientation: Vertical,
            reversed: false,
        },
        N => Anchor {
            coord: Coord::new(0.00, -24.92),
            orientation: Vertical,
            reversed: false,
        },
        Ng => Anchor {
            coord: Coord::new(8.45, -25.05),
            orientation: Vertical,
            reversed: false,
        },
        R => Anchor {
            coord: Coord::new(0.00, -27.50),
            orientation: Diagonal,
            reversed: false,
        },
        Gr => Anchor {
            coord: Coord::new(0.00, -27.47),
            orientation: Diagonal,
            reversed: false,
        },
        S => Anchor {
            coord: Coord::new(45.00, -24.97),
            orientation: Vertical,
            reversed: false,
        },
        Th => Anchor {
            coord: Coord::new(50.00, -25.05),
            orientation: Horizontal,
            reversed: true,
        },
        X => Anchor {
            coord: Coord::new(65.65, -25.03),
            orientation: Horizontal,
            reversed: true,
        },
        Z => Anchor {
            coord: Coord::new(12.65, -27.72),
            orientation: Diagonal,
            reversed: false,
        },
        Zh => Anchor {
            coord: Coord::new(9.45, -27.53),
            orientation: Diagonal,
            reversed: false,
        },
    }
}

pub(crate) fn get_end_ext_anchor(phoneme: &PhonemeCore) -> Anchor {
    use Orientation::*;
    use PhonemeCore::*;
    match phoneme {
        Placeholder => Anchor {
            coord: Coord::new(20.00, 25.00),
            orientation: Vertical,
            reversed: true,
        },
        F => Anchor {
            coord: Coord::new(40.00, 25.00),
            orientation: Vertical,
            reversed: true,
        },
        V => Anchor {
            coord: Coord::new(35.00, 25.00),
            orientation: Vertical,
            reversed: true,
        },
        C => Anchor {
            coord: Coord::new(40.00, 35.00),
            orientation: Horizontal,
            reversed: true,
        },
        Dz => Anchor {
            coord: Coord::new(45.00, 35.00),
            orientation: Horizontal,
            reversed: true,
        },
        T => Anchor {
            coord: Coord::new(10.00, 25.00),
            orientation: Vertical,
            reversed: true,
        },
        D => Anchor {
            coord: Coord::new(20.00, 25.00),
            orientation: Vertical,
            reversed: true,
        },
        Sh => Anchor {
            coord: Coord::new(30.00, 35.00),
            orientation: Horizontal,
            reversed: true,
        },
        Ch => Anchor {
            coord: Coord::new(40.00, 35.00),
            orientation: Horizontal,
            reversed: true,
        },
        J => Anchor {
            coord: Coord::new(45.00, 35.00),
            orientation: Horizontal,
            reversed: true,
        },
        L => Anchor {
            coord: Coord::new(40.00, 35.00),
            orientation: Horizontal,
            reversed: true,
        },
        M => Anchor {
            coord: Coord::new(37.50, 27.50),
            orientation: Diagonal,
            reversed: true,
        },
        Hs => Anchor {
            coord: Coord::new(33.85, 27.50),
            orientation: Diagonal,
            reversed: true,
        },
        H => Anchor {
            coord: Coord::new(45.00, 25.00),
            orientation: Vertical,
            reversed: true,
        },
        P => Anchor {
            coord: Coord::new(35.00, 25.00),
            orientation: Vertical,
            reversed: true,
        },
        K => Anchor {
            coord: Coord::new(56.30, 27.52),
            orientation: Diagonal,
            reversed: true,
        },
        B => Anchor {
            coord: Coord::new(39.4, 25.00),
            orientation: Vertical,
            reversed: true,
        },
        Dh => Anchor {
            coord: Coord::new(37.85, 27.28),
            orientation: Diagonal,
            reversed: true,
        },
        G => Anchor {
            coord: Coord::new(69.30, 27.52),
            orientation: Diagonal,
            reversed: true,
        },
        Hl => Anchor {
            coord: Coord::new(42.45, 27.50),
            orientation: Diagonal,
            reversed: true,
        },
        N => Anchor {
            coord: Coord::new(37.70, 27.42),
            orientation: Diagonal,
            reversed: true,
        },
        Ng => Anchor {
            coord: Coord::new(34.20, 27.55),
            orientation: Diagonal,
            reversed: true,
        },
        R => Anchor {
            coord: Coord::new(40.00, 35.00),
            orientation: Horizontal,
            reversed: true,
        },
        Gr => Anchor {
            coord: Coord::new(38.00, 35.03),
            orientation: Horizontal,
            reversed: true,
        },
        S => Anchor {
            coord: Coord::new(37.45, 27.47),
            orientation: Diagonal,
            reversed: true,
        },
        Th => Anchor {
            coord: Coord::new(40.60, 27.55),
            orientation: Diagonal,
            reversed: true,
        },
        X => Anchor {
            coord: Coord::new(52.60, 27.52),
            orientation: Diagonal,
            reversed: true,
        },
        Z => Anchor {
            coord: Coord::new(33.10, 27.72),
            orientation: Diagonal,
            reversed: true,
        },
        Zh => Anchor {
            coord: Coord::new(40.00, 35.03),
            orientation: Horizontal,
            reversed: true,
        },
    }
}
