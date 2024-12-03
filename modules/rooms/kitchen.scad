include<standards>;

include<cabinet_standards>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;

wallHeight = 116;

module kitchen() {
  peninsula_cabs = [ 33, 24, 36 ];
  peninsula_length = sumv(peninsula_cabs, len(peninsula_cabs) - 1);
  translate([ -peninsula_length, -base_cabinet_depth, 0 ]) {
    // Peninsula
    translate([ 0, 0, 0 ]) {
      cabinet_run(peninsula_cabs);
      countertop(peninsula_length, base_cabinet_depth + 9, [ 1, 0 ]);
    }

    // Sink Side
    sink_cabs = [ 12, 36, 12 ];
    sink_length = sumv(sink_cabs, len(sink_cabs) - 1);
    translate([ peninsula_length, base_cabinet_depth, 0 ]) {
      rotate([ 0, 0, -90 ]) {
        wall(sink_length + base_cabinet_depth * 2 + drywallThickness + two_by_four_depth, wallHeight, [ 0, -1 ]);
      }
    }
    translate([ peninsula_length - base_cabinet_depth, 0, 0 ]) {
      rotate([ 0, 0, -90 ]) {
        cabinet_run(sink_cabs);
        countertop(sink_length, base_cabinet_depth, [ -1, -1 ]);
      }
    }

    // Stove Side
    stove_cabs = [ 36, 12, 30, 21 ];
    stove_length = sumv(stove_cabs, len(stove_cabs) - 1);
    translate([ peninsula_length + drywallThickness, -sink_length - base_cabinet_depth, 0 ]) {
      rotate([ 0, 0, 180 ]) {
        // wall(stove_length + drywallThickness + two_by_four_depth, wallHeight, [ 0, 0 ]);
      }
    }
    translate([ peninsula_length, -(sink_length), 0 ]) {
      rotate([ 0, 0, 180 ]) {
        cabinet_run(stove_cabs);
        countertop(stove_length);
      }
    }
  }
}

kitchen();
