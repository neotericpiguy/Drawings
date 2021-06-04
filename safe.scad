include<standards>;

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

module keypad()
{
  frameDepth = 3 / 8;
  frameDia= 4;
  padDepth = 3.75;

  rotate([ 90, 0, 0 ])
  {
    cylinder(frameDepth, frameDia, frameDia);
    translate([ 0, 0, frameDepth ])
        cylinder(1, padDepth, padDepth);
  }
}

module safeDoor(width = 19.75, height = 54.75, angle = 0)
{
  doorThickness = 1;
  doorPadding = 2.75;
  lip = 1;
  hingeHeight = 5;
  hingeDia = 1;

  rotate([ 0, 0, angle ])
      translate([ -width, 0, 0 ])
  {
    cube([ width, doorThickness, height ]);
    translate([ lip, lip, lip ])
        cube([ width - 2 * lip, doorPadding, height - 2 * lip ]);

    translate([ 0, 0, height * (2 / 3) ])
        translate([ width, -1 / 2, -hingeHeight / 2 ])
            cylinder(hingeHeight, hingeDia / 2, hingeDia / 2);

    translate([ 0, 0, height * (1 / 3) ])
        translate([ width, -1 / 2, -hingeHeight / 2 ])
            cylinder(hingeHeight, hingeDia / 2, hingeDia / 2);

    translate([ width / 2, 0, height * (2 / 3) ])
        keypad();

    translate([ width / 2, 0, height * (15 / 32) ])
        doorHandle();
  }
}

module doorHandle()
{
  handleLength = 4;
  outsideDia = 2;
  spokes = 3;

  rotate([ 90, 0, 0 ])
  {
    cylinder(3 / 4, outsideDia, outsideDia);
    translate([ 0, 0, 3 / 4 ])
        cylinder(1, 2, 1.5);
  }

  angInc = 360 / spokes;

  for (x = [0:angInc:360])
  {
    rotate([ -25, x, 0 ])
        translate([ 0, 0, -handleLength - outsideDia ])
            cylinder(handleLength + 0.25, 7 / 8, 0.5);
  }
}

module safe(doorAngle = 60, width = 24, depth = 20, height = 59.5)
{
  wallThickness = 2;
  lipDepth = 0.5;
  lipWidth = 0.75;

  doorMargin = 0.25;

  // Exterior
  openBox(width, depth, height);

  // Door lip
  translate([ wallThickness / 2, 1.5, wallThickness / 2 ])
      frame(width - wallThickness, lipDepth, height - wallThickness, lipWidth + wallThickness / 2);

  // Door
  doorSafeWidth = width - 2 * wallThickness - doorMargin;
  translate([ wallThickness + doorMargin / 2 + doorSafeWidth, 0, wallThickness + doorMargin / 2 ])
      safeDoor(doorSafeWidth, height - 2 * wallThickness - doorMargin, doorAngle);
}

safe();
