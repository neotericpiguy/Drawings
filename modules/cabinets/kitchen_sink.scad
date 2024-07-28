include<cabinet_standards>;
use<base_cabinet.scad>;

// https://openscad.org/cheatsheet/

DOC_SCALING_FACTOR = 10;

include<dimlines>;

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

module kitchen_sink(countertop_width,
                    sink_width,
                    sink_depth,
                    sink_height,
                    cutout_width,
                    cutout_depth,
                    cutout_placement_depth) {
  countertop_height = 1.5;
  countertop_overhang = 1.5;
  countertop_depth = base_cabinet_depth + countertop_overhang;
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
    dimentor(countertop_width, countertop_depth, backsplash_height + countertop_height, 4);

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

  module sink(countertop_width = 36, sink_width = 33, sink_depth = 22, sink_height = 10, cutout_width = 31, cutout_depth = 17.8, cutout_placement_depth = 2) {
    // 33-31/2
    //
    lip = (sink_width - cutout_width) / 2;
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
    translate([ 0, 0, -sink_height + countertop_height ])
        dimentor(0, 0, sink_height, offset = -8);

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

  // Top View
  translate([ 0, 0, 0 ])
      sink(countertop_width,
           sink_width,
           sink_depth,
           sink_height,
           cutout_width,
           cutout_depth,
           cutout_placement_depth);
}

// https://www.homedepot.com/p/Glacier-Bay-33-in-Drop-In-Single-Bowl-18-Gauge-Gunmetal-black-Stainless-Steel-Workstation-Kitchen-Sink-with-Accessories-ACS3322A1TS/328548124#overlay
kitchen_sink(countertop_width = 36,
             sink_width = 33,
             sink_depth = 22,
             sink_height = 10,
             cutout_width = 31,
             cutout_depth = 17.8,
             cutout_placement_depth = 2);

// https://www.homedepot.com/p/HOROW-Drop-in-Stainless-Steel-33-in-Workstation-Ledge-Topmount-Kitchen-Sink-18-Gauge-2-Hole-Single-Bowl-with-Integrated-Ledge-HR-S3322UW/324822283#overlay
!kitchen_sink(countertop_width = 36,
              sink_width = 33,
              sink_depth = 22,
              sink_height = 10,
              cutout_width = 31,
              cutout_depth = 17,
              cutout_placement_depth = 2);
