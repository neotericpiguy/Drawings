include<standards>;

include<cabinet_standards>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

module entry() {
  entry_closet_width = 18;
  roomWalls = [
    [ 32, 0 ],
    [ 56.25, 90 ],
    [ 37.5, 45 ],
    [ 51.5, 45 ],
    [ 17, -45 ],
    [ 9.5 + entry_closet_width + 6, 45, [[entry_closet_width, 80], 9.5, 0] ],
    [ 4 + 36 + 4.5 + 10.5 + 5.5, -90, [ [ 36, 80 ], 4, 0 ] ],
    [ 130, -90 ],
    [ 77, 90 ],
  ];
  wall_run(roomWalls);
}

entry();
