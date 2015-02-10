led_diameter = 5;
led_radius = led_diameter / 2;

module led_hole()
{
	circle(r = led_radius, $fn = 20);
}