include<standards>;

use<twoByFour.scad>;

module wall(length, height = 8 * 12, drywallCoverage = [ 0, 0 ]) {
  //  //base plate
  //  for (x = [0:twoByFourLength:length - twoByFourLength])
  //  {
  //    translate([ x, drywallThickness, twoByFourHeight ])
  //        rotate([ -90, 0, 0 ])
  //            twoByFour(twoByFourLength);
  //  }
  //  if (length % twoByFourLength != 0)
  //  {
  //    translate([ length - (length % twoByFourLength), drywallThickness, twoByFourHeight ])
  //        rotate([ -90, 0, 0 ])
  //            twoByFour(length % twoByFourLength);
  //  }

  //  //top plate
  //  for (x = [0:twoByFourLength:length - twoByFourLength])
  //  {
  //    translate([ x, drywallThickness, height ])
  //        rotate([ -90, 0, 0 ])
  //            twoByFour(twoByFourLength);
  //  }
  //  if (length % twoByFourLength != 0)
  //  {
  //    translate([ length - (length % twoByFourLength), drywallThickness, height ])
  //        rotate([ -90, 0, 0 ])
  //            twoByFour(length % twoByFourLength);
  //  }

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

  // Drywall corner nail plates
  if (drywallCoverage[0] != 0)
  {
    translate([ ((drywallCoverage[0] + 2) % 3) * twoByFourDepth + drywallCoverage[0] * -twoByFourHeight,
                drywallThickness + (drywallCoverage[0] + 1) * twoByFourHeight / 2,
                twoByFourHeight ])
        rotate([ ((drywallCoverage[0] + 2) % 3) * 90, -90, -90 ])
            twoByFour(height - 2 * twoByFourHeight);
  }
  if (drywallCoverage[1] != 0)
  {
    translate([ length - ((drywallCoverage[1] + 2) % 3) * twoByFourHeight,
                drywallThickness + (drywallCoverage[1] + 1) * twoByFourHeight / 2,
                twoByFourHeight ])
        rotate([ ((drywallCoverage[1] + 2) % 3) * 90, -90, -90 ])
            twoByFour(height - 2 * twoByFourHeight);
  }

  if (enableDrywall)
  {
    color([ 1, 1, 1 ])
        drywall(length, height, drywallCoverage);
  }
}

module drywall(length, height = 8 * 12, drywallCoverage = [ 0, 0 ]) {
  drywallOffset = twoByFourDepth + drywallThickness;

  drywallLength = length + drywallOffset * (drywallCoverage[0] + drywallCoverage[1]);
  if (drywallCoverage[0] == 1 && drywallCoverage[1] == 1)
  {
    dryWallStart = -drywallOffset;
    translate([ dryWallStart, 0, 0 ])
        cube([ drywallLength, drywallThickness, height ]);
  }
  else if (drywallCoverage[0] == -1 && drywallCoverage[1] == -1)
  {
    dryWallStart = drywallOffset;
    translate([ dryWallStart, 0, 0 ])
        cube([ drywallLength, drywallThickness, height ]);
  }
  else if (drywallCoverage[1] != 0)
  {
    dryWallStart = 0;
    translate([ dryWallStart, 0, 0 ])
        cube([ drywallLength, drywallThickness, height ]);
  }
  else
  {
    dryWallStart = drywallCoverage[0] * (-(twoByFourDepth + drywallThickness));
    translate([ dryWallStart, 0, 0 ])
        cube([ drywallLength, drywallThickness, height ]);
  }
}

testLength = 3;

translate([ testLength * 12, -testLength * 12 * 2, 0 ])
    rotate([ 0, 0, 0 ])
        wall(testLength * 12);

wall(testLength * 12, 8 * 12, [ 0, -1 ]);

translate([ testLength * 12 - twoByFourDepth - drywallThickness, drywallThickness, 0 ])
    rotate([ 0, 0, -90 ])
        wall(testLength * 12, 8 * 12, [ 0, 0 ]);

translate([ testLength * 12, -testLength * 12, 0 ])
    rotate([ 0, 0, 0 ])
        wall(testLength * 12, 8 * 12, [ 1, 1 ]);

translate([ 2 * testLength * 12 + drywallThickness + twoByFourDepth, -testLength * 12 + drywallThickness, 0 ])
    rotate([ 0, 0, 90 ])
        wall(testLength * 12, 8 * 12, [ 0, 0 ]);

translate([ testLength * 12 * 2, 0, 0 ])
    wall(testLength * 12, 8 * 12, [ -1, 0 ]);
