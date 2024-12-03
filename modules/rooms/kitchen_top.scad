include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;

wallHeight = 116;

module table(width = 42, length = 66, height = 28.5) {
  skirtHeight = 6;
  legWidth = 3;

  translate([ 0, 0, height - skirtHeight ]) {
    cube([ width, length, skirtHeight ]);
  }

  translate([ 0, 0, 0 ]) {
    cube([ legWidth, legWidth, height - skirtHeight ]);
  }
  translate([ width - legWidth, 0, 0 ]) {
    cube([ legWidth, legWidth, height - skirtHeight ]);
  }

  translate([ 0, length - legWidth, 0 ]) {
    cube([ legWidth, legWidth, height - skirtHeight ]);
  }
  translate([ width - legWidth, length - legWidth, 0 ]) {
    cube([ legWidth, legWidth, height - skirtHeight ]);
  }

  translate([ 0, 0, height ]) {
    dimentor(width, 1, 0, 4);
  }
  translate([ 12, 0, height ]) {
    rotate([ 0, 0, 90 ]) {
      dimentor(length, 1, 0, 4);
    }
  }
}

module dining() {
  westWallLength = 92;
  southWallLength = 8 * 12;
  backDoorLength = 60;
  backDoorHeight = 80;

  northWallLeftReveal = 48;
  northWallRightReveal = 52;
  northWallLength = northWallLeftReveal + backDoorLength + northWallRightReveal;

  windowLeftReveal = 17;
  windowHeightFromFloor = 23;
  windowWidth = 58.5;
  windowHeight = 58.5;
  eastWallLength = 115;

  // West Wall
  //  translate([ 0, 0, 0 ]) {
  //    rotate([ 0, 0, 180 ]) {
  //      dimentor(westWallLength, 12, 0, 4);
  //      wall(westWallLength + two_by_four_depth + drywallThickness, wallHeight, [ 0, -1 ]);
  //    }
  //  }

  // North Wall
  translate([ -westWallLength, -drywallThickness, 0 ]) {
    rotate([ 0, 0, 90 ]) {
      difference() {
        wall(northWallLength, wallHeight, [ 0, 0 ]);
        translate([ northWallLeftReveal, 0, 0 ]) {
          wall_cutout(backDoorLength, backDoorHeight, 0, wallHeight);
        }
      }

      translate([ northWallLeftReveal, 0, 0 ]) {
        double_door_frame(backDoorLength, backDoorHeight, wallHeight);
        dimentor(backDoorLength, 6, 0, 4);
        translate([ backDoorLength, 0, 0 ]) {
          dimentor(northWallRightReveal, 6, 0, 4);
        }
      }

      dimentor(northWallLength, 12, 0, 4);
      dimentor(northWallLeftReveal, 6, 0, 4);
    }
  }

  // East Wall
  translate([ -westWallLength - two_by_four_depth - drywallThickness, northWallLength - drywallThickness * 2, 0 ]) {
    rotate([ 0, 0, 0 ]) {
      translate([ two_by_four_depth + drywallThickness, 0, 0 ]) {
        dimentor(eastWallLength, 12, 0, 4);
        dimentor(windowLeftReveal, 4, 0, 4);
        translate([ windowLeftReveal, 0, 0 ]) {
          dimentor(windowWidth, 4, 0, 4);
        }
      }

      difference() {
        wall(eastWallLength + two_by_four_depth + drywallThickness, wallHeight, [ -1, 0 ]);
        translate([ two_by_four_depth + drywallThickness + windowLeftReveal, 0, 0 ]) {
          wall_cutout(windowWidth, windowHeight, windowHeightFromFloor, wallHeight);
        }
      }
      translate([ two_by_four_depth + drywallThickness + windowLeftReveal, 0, 0 ]) {
        window_frame(windowWidth, windowHeight, windowHeightFromFloor, wallHeight);
      }
    }

    tableWidth = 40;
    tablelength = 72;
    tableHeight = 30;
    spaceBetweenWindowAndTable = 24;
    tablePlacementX = windowLeftReveal + (windowWidth - tableWidth) / 2 + 12;

    translate([ tablePlacementX, -spaceBetweenWindowAndTable - tablelength, 0 ]) {
      table(tableWidth, tablelength, tableHeight);

      translate([ -tablePlacementX + two_by_four_depth + drywallThickness, tablelength, 0 ]) {
        dimentor(tablePlacementX - two_by_four_depth - drywallThickness, -12, 0, 4);
      }
      translate([ 0, tablelength, 0 ]) {
        rotate([ 0, 0, 90 ]) {
          dimentor(spaceBetweenWindowAndTable, -12, 0, 4);
        }
      }
    }
  }

  translate([ eastWallLength - westWallLength, northWallLength - two_by_four_height + drywallThickness, 0 ]) {
    rotate([ 0, 0, 90 ]) {
      kitchen();
    }
  }
}

dining();
