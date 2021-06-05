include<standards>;

use<wall_stud.scad>;

module wall_studs(length, height = 8 * 12) {
  // stud on centers exclude last stud
  for (x = [0:studCenters:length - studCenters / 2])
  {
    translate([ x, drywallThickness, twoByFourHeight ])
        wall_stud(height - 2 * twoByFourHeight);
  }

  // Ensure stud at the very end of a wall
  translate([ length - twoByFourHeight,
              drywallThickness,
              twoByFourHeight ])
      wall_stud(height - 2 * twoByFourHeight);

  // Stud for combining long walls
  for (x = [twoByFourLength:twoByFourLength:length])
  {
    translate([ x - twoByFourHeight, drywallThickness, twoByFourHeight ])
        wall_stud(height - 2 * twoByFourHeight);
  }
}

wall_studs(9 * 12);
