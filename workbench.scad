sideWallLength = 24;
backWallFullLength = 8 * 12;

enableDrywall = 1;

include<wall.scad>;
include<shelfUnit.scad>;

// Side wall
translate([ 0, sideWallLength, 0 ]) rotate([ 0, 0, -90 ]) wall(sideWallLength);

// Back wall
translate([ -backWallFullLength, sideWallLength, 0 ]) rotate([ 0, 0, 0 ]) wall(backWallFullLength);

// Shelving
translate([ 0, 0, 72 ])
    shelfUnit();

