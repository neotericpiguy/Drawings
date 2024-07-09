include<cabinet_standards>;
use<two_by_four.scad>;

// Exterior
module platform(base_cabinet_width) {
  platform_depth = base_cabinet_depth - toekick_depth;
  platform_height = toekick_height;
  platform_width = base_cabinet_width - 2 * ear;

  // platform
  //  cube([ platform_width, platform_depth, platform_height ]);

  // Front
  two_by_four(platform_width);
  // back
  translate([ 0, platform_depth - two_by_four_height, 0 ])
      two_by_four(platform_width);

  // left
  translate([ two_by_four_height, two_by_four_height, 0 ])
      rotate([ 0, 0, 90 ])
          two_by_four(platform_depth - 2 * two_by_four_height);
  // right
  translate([ platform_width, two_by_four_height, 0 ])
      rotate([ 0, 0, 90 ])
          two_by_four(platform_depth - 2 * two_by_four_height);

  translate([ two_by_four_height, (platform_depth + two_by_four_depth) / 2, two_by_four_depth - two_by_four_height ])
      rotate([ 90, 0, 0 ])
          two_by_four(platform_width - 2 * two_by_four_height);

  if (dimOn)
  {
    color([ 0, 0, 0 ]) {
      // top view
      translate([ 0, -6, 0 ])
          dimensions(platform_width);
      translate([ -2, 0, 0 ])
          rotate([ 0, 0, 90 ])
              dimensions(platform_depth);

      // side view
      translate([ 0, platform_depth + 2, 0 ])
          rotate([ 90, -90, 90 ])
              dimensions(platform_height, loc = 1);
      translate([ platform_width, 0, -2 ])
          rotate([ 90, 0, 90 ])
              dimensions(platform_depth);
    }
  }
}

platform(36);
