include<standards>;

module kbbq_table(length = 72, depth = 48, height = 30) {
  top_thickness = 2;
  leg_dia = 6;

  bench_leg_height = 18.5;

  chair_width = 18;

  chair_set_buffer = 6;  // Space between chairs

  grill_dia = 24;

  module table_top(length, depth) {
    color([ 0.0001, 0.0001, 0.0001 ]) {
      difference() {
        cube([ length, depth, top_thickness ]);

        translate([ length / 2, depth / 2, -top_thickness / 2 ])
            cylinder(top_thickness * 2, grill_dia / 2, grill_dia / 2);
      }
    }

    translate([ length / 2, depth / 2, 0 ])
        grill(grill_dia);
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
    n = len(xs);
    x_bar = (xs * [ 1, 1, 1 ]) / n;
    y_bar = (ys * [ 1, 1, 1 ]) / n;
    x2_bar = (xs * xs) / n;
    S_xx = xs * xs - n * x_bar * x_bar;
    S_xy = xs * ys - n * x_bar * y_bar;

    function sum_x3(v, i, s = 0) = (i == s ? v[i] * v[i] * v[i] : v[i] * v[i] * v[i] + sum_x3(v, i - 1, s));
    S_xx2 = sum_x3(xs, n - 1) - n * x_bar * x2_bar;

    function sum_x2x2(v, i, s = 0) = (i == s ? (v[i] * v[i] - x2_bar) * (v[i] * v[i] - x2_bar) : (v[i] * v[i] - x2_bar) * (v[i] * v[i] - x2_bar) + sum_x2x2(v, i - 1, s));
    S_x2x2 = sum_x2x2(xs, n - 1);

    function sum_x2y(v, w, i, s = 0) = (i == s ? (v[i] * v[i] - x2_bar) * (w[i] - y_bar) : (v[i] * v[i] - x2_bar) * (w[i] - y_bar) + sum_x2y(v, w, i - 1, s));
    S_x2y = sum_x2y(xs, ys, n - 1);

    b = (S_xy * S_x2x2 - S_x2y * S_xx2) / (S_xx * S_x2x2 - (S_xx2 * S_xx2));
    c = (S_x2y * S_xx - S_xy * S_xx2) / (S_xx * S_x2x2 - (S_xx2 * S_xx2));
    a = y_bar - b * x_bar - c * x2_bar;

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
}

kbbq_table();
