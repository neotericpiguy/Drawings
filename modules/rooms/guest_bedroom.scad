include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

module guest_bedroom(
    roomWalls = [
      [ 145, -90 ],
      [ 105, -90, [ [ 58, 62 ], 24.5, 23 ] ],
      [ 145 - 28, -90 ],
      [ 69, -90, [ [ 46, 81 ], 12, 0, "sliding" ] ],
      [ 28, 90 ],
      [ 36, -90, [ [ 30, 80 ], 1.5, 0 ] ],
    ]) {
  wall_run(roomWalls);
}

guest_bedroom();
