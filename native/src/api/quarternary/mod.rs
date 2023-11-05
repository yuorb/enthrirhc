use as_any::AsAny;

use self::{bottom::QuarternaryBottom, top::QuarternaryTop};

use super::{
    utils::{get_core_boundary, get_component_boundary, Coord},
    Character,
};

mod bottom;
mod top;

pub(crate) const CORE_PATH: &'static str =
    "M 10.00 -35.00 L 0.00 -25.00 0.00 35.00 10.00 25.00 10.00 -35.00 Z";

const CORE_TOP_ANCHOR: Coord = Coord::new(0.00, -25.00);
const CORE_BOTTOM_ANCHOR: Coord = Coord::new(10.00, 25.00);

pub struct Quarternary {
    pub(crate) top: QuarternaryTop,
    pub(crate) bottom: QuarternaryBottom,
}

pub struct CaseQuarternary {
    pub(crate) top: QuarternaryTop,
    pub(crate) bottom: QuarternaryBottom,
}

pub struct VerbalQuarternary {
    pub(crate) illocution: QuarternaryTop,
    pub(crate) validation: QuarternaryBottom,
}

impl Quarternary {
    fn get_boundary(&self) -> (f64, f64) {
        let (core_left, core_right) = get_core_boundary(CORE_PATH);
        let (top_ext_left, top_ext_right) = get_component_boundary(self.top.path());
        let (bottom_ext_left, bottom_ext_right) = get_component_boundary(self.bottom.path());

        let left = [
            core_left,
            CORE_TOP_ANCHOR.x + top_ext_left,
            CORE_BOTTOM_ANCHOR.x + bottom_ext_left,
        ]
        .into_iter()
        .reduce(f64::min)
        .unwrap();

        let right = [
            core_right,
            CORE_TOP_ANCHOR.x + top_ext_right,
            CORE_BOTTOM_ANCHOR.x + bottom_ext_right,
        ]
        .into_iter()
        .reduce(f64::max)
        .unwrap();

        return (left, right);
    }
}

impl Character for Quarternary {
    fn get_svg(&self, base_x: f64, base_y: f64, fill_color: &str) -> (String, f64) {
        let (left, right) = self.get_boundary();
        let width = right - left;
        let core_x = base_x - left;
        let core_y = base_y;
        let top_x = core_x + CORE_TOP_ANCHOR.x;
        let top_y = core_y + CORE_TOP_ANCHOR.y;
        let bottom_x = core_x + CORE_BOTTOM_ANCHOR.x;
        let bottom_y = core_y + CORE_BOTTOM_ANCHOR.y;
        (
            format!(
                r##"
                  <use href="#quarternary_core" x="{core_x}" y="{core_y}" fill="{fill_color}" />
                  <use href="#quarternary_{:?}" x="{top_x}" y="{top_y}" fill="{fill_color}" />
                  <use href="#quarternary_{:?}" x="{bottom_x}" y="{bottom_y}" fill="{fill_color}" />
                "##,
                self.top, self.bottom
            ),
            width,
        )
    }
}

impl AsAny for Quarternary {
    fn as_any(&self) -> &dyn std::any::Any {
        self
    }
}