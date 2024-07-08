include<standards>;

// https://openscad.org/cheatsheet/

DOC_SCALING_FACTOR = 10;

include<dimlines>;

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

dimOn = false;

module kitchen_sink(doorAngle = 60, overal_width = 36, overall_depth = 24, height = 34.5) {
  module base_cabinet(base_cabinet_width = 24, base_cabinet_depth = 24, base_cabinet_height = 34.5, wallThickness = 2) { ear = 0.25;
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

    module faceframe() {
      // Left Stile
      cube([ stile_width, stile_thickness, stile_height ]);

      // Right Stile
      translate([ base_cabinet_width - stile_width, 0, 0 ])
          cube([ stile_width, stile_thickness, stile_height ]);

      // Top Rail
      translate([ stile_width, 0, stile_height - rail_height ])
          cube([ base_cabinet_width - stile_width * 2, rail_thickness, rail_height ]);

      // Bottom Rail
      translate([ stile_width, 0, 0 ])
          cube([ base_cabinet_width - stile_width * 2, rail_thickness, rail_height ]);

      if (dimOn)
      {
        color([ 0, 0, 0 ]) {
          translate([ 0, 0, base_cabinet_height ])
              rotate([ 90, 0, 0 ])
                  dimensions(base_cabinet_width);

          translate([ -DIM_LINE_WIDTH, 0, 0 ])
              rotate([ 90, -90, 0 ])
                  dimensions(stile_height);
        }
      }
    }

    module platform() {
      platform_depth = base_cabinet_depth - toekick_depth;
      platform_height = toekick_height;
      platform_width = base_cabinet_width - 2 * ear;
      // platform
      cube([ platform_width, platform_depth, platform_height ]);

      if (dimOn)
      {
        color([ 0, 0, 0 ]) {
          translate([ 0, 0, base_cabinet_height ])
              rotate([ 90, 0, 0 ])
                  dimensions(base_cabinet_width);

          translate([ -DIM_LINE_WIDTH, 0, 0 ])
              rotate([ 90, -90, 0 ])
                  dimensions(stile_height);
        }
      }
    }

    translate([ 0, 0, base_cabinet_height - stile_height ])
        faceframe();
    translate([ ear, toekick_depth, 0 ])
        platform();
    translate([ ear, stile_thickness, toekick_height ])
        box();
  }

  countertop_height = 1.5;
  countertop_overhang = 1.5;
  countertop_depth = overall_depth + countertop_overhang;

  module countertop(countertop_width = 24) {
    backsplash_depth = 1;
    backsplash_height = 3.5;

    // Deck
    translate([ 0, -countertop_depth, 0 ])
        cube([ countertop_width, countertop_depth, countertop_height ]);
    if (dimOn)
    {
      color([ 0, 0, 0 ]) {
        translate([ 0, DIM_LINE_WIDTH * 3, 0 ])
            dimensions(countertop_width);
        translate([ -2, -countertop_depth, 0 ])
            rotate([ 0, 0, 90 ])
                dimensions(countertop_depth);
      }
    }

    // Backsplash
    translate([ 0, -backsplash_depth, countertop_height ])
        cube([ countertop_width, backsplash_depth, backsplash_height ]);
  }

  module glacier_bay(countertop_width = 36) {
    // https://www.homedepot.com/p/Glacier-Bay-Dolancourt-Tight-Radius-33-in-Drop-In-Single-Bowl-18G-Stainless-Steel-Workstation-Kitchen-Sink-with-Spring-Neck-Faucet-FSD2R3322B1SA1/323275403#overlay
    cutout_depth = 21 + 3 / 8;
    cutout_width = 32 + 3 / 8;
    cutout_thickness = countertop_height * 1.1;

    overall_width = 33;
    overall_depth = 22;

    bowl_width = 30 + 1 / 4;
    bowl_depth = 16 + 5 / 8;
    bowl_height = 9;

    bowl_thickness = 0.0478;

    difference() {
      countertop(countertop_width);

      // cutout
      translate([ (countertop_width - cutout_width) / 2, -countertop_depth + countertop_overhang, countertop_height / 2 - cutout_thickness / 2 ])
          cube([ cutout_width, cutout_depth, cutout_thickness ]);
    }

    if (dimOn)
    {
      color([ 0, 0, 0 ]) {  // Dimension lines
        translate([ (countertop_width - cutout_width) / 2, -countertop_depth + countertop_overhang + DIM_LINE_WIDTH * 3, countertop_height / 2 - cutout_thickness / 2 ])
            dimensions(cutout_width);
        translate([ countertop_width + DIM_LINE_WIDTH * 3, -countertop_depth + countertop_overhang, 0 ])
            rotate([ 0, 0, 90 ])
                dimensions(cutout_depth);

        // Center
        translate([ (countertop_width - cutout_width) / 2, -countertop_depth / 2, countertop_height / 2 - cutout_thickness / 2 ])
            dimensions(cutout_width / 2);
      }
    }

    // Bowl
    //    translate([ (countertop_width - overall_width) / 2, 0, height - bowl_height + countertop_height ])
    //        cube([ overall_width, overall_depth, bowl_height + bowl_thickness ]);
  }

  // Exterior
  base_cabinet(36);
  // translate([ 0, 24, 34.5 ])
  //     glacier_bay(36);
  //   A sample used to create the image above.
}

kitchen_sink();
