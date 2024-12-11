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

module wall_run_studs(wallVec, rotation = 0, wall_offset = 0) {
  wallLength = abs(wallVec[0][0]);

  wall_direction = len(wallVec) > 1 ? (wallVec[1][1] != 0 ? abs(wallVec[1][1]) / wallVec[1][1] : 0) : 0;
  new_rotation = (rotation + 90);
  nextWallRotationDir = wallVec[1][1];
  wall_thickness = drywallThickness + two_by_four_depth;
  x_offset = (drywallThickness + two_by_four_depth) * wall_direction;

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
    dim_length(wallLength - wall_offset - x_offset, wall_run_outside_dim, wallHeight);
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
        wall_run_studs([for (index = [1:len(wallVec) - 1]) wallVec[index]], new_rotation, x_offset);
      }
    }
  }
}

module wall_run_no_studs(wallVec, rotation = 0, wall_offset = 0) {
  wallLength = abs(wallVec[0][0]);

  wall_direction = len(wallVec) > 1 ? (wallVec[1][1] != 0 ? abs(wallVec[1][1]) / wallVec[1][1] : 0) : 0;
  new_rotation = (rotation + 90);
  nextWallRotationDir = wallVec[1][1];
  wall_thickness = drywallThickness + two_by_four_depth;
  x_offset = (drywallThickness + two_by_four_depth) * wall_direction;

  // 1 for out side corner
  // -1 for inside corner
  wall_left_corner = wall_offset == 0 ? 0 : abs(wall_offset) / wall_offset;
  wall_right_corner = wall_direction;
  starting_offset = wall_left_corner == 0 ? drywallThickness : -wall_thickness + drywallThickness;
  left_outside_corner_offset = wall_left_corner > 0 ? wall_thickness + drywallThickness : starting_offset;
  pre_total_offset = wall_right_corner > 0 ? left_outside_corner_offset : wall_offset - drywallThickness;
  total_offset = len(wallVec) == 1 ? pre_total_offset + drywallThickness : pre_total_offset - drywallThickness;

  if (len(wallVec[0]) == 3)
  {
    cutout_width = wallVec[0][2][0][0];
    cutout_height = wallVec[0][2][0][1];
    reveal = wallVec[0][2][1];
    heightFromFloor = wallVec[0][2][2];

    // Create wall and cutout
    difference() {
      translate([ wall_offset, 0, 0 ]) {
        //        wall(wallLength - total_offset, wallHeight, [ wall_left_corner, 0 ]);
        color([ 1, 1, 1 ]) {
          cube([ wallLength - total_offset, two_by_four_depth + drywallThickness, wallHeight ]);
        }
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
      //      wall(wallLength - total_offset, wallHeight, [ wall_left_corner, 0 ]);
      color([ 1, 1, 1 ]) {
        cube([ wallLength - total_offset, two_by_four_depth + drywallThickness, wallHeight ]);
      }
    }
  }

  // Dimensions
  translate([ wall_offset, 0, 0 ]) {
    // outside dim
    dim_length(wallLength - wall_offset - x_offset, wall_run_outside_dim, wallHeight);
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
        wall_run_no_studs([for (index = [1:len(wallVec) - 1]) wallVec[index]], new_rotation, x_offset);
      }
    }
  }
}

module cutout_run(cutout_v) {
  c = cutout_v[0];
  cutout_width = c[0][0];
  cutout_height = c[0][1];
  reveal = c[1];
  heightFromFloor = c[2];

  translate([ reveal, 0, 0 ]) {
    wall_cutout(cutout_width, cutout_height, heightFromFloor);
  }
  //  dim_length(reveal, wall_run_outside2_dim, wallHeight);

  if (len(cutout_v) > 1)
  {
    translate([ cutout_width + reveal, 0, 0 ])
        cutout_run([for (index = [1:len(cutout_v) - 1]) cutout_v[index]]);
  }
}

module cutout_dim_run(cutout_v) {
  c = cutout_v[0];
  cutout_width = c[0][0];
  reveal = c[1];

  dim_length(reveal, wall_run_outside2_dim - 3, wallHeight);
  translate([ reveal, 0, 0 ]) {
    dim_length(cutout_width, wall_run_outside2_dim, wallHeight);
  }

  if (len(cutout_v) > 1)
  {
    translate([ cutout_width + reveal, 0, 0 ]) {
      cutout_dim_run([for (index = [1:len(cutout_v) - 1]) cutout_v[index]]);
    }
  }
}

module cutout_frame_run(cutout_v) {
  c = cutout_v[0];
  cutout_width = c[0][0];
  cutout_height = c[0][1];
  reveal = c[1];
  heightFromFloor = c[2];
  opening_type = len(c) > 3 ? c[3] : "hinged";

