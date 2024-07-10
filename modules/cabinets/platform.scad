include<cabinet_standards>;
use<two_by_four.scad>;

// Exterior
module platform() {
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

  // Center support
  translate([ two_by_four_height, (platform_depth + two_by_four_depth) / 2, two_by_four_depth - two_by_four_height ])
      rotate([ 90, 0, 0 ])
          two_by_four(platform_width - 2 * two_by_four_height);

  dimentor(platform_width, platform_depth, platform_height, 4);
}

platform();
