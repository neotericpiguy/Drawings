include<cabinet_standards>;
use<platform.scad>;
use<faceframe.scad>;
use<box.scad>;

module base_cabinet(base_cabinet_width = 24, base_cabinet_depth = 24, base_cabinet_height = 34.5, wallThickness = 2) {
  translate([ 0, 0, base_cabinet_height - stile_height ])
      faceframe();
  translate([ ear, toekick_depth, 0 ])
      platform();
  translate([ ear, stile_thickness, toekick_height ])
      box();
//dimentor(base_cabinet_width, base_cabinet_depth, base_cabinet_height, 8);
}

// Exterior
base_cabinet(base_cabinet_width);
