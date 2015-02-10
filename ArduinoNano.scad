// Reversed from Arduino Nano's Eagle board files.
nano_p1 = [0, 43.18];
nano_p2 = [17.78, 43.18];
nano_p3 = [17.78, 0];
nano_p4 = [0, 0];
nano_points = [nano_p1, nano_p2, nano_p3, nano_p4];

nano_hole1 = [1.27, 41.91];
nano_hole2 = [16.51, 41.91];
nano_hole3 = [16.51, 1.27];
nano_hole4 = [1.27, 1.27];
nano_hole_size = 1.7;

nano_usb_width = 6;
nano_usb_length = 2;

// Automatic calculated variables.
nano_hole_radius = nano_hole_size / 2;

arduino_nano_outline();
module arduino_nano_outline()
{
	difference() {
		polygon(points = nano_points,
				paths = [[0, 1, 2, 3]]);

		arduino_nano_holes();
	}

	translate([(nano_p2[0] - nano_usb_width) / 2, -nano_usb_length])
		square(size = [nano_usb_width, nano_usb_length]);
}

module arduino_nano_holes()
{
	translate(nano_hole1)
		circle(r = nano_hole_radius, $fn = 10);
	translate(nano_hole2)
		circle(r = nano_hole_radius, $fn = 10);
	translate(nano_hole3)
		circle(r = nano_hole_radius, $fn = 10);
	translate(nano_hole4)
		circle(r = nano_hole_radius, $fn = 10);
}
