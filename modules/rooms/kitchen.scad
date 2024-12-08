include<standards>;

include<cabinet_standards>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

wallHeight = 8 * 12;

module kitchen() {
  peninsula_cabs = [ 33, 24, 36 ];
  peninsula_length = sumv(peninsula_cabs, len(peninsula_cabs) - 1);

  sink_cabs = [ 12, 36, 12 ];
  sink_length = sumv(sink_cabs, len(sink_cabs) - 1);

  sink_window = [ 48, 36 ];
  sink_window_left_reveal = countertop_overhang + base_cabinet_depth + (sink_length - 2 * countertop_overhang - sink_window[0]) / 2;
  sink_window_height_from_floor = 42;

  stove_cabs = [ 36, 12, 30, 21 ];
  stove_countertop_length = sumv(stove_cabs, len(stove_cabs) - 1);

  rotate([ 0, 0, 90 ]) {
    translate([ -peninsula_length, -base_cabinet_depth, 0 ]) {
      // Peninsula
      translate([ 0, 0, 0 ]) {
        cabinet_run(peninsula_cabs);
        countertop(peninsula_length, base_cabinet_depth + 9, [ 1, 0 ]);
      }

      // Sink Side
      translate([ peninsula_length - base_cabinet_depth, 0, 0 ]) {
        rotate([ 0, 0, -90 ]) {
          cabinet_run(sink_cabs);
          countertop(sink_length, base_cabinet_depth, [ -1, -1 ]);
        }
      }

      // Stove Side
      translate([ peninsula_length, -sink_length, 0 ]) {
        rotate([ 0, 0, 180 ]) {
          cabinet_run(stove_cabs);
          countertop(stove_countertop_length);
        }
      }
    }
  }
  stubs = 4;
  wall_left_of_ref = 28;
  ref = 39;
  roomWalls = [[sink_length + base_cabinet_depth * 2, 0, [sink_window, sink_window_left_reveal, sink_window_height_from_floor]],
               [stove_countertop_length + ref, -90],
  ];
  wall_run(roomWalls);

//  translate([ sink_length + base_cabinet_depth * 2, -(stove_countertop_length + ref + stubs), 0 ]) {
//    rotate([ 0, 0, -90 ]) {
//      laundry_room();
//    }
//  }
}

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
  ];
  wall_run(roomWalls);
}

kitchen();
