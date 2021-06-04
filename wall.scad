include<standards>;

use<twoByFour.scad>;

module wall(length, height = 8 * 12, drywallCoverage = [ 0, 0 ]) {
  //base plate
  for (x = [0:twoByFourLength:length - twoByFourLength])
  {
    translate([ x, drywallThickness, twoByFourHeight ])
        rotate([ -90, 0, 0 ])
            twoByFour(twoByFourLength);
  }
  if (length % twoByFourLength != 0)
  {
    translate([ length - (length % twoByFourLength), drywallThickness, twoByFourHeight ])
        rotate([ -90, 0, 0 ])
            twoByFour(length % twoByFourLength);
  }

  //top plate
  for (x = [0:twoByFourLength:length - twoByFourLength])
  {
    translate([ x, drywallThickness, height ])
        rotate([ -90, 0, 0 ])
            twoByFour(twoByFourLength);
  }
  if (length % twoByFourLength != 0)
  {
    translate([ length - (length % twoByFourLength), drywallThickness, height ])
        rotate([ -90, 0, 0 ])
            twoByFour(length % twoByFourLength);
  }

  // stud on centers
  for (x = [0:studCenters:length - studCenters / 2])
  {
    translate([ x, drywallThickness, twoByFourHeight ])
        rotate([ 0, -90, -90 ])
            twoByFour(height - 2 * twoByFourHeight);
  }
  if (length % studCenters != 0)
  {
    translate([ length - twoByFourHeight, drywallThickness, twoByFourHeight ])
        rotate([ 0, -90, -90 ])
            twoByFour(height - 2 * twoByFourHeight);
  }

  // Ensure stud at the very end of a wall
  if (length % studCenters == 0)
  {
    translate([ length - twoByFourHeight, drywallThickness, twoByFourHeight ])
        rotate([ 0, -90, -90 ])
            twoByFour(height - 2 * twoByFourHeight);
  }

  color([ 1, 1, 1 ])
      drywall(length, height, drywallCoverage);
}

module drywall(overallLength, height = 8 * 12, coverage = [0.0]) {
  drywallOffset = twoByFourDepth + drywallThickness;

  length = overallLength + drywallOffset * (coverage[0] + coverage[1]);
  if (coverage[0] == 1 && coverage[1] == 1)
  {
    dryWallStart = -drywallOffset;
    translate([ dryWallStart, 0, 0 ])
        cube([ length, drywallThickness, height ]);
  }
  else if (coverage[0] == -1 && coverage[1] == -1)
  {
    dryWallStart = drywallOffset;
    translate([ dryWallStart, 0, 0 ])
        cube([ length, drywallThickness, height ]);
  }
  else if (coverage[1] != 0)
  {
    dryWallStart = 0;
    translate([ dryWallStart, 0, 0 ])
        cube([ length, drywallThickness, height ]);
  }
  else
  {
    dryWallStart = coverage[0] * (-(twoByFourDepth + drywallThickness));
    translate([ dryWallStart, 0, 0 ])
        cube([ length, drywallThickness, height ]);
  }
}

testLength = 4;
translate([ 0, 2 * (twoByFourDepth + drywallThickness) * 6, 0 ])
    wall(testLength * 12, 8 * 12, [ 1, 1 ]);
translate([ 0, 2 * (twoByFourDepth + drywallThickness) * 5, 0 ])
    wall(testLength * 12, 8 * 12, [ -1, -1 ]);
translate([ 0, 2 * (twoByFourDepth + drywallThickness) * 4, 0 ])
    wall(testLength * 12, 8 * 12, [ -1, 0 ]);
translate([ 0, 2 * (twoByFourDepth + drywallThickness) * 3, 0 ])
    wall(testLength * 12, 8 * 12, [ 0, -1 ]);
translate([ 0, 2 * (twoByFourDepth + drywallThickness) * 2, 0 ])
    wall(testLength * 12, 8 * 12, [ 1, 0 ]);
translate([ 0, 2 * (twoByFourDepth + drywallThickness) * 1, 0 ])
    wall(testLength * 12, 8 * 12, [ 0, 1 ]);
wall(testLength * 12);
