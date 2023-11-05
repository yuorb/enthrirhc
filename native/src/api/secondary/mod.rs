mod anchor;
mod phoneme;
mod phoneme_core;

use as_any::AsAny;

use crate::api::secondary::anchor::Orientation;

use self::{anchor::Anchor, phoneme::Phoneme, phoneme_core::PhonemeCore};
use super::{utils::get_core_boundary, Character};

pub struct Secondary {
    pub(crate) start_ext: Option<Phoneme>,
    pub(crate) end_ext: Option<Phoneme>,
    pub(crate) core: PhonemeCore,
}

impl Secondary {
    pub(crate) fn start_ext_anchor(&self) -> Anchor {
        anchor::get_start_ext_anchor(&self.core)
    }

    pub(crate) fn end_ext_anchor(&self) -> Anchor {
        anchor::get_end_ext_anchor(&self.core)
    }

    pub(crate) fn start_ext_path(&self) -> &'static str {
        use Orientation::*;
        match &self.start_ext {
            Some(start) => match self.start_ext_anchor().orientation {
                Vertical => start.vertical_path(),
                Horizontal => start.horizontal_path(),
                Diagonal => start.diagonal_path(),
            },
            None => "",
        }
    }

    pub(crate) fn end_ext_path(&self) -> &'static str {
        use Orientation::*;
        match &self.end_ext {
            Some(end) => match self.end_ext_anchor().orientation {
                Vertical => end.vertical_path(),
                Horizontal => end.horizontal_path(),
                Diagonal => end.diagonal_path(),
            },
            None => "",
        }
    }

    fn get_boundary(&self) -> (f64, f64) {
        let (core_left, core_right) = get_core_boundary(self.core.path());
        let (start_ext_left, start_ext_right) =
            get_extension_boundary(self.start_ext_path(), self.start_ext_anchor().reversed);
        let (end_ext_left, end_ext_right) =
            get_extension_boundary(self.end_ext_path(), self.end_ext_anchor().reversed);

        let left = [
            core_left,
            self.start_ext_anchor().coord.x + start_ext_left,
            self.end_ext_anchor().coord.x + end_ext_left,
        ]
        .into_iter()
        .reduce(f64::min)
        .unwrap();

        let right = [
            core_right,
            self.start_ext_anchor().coord.x + start_ext_right,
            self.end_ext_anchor().coord.x + end_ext_right,
        ]
        .into_iter()
        .reduce(f64::max)
        .unwrap();

        (left, right)
    }
}

impl Character for Secondary {
    fn get_svg(&self, base_x: f64, base_y: f64, fill_color: &str) -> (String, f64) {
        let secondary_boundary = self.get_boundary();
        let core_x = base_x - secondary_boundary.0;
        let core_y = base_y;
        let start_x = core_x + self.start_ext_anchor().coord.x;
        let start_y = core_y + self.start_ext_anchor().coord.y;
        let end_x = core_x + self.end_ext_anchor().coord.x;
        let end_y = core_y + self.end_ext_anchor().coord.y;

        let secondary_width = secondary_boundary.1 - secondary_boundary.0;

        let core_svg = format!(
            r##"<use href="#{:?}_core" x="{core_x}" y="{core_y}" fill="{fill_color}" />"##,
            self.core
        );
        let start_svg = if self.start_ext.is_some() {
            format!(
                r##"<use
                    href="#{:?}_ext_{:?}"
                    x="{start_x}"
                    y="{start_y}"
                    transform="rotate({}, {start_x}, {start_y})"
                    fill="{fill_color}"
                />"##,
                self.start_ext,
                self.start_ext_anchor().orientation,
                self.start_ext_anchor().rotation()
            )
        } else {
            String::new()
        };
        let end_svg = if self.end_ext.is_some() {
            format!(
                r##"<use
                    href="#{:?}_ext_{:?}"
                    x="{end_x}"
                    y="{end_y}"
                    transform="rotate({}, {end_x}, {end_y})"
                    fill="{fill_color}"
                />"##,
                self.end_ext,
                self.end_ext_anchor().orientation,
                self.end_ext_anchor().rotation()
            )
        } else {
            String::new()
        };
        (format!("{core_svg}{start_svg}{end_svg}"), secondary_width)
    }
}

fn get_extension_boundary(path: &str, is_reversed: bool) -> (f64, f64) {
    let is_to_rotate = is_reversed;
    let list: Vec<Result<f64, _>> = path.split(" ").map(|v| str::parse(v)).collect();
    let mut left = f64::INFINITY;
    let mut right = -f64::INFINITY;

    let mut i = 1;
    for index in 0..list.len() {
        if list[index].is_err() {
            continue;
        }
        if i % 2 != 0 {
            let coord_x = list[index].as_ref().unwrap();
            if *coord_x < left {
                left = *coord_x;
            }
            if *coord_x > right {
                right = *coord_x;
            }
        }
        i += 1;
    }
    if is_to_rotate {
        (-right, -left)
    } else {
        (left, right)
    }
}

impl AsAny for Secondary {
    fn as_any(&self) -> &dyn std::any::Any {
        self
    }
}
