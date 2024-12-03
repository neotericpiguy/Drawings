include<cabinet_standards>;
use<platform.scad>;
use<faceframe.scad>;
use<box.scad>;

module base_cabinet(base_cabinet_width = 24) {
  translate([ 0, 0, base_cabinet_height - stile_height ]) {
    faceframe(base_cabinet_width);
  }

  translate([ ear, toekick_depth, 0 ]) {
    platform(base_cabinet_width);
  }

  translate([ ear, stile_thickness, toekick_height ]) {
    box(base_cabinet_width);
  }
}

module cabinet_run(cabinet_vec) {
  base_cabinet(cabinet_vec[0]);

  if (len(cabinet_vec) > 1)
  {
    translate([ cabinet_vec[0], 0, 0 ]) {
      cabinet_run([for (index = [1:len(cabinet_vec) - 1]) cabinet_vec[index]]);
    }
  }
}

module countertop(length = 24, cabinet_depth = 24, countertop_overhang_direction = [ 0, 0 ]) {
  translate([ 0, -countertop_overhang, base_cabinet_height ]) {
    offset = countertop_overhang_direction[0] > 0 ? -countertop_overhang : (countertop_overhang_direction[0] < 0 ? countertop_overhang : 0);
    overallLength = length + (countertop_overhang_direction[0] + countertop_overhang_direction[1]) * countertop_overhang;

    translate([ offset, 0, 0 ]) {
      cube([ overallLength, countertop_overhang + cabinet_depth, countertop_overhang ]);
      translate([ 0, 0, countertop_overhang ]) {
        dimentor(overallLength, 12, 0, 4);
      }
    }
  }
}

// Exterior
base_cabinet(36);
