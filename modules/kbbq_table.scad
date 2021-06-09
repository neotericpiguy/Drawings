include<standards>;

module kbbq_table(length = 72, depth = 48, height = 30) {
  top_thickness = 2;
  leg_dia = 4;

  bench_leg_height = 18.5;

  chair_width = 18;

  chair_set_buffer = 6;  // Space between chairs

  grill_dia = 10;

  module kbbq_table_top(length, depth) {
    color([ 0.0001, 0.0001, 0.0001 ]) {
      difference() {
        cube([ length, depth, top_thickness ]);

        translate([ length / 2, depth / 2, -top_thickness / 2 ])
            cylinder(top_thickness * 2, grill_dia, grill_dia);
      }
    }

    translate([ length / 2, depth / 2, 0 ])
        grill();
  }

  module table_leg(height) {
    cylinder(height, leg_dia / 2, leg_dia / 2);
  }

  module bench(length = 72, depth = 24, height = 42) {
    bench_leg_height = 18.5;
    bench_backrest_thickness = 3;
    cube([ length, depth, bench_leg_height ]);
    translate([ 0, depth - bench_backrest_thickness, bench_leg_height ])
        cube([ length, bench_backrest_thickness, height - bench_leg_height ]);
  }

  module chair(length = 18, depth = 24, height = 42) {
    chair_leg_thickness = 2;
    difference() {
      bench(length, depth, height);
      translate([ chair_leg_thickness, -depth / 2, 0 ])
          cube([ length - chair_leg_thickness * 2, depth * 2, bench_leg_height - 2 ]);
      translate([ -length / 2, chair_leg_thickness, 0 ])
          cube([ length * 2, depth - chair_leg_thickness * 2, bench_leg_height - 2 ]);
    }
  }

  module grill() {
    color([ 0.753, 0.753, 0.753 ]) {
      rotate_extrude()
          polygon(points = [ [ 0, 0 ], [ 5, 1 ], [ 10, 2 ], [ 9, 2 ], [ 4, 1 ], [ 0, 0.4 ] ]);

      translate([ 0, 0, 3.5 ])
          rotate([ 0, 180, 0 ])
              rotate_extrude()
                  polygon(points = [ [ 0, 0.4 ], [ 5, 1 ], [ 10, 2 ], [ 9, 2 ], [ 4, 1 ], [ 0, 0.7 ] ]);

      rotate_extrude()
          polygon(points = [ [ 0, 0 ], [ 5, 1 ], [ 10, 2 ], [ 9, 2 ], [ 4, 1 ], [ 0, 0.4 ] ]);

      translate([ 0, 0, 3.5 ])
          rotate([ 0, 180, 0 ])
              rotate_extrude()
                  polygon(points = [ [ 0, 0.4 ], [ 5, 1 ], [ 10, 2 ], [ 9, 2 ], [ 4, 1 ], [ 0, 0.7 ] ]);
    }
  }

  chair_set_length = floor(length / (chair_width + chair_set_buffer)) * (chair_width + chair_set_buffer) - chair_set_buffer;
  chair_set_offset = (length - chair_set_length) / 2;

  for (x = [chair_set_offset:chair_width + chair_set_buffer:chair_set_length])
  {
    translate([ chair_width + x, 0, 0 ])
        rotate([ 0, 0, 180 ])
            chair(chair_width);
  }

  translate([ 0, 0, height ])
      kbbq_table_top(length, depth);

  // Table legs
  translate([ length * 1 / 5, depth / 2, 0 ])
      table_leg(height);

  translate([ length * 4 / 5, depth / 2, 0 ])
      table_leg(height);

  translate([ 0, depth / 2 + depth / 2, 0 ])
      bench(length);
}

kbbq_table();
