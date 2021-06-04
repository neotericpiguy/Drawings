include<standards>;

use<twoByFour.scad>;

module wall(length, height = 8 * 12) {
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

  // stud on centers
  for (x = [0:studCenters:length - studCenters / 2])
  {
    translate([ x, drywallThickness, 0 ])
        rotate([ 0, -90, -90 ])
            twoByFour(height);
  }

  // Landed on an un even stud center
  if (length % studCenters != 0)
  {
    translate([ length - twoByFourHeight, drywallThickness, 0 ])
        rotate([ 0, -90, -90 ])
            twoByFour(height);
  }

  if (length % studCenters == 0)
  {
    translate([ length - twoByFourHeight, drywallThickness, 0 ])
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

wall(9 * 12);
