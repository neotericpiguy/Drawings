include<cabinet_standards>;

module faceframe(base_cabinet_width = 36) {
  // Left Stile
  cube([ stile_width, stile_thickness, stile_height ]);

  // Right Stile
  translate([ base_cabinet_width - stile_width, 0, 0 ])
      cube([ stile_width, stile_thickness, stile_height ]);

  // Top Rail
  translate([ stile_width, 0, stile_height - rail_height ])
      cube([ base_cabinet_width - stile_width * 2, rail_thickness, rail_height ]);

  // Bottom Rail
  translate([ stile_width, 0, 0 ])
      cube([ base_cabinet_width - stile_width * 2, rail_thickness, rail_height ]);

if (dimOn)
{
  color([ 0, 0, 0 ]) {
    translate([ 0, 0, base_cabinet_height ])
        rotate([ 90, 0, 0 ])
            dimensions(base_cabinet_width);

    translate([ -DIM_LINE_WIDTH, 0, 0 ])
        rotate([ 90, -90, 0 ])
            dimensions(stile_height);
  }
}
}

// Exterior
faceframe(36);
