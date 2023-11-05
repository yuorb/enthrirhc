use super::extensions::TertiaryExtension;

pub(crate) fn get_extension_bottom(ext: &TertiaryExtension) -> f64 {
    // Ugly exceptions:
    if let TertiaryExtension::AspectCss = ext {
        return 7.0;
    }

    let path = ext.path();
    let list: Vec<Result<f64, _>> = path.split(' ').map(|v| str::parse(v)).collect();
    let mut bottom = -f64::INFINITY;
    let mut i = 1;
    for index in 0..list.len() {
        if list[index].is_err() {
            continue;
        }
        if i % 2 == 0 {
            let coord_y = list[index].as_ref().unwrap();
            if *coord_y > bottom {
                bottom = *coord_y;
            }
        }
        i += 1;
    }

    bottom
}

pub(crate) fn get_extension_top(ext: &TertiaryExtension) -> f64 {
    // Ugly exceptions:
    if let TertiaryExtension::AspectPrs = ext {
        return -7.0;
    }
    let path = ext.path();
    let list: Vec<Result<f64, _>> = path.split(" ").map(|v| str::parse(v)).collect();
    let mut top = f64::INFINITY;
    let mut i = 1;
    for index in 0..list.len() {
        if list[index].is_err() {
            continue;
        }
        if i % 2 == 0 {
            let coord_y = list[index].as_ref().unwrap();
            if *coord_y < top {
                top = *coord_y;
            }
        }
        i += 1;
    }

    return top;
}

pub(crate) fn get_horizontal_boundary(path: &str) -> (f64, f64) {
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

    (left, right)
}
