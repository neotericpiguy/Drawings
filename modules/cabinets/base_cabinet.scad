include<cabinet_standards>;
use<platform.scad>;
use<faceframe.scad>;
use<box.scad>;

module base_cabinet(base_cabinet_width = 24) {
  translate([ 0, 0, base_cabinet_height - stile_height ])
      faceframe(base_cabinet_width);
  translate([ ear, toekick_depth, 0 ])
      platform(base_cabinet_width);
  translate([ ear, stile_thickness, toekick_height ])
      box(base_cabinet_width);
}

// Exterior
base_cabinet(36);
