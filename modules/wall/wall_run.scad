include<standards>;
include<cabinet_standards>;

use<wall_stud.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;

wallHeight = 8 * 12;

wall_run_outside_dim = 2.5 * (two_by_four_depth + drywallThickness);
wall_run_outside2_dim = wall_run_outside_dim - two_by_four_depth + drywallThickness;
wall_run_inside_dim = -two_by_four_depth;
wall_run_height = wallHeight;

module
wall_run(wallVec, rotation = 0, wall_offset = 0) {
  wallLength = abs(wallVec[0][0]);

  wall_direction = len(wallVec) > 1 ? (wallVec[1][1] != 0 ? abs(wallVec[1][1]) / wallVec[1][1] : 0) : 0;
  new_rotation = (rotation + 90);
  nextWallRotationDir = wallVec[1][1];
  wall_thickness = drywallThickness + two_by_four_depth;
  new_wall_offset = (drywallThickness + two_by_four_depth) * wall_direction;

  // 1 for out side corner
  // -1 for inside corner
  wall_left_corner = wall_offset == 0 ? 0 : abs(wall_offset) / wall_offset;
  wall_right_corner = wall_direction;
  starting_offset = wall_left_corner == 0 ? drywallThickness : -wall_thickness + drywallThickness;
  left_outside_corner_offset = wall_left_corner > 0 ? wall_thickness + drywallThickness : starting_offset;
  pre_total_offset = wall_right_corner > 0 ? left_outside_corner_offset : wall_offset - drywallThickness;
  total_offset = len(wallVec) == 1 ? pre_total_offset + drywallThickness : pre_total_offset;

  if (len(wallVec[0]) == 3)
  {
    cutout_width = wallVec[0][2][0][0];
    cutout_height = wallVec[0][2][0][1];
    reveal = wallVec[0][2][1];
    heightFromFloor = wallVec[0][2][2];

    // Create wall and cutout
    difference() {
      translate([ wall_offset, 0, 0 ]) {
        wall(wallLength - total_offset, wallHeight, [ wall_left_corner, 0 ]);
      }
      translate([ reveal, 0, 0 ]) {
        wall_cutout(cutout_width, cutout_height, heightFromFloor);
      }
    }
    dim_length(reveal, wall_run_outside2_dim, wallHeight);

    translate([ reveal, 0, 0 ]) {
      // Add frame for door or a window
      if (heightFromFloor == 0)
      {
        double_door_frame(cutout_width, cutout_height, wallHeight);
      }
      else
      {
        window_frame(cutout_width, cutout_height, heightFromFloor, wallHeight);
      }
      dim_length(cutout_width, wall_run_outside2_dim, wallHeight);
    }

    translate([ reveal + cutout_width, 0, 0 ]) {
      dim_length(wallLength - cutout_width - reveal, wall_run_outside2_dim, wallHeight);
    }
  }
  else
  {
    // Create wall
    translate([ wall_offset, 0, 0 ]) {
      wall(wallLength - total_offset, wallHeight, [ wall_left_corner, 0 ]);
    }
  }

  // Dimensions
  translate([ wall_offset, 0, 0 ]) {
    // outside dim
    dim_length(wallLength - wall_offset - new_wall_offset, wall_run_outside_dim, wallHeight);
    translate([ -wall_offset, 0, 0 ]) {
      // inside dim
      dim_length(wallLength, wall_run_inside_dim, wallHeight);
    }
  }

  // prep origin for next wall
  if (len(wallVec) > 1)
  {
    translate([ wallLength, 0, 0 ]) {
      rotate([ 0, 0, nextWallRotationDir ]) {
        wall_run([for (index = [1:len(wallVec) - 1]) wallVec[index]], new_rotation, new_wall_offset);
      }
    }
  }
}

// Define inside wall length negative number creates an inside corner
// wallTest = [ 50, -50, 50, 80, 50 ];
// wallTest = [ -2 * 12, 5 * 12, -9 * 12, -9 * 12 + 12, -(2 + 9) * 12 - two_by_four_depth ];
// waller(wallTest);

wallTest = [
  //  [ 3 * 12, 90 ],   // Office Door
  [ 2 * 12, -90 ],  // Office
  [ 5 * 12, 90 ],
  [ 9 * 12, -90 ],
  [ 9 * 12 - 12, -90 ],
  [ 11 * 12, -90 ],
  [ 6, 90 ],
  [ 11 * 12, 90 ],  // Guest room
  [ 10 * 12, -90 ],
  [ 7.5 * 12 + 2, -90 ],
  [ 7 * 12, -90 ],
  [ 3 * 12 + 4, 90 ],
  //  [ 3 * 12, -90 ],  // Guest room doorway
  [ 8 * 12, 90 ],  // Bathroom
  [ 5 * 12, -90 ],
  [ 8 * 12, -90 ],
  [ 2 * 12, -90 ],
  [ 8, 90 ],  // Master Beddrom
  [ 3 * 12, 90 ],
  [ 9 * 12, 90 ],
  [ 15 * 12, -90 ],
  [ 12 * 12, -90 ],
  [ 7 * 12, -90 ],
  [ 8, 90 ],  // Master Bath
  [ 7 * 12, 90 ],
  [ 5 * 12, -90 ],
  [ 9 * 12, -90 ],
  [ 3 * 12, -90 ],
  [ 8, 90 ],  // Master Closet
  [ 3 * 12, 90 ],
  [ 6 * 12, -90 ],
  [ 5 * 12, -90 ],
  [ 5 * 12, -90 ],
  [ 8, 90 ],
  [ 7 * 12, 90 ],
  [ 6 * 12, 90 ],   // Hall way
  [ 17 * 12, 90 ],  // Living Room
  [ 13 * 12, -90 ],
  [ 13 * 12, -90 ],
  [ 12, 90 ],  // dining room
  [ 92, 90 ],
  [ 160, -90 ],
  [ 20 * 12, -90 ],  // Kitchen
  [ 10 * 12, -90 ],
  [ 3 * 12, -90 ],
  [ 6, 90 ],
  [ 3 * 12, 90 ],
  [ 7 * 12, -90 ],
  [ 5 * 12, -90 ],
  [ 5 * 12, -90 ],
  [ 3 * 12, 90 ],
  [ 4 * 12, 90 ],
  [ 4 * 12, 45 ],
  [ 6 * 12, 45 ],
  [ 2 * 12, 90 ],
  [ 3 * 12, -90 ],
  [ 2 * 12, -90 ],
  [ 1 * 12, -90 ],
  [ 0.5 * 12, 90 ],
  [ 3 * 12 + 2, 90 ],
  [ 6 * 12, -90 ],
];

wallTest2 = [
  [ 5 * 12, 0, [ [ 24, 24 ], 24, 60 ] ],
  [ 7 * 12, -90, [ [ 36, 84 ], 24, 0 ] ],
];
wall_run(wallTest2);
