include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

module bathroom(
    roomWalls = [
      [ 28 + 28 + 3, -90, [ [ 28, 80 ], 28, 0, "-hinged" ] ],
      [ 89, -90 ],
      [ 59, -90 ],
      [ 89, -90 ],
    ]) {
  wall_run(roomWalls);
}

bathroom();
