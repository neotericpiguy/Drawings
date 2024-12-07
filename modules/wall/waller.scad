include<standards>;

use<wall_stud.scad>;

module wall_studs(length, height = 8 * 12) {
  // stud on centers exclude last stud
  for (x = [0:studCenters:length - studCenters / 2])
  {
    translate([ x, drywallThickness, two_by_four_height ])
        wall_stud(height - 2 * two_by_four_height);
  }

  // Ensure stud at the very end of a wall
  translate([ length - two_by_four_height,
              drywallThickness,
              two_by_four_height ])
      wall_stud(height - 2 * two_by_four_height);

  // Stud for combining long walls
  for (x = [two_by_four_length:two_by_four_length:length])
  {
    translate([ x - two_by_four_height, drywallThickness, two_by_four_height ])
        wall_stud(height - 2 * two_by_four_height);
  }
}

wall_studs(9 * 12);
