include<lBracket.scad>;

module wall(length, height = 8 * 12)
{
  studCenters = 16;
  drywallThickness = 1 / 2;
  for (x = [0:studCenters:length])
  {
    translate([ x, drywallThickness, 0 ])
        rotate([ 0, -90, -90 ])
            twoByFour(height);
  }

  // Landed on an un even stud center
  if (length % studCenters != 0)
  {
    translate([ length - twoByFourWidth, drywallThickness, 0 ])
        rotate([ 0, -90, -90 ])
            twoByFour(height);
  }

  // Drywall
  if (enableDrywall)
    cube([ length, drywallThickness, height ]);
}
