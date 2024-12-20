include<standards>;

use<wall.scad>;
use<two_by_four.scad>;
use<window.scad>;

module double_door_frame(width = 60, height = 8 * 12, ceilingHeight = 8 * 12, type = "hinged") {
  doorThickness = 1.5;
  angle = 30;

  //  translate([ 0, drywallThickness, two_by_four_height ]) {
  //    rotate([ 0, -90, -90 ]) {
  //      // King stud
  //      translate([ 0, -two_by_four_height * 2, 0 ]) {
  //        two_by_four(ceilingHeight - 2 * two_by_four_height);
  //      }
  //      // Left trim stud
  //      translate([ 0, -two_by_four_height, 0 ]) {
  //        two_by_four(height - two_by_four_height);
  //      }
  //
  //      // King stud
  //      translate([ 0, width + two_by_four_height, 0 ]) {
  //        two_by_four(ceilingHeight - 2 * two_by_four_height);
  //      }
  //      // Right trim stud
  //      translate([ 0, width, 0 ]) {
  //        two_by_four(height - two_by_four_height);
  //      }
  //    }
  //
  //    // Header
  //    translate([ -two_by_four_height, 0, height - two_by_four_height ]) {
  //      cube([ width + 2 * two_by_four_height, two_by_four_depth, 6 ]);
  //    }
  //  }

  if (type == "hinged" || type == "-hinged")
  {
    // Doors
    if (width > 36)
    {
      rotate([ 0, 0, -angle ]) {
        cube([ width / 2, doorThickness, height ]);
      }
    }
    else
    {
      if (type == "hinged")
      {
        rotate([ 0, 0, -angle ]) {
          cube([ width, doorThickness, height ]);
        }
      }
      else
      {
        translate([ width, 0, 0]) {
          rotate([ 0, 0, angle ]) {
            mirror([ 1, 0, 0 ]) {
              cube([ width, doorThickness, height ]);
            }
          }
        }
      }
    }
  }
  else if (type == "sliding")
  {
    opening = 6;
    door_over_length = 0.75;
    translate([ 0, 0, 0 * 12 ]) {
      cube([ (width / 2) + door_over_length, doorThickness, height ]);

      translate([ width - opening, doorThickness, 0 ]) {
        mirror([ 1, 0, 0 ]) {
          cube([ width / 2 + door_over_length, doorThickness, height ]);
        }
      }
    }
  }
}

difference() {
  wall(8 * 12, 10 * 12, [ 0, 0 ]);
  translate([ (8 * 12 - 60) / 2, 0, 0 ]) {
    wall_cutout(60, 7 * 12, 0, 10 * 12);
  }
}

translate([ (8 * 12 - 60) / 2, 0, 0 ]) {
  double_door_frame(60, 7 * 12, 10 * 12);
}

