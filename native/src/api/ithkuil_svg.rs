use itertools::Itertools;

use super::Character;
use crate::api::{primary, quarternary, secondary, tertiary};

use primary::Primary;
use quarternary::Quarternary;
use secondary::Secondary;
use tertiary::Tertiary;

const UNIT_HEIGHT: f64 = 35.0;
const VERTICAL_PADDING: f64 = UNIT_HEIGHT;
const HORIZONTAL_PADDING: f64 = 20.0;
const HORIZONTAL_GAP: f64 = 10.0;

pub fn ithkuil_svg(characters: Vec<Box<dyn Character>>, fill_color: String) -> String {
    // 1 unit height = 35
    // core letter height = 2 unit height = 70
    // full letter height = 4 unit height = 140
    // full letter with padding height = 6 unit height = 210

    // final String fillColor = "#e6e1e6";

    let used_specifications = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Primary>())
        .map(|v| &v.specification)
        .unique()
        .collect::<Vec<_>>();

    let used_primary_tops: Vec<_> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Primary>())
        .map(|s| &s.context)
        .unique()
        .collect();
    let used_a_anchors: Vec<(String, &str)> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Primary>())
        .map(|s| {
            (
                format!("{:?}_{:?}", s.essence, s.affiliation),
                s.component_a().path(),
            )
        })
        .unique()
        .collect();
    let used_b_anchors: Vec<(String, &str)> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Primary>())
        .map(|s| {
            (
                format!("{:?}_{:?}", s.perspective, s.extension),
                s.component_b().path(),
            )
        })
        .unique()
        .collect();
    let used_c_anchors: Vec<(String, &str)> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Primary>())
        .map(|s| {
            (
                format!("{:?}_{:?}", s.separability, s.similarity),
                s.component_c().path(),
            )
        })
        .unique()
        .collect();
    let used_d_anchors: Vec<(String, &str)> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Primary>())
        .map(|s| {
            (
                format!(
                    "{:?}_{:?}_{:?}_{:?}",
                    s.function, s.version, s.plexity, s.stem
                ),
                s.component_d().path(),
            )
        })
        .unique()
        .collect();
    let used_extensions: Vec<(String, &str)> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Secondary>())
        .map(|s| {
            let start = &s.start_ext;
            let end = &s.end_ext;
            vec![
                start.as_ref().map(|v| {
                    (
                        format!("{:?}_ext_{:?}", v, s.start_ext_anchor().orientation),
                        s.start_ext_path(),
                    )
                }),
                end.as_ref().map(|v| {
                    (
                        format!("{:?}_ext_{:?}", v, s.end_ext_anchor().orientation),
                        s.end_ext_path(),
                    )
                }),
            ]
        })
        .concat()
        .into_iter()
        .filter_map(|v| v)
        .unique()
        .collect::<Vec<_>>();

    let used_cores: Vec<_> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Secondary>())
        .map(|s| &s.core)
        .unique()
        .collect();
    let used_valences: Vec<_> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Tertiary>())
        .map(|s| &s.valence)
        .unique()
        .collect();
    let used_tertiary_extensions: Vec<_> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Tertiary>())
        .map(|s| vec![&s.top, &s.bottom])
        .concat()
        .into_iter()
        .unique()
        .collect();

    let has_quarternary = !characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Quarternary>())
        .collect::<Vec<_>>()
        .is_empty();
    let used_quarternary_tops: Vec<(&str, &str)> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Quarternary>())
        .map(|s| ("quarternary_${s.top.name}", s.top.path()))
        .collect();
    let used_quarternary_bottoms: Vec<(&str, &str)> = characters
        .iter()
        .filter_map(|v| v.as_any().downcast_ref::<Quarternary>())
        .map(|s| ("quarternary_${s.bottom.name}", s.bottom.path()))
        .collect();

    let mut char_images: Vec<String> = Vec::new();
    let mut left_coord: f64 = HORIZONTAL_PADDING;

    for character in characters.iter() {
        let center_y = VERTICAL_PADDING + UNIT_HEIGHT * 2.0;
        let (svg_string, svg_width) = character.get_svg(left_coord, center_y, &fill_color);
        char_images.push(svg_string);
        left_coord += svg_width + HORIZONTAL_GAP;
    }
    let char_images = char_images.join("\n");

    let base_width = left_coord - HORIZONTAL_GAP + HORIZONTAL_PADDING;

    let defs = [
        if has_quarternary {
            format!(
                r#"<path stroke="none" id="quarternary_core" d="{}" />"#,
                quarternary::CORE_PATH
            )
        } else {
            String::new()
        },
        used_specifications
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{:?}" d="{}" />"#, e, e.path()))
            .join("\n"),
        used_primary_tops
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{:?}" d="{}" />"#, e, e.path()))
            .join("\n"),
        used_a_anchors
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{}" d="{}" />"#, e.0, e.1))
            .join("\n"),
        used_b_anchors
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{}" d="{}" />"#, e.0, e.1))
            .join("\n"),
        used_c_anchors
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{}" d="{}" />"#, e.0, e.1))
            .join("\n"),
        used_d_anchors
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{}" d="{}" />"#, e.0, e.1))
            .join("\n"),
        used_cores
            .into_iter()
            .map(|e| {
                format!(
                    r#"<path stroke="none" id="{:?}_core" d="{}" />"#,
                    e,
                    e.path()
                )
            })
            .join("\n"),
        used_extensions
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{}" d="{}" />"#, e.0, e.1))
            .join("\n"),
        used_valences
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{:?}" d="{}" />"#, e, e.path()))
            .join("\n"),
        used_tertiary_extensions
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{:?}" d="{}" />"#, e, e.path()))
            .join("\n"),
        used_quarternary_tops
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{}" d="{}" />"#, e.0, e.1))
            .join("\n"),
        used_quarternary_bottoms
            .into_iter()
            .map(|e| format!(r#"<path stroke="none" id="{}" d="{}" />"#, e.0, e.1))
            .join("\n"),
    ]
    .join("\n");

    format!(
        r##"<svg width="{base_width}" height="{}">
            <defs>
                {defs}
            </defs>
            <rect x="0" y="0" height="{}" width="{base_width}" style="fill: transparent" />
            {char_images}
          </svg>"##,
        UNIT_HEIGHT * 6.0,
        UNIT_HEIGHT * 6.0,
    )
}
