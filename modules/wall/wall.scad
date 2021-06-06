include<standards>;

use<two_by_four.scad>;
use<wall_plate.scad>;
use<wall_studs.scad>;
use<wall_nail_plate.scad>;
use<drywall.scad>;

module wall(length, height = 8 * 12, drywallCoverage = [ 0, 0 ]) {
  // base plate
  wall_plate(length, two_by_four_height);

  // top plate
  // wall_plate(length, height);

  // Wall Studs
  wall_studs(length, height);

  // Drywall nail plate
  wall_nail_plate(length, height, drywallCoverage);

  // Interior Drywall
  drywall(length, height, drywallCoverage);
}

testLength = 4;

wall(testLength * 12, 8 * 12, [ 0, -1 ]);

translate([ testLength * 12 - two_by_four_depth - drywallThickness, drywallThickness, 0 ])
    rotate([ 0, 0, -90 ])
        wall(testLength * 12, 8 * 12, [ 0, 0 ]);

translate([ testLength * 12, -testLength * 12, 0 ])
    rotate([ 0, 0, 0 ])
        wall(testLength * 12, 8 * 12, [ 1, 1 ]);

translate([ 2 * testLength * 12 + drywallThickness + two_by_four_depth, -testLength * 12 + drywallThickness, 0 ])
    rotate([ 0, 0, 90 ])
        wall(testLength * 12, 8 * 12, [ 0, 0 ]);

translate([ testLength * 12 * 2, 0, 0 ])
    wall(testLength * 12, 8 * 12, [ -1, 0 ]);

translate([ testLength * 12, -testLength * 12 * 2, 0 ])
    rotate([ 0, 0, 0 ])
        wall(testLength * 12);
