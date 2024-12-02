include<standards>;

use<wall.scad>;
use<two_by_four.scad>;

module window_cutout(width = 60, height = 8 * 12,heightFromFloor=24) {
  buffer = 3;
  cutout = (two_by_four_depth + drywallThickness) + buffer;

  translate([ 0, 0, 0])
      cube([ width+2*two_by_four_height, two_by_four_depth+drywallThickness, two_by_four_height]);

  // Added for projections
  translate([ 0, -buffer / 2, heightFromFloor])
      cube([ width+2*two_by_four_height, cutout, height+2*two_by_four_height ]);
}

module window_frame(width = 60, height = 8 * 12, heightFromFloor=24) {
  translate([0,0,heightFromFloor])
  {
    // Bottom plate
    translate([0,two_by_four_depth,0])
      rotate([90,0,0])
        two_by_four(width+(2*two_by_four_height));

    // Top plate
    translate([0,two_by_four_depth,height+two_by_four_height])
      rotate([90,0,0])
        two_by_four(width+(2*two_by_four_height));

    // left plate
    translate([two_by_four_height,two_by_four_depth,two_by_four_height])
      rotate([90,-90,0])
        two_by_four(height);

    // right Plate
    translate([width+(2*two_by_four_height),two_by_four_depth,two_by_four_height])
      rotate([90,-90,0])
        two_by_four(height);

    }
    
    // Added for projections
    translate([0, (drywallThickness+two_by_four_depth-two_by_four_height)/2,0])
      rotate([0,0,0])
      two_by_four(width+2*two_by_four_height);
}

difference() {
  wall(8 * 12, 8 * 12, [ 0, 0 ]);
  translate([ (8 * 12 - 60) / 2, 0, 0 ])
      window_cutout(60, 60,24);
}

translate([ (8 * 12 - 60) / 2, 0, 0 ])
  window_frame(60, 60, 24);
