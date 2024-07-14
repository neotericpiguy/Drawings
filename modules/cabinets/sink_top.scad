include<cabinet_standards>;
use<kitchen_sink.scad>;

// https://openscad.org/cheatsheet/

module kitchen_sink_top(countertop_width = 36,
                        sink_width = 33,
                        sink_depth = 22,
                        sink_height = 10,
                        cutout_width = 31,
                        cutout_depth = 17.8,
                        cutout_placement_depth = 2) {
  kitchen_sink(countertop_width,
               sink_width,
               sink_depth,
               sink_height,
               cutout_width,
               cutout_depth,
               cutout_placement_depth);

  // Front View
  translate([ 0, -20, 0 ])
      rotate([ -90, 0, 0 ])
          kitchen_sink(countertop_width,
                       sink_width,
                       sink_depth,
                       sink_height,
                       cutout_width,
                       cutout_depth,
                       cutout_placement_depth);

  //  // Side View 90,0,90
  translate([ 48, -20, 0 ])
      rotate([ -90, -90, 0 ])
          kitchen_sink(countertop_width,
                       sink_width,
                       sink_depth,
                       sink_height,
                       cutout_width,
                       cutout_depth,
                       cutout_placement_depth);

  details = [[cols [0] + desc_x, rows [0] + det_y, DIM_HORZ, " ", 1],         // Responsible dep.
             [cols [1] + desc_x, rows [0] + det_y, DIM_HORZ, " ", 1],         // Technical reference
             [cols [2] + desc_x, rows [0] + det_y, DIM_HORZ, "J. Annua", 1],  // Creator
             [cols [3] + desc_x, rows [0] + det_y, DIM_HORZ, " ", 1],         // Approval person
             [cols [0] + desc_x + 10, rows [2] + det_y, DIM_HORZ, "Sink project", 1],
             [cols [2] + desc_x, rows [1] + det_y, DIM_HORZ, " ", 1],                // Document type
             [cols [3] + desc_x, rows [1] + det_y, DIM_HORZ, "Initial Release", 1],  // Document status
             [cols [2] + desc_x, rows [2] + det_y, DIM_HORZ, " ", 1],                // Title
             [cols [3] + desc_x, rows [2] + det_y, DIM_HORZ, "123", 1],              // Identification number
             [cols [3] + desc_x, rows [3] + det_y, DIM_HORZ, " ", 1],                // Rev
             [cols [4] + desc_x, rows [3] + det_y, DIM_HORZ, " ", 1],                // Date of issue
             [cols [5] + desc_x, rows [3] + det_y, DIM_HORZ, "1/1", 1]               // Sheet
  ];

  translate([ 42, 24.5, 0 ])
      titleblock(lines, descs, details);
}

// https://www.homedepot.com/p/HOROW-Drop-in-Stainless-Steel-33-in-Workstation-Ledge-Topmount-Kitchen-Sink-18-Gauge-2-Hole-Single-Bowl-with-Integrated-Ledge-HR-S3322UW/324822283#overlay
kitchen_sink_top(countertop_width = 36,
                 sink_width = 33,
                 sink_depth = 22,
                 sink_height = 10,
                 cutout_width = 31,
                 cutout_depth = 17,
                 cutout_placement_depth = 2);
// kitchen_sink(countertop_width = 36,
//                         sink_width = 33,
//                         sink_depth = 22,
//                         sink_height = 10,
//                         cutout_width = 31,
//                         cutout_depth = 17.8,
//                         cutout_placement_depth = 2) {
// }
