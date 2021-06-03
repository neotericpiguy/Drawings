include<lBracket.scad>;

module shelfUnit()
{
  backWallLength = backWallFullLength / 2 - twoByFourWidth + twoByFourWidth / 2;

  // Side wall
  rotate([ 0, 0, 90 ]) twoByFour(sideWallLength);

  // Back Wall 1
  translate([ -twoByFourWidth, sideWallLength, 0 ])
      rotate([ 0, 0, 180 ])
          twoByFour(backWallLength - twoByFourHeight);

  // Back Wall 2
  translate([ -twoByFourWidth - backWallLength, sideWallLength, 0 ])
      rotate([ 0, 0, 180 ])
          twoByFour(backWallLength - twoByFourHeight);

  // Middle bracket
  translate([ -backWallLength, sideWallLength, twoByFourHeight - twoByFourWidth ])
      rotate([ 0, 0, 180 ])
          lBracket();

  // End bracket
  translate([ -backWallLength - backWallLength, sideWallLength, twoByFourHeight - twoByFourWidth ])
      rotate([ 0, 0, 180 ])
          lBracket();

  // Shelf plate
  translate([ -backWallFullLength, 0, twoByFourHeight ]) 
    cube([ backWallFullLength, sideWallLength, 3 / 4 ]);
}

