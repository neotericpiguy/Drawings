include<standards>;

use<safe.scad>;
use<shelfUnit.scad>;
use<wall.scad>;

module workbench() {
  sideWallLength = 24;
  backWallFullLength = 9 * 12;

  // Side wall
  translate([ 0, sideWallLength + drywallThickness, 0 ])
      rotate([ 0, 0, -90 ])
          wall(sideWallLength);

  // light switch wall
  translate([ twoByFourDepth + drywallThickness, 0, 0 ])
      wall(sideWallLength, 8 * 12, [ 1, 0 ]);

  // Back wall
  translate([ -backWallFullLength, sideWallLength, 0 ])
      rotate([ 0, 0, 0 ])
          wall(backWallFullLength + twoByFourDepth + drywallThickness, 8 * 12, [ 0, -1 ]);

  // Shelving
  translate([ 0, 0, 72 ])
      shelfUnit();

  // Safe
  translate([ -28, 0, 0 ])
      safe();
}

workbench();
