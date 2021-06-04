include<standards>;

use<twoByFour.scad>;

module wall(length, height = 8 * 12)
{
  studCenters = 16;
  drywallThickness = 1 / 2;

  for (x = [0:studCenters:length - studCenters / 2])
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

  if (length % studCenters == 0)
  {
    translate([ length - twoByFourWidth, drywallThickness, 0 ])
        rotate([ 0, -90, -90 ])
            twoByFour(height);
  }

  // Drywall
  if (enableDrywall)
  {
    color([ 1, 1, 1 ])
        cube([ length, drywallThickness, height ]);
  }
}

wall(96);
