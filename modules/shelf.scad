include<standards>;

use<l_bracket.scad>;
use<two_by_four.scad>;

module shelf(shelfLength = 8 * 12, shelfDepth = 24) {
  backWallLength = shelfLength / 2 - two_by_four_height + two_by_four_height / 2;

  // Side wall
  rotate([ 0, 0, 90 ]) two_by_four(shelfDepth);

  // Back Wall 1
  translate([ -two_by_four_height, shelfDepth, 0 ])
      rotate([ 0, 0, 180 ])
          two_by_four(backWallLength - two_by_four_depth);

  // Back Wall 2
  translate([ -two_by_four_height - backWallLength, shelfDepth, 0 ])
      rotate([ 0, 0, 180 ])
          two_by_four(backWallLength - two_by_four_depth);

  // Middle bracket
  translate([ -backWallLength, shelfDepth, two_by_four_depth - two_by_four_height ])
      rotate([ 0, 0, 180 ])
          l_bracket();

  // End bracket
  translate([ -backWallLength - backWallLength, shelfDepth, two_by_four_depth - two_by_four_height ])
      rotate([ 0, 0, 180 ])
          l_bracket();

  // Shelf plate
  translate([ -shelfLength, 0, two_by_four_depth ])
      cube([ shelfLength, shelfDepth, 3 / 4 ]);
}

shelf();
