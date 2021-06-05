include<standards>;

use<twoByFour.scad>;

module wall_stud(height = 8 * 12) {
  rotate([ 0, -90, -90 ])
      twoByFour(height);
}

wall_stud();
