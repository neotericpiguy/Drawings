include<cabinet_standards>;

module dim_length(length = 42, offset = 12, height = 8 * 12, location = 1) {
  color([ 0, 0, 0 ]) {
    translate([ 0, offset, height ]) {
      if (length < 6)
        dimensions(length, loc = location);
      else
        dimensions(length);
    }
  }
}

module dimentor(width, depth, height, offset = 2, side = 0) {
  if (dimOn)
  {
    color([ 0, 0, 0 ]) {
      if (width != 0 && depth != 0 && height == 0)
      {
        // Width
        translate([ 0, depth + offset, 0 ]) {
          if (width > 12)
            dimensions(width);
          else
            dimensions(width);
        }
      }

      if (width > 0 && height != 0)
      {
        // Width
        translate([ 0, depth + offset, 0 ]) {
          if (width > 12)
            dimensions(width);
          else
            dimensions(width);
        }
      }
      if (depth > 0 && height != 0)
      {
        // Depth
        translate([ -offset, 0, 0 ]) {
          rotate([ 0, 0, 90 ]) {
            if (depth > 12)
              dimensions(depth);
            else
            {
              if (side == 0)
                dimensions(depth, loc = 1);
              else
                dimensions(depth, loc = side);
            }
          }
        }
      }

      // side view
      if (height > 0)
      {
        if (depth > 0)
        {
          // Height
          translate([ width, 0, -offset ]) {
            rotate([ 90, 0, 90 ]) {
              if (depth > 12)
                dimensions(depth);
              else
                dimensions(depth, loc = 1);
            }
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
}
