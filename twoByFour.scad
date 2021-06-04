include<standards.scad>;

module twoByFour(length)
{
  cube([ length, twoByFourWidth, twoByFourHeight ]);
}

twoByFour(48);
