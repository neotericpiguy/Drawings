include<standards>;

module workbench(length = 72, depth = 24, height = 5 * 12) {
  workbench_leg_width = 2.0;
  workbench_leg_thickness = 1 / 8;
  workbench_leg_height = 36;
  workbench_shelf_thickness = 1 / 2;

  module workbench_leg(height = 40) {
    cube([ workbench_leg_width, workbench_leg_thickness, height ]);
    translate([ workbench_leg_thickness, workbench_leg_thickness, 0 ])
        rotate([ 0, 0, 90 ])
            cube([ workbench_leg_width - workbench_leg_thickness, workbench_leg_thickness, height ]);
  }

  module workbench_legs(length, depth, height) {
    // Legs
    translate([ 0, 0, 0 ])
        rotate([ 0, 0, 0 ])
            workbench_leg(height);

    translate([ length, 0, 0 ])
        rotate([ 0, 0, 90 ])
            workbench_leg(height);

    translate([ 0, depth, 0 ])
        rotate([ 0, 0, -90 ])
            workbench_leg(height);

    translate([ length, depth, 0 ])
        rotate([ 0, 0, 180 ])
            workbench_leg(height);
  }

  module workbench_shelf(length, depth) {
    translate([ 0, 0, 2 ])
        cube([ length, depth, workbench_shelf_thickness ]);

    translate([ 0, 0, 0 ])
        rotate([ 0, 0, 0 ])
            cube([ length, workbench_leg_thickness, workbench_leg_width ]);
    translate([ 0, depth - workbench_leg_thickness, 0 ])
        rotate([ 0, 0, 0 ])
            cube([ length, workbench_leg_thickness, workbench_leg_width ]);

    translate([ length, workbench_leg_thickness, 0 ])
        rotate([ 0, 0, 90 ])
            cube([ depth - 2 * workbench_leg_thickness, workbench_leg_thickness, workbench_leg_width ]);

    translate([ workbench_leg_thickness, workbench_leg_thickness, 0 ])
        rotate([ 0, 0, 90 ])
            cube([ depth - 2 * workbench_leg_thickness, workbench_leg_thickness, workbench_leg_width ]);
  }

  workbench_legs(length, depth, workbench_leg_height);

  translate([ workbench_leg_thickness, workbench_leg_thickness, 8 ])
      workbench_shelf(length - 2 * workbench_leg_thickness, depth - 2 * workbench_leg_thickness);

  translate([ workbench_leg_thickness,
              workbench_leg_thickness,
              workbench_leg_height - workbench_shelf_thickness - workbench_leg_width])
      workbench_shelf(length - 2 * workbench_leg_thickness, depth - 2 * workbench_leg_thickness);
}

workbench(36);
