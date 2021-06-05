include<standards>;

use<twoByFour.scad>;

module wall_plate(length, height = 0) {
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
}

wall_plate(2 * 12);
