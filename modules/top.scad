include<standards>;

use<safe.scad>;
use<shelf.scad>;
use<wall.scad>;
use<workbench.scad>;

module top() {
  sideWallLength = 24;
  backWallFullLength = 9 * 12;

  // Side wall
  translate([ 0, sideWallLength + drywallThickness, 0 ])
      rotate([ 0, 0, -90 ])
          wall(sideWallLength);

  // light switch wall
  translate([ two_by_four_depth + drywallThickness, 0, 0 ])
      wall(sideWallLength, 8 * 12, [ 1, 0 ]);

  // Back wall
  translate([ -backWallFullLength, sideWallLength, 0 ])
      rotate([ 0, 0, 0 ])
          wall(backWallFullLength + two_by_four_depth + drywallThickness, 8 * 12, [ 0, -1 ]);

  // Shelving
  translate([ 0, 0, 7 * 12 ])
      shelf();

  // Safe
  translate([ -28, 0, 0 ])
      safe();

  // workbench
  translate([ -8 * 12, 0, 0 ])
      workbench(48);
}

top();
