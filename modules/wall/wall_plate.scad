include<standards>;

use<two_by_four.scad>;

module wall_plate(length, height = 0) {
  for (x = [0:two_by_four_length:length - two_by_four_length])
  {
    translate([ x, drywallThickness, height ])
        rotate([ -90, 0, 0 ])
            two_by_four(two_by_four_length);
  }
  if (length % two_by_four_length != 0)
  {
    translate([ length - (length % two_by_four_length), drywallThickness, height ])
        rotate([ -90, 0, 0 ])
            two_by_four(length % two_by_four_length);
  }
}

wall_plate(2 * 12);
