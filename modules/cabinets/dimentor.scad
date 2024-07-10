include<cabinet_standards>;

module dimentor(width, depth, height, offset) {
  if (dimOn)
  {
    color([ 0, 0, 0 ]) {
      // Width
      translate([ 0, depth + offset, 0 ]) {
        if (width > 12)
          dimensions(width);
        else
          dimensions(width);
      }

      // Depth
      translate([ -offset, 0, 0 ]) {
        rotate([ 0, 0, 90 ]) {
          if (depth > 12)
            dimensions(depth);
          else
            dimensions(depth, loc = 1);
        }
      }

      // Height
      translate([ width, 0, -offset ]) {
        rotate([ 90, 0, 90 ]) {
          if (depth > 12)
            dimensions(depth);
          else
            dimensions(depth, loc = 1);
        }
      }

      translate([ 0, depth + offset, 0 ]) {
        rotate([ 90, -90, 90 ]) {
          if (height > 12)
            dimensions(height);
          else
            dimensions(height, loc = 1);
        }
      }
    }
  }
}

