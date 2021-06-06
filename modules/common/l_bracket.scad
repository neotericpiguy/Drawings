include<standards>;

use<two_by_four.scad>;

module l_bracket(depth = 24, height = 18) {
  x = -0.25;  // Centering offset

  // Top plate
  translate([ -two_by_four_depth / 2 + x, 0, 0 ])
      rotate([ 90, 0, 90 ])
          two_by_four(depth);

  // Wall Plate
  translate([ -two_by_four_depth / 2 + x, 0, 0 ])
      rotate([ 0, 90, 0 ])
          two_by_four(height);

  // Diagonal thing
  diaganalLength_x = depth * 2 / 3;
  diaganalLength_y = depth * 2 / 3;

  diaganalLength = norm([ diaganalLength_y, diaganalLength_x ]);  // radial distance
  b = acos(diaganalLength_x / diaganalLength);                    // inclination angle
  c = atan2(diaganalLength_y, 0);                                 // azimuthal angle

  difference() {
    translate([ two_by_four_height / 2 + x, 0, -diaganalLength_y ])
        rotate([ 0, -b, 90 ])
            two_by_four(diaganalLength);

    translate([ -two_by_four_height + x, two_by_four_height, 0 ]) cube([ 2 * two_by_four_height, 2 * diaganalLength_x, 2 * two_by_four_depth ]);
    translate([ -two_by_four_height + x, -2 * two_by_four_depth, -2 * diaganalLength_y ]) cube([ 2 * two_by_four_height, 2 * two_by_four_depth, 2 * diaganalLength_y ]);
  }
}

l_bracket();
