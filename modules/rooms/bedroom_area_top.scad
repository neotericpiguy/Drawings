include<standards>;

include<cabinet_standards>;
use<entry.scad>;
use<office.scad>;
use<guest_bedroom.scad>;
use<bathroom.scad>;
use<master_bedroom.scad>;

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
     [ 28, -90 ],
     [ 69, 90, [ [ 46, 81 ], 12, 0, "sliding" ] ],
     [ 145 - 28, -90 ],
     [ 105, -90, [ [ 58, 62 ], 24.5, 23 ] ],
     [ 145, -90 ],
     [ 36, -90, [ [ 30, 80 ], 1.5, 0 ] ],
   ] ],
  [ "guest_bedroom", [
     [ 145, -90 ],
     [ 47 + 58 + 24, -90, [ [ 58, 62 ], 47, 23 ] ],
     [ 145 - 28, -90 ],
     [ 17 + 58 + 18, -90, [ [ 58, 80 ], 17, 0, "sliding" ] ],
     [ 28, 90 ],
     [ 36, -90, [ [ 30, 80 ], 1.5, 0, "-hinged" ] ],
   ] ],
  [ "bathroom", [
     [ 28 + 28 + 3, -90, [ [ 28, 80 ], 28, 0, "-hinged" ] ],
     [ 89, -90 ],
     [ 59, -90 ],
     [ 89, -90 ],
   ] ],
  [ "master_bedroom", [
     [ 90, -90 ],
     [ 3 + 30 + 3, -90, [ [ 30, 80 ], 3, 0 ] ],
     [ 20.5, -90 ],
     [ 93, 90 ],
     [ 145 + 35 + 5, -90, [ [ 35, 58 ], 145, 23.5 ] ],
     [ 36 + 93, -90, [ [ 35, 58 ], 3, 23.5 ] ],
   ] ],
];

entry_walls = wall_selector("entry", walls);
office_walls = wall_selector("office", walls);
guest_bedroom_walls = wall_selector("guest_bedroom", walls);
master_bedroom_walls = wall_selector("master_bedroom", walls);
bathroom_walls = wall_selector("bathroom", walls);

rotate([ 0, 0, 180 ]) {
  entry(entry_walls);
}

office_y_offset = entry_walls[1][0] + entry_walls[2][0] * cos(entry_walls[2][1]) + entry_walls[4][0] * cos(entry_walls[4][1]) + entry_walls[6][0] + entry_walls[8][0] - 4;
office_x_offset = entry_walls[0][0] - entry_walls[2][0] * cos(entry_walls[2][1]) - entry_walls[3][0] - entry_walls[4][0] * cos(entry_walls[4][1]) - entry_walls[5][0] + entry_walls[7][0] - 4;
translate([ -office_x_offset, -office_y_offset, 0 ]) {
  office(office_walls);
}

guest_bedroom_y_offset = office_y_offset + office_walls[5][0] + 4;
guest_bedroom_x_offset = office_x_offset;
translate([ -guest_bedroom_x_offset, -guest_bedroom_y_offset, 0 ]) {
  guest_bedroom(guest_bedroom_walls);
}

bathroom_y_offset = guest_bedroom_y_offset + guest_bedroom_walls[5][0] + 4;
bathroom_x_offset = guest_bedroom_x_offset + bathroom_walls[0][0] + 4;
translate([ -bathroom_x_offset, -bathroom_y_offset, 0 ]) {
  bathroom(bathroom_walls);
}

master_bedroom_x_offset = bathroom_x_offset - master_bedroom_walls[2][0] +  master_bedroom_walls[0][0]+4;
master_bedroom_y_offset = bathroom_y_offset -  master_bedroom_walls[1][0]-4;
translate([ -master_bedroom_x_offset, -master_bedroom_y_offset, 0 ]) {
  master_bedroom(master_bedroom_walls);
}
