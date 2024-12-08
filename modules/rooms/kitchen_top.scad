include<standards>;

include<cabinet_standards>;
use<kitchen.scad>;
use<dining.scad>;
use<laundry_room.scad>;

dining();

translate([ 115 - 92, 160, 0 ]) {
  rotate([ 0, 0, 0 ]) {
    kitchen();
  }
}

translate([ 108 + 28 - 5, 18, 0 ]) {
  rotate([ 0, 0, -90 ]) {
    laundry_room();
  }
}
