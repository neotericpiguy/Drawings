include<standards>;

use<wall.scad>;
use<two_by_four.scad>;

module wall_cutout(width = 60, height = 8 * 12, heightFromFloor = 24, ceilingHeight = 8 * 12) {
  // Buffer is added to ensure no z fighting
  buffer = 2 * nothing;
  // buffer = 2;
  opening_cutout = (two_by_four_depth + drywallThickness) + buffer;
  stud_cutout = two_by_four_depth + buffer;
  trim_stud_and_king_stud_width = 2 * two_by_four_height + studCenters / 4;

  // opening
  // Cut out for studs in the way of opening
  // Centered in the 2x4 wall
  translate([ 0, -buffer / 2, heightFromFloor ]) {
    cube([ width, opening_cutout, height ]);
  }

  // In the plane of the front face of the 2x4 wall instead of drywall
  // and on top of the baseplate
//  translate([ 0, drywallThickness - buffer / 2, two_by_four_height ]) {
//    // Left King stud
//    translate([ -trim_stud_and_king_stud_width, 0, 0 ]) {
//      cube([ trim_stud_and_king_stud_width, stud_cutout, ceilingHeight - two_by_four_height * 2 + buffer ]);
//    }
//    translate([ -buffer, 0, heightFromFloor + height - two_by_four_height ]) {
//      cube([ trim_stud_and_king_stud_width + buffer, stud_cutout, ceilingHeight - two_by_four_height + buffer - height - heightFromFloor ]);
//    }
//
//    // Right King stud
//    translate([ width, 0, 0 ]) {
//      cube([ trim_stud_and_king_stud_width, stud_cutout, ceilingHeight - two_by_four_height * 2 + buffer ]);
//    }
//    translate([ width - trim_stud_and_king_stud_width, 0, heightFromFloor + height - two_by_four_height ]) {
//      cube([ trim_stud_and_king_stud_width + buffer, stud_cutout, ceilingHeight - two_by_four_height + buffer - height - heightFromFloor ]);
//    }
//
//    // Header Cutout
//    translate([ trim_stud_and_king_stud_width, 0, heightFromFloor + height - two_by_four_height ]) {
//      cube([ width - 2 * trim_stud_and_king_stud_width, stud_cutout, 6 ]);
//    }
//
//    if (heightFromFloor > 0)
//    {
//      // rough Sill
//      translate([ 0, 0, heightFromFloor - two_by_four_height * 3 ]) {
//        cube([ width, stud_cutout, two_by_four_height * 2 ]);
//      }
//    }
//  }
}

module window_frame(width = 60, height = 8 * 12, heightFromFloor = 24, ceilingHeight = 8 * 12) {
  // Bottom plate
  translate([ 0, two_by_four_depth + drywallThickness, heightFromFloor - two_by_four_height * 2 ]) {
    rotate([ 90, 0, 0 ]) {
      two_by_four(width);
    }
  }

  translate([ 0, two_by_four_depth + drywallThickness, heightFromFloor - two_by_four_height ]) {
    rotate([ 90, 0, 0 ]) {
      two_by_four(width);
    }
  }

  // Header
  translate([ -two_by_four_height, drywallThickness, heightFromFloor + height ]) {
    cube([ width + 2 * two_by_four_height, 3.5, 6 ]);
  }

  // Window Sill
  translate([ 0, -1, heightFromFloor ]) {
    cube([ width, 6, .75 ]);
  }

  // Sides
  translate([ 0, drywallThickness + two_by_four_depth, two_by_four_height ]) {
    rotate([ 90, -90, 0 ]) {
      two_by_four(height + heightFromFloor - two_by_four_height);
    }
  }

  translate([ width + two_by_four_height, drywallThickness + two_by_four_depth, two_by_four_height ]) {
    rotate([ 90, -90, 0 ]) {
      two_by_four(height + heightFromFloor - two_by_four_height);
    }
  }

  // King Studs
  translate([ -two_by_four_height, drywallThickness + two_by_four_depth, two_by_four_height ]) {
    rotate([ 90, -90, 0 ]) {
      two_by_four(ceilingHeight - two_by_four_depth + drywallThickness);
    }
  }
  translate([ width + two_by_four_height * 2, drywallThickness + two_by_four_depth, two_by_four_height ]) {
    rotate([ 90, -90, 0 ]) {
      two_by_four(ceilingHeight - two_by_four_depth + drywallThickness);
    }
  }
}

difference() {
  wall(8 * 12, 8 * 12, [ 0, 0 ]);
  translate([ (8 * 12 - 60) / 2, 0, 0 ]) {
    wall_cutout(60, 60, 24, 8 * 12);
  }
}

translate([ (8 * 12 - 60) / 2, 0, 0 ]) {
  window_frame(60, 60, 24, 8 * 12);
}
