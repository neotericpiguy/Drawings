include<standards>;

use<twoByFour.scad>;

module lBracket(depth = 24, height = 18) {
  x = -0.25;  // Centering offset

  // Top plate
  translate([ -twoByFourHeight / 2 + x, 0, 0 ])
      rotate([ 90, 0, 90 ])
          twoByFour(depth);

  // Wall Plate
  translate([ -twoByFourHeight / 2 + x, 0, 0 ])
      rotate([ 0, 90, 0 ])
          twoByFour(height);

  // Diagonal thing
  diaganalLength_x = depth * 2 / 3;
  diaganalLength_y = depth * 2 / 3;

  diaganalLength = norm([ diaganalLength_y, diaganalLength_x ]);  // radial distance
  b = acos(diaganalLength_x / diaganalLength);                    // inclination angle
  c = atan2(diaganalLength_y, 0);                                 // azimuthal angle

  difference() {
    translate([ twoByFourWidth / 2 + x, 0, -diaganalLength_y ]) rotate([ 0, -b, 90 ])
        twoByFour(diaganalLength);

    translate([ -twoByFourWidth + x, twoByFourWidth, 0 ]) cube([ 2 * twoByFourWidth, 2 * diaganalLength_x, 2 * twoByFourHeight ]);
    translate([ -twoByFourWidth + x, -2 * twoByFourHeight, -2 * diaganalLength_y ]) cube([ 2 * twoByFourWidth, 2 * twoByFourHeight, 2 * diaganalLength_y ]);
  }
}

lBracket();
