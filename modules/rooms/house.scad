include<standards>;

include<cabinet_standards>;
use<entry.scad>;
use<office.scad>;
use<guest_bedroom.scad>;
use<bathroom.scad>;
use<master_bedroom.scad>;
use<living_room.scad>;
use<dining.scad>;

use<wall_run.scad>;

walls = [
  [ "entry", [
     [ 32, 0 ],
     [ 56.25, 90 ],
     [ 37.5, 45 ],
     [ 51.5, 45 ],
     [ 17, -45 ],
     [ 9.5 + 18 + 6, 45, [ [ 18, 80 ], 9.5, 0 ] ],
     [ 4 + 36 + 4.5 + 10.5 + 5.5, -90, [ [ [ 36, 80 ], 4, 0 ], [ [ 10.5, 58.5 ], 4.5, 80 - 58.5 ] ] ],
     [ 103, -90 ],
     [ 77, 90 ],
   ] ],
  [ "office", [
     [ 28, 0 ],
     [ 69, 90, [ [ 46, 81 ], 12, 0, "sliding" ] ],
     [ 145 - 28, -90 ],
     [ 105, -90, [ [ 58, 62 ], 24.5, 23 ] ],
     [ 145, -90 ],
     [ 36, -90, [ [ 30, 80 ], 1.5, 0 ] ],
   ] ],
  [ "guest_bedroom", [
     [ 145, 0 ],
     [ 47 + 58 + 24, -90, [ [ 58, 62 ], 47, 23 ] ],
     [ 145 - 28, -90 ],
     [ 17 + 58 + 18, -90, [ [ 58, 80 ], 17, 0, "sliding" ] ],
     [ 28, 90 ],
     [ 36, -90, [ [ 30, 80 ], 1.5, 0, "-hinged" ] ],
   ] ],
  [ "bathroom", [
     [ 28 + 28 + 3, 0, [ [ 28, 80 ], 28, 0, "-hinged" ] ],
     [ 89, -90 ],
     [ 59, -90 ],
     [ 89, -90 ],
   ] ],
  [ "master_bedroom", [
     [ 90, 0 ],
     [ 3 + 30 + 3, -90, [ [ 30, 80 ], 3, 0 ] ],
     [ 20.5, -90 ],
     [ 93, 90 ],
     [ 145 + 35 + 5, -90, [ [ 35, 58 ], 145, 23.5 ] ],
     [ 36 + 93, -90, [ [ 35, 58 ], 3, 23.5 ] ],
   ] ],
  [ "living_room", [
     [ 10 + 46 + 18, 0, [ [ 46, 80 ], 10, 0, "sliding" ] ],
     [ 176, 90 ],
     [ 6 + 35 + 13, -90, [ [ 35, 58 ], 6, 23.5 ] ],
     [ 5.5, -90 ],
     [ 58.5, 90 ],
     [ 5.5, 90 ],
     [ 12 + 35 + 6, -90, [ [ 35, 58 ], 12, 23.5 ] ],
     [ 152, -90, [ [ 34.5, 58 ], 6, 23.5 ] ],
     [ 13, 90 ],
   ] ],
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

entry_walls = wall_selector("entry", walls);
office_walls = wall_selector("office", walls);
guest_bedroom_walls = wall_selector("guest_bedroom", walls);
master_bedroom_walls = wall_selector("master_bedroom", walls);
bathroom_walls = wall_selector("bathroom", walls);
living_room_walls = wall_selector("living_room", walls);
dining_walls = wall_selector("dining", walls);

rotate([ 0, 0, 180 ]) {
  entry(entry_walls);
}

office_x_offset = wall_x_offset(entry_walls, len(entry_walls) - 1) - 4;
office_y_offset = wall_y_offset(entry_walls, len(entry_walls) - 1);

translate([ -office_x_offset, -office_y_offset, 0 ]) {
  office(office_walls);
}

guest_bedroom_x_offset = office_x_offset + wall_x_offset(office_walls, len(office_walls) - 1);
guest_bedroom_y_offset = office_y_offset + wall_y_offset(office_walls, len(office_walls) - 1) + office_walls[5][0] + 4;
translate([ -guest_bedroom_x_offset, -guest_bedroom_y_offset, 0 ]) {
  guest_bedroom(guest_bedroom_walls);
}

bathroom_x_offset = guest_bedroom_x_offset + wall_x_offset(guest_bedroom_walls, len(guest_bedroom_walls) - 1) + bathroom_walls[0][0] + 4;
bathroom_y_offset = guest_bedroom_y_offset + wall_y_offset(guest_bedroom_walls, len(guest_bedroom_walls) - 1) + guest_bedroom_walls[5][0] + 4;
translate([ -bathroom_x_offset, -bathroom_y_offset, 0 ]) {
  bathroom(bathroom_walls);
}

master_bedroom_x_offset = bathroom_x_offset - master_bedroom_walls[2][0] + master_bedroom_walls[0][0] + 4;
master_bedroom_y_offset = bathroom_y_offset - master_bedroom_walls[1][0] - 4;
translate([ -master_bedroom_x_offset, -master_bedroom_y_offset, 0 ]) {
  master_bedroom(master_bedroom_walls);
}

living_room_x_offset = master_bedroom_x_offset - 4 - master_bedroom_walls[0][0];
living_room_y_offset = master_bedroom_y_offset;
translate([ -living_room_x_offset, -living_room_y_offset, 0 ]) {
  rotate([ 0, 0, 90 ]) {
    living_room(living_room_walls);
  }
}

dining_x_offset = living_room_x_offset + wall_y_offset(living_room_walls, len(living_room_walls) - 1);
dining_y_offset = living_room_y_offset - wall_x_offset(living_room_walls, len(living_room_walls) - 1) - 4;
translate([ -dining_x_offset, -dining_y_offset, 0 ]) {
  rotate([ 0, 0, 0 ]) {
    dining(dining_walls);
  }
}
