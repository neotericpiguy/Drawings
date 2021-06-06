include<standards>;

module two_by_four(length) {
  cube([ length, two_by_four_height, two_by_four_depth ]);
}

two_by_four(48);
