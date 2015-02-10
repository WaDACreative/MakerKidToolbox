ts_hole_width = 6;
ts_hole_length = 10.5;
ts_width = 11;
ts_length = 36;

module tracker_sensor_2d_dimension()
{
	difference() {
		square(size = [ts_width, ts_length]);

		tracker_sensor_hole();
	}
}

module tracker_sensor_hole()
{
	translate([(ts_width - ts_hole_width) / 2, ts_length - ts_hole_length - 1])
		square(size = [ts_hole_width, ts_hole_length]);
}