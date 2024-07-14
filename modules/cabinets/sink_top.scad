include<cabinet_standards>;
use<base_cabinet.scad>;

// https://openscad.org/cheatsheet/

DOC_SCALING_FACTOR = 10;

include<dimlines>;

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

module kitchen_sink(doorAngle = 60, overal_width = 36, overall_depth = 24, height = 34.5) {
  countertop_height = 1.5;
  countertop_overhang = 1.5;
  countertop_depth = overall_depth + countertop_overhang;
  cutout_thickness = countertop_height * 1.0;

  module countertop(countertop_width = 36, sink_width = 33, sink_depth = 22, cutout_width = 31, cutout_depth = 17.8, cutout_placement_depth = 2) {
    backsplash_depth = 1;
    backsplash_height = 3.5;
    side_countertop_strip_width = (countertop_width - cutout_width) / 2;

    // Cut out cube for reference
    // #translate([ (countertop_width - cutout_width) / 2, countertop_overhang, countertop_height / 2 - cutout_thickness / 2 ])
    //    translate([ (countertop_width - cutout_width) / 2, cutout_placement_depth, countertop_height / 2 - cutout_thickness / 2 ])
    //        cutout(cutout_width, cutout_depth);

    // Backsplash
    translate([ 0, countertop_depth - backsplash_depth, countertop_height ])
        cube([ countertop_width, backsplash_depth, backsplash_height ]);

    // left
    cube([ side_countertop_strip_width, countertop_depth, countertop_height ]);

    // right
    translate([ side_countertop_strip_width + cutout_width, 0, 0 ])
        cube([ side_countertop_strip_width, countertop_depth, countertop_height ]);

    // back
    translate([ side_countertop_strip_width, cutout_depth + cutout_placement_depth, 0 ])
        cube([ cutout_width, countertop_depth - cutout_depth - cutout_placement_depth, countertop_height ]);

    // front
    translate([ side_countertop_strip_width, 0, 0 ])
        cube([ cutout_width, cutout_placement_depth, countertop_height ]);

    // Outside dimension
    dimentor(countertop_width, countertop_depth, 0, 4);

    // cutout dimensions
    translate([ side_countertop_strip_width, cutout_placement_depth, 0 ])
        dimentor(cutout_width, cutout_depth, 0, -2);

    // cutout_placement_depth
    translate([ 0, 0, 0 ])
        dimentor(0, cutout_placement_depth, 0);
    translate([ 0, countertop_depth - (countertop_depth - cutout_depth - cutout_placement_depth), 0 ])
        dimentor(0, countertop_depth - cutout_depth - cutout_placement_depth, 0);

    // Center line
    translate([ countertop_width - side_countertop_strip_width - (cutout_width / 2), cutout_placement_depth + (cutout_depth / 2), 0 ])
        dimentor(cutout_width / 2, 0, 0, 0);
  }

  module glacier_bay(countertop_width = 36) {
    // https://www.homedepot.com/p/Glacier-Bay-Dolancourt-Tight-Radius-33-in-Drop-In-Single-Bowl-18G-Stainless-Steel-Workstation-Kitchen-Sink-with-Spring-Neck-Faucet-FSD2R3322B1SA1/323275403#overlay
    cutout_depth = 21 + 3 / 8;
    cutout_width = 32 + 3 / 8;

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

  module sink(countertop_width = 36, sink_width = 33, sink_depth = 22, sink_height = 10, lip = 1, cutout_width = 31, cutout_depth = 17.8, cutout_placement_depth = 2) {
    // 33-31/2
    //
    lip = (sink_width - cutout_width) / 2,
    lip_height = 1 / 8;

    bowl_width = cutout_width;
    bowl_depth = cutout_depth;

    countertop(countertop_width, sink_width, sink_depth, cutout_width, cutout_depth, cutout_placement_depth);

    // Bowl
    color([ 0, 0, 0, 0.1 ]) {
      translate([ (countertop_width - sink_width) / 2, cutout_placement_depth - lip, countertop_height ])
          cube([ sink_width, sink_depth, lip_height ]);
      translate([ (countertop_width - cutout_width) / 2, cutout_placement_depth - lip, countertop_height - sink_height ])
          cube([ bowl_width, bowl_depth, sink_height ]);
    }

    // sink Width
    translate([ (countertop_width - sink_width) / 2, 0, 0 ])
        dimentor(sink_width, 0, 0, -2);

    // sink depth
    translate([ countertop_width, cutout_placement_depth - lip, 0 ])
        dimentor(0, sink_depth, 0, -2);

    // Sink to front of countertop
    translate([ countertop_width, 0, 0 ])
        dimentor(0, cutout_placement_depth - lip, 0, -2);

    // backsplash to sink
    translate([ countertop_width, countertop_depth - (countertop_depth - (cutout_placement_depth - lip + sink_depth)), 0 ])
        dimentor(0, countertop_depth - (cutout_placement_depth - lip + sink_depth), 0, offset = -2, side = 2);
  }

  module cutout(width, depth) {
    cube([ width, depth, cutout_thickness ]);
  }

  // Exterior
  //  translate([ 0, countertop_overhang, 0 ])
  //      base_cabinet(36);

  // translate([ 0, 0, 34.5 ])
  sink(countertop_width = 36,
       sink_width = 33,
       sink_depth = 22,
       sink_height = 10,
       cutout_width = 31,
       cutout_depth = 17.8,
       cutout_placement_depth = 2);

  // glacier_bay(36);
}

kitchen_sink();
