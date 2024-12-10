include<standards>;

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
}

module futon(dim = [ 60, 48, 24 ]) {
  length = dim[0];
  depth = dim[1];
  height = dim[2];

  desk_thickness = 1.5;
  leg_radius = 0.75;
  leg_height = height - desk_thickness;
  leg_offset = 2.25;

  // Top
  translate([ 0, 0, 0 ]) {
    cube(dim);
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

  futon_dim = [ 62, 26, 36 ];
  futon_space_from_south_wall = 12;
translate([ roomWalls[4][0] - futon_space_from_south_wall, roomWalls[1][0] - roomWalls[3][0] + desk_dim[1],0 * 12 ]) {
  rotate([ 0, 0, 180 ]) {
    futon(futon_dim);
  }
}
}

office();
