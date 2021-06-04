include<standards.scad>;

use<lBracket.scad>;
use<twoByFour.scad>;

module shelfUnit(shelfLength = 8*12, shelfDepth = 24)
{
  backWallLength = shelfLength / 2 - twoByFourWidth + twoByFourWidth / 2;

  // Side wall
  rotate([ 0, 0, 90 ]) twoByFour(shelfDepth);

  // Back Wall 1
  translate([ -twoByFourWidth, shelfDepth, 0 ])
      rotate([ 0, 0, 180 ])
          twoByFour(backWallLength - twoByFourHeight);

  // Back Wall 2
  translate([ -twoByFourWidth - backWallLength, shelfDepth, 0 ])
      rotate([ 0, 0, 180 ])
          twoByFour(backWallLength - twoByFourHeight);

  // Middle bracket
  translate([ -backWallLength, shelfDepth, twoByFourHeight - twoByFourWidth ])
      rotate([ 0, 0, 180 ])
          lBracket();

  // End bracket
  translate([ -backWallLength - backWallLength, shelfDepth, twoByFourHeight - twoByFourWidth ])
      rotate([ 0, 0, 180 ])
          lBracket();

  // Shelf plate
  translate([ -shelfLength, 0, twoByFourHeight ])
      cube([ shelfLength, shelfDepth, 3 / 4 ]);
}

shelfUnit();
