/*
 * Big Size:
 */
/*
// Manfacturing variables
inner_compensate = 0.3;
outter_compensate = 0.2;
board_thickness = 3;
box_padding = 7;

x_mortise_size = 70;
x_mortise_count = 1;

y_mortise_size = 40;
y_mortise_count = 1;

z_mortise_size = 20;
z_mortise_count = 1;

// Design variables.
box_inner_width = 140;
box_inner_length =100;
box_inner_height = 50;
*/

/*
 * Small Size:
 */
// Manfacturing variables
inner_compensate = 0.3;
outter_compensate = 0.2;
board_thickness = 3;
box_padding = 5;

x_mortise_size = 70;
x_mortise_count = 1;

y_mortise_size = 40;
y_mortise_count = 1;

z_mortise_size = 20;
z_mortise_count = 1;

// Design variables.
box_inner_width = 100;
box_inner_length = 80;
box_inner_height = 40;

// Automatic-calculated variables.
box_outter_width = box_inner_width + (box_padding + board_thickness + outter_compensate) * 2;
box_outter_length = box_inner_length + (board_thickness + outter_compensate) * 2;
box_outter_height = box_inner_height + (board_thickness + outter_compensate) * 2;

x_mortise_space = (box_inner_width - x_mortise_size * x_mortise_count) / (x_mortise_count + 1);
echo ("X Mortise Space => ", x_mortise_space);

y_mortise_space = box_inner_length / y_mortise_count - y_mortise_size;
echo ("Y Mortise Space => ", y_mortise_space);

z_mortise_space = (box_inner_height - z_mortise_size * z_mortise_count) / (z_mortise_count + 1);
echo ("Z Mortise Space => ", z_mortise_space);

/*
 *
 * 建立平面 DXF 檔
 *
 */

base_board();
//translate([outter_compensate, box_outter_length + board_thickness])
//	base_board();

translate([-(box_outter_height + board_thickness), outter_compensate]) 
	side_board();
//translate([-(box_outter_height + board_thickness), box_outter_length + board_thickness]) 
//	side_board();

translate([outter_compensate, -(box_outter_height + board_thickness)])
	face_board();
//translate([outter_compensate, -(box_outter_height + board_thickness) * 2])
//	face_board();

// 建立底板
/*
color("Brown")
linear_extrude(height = board_thickness)
	base_board();

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
	side_board();

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
*/

/*
 *
 * Shape Modules
 *
 */

// 面板
module face_board() {
	union() {
		difference() {
			translate([0, board_thickness])
				square(size = [box_outter_width, box_outter_height - board_thickness * 2]);

			for (y = [board_thickness + z_mortise_space: z_mortise_size + z_mortise_space + inner_compensate: box_inner_height]) {
				translate([box_padding + outter_compensate, y + outter_compensate])
					square(size = [board_thickness + inner_compensate * 2 , z_mortise_size + inner_compensate * 2]);
				translate([box_outter_width - box_padding - board_thickness - outter_compensate, y + outter_compensate])
					square(size = [board_thickness + inner_compensate * 2, z_mortise_size + inner_compensate * 2]);
			}
		}

		for (x = [x_mortise_space + board_thickness + box_padding: x_mortise_size + x_mortise_space + outter_compensate * 2: box_inner_width]) {
			echo("X => ", x);
			translate([x, outter_compensate])
				square(size = [x_mortise_size + outter_compensate * 2, board_thickness + inner_compensate]);
			translate([x, box_outter_height - board_thickness - outter_compensate])
				square(size = [x_mortise_size + outter_compensate * 2, board_thickness + inner_compensate]);
		}
	}
}

// 側版
module side_board() {
	for (y = [y_mortise_space / 2 + board_thickness : y_mortise_size + y_mortise_space + outter_compensate: box_outter_length]) {
		echo("Y => ", y);
		translate([outter_compensate, y + outter_compensate])
			square(size = [board_thickness - outter_compensate, y_mortise_size - outter_compensate]);
		translate([box_outter_height - board_thickness - outter_compensate, y + outter_compensate])
			square(size = [board_thickness - outter_compensate, y_mortise_size - outter_compensate]);
	}

	difference() {
		translate([board_thickness, outter_compensate])
			square(size = [box_outter_height - board_thickness * 2, box_outter_length - outter_compensate]);

		for (x = [board_thickness : z_mortise_size + z_mortise_space + outter_compensate * 2 : box_outter_height]) {
			translate([x, outter_compensate])
				square(size = [z_mortise_space, board_thickness]);
			translate([x, box_outter_length - board_thickness])
				square(size = [z_mortise_space, board_thickness]);
		}
	}
}

// 底板
module base_board() {
difference() {
	square(size = [box_outter_width, box_outter_length]);

	for (y = [y_mortise_space / 2 + board_thickness : y_mortise_size + y_mortise_space : box_outter_length]) {
		echo("Y => ", y);
		// 左邊榫溝
		translate([box_padding + outter_compensate, y + outter_compensate])
			square(size = [board_thickness + inner_compensate * 2, y_mortise_size + inner_compensate * 2]);
		// 右邊榫溝
		translate([box_outter_width + outter_compensate - box_padding - board_thickness, y + outter_compensate])
			square(size = [board_thickness + inner_compensate * 2, y_mortise_size + inner_compensate * 2]);
	}

	for (x = [x_mortise_space + board_thickness + box_padding : x_mortise_size + x_mortise_space : box_inner_width]) {
		echo("X => ", x);
		// 下邊榫溝
		translate([x + outter_compensate, 0])
			square(size = [x_mortise_size - outter_compensate * 2, board_thickness + outter_compensate]);
		// 上邊榫溝
		translate([x + outter_compensate, box_outter_length - outter_compensate - board_thickness + outter_compensate])
			square(size = [x_mortise_size - outter_compensate * 2, board_thickness + inner_compensate]);
	}
}
}
