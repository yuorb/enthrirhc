pub(crate) struct Coord {
    pub(crate) x: f64,
    pub(crate) y: f64,
}

impl Coord {
    pub(crate) const fn new(x: f64, y: f64) -> Self {
        Coord { x, y }
    }
}

pub(crate) fn get_core_boundary(path: &str) -> (f64, f64) {
    let list: Vec<Result<f64, _>> = path.split(" ").map(|v| str::parse(v)).collect();
    let mut right: f64 = -f64::INFINITY;
    let mut i = 1;
    for index in 0..list.len() {
        if list[index].is_err() {
            continue;
        }
        if i % 2 != 0 {
            let coord_x = list[index].as_ref().unwrap();
            if *coord_x > right {
                right = *coord_x;
            }
        }
        i += 1;
    }
    // Core must start from axis `x = 0`;
    return (0.0, right);
}

pub(crate) fn get_component_boundary(path: &str) -> (f64, f64) {
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

    return (left, right);
}
