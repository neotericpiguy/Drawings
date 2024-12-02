include<standards>;

use<wall.scad>;
use<two_by_four.scad>;

module double_door_cutout(width = 60, height = 8 * 12, ceilingHeight = 8 * 12) {
  buffer = 2 * nothing;
  cutout = two_by_four_depth + buffer;
  overspan = studCenters;

  translate([ 0, drywallThickness - nothing, 0 ]) {
    translate([ 0, -cutout / 2, 0 ]) {
      cube([ width, cutout * 2, height ]);
    }

    // Remove base plate
    cube([ width + buffer, cutout, two_by_four_height + nothing ]);

    // Cutout for trim and king studs
    translate([ -overspan / 2, 0, two_by_four_height - nothing ]) {
      cube([ width + overspan, cutout, height + 6 - two_by_four_height ]);
    }

    // Remove top area plate
    translate([ -overspan / 2, 0, height + 6 ]) {
      cube([ overspan, cutout, ceilingHeight - height - 6 - 1 * two_by_four_height + nothing ]);
    }
    translate([ width - overspan / 2, 0, height + 6 ]) {
      cube([ overspan, cutout, ceilingHeight - height - 6 - 1 * two_by_four_height + nothing ]);
    }
  }
}

module double_door_frame(width = 60, height = 8 * 12, ceilingHeight = 8 * 12) {
  doorThickness = 1.5;
  angle = 30;

  translate([ 0, drywallThickness, two_by_four_height ]) {
    rotate([ 0, -90, -90 ]) {
      // King stud
      translate([ 0, -two_by_four_height * 2, 0 ]) {
        two_by_four(ceilingHeight - 2 * two_by_four_height);
      }
      // Left trim stud
      translate([ 0, -two_by_four_height, 0 ]) {
        two_by_four(height);
      }

      // King stud
      translate([ 0, width + two_by_four_height, 0 ]) {
        two_by_four(ceilingHeight - 2 * two_by_four_height);
      }
      // Right trim stud
      translate([ 0, width, 0 ]) {
        two_by_four(height);
      }
    }

    // Header
    translate([ -two_by_four_height, 0, height - two_by_four_height ]) {
      cube([ width + 2 * two_by_four_height, two_by_four_depth, 6 ]);
    }
  }

  // Doors
  rotate([ 0, 0, -angle ]) {
    cube([ width / 2, doorThickness, height ]);
  }

  translate([ width, 0, 0 ]) {
    rotate([ 0, 0, angle ]) {
      mirror([ 1, 0, 0 ]) {
        cube([ width / 2, doorThickness, height ]);
      }
    }
  }
}

difference() {
  wall(8 * 12, 10 * 12, [ 0, 0 ]);
  translate([ (8 * 12 - 60) / 2, 0, 0 ]) {
    double_door_cutout(60, 7 * 12, 10 * 12);
  }
}

translate([ (8 * 12 - 60) / 2, 0, 0 ]) {
  double_door_frame(60, 7 * 12, 10 * 12);
}

