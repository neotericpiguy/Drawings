include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;
use<base_cabinet.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

wallHeight = 116;

module table(width = 42, length = 66, height = 28.5, type = "basic") {
  if (type == "basic")
  {
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

module dining(
    roomWalls = [
      // Dining Rom
      [ 92, 0 ],                                     // west wall
      [ 48 + 60 + 52, -90, [ [ 60, 80 ], 52, 0 ] ],  // north wall with double door
      [ 115, -90, [ [ 58.5, 58.5 ], 17, 23.5 ] ],    // East wall with big window
    ]) {
  west_wall_length = roomWalls[0][0];
  north_wall_length = roomWalls[1][0];

  window_left_reveal = roomWalls[2][2][1];
  window_length = roomWalls[2][2][0][0];

  hutch_width = 60;
  hutch_depth = 18;
  hutch_height = 32;
  rotate([ 0, 0, 180 ]) {
    wall_run(roomWalls);
    translate([ west_wall_length - hutch_width, -hutch_depth, 0 ]) {
      base_cabinet(hutch_width, depth = hutch_depth, height = hutch_height);
    }
    translate([ west_wall_length - hutch_width, 0, 0 ]) {
      dim_length(hutch_width, -3, hutch_height);
    }
    translate([ west_wall_length - hutch_width, -hutch_depth, 0 ]) {
      rotate([ 0, 0, 90 ]) {
        dim_length(hutch_depth, -3, hutch_height);
      }
    }
        dim_length(west_wall_length-hutch_width, -3, hutch_height);
  }

  // 30x40x78
  table_type = "ridgely";
  tables = [
    [ "basic", [ 40, 66, 28.5 ] ],
    [ "ridgely", [ 40, 78, 30 ] ],
  ];
  table_width = selector(table_type, tables)[1][0];
  table_length = selector(table_type, tables)[1][1];
  table_height = selector(table_type, tables)[1][2];

  spaceBetweenWindowAndTable = 24;
  uncentered_misalignment = 6;

  // Try to center table in front of window
  tablePlacementX = window_left_reveal + (window_length - table_width) / 2 + uncentered_misalignment;

  translate([ -west_wall_length + tablePlacementX, north_wall_length - table_length - spaceBetweenWindowAndTable, 0 ]) {
    table(table_width, table_length, table_height);

    translate([ -tablePlacementX, table_length / 2, 0 ]) {
      dim_length(tablePlacementX, 0, table_height);
    }

    translate([ table_width / 2, table_length, 0 ]) {
      rotate([ 0, 0, 90 ]) {
        dim_length(spaceBetweenWindowAndTable, 0, table_height);
      }
    }
  }
}

dining();
