include<standards>;

use<wall.scad>;

module double_door(width = 60, height = 8 * 12) {
  buffer = 3;
  cutout = (two_by_four_depth + drywallThickness) + buffer;

  translate([ 0, -buffer / 2, 0 ]) {
    cube([ width, cutout, height ]);
  }
}

module double_door_doors(width = 60, height = 8 * 12) {
  buffer = 3;
  cutout = (two_by_four_depth + drywallThickness) + buffer;
  doorThickness = 1.5;
  angle = 30;

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
  wall(8 * 12, 8 * 12, [ 0, 0 ]);
  translate([ (8 * 12 - 60) / 2, 0, 0 ]) {
    double_door(60, 7 * 12);
  }
}

translate([ (8 * 12 - 60) / 2, 0, 0 ]) {
  double_door_doors(60, 7 * 12);
}

