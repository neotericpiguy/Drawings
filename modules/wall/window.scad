include<standards>;

use<wall.scad>;
use<two_by_four.scad>;

module window_cutout(width = 60, height = 8 * 12, heightFromFloor=24,ceilingHeight=8*12) {
  buffer = 2*nothing;
  cutout = (two_by_four_depth + drywallThickness) + buffer;

  // Window thing
  translate([ 0, -buffer / 2, heightFromFloor])
    cube([ width, cutout, height]);

  // Cutout
  translate([ 0, drywallThickness-nothing, heightFromFloor-two_by_four_height*2])
    cube([ width, cutout, height+two_by_four_height*2+6]);

  translate([0,drywallThickness-nothing,two_by_four_height])
    rotate([0,0,90])
      cube([ two_by_four_depth+2*nothing, 3*two_by_four_height,ceilingHeight-two_by_four_depth+drywallThickness+nothing]);

  translate([3*two_by_four_height+width,drywallThickness-nothing,two_by_four_height])
    rotate([0,0,90])
      cube([ two_by_four_depth+2*nothing, 3*two_by_four_height,ceilingHeight-two_by_four_depth+drywallThickness+nothing]);
}

module window_frame(width = 60, height = 8 * 12, heightFromFloor=24,ceilingHeight=8*12) {
    // Bottom plate
    translate([0,two_by_four_depth+drywallThickness,heightFromFloor-two_by_four_height*2])
      rotate([90,0,0])
        two_by_four(width);
    translate([0,two_by_four_depth+drywallThickness,heightFromFloor-two_by_four_height])
      rotate([90,0,0])
        two_by_four(width);

    // Header
    translate([-two_by_four_height,drywallThickness,heightFromFloor+height])
      cube([width+2*two_by_four_height,3.5,6]);

    // Window Sill
    translate([0,-1,heightFromFloor])
      cube([width,6,.75]);

    // Sides
    translate([0,drywallThickness+two_by_four_depth,two_by_four_height])
      rotate([90,-90,0])
        two_by_four(height+heightFromFloor-two_by_four_height);
    translate([width+two_by_four_height,drywallThickness+two_by_four_depth,two_by_four_height])
      rotate([90,-90,0])
        two_by_four(height+heightFromFloor-two_by_four_height);

    // King Studs
    translate([-two_by_four_height,drywallThickness+two_by_four_depth,two_by_four_height])
      rotate([90,-90,0])
        two_by_four(ceilingHeight-two_by_four_depth+drywallThickness);
    translate([width+two_by_four_height*2,drywallThickness+two_by_four_depth,two_by_four_height])
      rotate([90,-90,0])
        two_by_four(ceilingHeight-two_by_four_depth+drywallThickness);
}

difference() {
  wall(8 * 12, 8 * 12, [ 0, 0 ]);
  translate([ (8 * 12 - 60) / 2, 0, 0 ])
    window_cutout(60, 60,24,8*12);
}

translate([ (8 * 12 - 60) / 2, 0, 0 ])
  window_frame(60, 60, 24,8*12);
