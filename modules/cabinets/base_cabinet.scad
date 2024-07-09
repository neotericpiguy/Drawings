include<cabinet_standards>;
use<faceframe.scad>;
use<platform.scad>;

// https://openscad.org/cheatsheet/

DOC_SCALING_FACTOR = 10;

include<dimlines>;

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

dimOn = false;

module base_cabinet(base_cabinet_width = 24, base_cabinet_depth = 24, base_cabinet_height = 34.5, wallThickness = 2) {
  ear = 0.25;
  toekick_height = 3.5;
  toekick_depth = 3.5;

  rail_height = 1.75;
  rail_thickness = 0.75;

  stile_width = 1.75;
  stile_height = base_cabinet_height - toekick_height;
  stile_thickness = 0.75;

  box_thickness = 0.75;
  box_width = base_cabinet_width - 2 * ear;
  box_depth = base_cabinet_depth - stile_thickness;
  box_height = stile_height;

  module box() {
    // Left Side
    cube([ box_thickness, box_depth, box_height ]);

    // Right Side
    translate([ box_width - box_thickness, 0, 0 ])
        cube([ box_thickness, box_depth, box_height ]);

    // Floor
    translate([ box_thickness, 0, stile_thickness ])
        cube([ box_width - 2 * box_thickness, box_depth, box_thickness ]);

    // Backing
    translate([ box_thickness, box_depth - box_thickness, box_height - 2 * rail_height ])
        cube([ box_width - 2 * box_thickness, box_thickness, 2 * rail_height ]);
  }

  translate([ 0, 0, base_cabinet_height - stile_height ])
      faceframe();
  translate([ ear, toekick_depth, 0 ])
      platform(36);
  translate([ ear, stile_thickness, toekick_height ])
      box();
}

// Exterior
base_cabinet(36);
