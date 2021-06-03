include<lBracket.scad>;

sideWallLength = 24;
backWallFullLength = 96;

enableDrywall = 1;

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
  translate([ -12 * 8, 0, twoByFourHeight ]) cube([ 12 * 8, sideWallLength, 3 / 4 ]);
}

module wall(length, height = 8 * 12)
{
  studCenters = 16;
  drywallThickness = 1 / 2;
  for (x = [0:studCenters:length])
  {
    translate([ x, drywallThickness, 0 ])
        rotate([ 0, -90, -90 ])
            twoByFour(height);
  }

  // Landed on an un even stud center
  if (length % studCenters != 0)
  {
    translate([ length - twoByFourWidth, drywallThickness, 0 ])
        rotate([ 0, -90, -90 ])
            twoByFour(height);
  }

  // Drywall
  if (enableDrywall)
    cube([ length, drywallThickness, height ]);
}

// Side wall
translate([ 0, sideWallLength, 0 ]) rotate([ 0, 0, -90 ]) wall(sideWallLength);

// Back wall
translate([ -backWallFullLength, sideWallLength, 0 ]) rotate([ 0, 0, 0 ]) wall(backWallFullLength);

// Shelving
translate([ 0, 0, 72 ]) 
  shelfUnit();

