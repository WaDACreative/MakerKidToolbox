n20_mount_width = 25.5;
n20_mount_length = 8.5;

n20_mount_hole_diameter = 2;
n20_mount_hole_radius = n20_mount_hole_diameter / 2;
n20_mount_hole_span = 17.5;

module n20_mount_2d_dimension()
{
	difference() {
		square(size = [n20_mount_width, n20_mount_length]);

		n20_mount_holes();
	}
}

module n20_mount_holes()
{
	hole_start = (n20_mount_width - n20_mount_hole_span) / 2;

	for (i = [0: 1]) {
		translate([hole_start + i * n20_mount_hole_span,
				n20_mount_length / 2])
			circle(r = n20_mount_hole_radius, $fn = 10);
	}
}

dummy_wheel_span = 39;
dummy_wheel_hole_diameter = 3;
dummy_wheel_hole_radius = dummy_wheel_hole_diameter / 2;

module dummy_wheel_holes()
{
	for (i = [0: 1]) {
		translate([dummy_wheel_span * i, 0])
			circle(r = dummy_wheel_hole_radius, $fn = 10);
	}
}