  translate([ reveal, 0, 0 ]) {
    if (heightFromFloor == 0)
    {
      double_door_frame(cutout_width, cutout_height, wallHeight, type = opening_type);
    }
    else
    {
      window_frame(cutout_width, cutout_height, heightFromFloor, wallHeight);
    }
  }

  if (len(cutout_v) > 1)
  {
    translate([ cutout_width + reveal, 0, 0 ]) {
      cutout_frame_run([for (index = [1:len(cutout_v) - 1]) cutout_v[index]]);
    }
  }
}

module wall_run(wallVec, rotation = 0, wall_offset = 0) {
  wall_length = abs(wallVec[0][0]);
  wall_dir = wallVec[0][1];

  new_rotation = (rotation + 90);
  next_wall_rotate_dir = wallVec[1][1];
  wall_thickness = drywallThickness + two_by_four_depth;

  // 1 for out side corner
  // -1 for inside corner
  //  wall_left_corner = wall_offset == 0 ? 0 : abs(wall_offset) / wall_offset;
  //  wall_right_corner = wall_direction;
  //  starting_offset = wall_left_corner == 0 ? drywallThickness : -wall_thickness + drywallThickness;
  //  left_outside_corner_offset = wall_left_corner > 0 ? wall_thickness + drywallThickness : starting_offset;
  //  pre_total_offset = wall_right_corner > 0 ? left_outside_corner_offset : wall_offset - drywallThickness;
  //  total_offset = len(wallVec) == 1 ? pre_total_offset + drywallThickness : pre_total_offset - drywallThickness;
  outside_corner_x_offset = wall_thickness * sin(wallVec[0][1]);
  x_offset = wall_dir < 0 ? 0 : outside_corner_x_offset;
  outside_corner_y_offset = (cos(wallVec[0][1]) != 0 && wallVec[0][1] != 0) ? wall_thickness - (x_offset * tan(wallVec[0][1])) : 0;
  y_offset = wall_dir < 0 ? 0 : outside_corner_y_offset;

  length_offset = 0;
  if (len(wallVec[0]) == 3)
  {
    cutout_vec = is_list(wallVec[0][2][1]) ? wallVec[0][2] : [wallVec[0][2]];
    difference() {
      translate([ 0, 0, 0 ]) {
        color([ 1, 1, 1 ]) {
          cube([ wall_length + length_offset, wall_thickness, wallHeight ]);
        }
      }
      cutout_run(cutout_vec);
    }

    cutout_frame_run(cutout_vec);

    // will handle left reveal and cutout width
    cutout_dim_run(cutout_vec);

    // Final right reveal
    right_reveals = [for (x = cutout_vec) x[0][0] + x[1]];
    right_reveal = sumv(right_reveals, len(right_reveals) - 1);
    translate([ right_reveal, 0, 0 ]) {
      dim_length(wall_length - right_reveal, wall_run_outside2_dim - 3, wallHeight);
    }
  }
  else
  {
    // Create wall
    //  translate([ x_offset, -y_offset, 0 ]) {
    translate([ 0, 0, 0 ]) {
      color([ 1, 1, 1 ]) {
        cube([ wall_length + length_offset, wall_thickness, wallHeight ]);
      }
    }
  }

  // Dimensions
  translate([ 0, 0, 0 ]) {
    // outside dim
    dim_length(wall_length, wall_run_outside_dim - 8, wallHeight);
    translate([ 0, 0, 0 ]) {
      // inside dim
      //      dim_length(wall_length, wall_run_inside_dim, wallHeight);
    }
  }

  // prep origin for next wall
  if (len(wallVec) > 1)
  {
    translate([ wall_length, 0, 0 ]) {
      rotate([ 0, 0, next_wall_rotate_dir ]) {
        wall_run([for (index = [1:len(wallVec) - 1]) wallVec[index]], new_rotation, x_offset);
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

wallTest4 = [
  [ 3 * 12, 0 ],
  [ 3 * 12, 90 ],
];
translate([ 80, 20, 0 ]) {
  wall_run(wallTest4);
}

wallTest5 = [
  [ 3 * 12, 0 ],
  [ 3 * 12, 45 ],
];
translate([ 0, 20, 0 ]) {
  wall_run(wallTest5);
}

wallTest2 = [
  [ 3 * 12, -90 ],
  [ 3 * 12, -45 ],
];
wall_run(wallTest2);
wallTest3 = [
  [ 3 * 12, -90 ],
  [ 8 * 12, -90, [ [ 3 * 12, 24 ], 24, 54 ] ],
];
translate([ 80, 0, 0 ]) {
  wall_run(wallTest3);
}

