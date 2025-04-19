include<cabinet_standards>;
use<platform.scad>;
use<faceframe.scad>;
use<box.scad>;

module base_cabinet(base_cabinet_width = 24, depth = base_cabinet_depth, height = base_cabinet_height) {
  translate([ 0, 0, toekick_height ]) {
    cabinet([ base_cabinet_width, depth, height ]);
  }

  translate([ ear, toekick_depth, 0 ]) {
    platform(base_cabinet_width, depth);
  }
}

module cabinet(dim = [ 24, 24, base_cabinet_height ]) {
  width = dim[0];
  depth = dim[1];
  height = dim[2];

  stile_height = height - toekick_height;
  // translate([ 0, 0, height - stile_height ]) {
  translate([ 0, 0, 0 ]) {
    faceframe(width, height = height);
  }

  translate([ ear, stile_thickness, 0 ]) {
    box(width, depth, height);
  }
}

module cabinet_run(cabinet_vec) {
  if (cabinet_vec[0] > 0)
  {
    base_cabinet(cabinet_vec[0]);
  }

  if (len(cabinet_vec) > 1)
  {
    translate([ abs(cabinet_vec[0]), 0, 0 ]) {
      cabinet_run([for (index = [1:len(cabinet_vec) - 1]) cabinet_vec[index]]);
    }
  }
}

module countertop(length = 24, cabinet_depth = 24, countertop_overhang_direction = [ 0, 0 ]) {
  translate([ 0, -countertop_overhang, base_cabinet_height ]) {
    offset = countertop_overhang_direction[0] > 0 ? -countertop_overhang : (countertop_overhang_direction[0] < 0 ? countertop_overhang : 0);
    overallLength = length + (countertop_overhang_direction[0] + countertop_overhang_direction[1]) * countertop_overhang;

    translate([ offset, 0, 0 ]) {
      color([ 0.7, 0.7, 0.8 ]) {
        cube([ overallLength, countertop_overhang + cabinet_depth, countertop_overhang ]);
      }
      translate([ 0, 0, countertop_overhang ]) {
        dimentor(overallLength, 12, 0, 4);
      }
    }
  }
}

// Exterior
base_cabinet(36);

translate([ 48, 0, 0 ]) {
  base_cabinet(36, 21);
}
