include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

module desk(dim = [ 60, 48, 24 ]) {
  length = dim[0];
  depth = dim[1];
  height = dim[2];

  desk_thickness = 1.5;
  leg_radius = 0.75;
  leg_height = height - desk_thickness;
  leg_offset = 2.25;

  // Top
  translate([ 0, 0, leg_height ]) {
    cube([ length, depth, desk_thickness ]);
  }

  translate([ leg_offset, leg_offset, 0 ]) {
    cylinder(leg_height, leg_radius);
  }
  translate([ length - leg_offset, leg_offset, 0 ]) {
    cylinder(leg_height, leg_radius);
  }
  translate([ leg_offset, depth - leg_offset, 0 ]) {
    cylinder(leg_height, leg_radius);
  }
  translate([ length - leg_offset, depth - leg_offset, 0 ]) {
    cylinder(leg_height, leg_radius);
  }

  dim_length(length, 3, height);
  rotate([ 0, 0, 90 ]) {
    dim_length(depth, -3, height);
  }
}

module bookshelf(dim = [ 30, 12, 80 ], shelves = 5) {
  width = dim[0];
  depth = dim[1];
  height = dim[2];
  stile_length = width - 2 * stile_width;

  base_cabinet(width, depth, height);

  number_of_shelves = shelves;
  height_of_shelf = ((height - toekick_height) / number_of_shelves);
  shelf_thickness = 0.5;
  for (x = [height_of_shelf:height_of_shelf:height - height_of_shelf])
  {
    translate([ stile_width, 0, toekick_height + stile_width + x ]) {
      cube([ stile_length, stile_thickness, stile_width ]);
      translate([ -stile_width / 2, stile_thickness, (stile_width - shelf_thickness) / 2 ]) {
        cube([ stile_length + stile_width, depth - stile_thickness, shelf_thickness ]);
      }
    }
  }

  // space between closet and desk for book shelf
  translate([ 0, 0, 0 ]) {
    dim_length(width, 3, height);
  }
  translate([ 0, 0, 0 ]) {
    rotate([ 0, 0, 90 ]) {
      dim_length(depth, -3, height);
    }
  }
}

module futon(dim = [ 60, 48, 24 ]) {
  width = dim[0];
  depth = dim[1];
  height = dim[2];

  platform_height = 9;
  cushion_height = 9;
  arm_height = 12;
  translate([ 0, 0, platform_height ]) {
    cube([ width, depth, cushion_height ]);
    translate([ 0, 0, cushion_height ]) {
      cube([ cushion_height, depth, arm_height ]);
    }
    translate([ width - cushion_height, 0, cushion_height ]) {
      cube([ cushion_height, depth, arm_height ]);
    }
    translate([ cushion_height, depth - cushion_height, cushion_height ]) {
      cube([ width - 2 * cushion_height, cushion_height, height - cushion_height - platform_height ]);
    }
  }
  dim_length(width, 3, height);
  rotate([ 0, 0, 90 ]) {
    dim_length(depth, -3, height);
  }
}

module desk_chair(dim = [ 27, 27, 37 ]) {
  width = dim[0];
  depth = dim[1];
  height = dim[2];

  cushion_height = 2;

  number_of_legs = 5;

  leg_angle = 10;
  leg_length = 14;
  wheel_radius = 1;
  leg_thickness = 1;
  leg_base_height = (leg_length + wheel_radius) * sin(leg_angle);
  translate([ 0, 0, leg_base_height ]) {
    for (x = [0:360 / number_of_legs:360])
    {
      rotate([ 0, 0, x ]) {
        translate([ 0, leg_thickness / 2, 0 ]) {
          rotate([ 90, leg_angle, 0 ]) {  // angle to ground
            cube([ leg_length, wheel_radius, wheel_radius ]);
            translate([ leg_length, 0, 0 ]) {
              cylinder(leg_thickness, wheel_radius, wheel_radius);
            }
          }
        }
      }
    }
  }
  cushion_height_from_floor = 15;
  center_tube_length = cushion_height_from_floor - leg_base_height;
  translate([ 0, 0, leg_base_height ]) {
    cylinder(center_tube_length, 1, 1);
  }
  translate([ 0, 0, cushion_height_from_floor ]) {
    cylinder(cushion_height, width / 3, width / 3);
  }
}

module office() {
  roomWalls = [
    [ 28, -90 ],
    [ 69, 90, [ [ 46, 81 ], 12, 0, "sliding" ] ],
    [ 145 - 28, -90 ],
    [ 105, -90, [ [ 58, 62 ], 24.5, 23 ] ],
    [ 145, -90 ],
    [ 36, -90, [ [ 30, 80 ], 1.5, 0 ] ],
  ];
  wall_run(roomWalls);

  desk_dim = [ 74, 26, 28 ];
  translate([ roomWalls[2][0] + roomWalls[0][0] - desk_dim[0], roomWalls[1][0] - desk_dim[1], 0 ]) {
    desk(desk_dim);
  }

  // space between closet and desk for book shelf
  closet_to_desk_space = roomWalls[2][0] - desk_dim[0];
  translate([ roomWalls[0][0], 0, 0 ]) {
    dim_length(closet_to_desk_space, roomWalls[1][0] - desk_dim[1], 0);
  }

  bookshelf_dim = [ 30, 16.5, 6 * 12 ];
  translate([ roomWalls[0][0] + (closet_to_desk_space - bookshelf_dim[0]), roomWalls[1][0] - bookshelf_dim[1] ]) {
    bookshelf(bookshelf_dim);
  }

  futon_dim = [ 62, 26, 36 ];
  futon_space_from_south_wall = 12;
  translate([ roomWalls[4][0] - futon_space_from_south_wall, roomWalls[1][0] - roomWalls[3][0] + desk_dim[1] ]) {
    rotate([ 0, 0, 180 ]) {
      futon(futon_dim);
    }
  }

  desk_chair_dim = [ 27, 27, 37 ];
  translate([ roomWalls[0][0] + roomWalls[2][0] - desk_dim[0] + desk_dim[0] / 2, roomWalls[1][0] / 2, 0 ]) {
    desk_chair(desk_chair_dim);
  }
}

office();
