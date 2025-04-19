include<standards>;

// 4+117+4+28+59+4+185+4

base_length = 4 + 117 + 4 + 28 + 59 + 4 + 185 + 4;
module west_house_wall() {
  min_height = 8 * 12;
  attic_height = 16 * 12;

  exterior_wall_thickness = 6;

  translate([ 0, exterior_wall_thickness, 0 ]) {
    rotate([ 90, 0, 0 ]) {
      linear_extrude(exterior_wall_thickness) {
        polygon(points = [ [ 0, 0 ], [ base_length, 0 ], [ base_length, min_height ], [ base_length / 2, attic_height ], [ 0, min_height ] ]);
      }
    }
  }
}

module brick_wall() {
  property_wall_thickness = 9;
  property_west_wall = 12 * 12;
  left_gate_wall = 12;
  right_gate_wall = 24;
  gate_width = 30;
  wall_height = 7 * 12;

  translate([ -property_west_wall - property_wall_thickness, -(left_gate_wall + gate_width + right_gate_wall + property_wall_thickness), 0 ]) {
    cube([ property_west_wall, 9, wall_height ]);

    translate([ property_west_wall + property_wall_thickness, 0, 0 * 12 ]) {
      rotate([ 0, 0, 90 ]) {
        cube([ left_gate_wall, property_wall_thickness, wall_height ]);
        translate([ gate_width + property_wall_thickness + left_gate_wall, 0, 0 * 12 ]) {
          rotate([ 0, 0, 0 ]) {
            cube([ right_gate_wall, property_wall_thickness, wall_height ]);
          }
        }
      }
    }
  }
}

module ham_antenna_plan() {
  west_house_wall();
  translate([ base_length - 12 * 12, 0, 0 ]) {
    brick_wall();
  }
  walls = [ [ 12 * 12, 0 ], [ 12, 90 ] ];
//  module_run(walls);
}

module module_run(wallVec, rotation = 0, wall_offset = 0, wall_height = 7 * 12, shape = cube) {
  wall_length = abs(wallVec[0][0]);
  wall_dir = wallVec[0][1];

  new_rotation = (rotation + 90);
  next_wall_rotate_dir = wallVec[1][1];
  wall_thickness = drywallThickness + two_by_four_depth;

  outside_corner_x_offset = wall_thickness * sin(wallVec[0][1]);
  x_offset = wall_dir < 0 ? 0 : outside_corner_x_offset;
  outside_corner_y_offset = (cos(wallVec[0][1]) != 0 && wallVec[0][1] != 0) ? wall_thickness - (x_offset * tan(wallVec[0][1])) : 0;
  y_offset = wall_dir < 0 ? 0 : outside_corner_y_offset;

  length_offset = 0;
  // Create wall
  //  translate([ x_offset, -y_offset, 0 ]) {
  translate([ 0, 0, 0 ]) {
    color([ 1, 1, 1 ]) {
      cube([ wall_length + length_offset, wall_thickness, wall_height ]);
    }
  }

  // prep origin for next wall
  if (len(wallVec) > 1)
  {
    translate([ wall_length, 0, 0 ]) {
      rotate([ 0, 0, next_wall_rotate_dir ]) {
        module_run([for (index = [1:len(wallVec) - 1]) wallVec[index]], new_rotation, x_offset);
      }
    }
  }
}

ham_antenna_plan();
