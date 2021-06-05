include<standards>;

use<wall_stud.scad>;

module wall_nail_plate(length, height = 8 * 12, drywallCoverage = [ 0, 0 ]) {
  // Drywall corner nail plates
  if (drywallCoverage[0] != 0)
  {
    translate([ ((drywallCoverage[0] + 2) % 3) * twoByFourDepth + drywallCoverage[0] * -twoByFourHeight,
                drywallThickness + (drywallCoverage[0] + 1) * twoByFourHeight / 2,
                twoByFourHeight ])
        rotate([ 0, 0, ((drywallCoverage[0] + 2) % 3) * 90 ])
            wall_stud(height - 2 * twoByFourHeight);
  }
  if (drywallCoverage[1] != 0)
  {
    translate([ length - ((drywallCoverage[1] + 2) % 3) * twoByFourHeight,
                drywallThickness + (drywallCoverage[1] + 1) * twoByFourHeight / 2,
                twoByFourHeight ])
        rotate([ 0, 0, ((drywallCoverage[1] + 2) % 3) * 90 ])
            wall_stud(height - 2 * twoByFourHeight);
  }
}

wall_nail_plate(8, 8 * 12, [ 1, 1 ]);
