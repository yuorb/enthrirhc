mod components;
mod categories;

use as_any::AsAny;

use self::{
    components::{ComponentA, ComponentB, ComponentC, ComponentD},
    categories::*,
};

use super::{
    utils::{get_core_boundary, get_component_boundary},
    Character,
};

#[derive(Debug)]
pub struct Primary {
    pub(crate) specification: Specification,
    pub(crate) context: Context,
    // Properties for A Anchor
    pub(crate) essence: Essence,
    pub(crate) affiliation: Affiliation,
    // Properties for B Anchor
    pub(crate) perspective: Perspective,
    pub(crate) extension: Extension,
    // Properties for C Anchor
    pub(crate) separability: Separability,
    pub(crate) similarity: Similarity,
    // Properties for D Anchor
    pub(crate) function: Function,
    pub(crate) version: Version,
    pub(crate) plexity: Plexity,
    pub(crate) stem: Stem,
}

impl Primary {
    fn get_boundary(&self) -> (f64, f64) {
        let (core_left, core_right) =
            get_core_boundary(self.specification.path());

        let anchor_a_path = self.component_a().path();
        let anchor_b_path = self.component_b().path();
        let anchor_c_path = self.component_d().path();
        let anchor_d_path = self.component_d().path();

        let (anchor_a_left, anchor_a_right) = get_component_boundary(anchor_a_path);
        let (anchor_b_left, anchor_b_right) = get_component_boundary(anchor_b_path);
        let (anchor_c_left, anchor_c_right) = get_component_boundary(anchor_c_path);
        let (anchor_d_left, anchor_d_right) = get_component_boundary(anchor_d_path);

        let left = [
            core_left,
            self.specification.center_x() + anchor_a_left,
            self.specification.anchor_b().x + anchor_b_left,
            self.specification.center_x() + anchor_c_left,
            self.specification.anchor_d().x + anchor_d_left,
        ]
        .into_iter()
        .reduce(f64::min)
        .unwrap();
        let right = [
            core_right,
            self.specification.center_x() + anchor_a_right,
            self.specification.anchor_b().x + anchor_b_right,
            self.specification.center_x() + anchor_c_right,
            self.specification.anchor_d().x + anchor_d_right,
        ]
        .into_iter()
        .reduce(f64::max)
        .unwrap();

        return (left, right);
    }

    pub(crate) fn component_a(&self) -> ComponentA {
        ComponentA {
            essence: self.essence,
            affiliation: self.affiliation,
        }
    }

    pub(crate) fn component_b(&self) -> ComponentB {
        ComponentB {
            perspective: self.perspective,
            extension: self.extension,
        }
    }

    pub(crate) fn component_c(&self) -> ComponentC {
        ComponentC {
            similarity: self.similarity,
            separability: self.separability,
        }
    }

    pub(crate) fn component_d(&self) -> ComponentD {
        ComponentD {
            function: self.function,
            version: self.version,
            plexity: self.plexity,
            stem: self.stem,
        }
    }
}

impl Character for Primary {
    fn get_svg(&self, base_x: f64, base_y: f64, fill_color: &str) -> (String, f64) {
        let (left, right) = self.get_boundary();
        let width = right - left;

        let specification_x = base_x - left;
        let specification_y = base_y;
        let top_x = specification_x + self.specification.center_x();
        let top_y = specification_y;
        let anchor_a_x = specification_x + self.specification.center_x();
        let anchor_a_y = specification_y;
        let anchor_b_x = specification_x + self.specification.anchor_b().x;
        let anchor_b_y = specification_y + self.specification.anchor_b().y;
        let anchor_c_x = specification_x + self.specification.center_x();
        let anchor_c_y = specification_y;
        let anchor_d_x = specification_x + self.specification.anchor_d().x;
        let anchor_d_y = specification_y + self.specification.anchor_d().y;

        let specification_name = format!("{:?}", self.specification);
        let top_name = format!("{:?}", self.context);
        let anchor_a_name = format!("{:?}_{:?}", self.essence, self.affiliation);
        let anchor_b_name = format!("{:?}_{:?}", self.perspective, self.extension);
        let anchor_c_name = format!("{:?}_{:?}", self.separability, self.similarity);
        let anchor_d_name = format!(
            "{:?}_{:?}_{:?}_{:?}",
            self.function, self.version, self.essence, self.affiliation
        );

        (
            format!(
                r##"
                    <use href="#{specification_name}" x="{specification_x}" y="{specification_y}" fill="{fill_color}" />
                    <use href="#{top_name}" x="{top_x}" y="{top_y}" fill="{fill_color}" />
                    <use href="#{anchor_a_name}" x="{anchor_a_x}" y="{anchor_a_y}" fill="{fill_color}" />
                    <use href="#{anchor_b_name}" x="{anchor_b_x}" y="{anchor_b_y}" fill="{fill_color}" />
                    <use href="#{anchor_c_name}" x="{anchor_c_x}" y="{anchor_c_y}" fill="{fill_color}" />
                    <use href="#{anchor_d_name}" x="{anchor_d_x}" y="{anchor_d_y}" fill="{fill_color}" />
                "##
            ),
            width,
        )
    }
}

impl AsAny for Primary {
    fn as_any(&self) -> &dyn std::any::Any {
        self
    }
}
