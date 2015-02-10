ss_diameter = 16;
ss_span = 9.5;
ss_width = 45;
ss_height = 20;
ss_top_margin = 10;

// Automatic calculated variables.
ss_y_padding = (ss_height - ss_diameter) / 2;
ss_x_padding = (ss_width - ss_span) / 2 - ss_diameter;

module sonic_sensor_2d_dimension()
{
	difference() {
		square(size = [ss_width, ss_height]);

		for (x = [ss_x_padding + ss_diameter / 2,
				  ss_x_padding + ss_diameter * 1.5 + ss_span])
		{
			translate([x, ss_height / 2])
				circle(r = ss_diameter / 2, $fn = 50);
		}
	}
}

module sonic_sensor_holes()
{
	for (x = [ss_x_padding + ss_diameter / 2,
			  ss_x_padding + ss_diameter * 1.5 + ss_span])
	{
		translate([x, ss_height / 2])
			circle(r = ss_diameter / 2, $fn = 50);
	}
}