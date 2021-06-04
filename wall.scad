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

  // Landed on an un even stud center
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

  // Drywall
  if (enableDrywall)
  {
    color([ 1, 1, 1 ])
        cube([ length, drywallThickness, height ]);
  }
}

wall(9 * 12);
