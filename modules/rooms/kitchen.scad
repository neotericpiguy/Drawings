include<standards>;

include<cabinet_standards>;
use<base_cabinet.scad>;
// 
// use<wall.scad>;
// use<double_door.scad>;
// use<window.scad>;

module dining_kitchen() {
  westWallLength = 92;
  southWallLength = 8 * 12;
  backDoorLength = 60;
  backDoorHeight= 80;
  wallHeight = 116;

  northWallLeftReveal = 48;
  northWallRightReveal = 52;
  northWallLength = northWallLeftReveal + backDoorLength + northWallRightReveal;

  windowLeftReveal=17;
  windowHeightFromFloor=23;
  windowWidth=58.5;
  windowHeight=58.5;
  eastWallLength = 115;

  module wall(length = 96, height = 96, vec) {
    color([ 1, 1, 1 ])
      cube([length, 4, height]);
  }

  module double_door(width = 60, height = 8 * 12) {
    buffer = 3;
    cutout = (two_by_four_depth + drywallThickness) + buffer;

    translate([ 0, -buffer / 2, 0 ])
      cube([ width, cutout, height ]);
  }

  module double_door_doors(width = 60, height = 8 * 12) {
    buffer = 3;
    cutout = (two_by_four_depth + drywallThickness) + buffer;
    doorThickness = 1.5;
    angle=30;

    rotate([ 0, 0, -angle ])
      cube([ width/2, doorThickness, height ]);

    translate([ width, 0, 0 ])
      rotate([ 0, 0, angle ])
        mirror([1,0,0])
          cube([ width/2, doorThickness, height ]);
  }

  module window_cutout(width = 60, height = 8 * 12,heightFromFloor=24) {
    buffer = 3;
    cutout = (two_by_four_depth + drywallThickness) + buffer;

    // Added for projections
//    translate([ 0, 0, 0])
//      cube([ width+2*two_by_four_height, two_by_four_depth+drywallThickness, two_by_four_height]);

    translate([ 0, -buffer / 2, heightFromFloor])
    color([ 0.5, 0.5, 0.5 ])
      cube([ width, cutout, height+2*two_by_four_height ]);
  }

  // West Wall
  translate([ 0, 0, 0 ])
      rotate([ 0, 0, 180 ]) {
        dimentor(westWallLength, 12, 0, 4);
        wall(westWallLength, wallHeight, [ 0, 0 ]);
      }

  // North Wall
  translate([ -westWallLength, 0, 0 ])
    rotate([ 0, 0, 90 ]) {
      difference() {
        wall(northWallLength, wallHeight, [ 0, 0 ]);
        translate([ northWallLeftReveal, 0, 0 ])
            double_door(backDoorLength, backDoorHeight);
      }

      translate([ northWallLeftReveal, 0, 0 ]) {
          double_door_doors(backDoorLength, backDoorHeight);
          dimentor(backDoorLength, 6, 0, 4);
          translate([ backDoorLength, 0, 0 ])
            dimentor(northWallRightReveal, 6, 0, 4);
      }

      dimentor(northWallLength, 12, 0, 4);
      dimentor(northWallLeftReveal, 6, 0, 4);
    }

  // East Wall
  translate([ -westWallLength, northWallLength, 0 ])
    rotate([ 0, 0, 0 ])
    {
      dimentor(eastWallLength, 12, 0, 4);
      dimentor(windowLeftReveal, 4, 0, 4);
      translate([windowLeftReveal,0,0])
        dimentor(windowWidth, 4, 0, 4);

//      difference() {
        wall(eastWallLength, wallHeight, [ 0, 0 ]);
        translate([windowLeftReveal,0,0])
          window_cutout(windowWidth, windowHeight,windowHeightFromFloor);
//      }
//      translate([windowLeftReveal,0,0])
//        window_frame(windowWidth, windowHeight,windowHeightFromFloor);
    }

  // South Wall with Window
  //  translate([ southWallLength + 1 * (two_by_four_depth + drywallThickness), drywallThickness, 0 ])
  //      rotate([ 0, 0, 180 ])
  //          wall(southWallLength + 2 * (two_by_four_depth + drywallThickness), wallHeight, [ -1, -1 ]);
  //
  //  // East Wall
  //  translate([ southWallLength, eastWallLength, 0 ])
  //      rotate([ 0, 0, -90 ])
  //          wall(eastWallLength, wallHeight, [ 0, 0 ]);
  //
  //  // North Wall with Window
  //  translate([ -two_by_four_depth - drywallThickness, westWallLength - drywallThickness, 0 ])
  //      rotate([ 0, 0, 0 ])
  //          wall(northWallLength + 2 * (two_by_four_depth + drywallThickness), wallHeight, [ -1, -1 ]);
}

dining_kitchen();
