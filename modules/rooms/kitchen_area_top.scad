include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;
use<dining.scad>;
use<laundry_room.scad>;

walls = [
  [ "dining", [
     [ 92, 0 ],                                     // west wall
     [ 48 + 60 + 52, -90, [ [ 60, 80 ], 52, 0 ] ],  // north wall with double door
     [ 115, -90, [ [ 58.5, 58.5 ], 17, 23.5 ] ],    // East wall with big window
   ] ],
  [ "kitchen", [
     [ 30 + 48 + 30, 0, [ [ 48, 36 ], 30, 42 ] ],  // East sink side wall
     [ 138, -90 ],                                 // Stove wall
   ] ],
];

dining_walls = wall_selector("dining", walls);
dining(dining_walls);

kitchen_walls = wall_selector("kitchen", walls);
translate([ dining_walls[2][0] - dining_walls[0][0], dining_walls[1][0], 0 ]) {
  rotate([ 0, 0, 0 ]) {
    kitchen(wall_selector("kitchen", walls));
  }
}

translate([ dining_walls[2][0] - dining_walls[0][0] + kitchen_walls[0][0], dining_walls[1][0] - kitchen_walls[1][0] - 4, 0 ]) {
  rotate([ 0, 0, -90 ]) {
    laundry_room();
  }
}
