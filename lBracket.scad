twoByFourWidth = 1.5;
twoByFourHeight = 3.5;

module twoByFour(length)
{
  cube([ length, twoByFourWidth, twoByFourHeight ]);
}

module lBracket(x = 0, y = 0, z = 0)
{
  x = x - 0.25;
  depth = 24;
  height = 18;

  // Top plate
  translate([ -twoByFourHeight / 2 + x, 0 + y, 0 + z ]) rotate([ 90, 0, 90 ]) twoByFour(depth);

  // Wall Plate
  translate([ -twoByFourHeight / 2 + x, 0 + y, 0 + z ]) rotate([ 0, 90, 0 ]) twoByFour(height);

  // Diagonal thing
  diaganalLength_x = depth * 2 / 3;
  diaganalLength_y = depth * 2 / 3;

  diaganalLength = norm([ diaganalLength_y, diaganalLength_x ]);  // radial distance
  b = acos(diaganalLength_x / diaganalLength);                    // inclination angle
  c = atan2(diaganalLength_y, 0);                                 // azimuthal angle

  difference()
  {
    translate([ twoByFourWidth / 2 + x, 0 + y, -diaganalLength_y + z ]) rotate([ 0, -b, 90 ])
        twoByFour(diaganalLength);

    translate([ -twoByFourWidth + x, 0 + y, 0 + z ]) cube([ 2 * twoByFourWidth, 2 * diaganalLength_x, 2 * twoByFourHeight ]);
    translate([ -twoByFourWidth + x, -2 * twoByFourHeight + y, -2 * diaganalLength_y + z ]) cube([ 2 * twoByFourWidth, 2 * twoByFourHeight, 2 * diaganalLength_y ]);
  }
}

