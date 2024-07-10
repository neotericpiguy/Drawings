include<cabinet_standards>;

module faceframe() {
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

  dimentor(base_cabinet_width, stile_thickness, stile_height, 2);
}

// Exterior
faceframe();
