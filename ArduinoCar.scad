include <Toolbox.scad>
include <LED.scad>
include <DCMotorN20.scad>
include <SonicSensor.scad>
include <TrackerSensor.scad>
include <ArduinoUno.scad>

module bread_board()
{
	cube(size = [82, 55, 10]);
}

module assembly_zone()
{
	for (i = [0 : $children - 1])
		translate([0, -(box_outter_length * 2), 0])
			child(i);
}


/*
 * Arduino Placement.
 */
arduino_x = 20;
arduino_y = 17;

module place_arduino()
{
	translate([arduino_x, arduino_y])
		child();
}


/*
 * Front Side Config.
 */
face_led_top_margin = 30;
face_led_horizontal_margin = 13;

ts_bottom_margin = 35;
ts_space = 2;

/*
 * Base Board Config.
 */
motor_bottom_margin = 25;
motor_horizontal_margin = 3;
dummy_wheel_top_margin = 25;

/*
 * Automatic calculated variables.
 */
ts_y_start = (box_outter_length - ts_width * 3 - ts_space * 2) / 2;

/*
 * Design Zone.
 */

echo ("前面板");
	difference() {
		side_board();

		// Sonic Sensor Holes.
		translate([box_outter_height - ss_height - ss_top_margin, (box_outter_length - ss_width) / 2 + ss_width])
		rotate(-90, [0, 0, 1])
			sonic_sensor_holes();
		// LEDs.
		for (y = [face_led_horizontal_margin
				, box_outter_length - face_led_horizontal_margin]) {
			translate([box_outter_height - face_led_top_margin, y])
				led_hole();
		}
	}

//color("Brown")
//linear_extrude(height = board_thickness)
/*
difference() {
	base_board();

	echo ("Arduino Uno");
	place_arduino()
		arduino_uno_holes();

	echo ("Tracker Sensor");
	for (i = [0 : 2]) {
		translate([ts_bottom_margin + ts_length,
				 ts_y_start + (ts_space + ts_width) * i ])
			rotate(90, [0, 0, 1])
//			tracker_sensor_2d_dimension();
			tracker_sensor_hole();
	}

	echo ("馬達固定座");
	translate([motor_bottom_margin,
			board_thickness + motor_horizontal_margin])
		n20_mount_holes();
	translate([motor_bottom_margin + n20_mount_width,
			box_outter_length - board_thickness - motor_horizontal_margin])
		rotate(180, [0, 0, 1])
		n20_mount_holes();

	echo ("前輪");

	translate([box_outter_width - dummy_wheel_top_margin,
			 (box_outter_length - dummy_wheel_span) / 2])
	rotate(90, [0, 0, 1])
		dummy_wheel_holes();
}
*/

/*
 * Assembly Zone.
 */ 
assembly_zone() {

// 麵包板
//color("LightSlateGray")
//	bread_board();

/*
 * 外殼
 */

// 建立底板
color("Brown")
linear_extrude(height = board_thickness)
difference() {
	base_board();

	place_arduino()
		arduino_uno_holes();
}

// 建立左側板
color("Chocolate")
translate([box_padding + board_thickness, outter_compensate])
	rotate(-90, [0, 1, 0])
	linear_extrude(height = board_thickness)
	side_board();

// 建立右側板
color("Chocolate")
translate([box_outter_width - box_padding, outter_compensate])
	rotate(-90, [0, 1, 0])
	linear_extrude(height = board_thickness)
	difference() {
		side_board();

		// Sonic Sensor Holes.
		translate([box_outter_height - ss_height - ss_top_margin, (box_outter_length - ss_width) / 2 + ss_width])
		rotate(-90, [0, 0, 1])
			sonic_sensor_holes();
		// LEDs.
		for (y = [face_led_horizontal_margin
				, box_outter_length - face_led_horizontal_margin]) {
			translate([box_outter_height - face_led_top_margin, y])
				led_hole();
		}
	}

// 建立前面板
color("Orange")
translate([0, board_thickness])
	rotate(90, [1, 0, 0])
	linear_extrude(height = board_thickness)
	face_board();

// 建立後面板
color("Orange")
translate([0, box_outter_length])
	rotate(90, [1, 0, 0])
	linear_extrude(height = board_thickness)
	face_board();
}