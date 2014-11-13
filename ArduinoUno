// Reversed from Arduino Uno's Eagle board files.
uno_p1 = [0, 53.34];
uno_p2 = [64.516, 53.34];
uno_p3 = [66.04, 51.816];
uno_p4 = [66.04, 40.386];
uno_p5 = [68.58, 37.846];
uno_p6 = [68.58, 5.08];
uno_p7 = [66.04, 2.54];
uno_p8 = [66.04, 0];
uno_p9 = [0, 0];
uno_points = [uno_p1, uno_p2, uno_p3, uno_p4, uno_p5, uno_p6, uno_p7, uno_p8, uno_p9];

uno_hole1 = [15.24, 50.8];
uno_hole2 = [66.04, 35.56];
uno_hole3 = [66.04, 7.62];
uno_hole4 = [13.97, 2.54];
uno_hole_size = 3.2;

// Automatic calculated variables.
uno_hole_radius = uno_hole_size / 2;

difference() {
	polygon(points = uno_points, paths = [[0, 1, 2, 3, 4, 5, 6, 7, 8]]);

	translate(uno_hole1)
		circle(r = uno_hole_radius, $fn = 10);
	translate(uno_hole2)
		circle(r = uno_hole_radius, $fn = 10);
	translate(uno_hole3)
		circle(r = uno_hole_radius, $fn = 10);
	translate(uno_hole4)
		circle(r = uno_hole_radius, $fn = 10);
}
