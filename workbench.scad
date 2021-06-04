include<standards>;

use<shelfUnit.scad>;
use<wall.scad>;
use<safe.scad>;

module workbench()
{
  sideWallLength = 24;
  backWallFullLength = 9 * 12;
  // Side wall
  translate([ 0, sideWallLength, 0 ])
      rotate([ 0, 0, -90 ])
          wall(sideWallLength);

  // Back wall
  translate([ -backWallFullLength, sideWallLength, 0 ])
      rotate([ 0, 0, 0 ])
          wall(backWallFullLength);

  // Shelving
  translate([ 0, 0, 72 ])
      shelfUnit();

  translate([ -28, 0, 0 ])
      safe();
}

workbench();
