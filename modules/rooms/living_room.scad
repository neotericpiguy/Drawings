include<standards>;

use<wall_run.scad>;

module living_room(
    roomWalls = [
      [ 10 + 46 + 18, 0, [ [ 46, 80 ], 10, 0, "sliding" ] ],
      [ 176, 90 ],
      [ 6 + 35 + 13, -90, [ [ 35, 58 ], 6, 23.5 ] ],
      [ 5.5, -90 ],
      [ 58.5, 90 ],
      [ 5.5, 90 ],
      [ 12 + 35 + 6, -90, [ [ 35, 58 ], 12, 23.5 ] ],
      [ 152, -90, [ [ 34.5, 58 ], 6, 23.5 ] ],
      [ 13, 90 ],
    ]) {
  wall_run(roomWalls);
}

living_room();
