include<standards>;

include<cabinet_standards>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

wallHeight = 8 * 12;

module kitchen(roomWalls = [ [ 30 + 48 + 30, 0, [ [ 48, 36 ], 30, 42 ] ], [ 138, -90 ] ]) {
  peninsula_cabs = [ 33, -24, 36 ];
  peninsula_length = sumv_abs(peninsula_cabs, len(peninsula_cabs) - 1);

  sink_cabs = [ 12, 36, 12 ];
  sink_length = sumv_abs(sink_cabs, len(sink_cabs) - 1);

  sink_window = [ 48, 36 ];
  sink_window_left_reveal = countertop_overhang + base_cabinet_depth + (sink_length - 2 * countertop_overhang - sink_window[0]) / 2;
  sink_window_height_from_floor = 42;

  stove_width = 30;
  stove_cabs = [ 36, 12, -stove_width, 21 ];
  stove_countertop_length = sumv_abs(stove_cabs, len(stove_cabs) - 1);
  stubs = 4;
  wall_left_of_ref = 28;
  ref = 39;

  wall_run(roomWalls);

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
          countertop(stove_countertop_length - stove_width - stove_cabs[3]);
          translate([ stove_countertop_length - stove_width - stove_cabs[3], 0, 0 ]) {
            stove(stove_width);
          }
          translate([ stove_countertop_length - stove_cabs[3], 0, 0 ]) {
            countertop(stove_cabs[3]);
          }
        }
      }
    }
  }

  //  translate([ sink_length + base_cabinet_depth * 2, -(stove_countertop_length + ref + stubs), 0 ]) {
  //    rotate([ 0, 0, -90 ]) {
  //      laundry_room();
  //    }
  //  }
}

module stove(width = 30, depth = 27, height = 36) {
  translate([ 0, 24 - depth, 0 ]) {
    cube([ width, depth, height ]);

    burner_r = 4;
    burner_h = 1;
    x_div = width / 3;
    y_div = depth / 3;
    translate([ x_div * 1 - 2, y_div - 2, height ]) {
      cylinder(burner_h, burner_r, burner_r);
    }
    translate([ x_div * 2 + 2, y_div - 2, height ]) {
      cylinder(burner_h, burner_r, burner_r);
    }
    translate([ x_div * 1 - 2, 2 * y_div + 2, height ]) {
      cylinder(burner_h, burner_r, burner_r);
    }
    translate([ x_div * 2 + 2, 2 * y_div + 2, height ]) {
      cylinder(burner_h, burner_r, burner_r);
    }
    dim_length(width, 12, height);
  }
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
