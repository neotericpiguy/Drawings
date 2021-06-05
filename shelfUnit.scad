include<standards>;

use<lBracket.scad>;
use<twoByFour.scad>;

module shelfUnit(shelfLength = 8 * 12, shelfDepth = 24) {
  backWallLength = shelfLength / 2 - twoByFourHeight + twoByFourHeight / 2;

  // Side wall
  rotate([ 0, 0, 90 ]) twoByFour(shelfDepth);

  // Back Wall 1
  translate([ -twoByFourHeight, shelfDepth, 0 ])
      rotate([ 0, 0, 180 ])
          twoByFour(backWallLength - twoByFourDepth);

  // Back Wall 2
  translate([ -twoByFourHeight - backWallLength, shelfDepth, 0 ])
      rotate([ 0, 0, 180 ])
          twoByFour(backWallLength - twoByFourDepth);

  // Middle bracket
  translate([ -backWallLength, shelfDepth, twoByFourDepth - twoByFourHeight ])
      rotate([ 0, 0, 180 ])
          lBracket();

  // End bracket
  translate([ -backWallLength - backWallLength, shelfDepth, twoByFourDepth - twoByFourHeight ])
      rotate([ 0, 0, 180 ])
          lBracket();

  // Shelf plate
  translate([ -shelfLength, 0, twoByFourDepth ])
      cube([ shelfLength, shelfDepth, 3 / 4 ]);
}

shelfUnit();
