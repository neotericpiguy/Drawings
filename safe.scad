include<standards.scad>;

module openBox(width = 24, depth = 20, height = 30, wallThickness = 2)
{
  difference()
  {
    // Outside dimensions
    cube([ width, depth, height ]);

    translate([ wallThickness, -wallThickness, wallThickness ])
        cube([ width - 2 * wallThickness, depth, height - 2 * wallThickness ]);
  }
}

module frame(width = 24, depth = 20, height = 30, wallThickness = 2)
{
  difference()
  {
    cube([ width, depth, height ]);
    translate([ wallThickness, -depth / 2, wallThickness ])
        cube([ width - 2 * wallThickness, 2 * depth, height - 2 * wallThickness ]);
  }
}

module safe(width = 24, depth = 20, height = 59.5)
{
  wallThickness = 2;
  lipDepth = 0.5;
  lipWidth = 0.75;

  // Exterior
  openBox(width, depth, height);

  // Door lip
  translate([ wallThickness / 2, 1.5, wallThickness / 2 ])
      frame(width - wallThickness, lipDepth, height - wallThickness, lipWidth + wallThickness / 2);
}

safe();
