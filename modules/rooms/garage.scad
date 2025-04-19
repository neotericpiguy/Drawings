include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

module garage(
    roomWalls = [
      [ 13 * 12, 0, [ [ 30, 80 ], 12, 0 ] ],
      [ 19 * 12, -90 ],
      [ 15 * 12, -90, [ [ 10 * 12, 62 ], 12, 0, "open" ] ],
      [ 16 * 12, -90 ],
      [ 2 * 12, -90 ],
      [ 3 * 12, 90 ],
    ]) {
  wall_run(roomWalls);
}

garage();
