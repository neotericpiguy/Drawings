include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

module master_bedroom(
    roomWalls = [
      [ 90, -90 ],
      [ 3 + 30 + 3, -90, [ [ 30, 80 ], 3, 0 ] ],
      [ 20.5, -90 ],
      [ 93, 90 ],
      [ 145 + 35 + 5, -90, [ [ 35, 58 ], 145, 23.5 ] ],
      [ 36 + 93, -90, [ [ 35, 58 ], 3, 23.5 ] ],
    ]) {
  wall_run(roomWalls);

  bath_walls = [
    [ 119, -90, [ [ 27, 80 ], 3, 0, "sliding" ] ],
    [ 59.5, -90 ],
    [ 119, -90 ],
  ];
  module master_bath(master_bath_walls = bath_walls) {
    wall_run(master_bath_walls);
  }

  master_bath_x_offset = roomWalls[0][0] - roomWalls[2][0] - roomWalls[4][0] + bath_walls[0][0];
  translate([ master_bath_x_offset, 4, 0 ]) {
    rotate([ 0, 0, 180 ]) {
      master_bath();
    }
  }

  closet_walls = [
    [ 3 + 27.5 + 29, -90, [ [ 30, 80 ], 3, 0 ] ],
    [ 61.5, -90 ],
    [ 59.5, -90 ],
    [ 61.5, -90 ],
  ];
  module master_closet(master_closet_walls = closet_walls) {
    wall_run(master_closet_walls);
  }

  master_closet_x_offset = master_bath_x_offset - bath_walls[0][0] + bath_walls[2][0];
  translate([ master_closet_x_offset, 4, 0 ]) {
    rotate([ 0, 0, 90 ]) {
      master_closet();
    }
  }
}

master_bedroom();
