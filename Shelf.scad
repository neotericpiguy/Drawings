include<lBracket.scad>

    sideWallLength = 24;
backWallLength = 48 - twoByFourWidth + 0.75;  //FIX

// Side wall
rotate([ 0, 0, 90 ]) twoByFour(sideWallLength);

// Back Wall 1
translate([ -twoByFourWidth, sideWallLength, 0 ])
    rotate([ 0, 0, 180 ])
        twoByFour(backWallLength - twoByFourHeight);

// Back Wall 2
translate([ -twoByFourWidth - backWallLength, sideWallLength, 0 ])
    rotate([ 0, 0, 180 ])
        twoByFour(backWallLength - twoByFourHeight);

// Middle bracket
translate([ -backWallLength, sideWallLength, twoByFourHeight - twoByFourWidth ])
    rotate([ 0, 0, 180 ])
        lBracket();

// End bracket
translate([ -backWallLength - backWallLength, sideWallLength, twoByFourHeight - twoByFourWidth ])
    rotate([ 0, 0, 180 ])
        lBracket();

// Shelf plate
translate([ -12 * 8, 0, twoByFourHeight ]) cube([ 12 * 8, 12 * 4 / 2, 3 / 4 ]);
