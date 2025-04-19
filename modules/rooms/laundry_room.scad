include<standards>;

include<cabinet_standards>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

wallHeight = 8 * 12;

module laundry_room() {
  wall_left_of_ref = 28;
  garagedoor_width = 32;
  kitchendoor_width = 30;
  washing_machine_wall_length = 63.5;
  shelfwall_width = 4 * 12 + 1.58;
  shelfwall_depth = 27.25;
  kitchendoor_wall_length = shelfwall_depth + kitchendoor_width + wall_left_of_ref;
  roomWalls = [
    [ 3 + garagedoor_width + 36.5, 0, [[garagedoor_width, 80], 3, 0] ],
    [ washing_machine_wall_length, -90 ],
    [ 31, -45 ],
    [ shelfwall_width, -45 ],
    [ kitchendoor_wall_length, -90, [[kitchendoor_width, 80], shelfwall_depth, 0] ],
  ];
  wall_run(roomWalls);

  //  // translate([ -4, -82.5 + 24, 0 ]) {
  //  translate([ -4, -kitchendoor_wall_length + shelfwall_depth, 0 ]) {
  //    rotate([ 0, 0, -90 ]) {
  //      entry();
  //    }
  //  }
}

laundry_room();
