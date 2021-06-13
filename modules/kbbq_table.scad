include<standards>;

module kbbq_table(length = 72, depth = 48, height = 30) {
  top_thickness = 2;
  leg_dia = 6;

  bench_leg_height = 18.5;

  chair_width = 18;

  chair_set_buffer = 6;  // Space between chairs

  grill_dia = depth / 2;

  module table_top(length, depth) {
    color([ 0.0001, 0.0001, 0.0001 ]) {
      difference() {
        cube([ length, depth, top_thickness ]);

        translate([ length / 2, depth / 2, -top_thickness / 2 ])
            cylinder(top_thickness * 2, grill_dia / 2, grill_dia / 2);
      }
    }

//    translate([ length / 2, depth / 2, 0 ])
//        grill(grill_dia);
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

  module grill(dia = 20, h = 2) {
    r = dia / 2;

    xs = [ 0, 2 / 3 * r, r ];
    ys = [ 0, h / 2, h ];

    reg = QuadReg(xs, ys);

    a = reg[0];
    b = reg[1];
    c = reg[2];

    rotate_extrude()
        polygon([for (x = [0:1:r])[x, a + b * x + c * x * x]]);

    translate([ 0, 0, 2 * h - h / 3 ])
        rotate([ 0, 180, 0 ])
            rotate_extrude()
                polygon([for (x = [0:1:r])[x, a + b * x + c * x * x]]);
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
      table_top(length, depth);

  // Table legs
  translate([ length * 1 / 5, depth / 2, 0 ])
      table_leg(height);

  translate([ length * 4 / 5, depth / 2, 0 ])
      table_leg(height);

  translate([ 0, depth, 0 ])
      bench(length);

  !grill(12);
}

kbbq_table();
