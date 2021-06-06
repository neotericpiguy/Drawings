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

  // Peb board support
  translate([ 0, depth, workbench_leg_height ])
      rotate([ 0, 0, -90 ])
          workbench_leg(height - workbench_leg_height);

  translate([ length, depth, workbench_leg_height ])
      rotate([ 0, 0, 180 ])
          workbench_leg(height - workbench_leg_height);

  // top shelf
  translate([ workbench_leg_thickness, depth - 12 - workbench_leg_thickness, height - workbench_shelf_thickness - workbench_leg_width ])
      workbench_shelf(length - 2 * workbench_leg_thickness,
                      12);
}

workbench(36);
