use as_any::AsAny;

use self::{
    extensions::TertiaryExtension,
    utils::{get_extension_bottom, get_extension_top, get_horizontal_boundary},
    valence::Valence,
};

use super::Character;

mod extensions;
mod utils;
mod valence;

pub struct Tertiary {
    pub(crate) valence: Valence,
    pub(crate) top: TertiaryExtension,
    pub(crate) bottom: TertiaryExtension,
}

impl Tertiary {
    fn get_boundary(&self) -> (f64, f64) {
        let (valence_left, valence_right) = get_horizontal_boundary(self.valence.path());
        let (top_ext_left, top_ext_right) = get_horizontal_boundary(self.top.path());
        let (bottom_ext_left, bottom_ext_right) = get_horizontal_boundary(self.bottom.path());

        let left = [valence_left, top_ext_left, bottom_ext_left]
            .into_iter()
            .reduce(f64::min)
            .unwrap();
        let right = [valence_right, top_ext_right, bottom_ext_right]
            .into_iter()
            .reduce(f64::max)
            .unwrap();

        return (left, right);
    }
}

impl Character for Tertiary {
    fn get_svg(&self, base_x: f64, base_y: f64, fill_color: &str) -> (String, f64) {
        let (left, right) = self.get_boundary();
        let width = right - left;
        let valence_x = base_x - left;
        let valence_y = base_y;
        let top_x = valence_x;
        let top_y = valence_y - 12.0 - get_extension_bottom(&self.top);
        let bottom_x = valence_x;
        let bottom_y = valence_y + 12.0 - get_extension_top(&self.bottom);
        return (
            format!(
                r##"
                  <use href="#{:?}" x="{valence_x}" y="{valence_y}" fill="{fill_color}" />
                  <use href="#{:?}" x="{top_x}" y="{top_y}" fill="{fill_color}" />
                  <use href="#{:?}" x="{bottom_x}" y="{bottom_y}" fill="{fill_color}" />
                "##,
                self.valence, self.top, self.bottom
            ),
            width,
        );
    }
}

impl AsAny for Tertiary {
    fn as_any(&self) -> &dyn std::any::Any {
        self
    }
}
