include<standards>;

include<cabinet_standards>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;

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

  // West Wall
  translate([ 0, 0, 0 ])
      rotate([ 0, 0, 180 ]) {
        dimentor(westWallLength, 12, 0, 4);
        wall(westWallLength+two_by_four_depth+drywallThickness, wallHeight, [ 0, -1 ]);
      }

  // North Wall
  translate([ -westWallLength, -drywallThickness, 0 ])
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
  translate([ -westWallLength-two_by_four_depth-drywallThickness, northWallLength-drywallThickness*2, 0 ])
    rotate([ 0, 0, 0 ])
    {
      dimentor(eastWallLength, 12, 0, 4);
      dimentor(windowLeftReveal, 4, 0, 4);
      translate([windowLeftReveal,0,0])
        dimentor(windowWidth, 4, 0, 4);

      difference() {
        wall(eastWallLength, wallHeight, [ -1, 0 ]);
        translate([windowLeftReveal,0,0])
          window_cutout(windowWidth, windowHeight,windowHeightFromFloor,wallHeight);
      }
      translate([windowLeftReveal,0,0])
        window_frame(windowWidth, windowHeight,windowHeightFromFloor,wallHeight);
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
