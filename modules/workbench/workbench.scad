include<standards>;

module workbench(length = 72, depth = 24, height = 5 * 12) {
  workbench_leg_width = 1.5;
  workbench_leg_thickness = 1 / 16;
  workbench_leg_height = 36;
  workbench_shelf_thickness = 1 / 2;
  workbench_shelf_support_height = 2;

  module workbench_leg(height = 40) {
    cube([ workbench_leg_width, workbench_leg_thickness, height ]);
    translate([ workbench_leg_thickness, workbench_leg_thickness, 0 ])
        rotate([ 0, 0, 90 ])
            cube([ workbench_leg_width - workbench_leg_thickness, workbench_leg_thickness, height ]);
  }

  module workbench_legs(length, depth, height) {
    // Front Legs
    translate([ 0, 0, 0 ])
        rotate([ 0, 0, 0 ])
            workbench_leg(height);

    translate([ length, 0, 0 ])
        rotate([ 0, 0, 90 ])
            workbench_leg(height);

    // Rear legs
    translate([ 0, depth, 0 ])
        rotate([ 0, 0, -90 ])
            workbench_leg(height);

    translate([ length, depth, 0 ])
        rotate([ 0, 0, 180 ])
            workbench_leg(height);
  }

  module workbench_shelf(length, depth) {
    color([ 0.1, 0.1, 0.1 ]) {
      translate([ 0, 0, workbench_leg_width ])
          cube([ length, depth, workbench_shelf_thickness ]);

      translate([ 0, 0, 0 ])
          rotate([ 0, 0, 0 ])
              cube([ length, workbench_leg_thickness, workbench_shelf_support_height ]);

      translate([ 0, depth - workbench_leg_thickness, 0 ])
          rotate([ 0, 0, 0 ])
              cube([ length, workbench_leg_thickness, workbench_shelf_support_height ]);

      translate([ length, workbench_leg_thickness, 0 ])
          rotate([ 0, 0, 90 ])
              cube([ depth - 2 * workbench_leg_thickness, workbench_leg_thickness, workbench_shelf_support_height ]);

      translate([ workbench_leg_thickness, workbench_leg_thickness, 0 ])
          rotate([ 0, 0, 90 ])
              cube([ depth - 2 * workbench_leg_thickness, workbench_leg_thickness, workbench_shelf_support_height ]);
    }
  }

  pegboard_thickness = 1 / 4;
  module workbench_pegboard(length = 36, height = 24) {
    peg_spacing_x = 1;
    peg_spacing_z = 1;

    module workbench_pegboard_peg() {
      pegboard_holedia = 1 / 8;
      translate([ 0, 0, 0 ])
          rotate([ -90, 0, 0 ])
              cylinder(pegboard_thickness * 2, 1 / 8, 1 / 8);
    }

    difference() {
      cube([ length, pegboard_thickness, height ]);
      for (x = [peg_spacing_x:peg_spacing_x:length - peg_spacing_x])
      {
        for (z = [peg_spacing_z:peg_spacing_z:height - peg_spacing_z])
        {
          translate([ x, -pegboard_thickness, z ])
              workbench_pegboard_peg();
        }
      }
    }
  }

  workbench_legs(length, depth, workbench_leg_height);

  // Bottom shelf
  translate([ workbench_leg_thickness, workbench_leg_thickness, 8 ])
      workbench_shelf(length - 2 * workbench_leg_thickness, depth - 2 * workbench_leg_thickness);

  // work top
  translate([ workbench_leg_thickness,
              workbench_leg_thickness,
              workbench_leg_height - workbench_shelf_thickness -
              workbench_leg_width ])
      workbench_shelf(length - 2 * workbench_leg_thickness, depth - 2 * workbench_leg_thickness);

  // Peb board support legs
  translate([ 0, depth, workbench_leg_height ])
      rotate([ 0, 0, -90 ])
          workbench_leg(height - workbench_leg_height);

  translate([ length, depth, workbench_leg_height ])
      rotate([ 0, 0, 180 ])
          workbench_leg(height - workbench_leg_height);

  // top shelf
  translate([ workbench_leg_thickness, depth - 12 - workbench_leg_thickness, height - workbench_shelf_thickness - workbench_leg_width ])
      workbench_shelf(length - 2 * workbench_leg_thickness, 12);

  // Pegboard
  translate([ workbench_leg_thickness, depth - workbench_leg_thickness - pegboard_thickness, workbench_leg_height ])
      workbench_pegboard(length - 2 * workbench_leg_thickness, height - workbench_leg_height - workbench_shelf_support_height);
}

workbench();
