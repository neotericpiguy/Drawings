include<standards>;

module drywall(length, height = 8 * 12, drywallCoverage = [ 0, 0 ]) {
  // TODO: Figure out why dryWallStart value isn't persistent outside of the if
  // statements

  drywallOffset = two_by_four_depth + drywallThickness;
  drywallLength = length + drywallOffset * (drywallCoverage[0] + drywallCoverage[1]);

  if (enableDrywall)
  {
    color([ 1, 1, 1 ]) {
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
        dryWallStart = drywallCoverage[0] * (-(two_by_four_depth + drywallThickness));
        translate([ dryWallStart, 0, 0 ])
            cube([ drywallLength, drywallThickness, height ]);
      }
    }
  }
}
drywall(8 * 12, 8 * 12);
