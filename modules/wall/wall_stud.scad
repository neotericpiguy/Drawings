include<standards>;

use<two_by_four.scad>;

module wall_stud(height = 8 * 12) {
  rotate([ 0, -90, -90 ])
      two_by_four(height);
}

wall_stud();
