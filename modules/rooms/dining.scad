include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;

use<wall.scad>;
use<double_door.scad>;
use<window.scad>;
use<wall_run.scad>;

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
  west_wall_length = 92;
  south_wall_length = 8 * 12;

  north_wall_left_reveal = 48;
  backdoor_length = 60;
  backdoor_height = 80;
  north_wall_right_reveal = 52;
  north_wall_length = north_wall_left_reveal + backdoor_length + north_wall_right_reveal;

  window_left_reveal = 17;
  window_height_from_floor = 23;
  window_length = 58.5;
  window_height = 58.5;
  east_wall_length = 115;

  roomWalls = [[west_wall_length, 0],
               [north_wall_length, -90, [[backdoor_length, backdoor_height], north_wall_left_reveal, 0]],
               [east_wall_length, -90, [[window_length, window_height], window_left_reveal, window_height_from_floor]],
  ];

  rotate([ 0, 0, 180 ]) {
    wall_run(roomWalls);
  }

  //  translate([ east_wall_length - west_wall_length, north_wall_length, 0 ]) {
  //    rotate([ 0, 0, 0 ]) {
  //      kitchen();
  //    }
  //  }

  table_width = 40;
  table_length = 66;
  table_height = 30;
  spaceBetweenWindowAndTable = 24;
  tablePlacementX = window_left_reveal + (window_length - table_width) / 2 + 6;

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
