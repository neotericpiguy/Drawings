include<standards>;

use<wall.scad>;

module office() {
  westWallLength = 12 * 12;
  southWallLength = 8 * 12;
  eastWallLength = westWallLength;
  northWallLength = southWallLength;
  wallHeight = 8 * 12;

  // West Wall
  translate([ 0, 0, 0 ])
      rotate([ 0, 0, 90 ])
          wall(westWallLength, wallHeight, [ 0, 0 ]);

  // South Wall with Window
  translate([ southWallLength + 1 * (two_by_four_depth + drywallThickness), drywallThickness, 0 ])
      rotate([ 0, 0, 180 ])
          wall(southWallLength + 2 * (two_by_four_depth + drywallThickness), wallHeight, [ -1, -1 ]);

  // East Wall
  translate([ southWallLength, eastWallLength, 0 ])
      rotate([ 0, 0, -90 ])
          wall(eastWallLength, wallHeight, [ 0, 0 ]);

  // North Wall with Window
  translate([ -two_by_four_depth - drywallThickness, westWallLength - drywallThickness, 0 ])
      rotate([ 0, 0, 0 ])
          wall(northWallLength + 2 * (two_by_four_depth + drywallThickness), wallHeight, [ -1, -1 ]);
}

office();
