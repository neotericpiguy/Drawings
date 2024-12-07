include<standards>;
include<cabinet_standards>;

use<wall_stud.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;

module waller(wallVec, rotation = 0, wall_offset = 0) {
  //  echo(wallVec[0], len(wallVec), rotation, wall_offset);

  wallLength = abs(wallVec[0]);

  wall_direction = len(wallVec) > 1 ? (abs(wallVec[1]) / wallVec[1]) : 0;
  new_rotation = (rotation + 90);
  nextWallRotationDir = 90 * wall_direction;
  wall_thickness = drywallThickness + two_by_four_depth;
  new_wall_offset = (drywallThickness + two_by_four_depth) * wall_direction;

  // 1 for out side corner
  // -1 for inside corner
  wall_left_corner = wall_offset == 0 ? 0 : abs(wall_offset) / wall_offset;
  wall_right_corner = wall_direction;
  starting_offset = wall_left_corner == 0 ? drywallThickness : -wall_thickness + drywallThickness;
  left_outside_corner_offset = wall_left_corner > 0 ? wall_thickness + drywallThickness : starting_offset;
  total_offset = wall_right_corner > 0 ? left_outside_corner_offset : wall_offset - drywallThickness;

  // Create wall
  translate([ wall_offset, 0, 0 ]) {
    //    echo(wallVec, wall_direction, wall_left_corner, wall_right_corner);
    wall(wallLength - total_offset, 8 * 12, [ wall_left_corner, 0 ]);
  }

  // Dimensions
  echo(rotation);
  translate([ wall_offset, 0, 0 ]) {
    // outside dim
    dimentor(wallLength - wall_offset - new_wall_offset, 3, 0, 4);
    translate([ -wall_offset, 0, 0 ]) {
      // inside dim
      dimentor(wallLength, -6, 0, 4);
    }
  }

  // prep origin for next wall
  if (len(wallVec) > 1)
  {
    translate([ wallLength, 0, 0 ]) {
      rotate([ 0, 0, nextWallRotationDir ]) {
        waller([for (index = [1:len(wallVec) - 1]) wallVec[index]], new_rotation, new_wall_offset);
      }
    }
  }
}

// Define inside wall length negative number creates an inside corner
// wallTest = [ 50, -50, 50, 80, 50 ];
wallTest = [ 36, -2 * 12, 5 * 12, -9 * 12, -9 * 12 + 12, -(2 + 9) * 12 - two_by_four_depth ];
waller(wallTest);
