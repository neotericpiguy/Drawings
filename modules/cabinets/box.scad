include<cabinet_standards>;

module box(base_cabinet_width = 36) {
  box_width = base_cabinet_width - 2 * ear;
  // Left Side
  cube([ box_thickness, box_depth, box_height ]);

  // Right Side
  translate([ box_width - box_thickness, 0, 0 ])
      cube([ box_thickness, box_depth, box_height ]);

  // Floor
  translate([ box_thickness, 0, stile_thickness ])
      cube([ box_width - 2 * box_thickness, box_depth, box_thickness ]);

  // Backing
  translate([ box_thickness, box_depth - box_thickness, box_height - 2 * rail_height ])
      cube([ box_width - 2 * box_thickness, box_thickness, 2 * rail_height ]);

  translate([ box_thickness, 0, 6 ])
      dimentor(box_width - 2 * box_thickness, box_depth, 0, -2);
}

box();
