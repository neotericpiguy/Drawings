include<standards>;

include<cabinet_standards>;
use<base_cabinet.scad>;

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

module kitchen() {
  module countertop(length = 24, cabinet_depth = 24) {
    countertop_overhang = 1.5;
    translate([ -countertop_overhang, -countertop_overhang, 34.5 ]) {
      cube([ length + countertop_overhang, cabinet_depth + countertop_overhang, countertop_overhang ]);
    }
  }

  // Peninsula
  translate([ 0, 0, 0 ]) {
    base_cabinet(33);
    countertop(33 + 24 + 36, 24 + 9);
    translate([ 33, 0, 0 ]) {
      base_cabinet(24);
      translate([ 24, 0, 0 ]) {
        base_cabinet(36);
      }
    }
  }

  // Sink Side
  translate([ 33 + 24 + 36, 24, 0 ]) {
    rotate([ 0, 0, -90 ]) {
      wall(36 + 36 + 36 + drywallThickness + two_by_four_depth, wallHeight, [ 0, -1 ]);
    }
  }
  translate([ 33 + 36, 0, 0 ]) {
    rotate([ 0, 0, -90 ]) {
      base_cabinet(12);
      countertop(12 + 36 + 12);
      translate([ 12, 0, 0 ]) {
        base_cabinet(36);
        translate([ 36, 0, 0 ]) {
          base_cabinet(12);
        }
      }
    }
  }

  // Stove Side
  //  translate([ 33 + 24 + 36 + drywallThickness, -36 * 2 - 12, 0 ]) {
  //    rotate([ 0, 0, 180 ]) {
  //      wall(36 + 36 + 36 + drywallThickness + two_by_four_depth, wallHeight, [ 0, -1 ]);
  //    }
  //  }

  translate([ 33 + 36 + 24, -(12 + 36 + 12), 0 ]) {
    rotate([ 0, 0, 180 ]) {
      countertop(36 + 12 + 30 + 21);
      base_cabinet(36);
      translate([ 36, 0, 0 ]) {
        base_cabinet(12);
        translate([ 12, 0, 0 ]) {
          base_cabinet(30);
          translate([ 30, 0, 0 ]) {
            base_cabinet(21);
          }
        }
      }
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
  translate([ 0, 0, 0 ]) {
    rotate([ 0, 0, 180 ]) {
      dimentor(westWallLength, 12, 0, 4);
      wall(westWallLength + two_by_four_depth + drywallThickness, wallHeight, [ 0, -1 ]);
    }
  }

  // North Wall
  translate([ -westWallLength, -drywallThickness, 0 ]) {
    rotate([ 0, 0, 90 ]) {
      difference() {
        wall(northWallLength, wallHeight, [ 0, 0 ]);
        translate([ northWallLeftReveal, 0, 0 ]) {
          double_door_cutout(backDoorLength, backDoorHeight, wallHeight);
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
      dimentor(eastWallLength, 12, 0, 4);
      dimentor(windowLeftReveal, 4, 0, 4);
      translate([ windowLeftReveal, 0, 0 ]) {
        dimentor(windowWidth, 4, 0, 4);
      }

      difference() {
        wall(eastWallLength, wallHeight, [ -1, 0 ]);
        translate([ windowLeftReveal, 0, 0 ]) {
          window_cutout(windowWidth, windowHeight, windowHeightFromFloor, wallHeight);
        }
      }
      translate([ windowLeftReveal, 0, 0 ]) {
        window_frame(windowWidth, windowHeight, windowHeightFromFloor, wallHeight);
      }
    }

    tableWidth = 42;
    tablelength = 66;
    tableHeight = 33.5;
    spaceBetweenWindowAndTable = 12;

    translate([ windowLeftReveal + (windowWidth - tableWidth) / 2, -spaceBetweenWindowAndTable - tablelength, 0 ]) {
      table(tableWidth, tablelength, tableHeight);
    }
  }

  translate([ -4 + base_cabinet_depth + (eastWallLength - westWallLength), northWallLength - 33 - 24 - 36 - 1, 0 ]) {
    rotate([ 0, 0, 90 ]) {
      kitchen();
    }
  }
}

dining();
