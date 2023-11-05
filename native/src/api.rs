use as_any::AsAny;

mod ithkuil_svg;
mod primary;
mod quarternary;
mod secondary;
mod tertiary;
mod utils;

pub trait Character: AsAny {
    fn get_svg(&self, base_x: f64, base_y: f64, fill_color: &str) -> (String, f64);
}

pub use ithkuil_svg::ithkuil_svg;
pub use primary::Primary;
pub use quarternary::Quarternary;
pub use secondary::Secondary;
pub use tertiary::Tertiary;
