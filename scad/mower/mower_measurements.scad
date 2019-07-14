

wheel_motor_diameter=37.5;
wheel_motor_total_height=71;
wheel_motor_nub_diameter=12.25;
wheel_motor_nub_height=5.5;
wheel_motor_narrow_height=36;
wheel_motor_narrow_diameter=35.61;
wheel_motor_height=wheel_motor_total_height-wheel_motor_nub_height-wheel_motor_narrow_height;
wheel_motor_mount_width=wheel_motor_diameter+18;
wheel_motor_mount_length=wheel_motor_diameter/2+5;
wheel_motor_mount_height=wheel_motor_height+wheel_motor_narrow_height+wheel_motor_nub_height;
wheel_motor_shaft_diameter=6;
wheel_motor_shaft_height=15;
wheel_motor_shaft_D_width=5.4;
wheel_motor_bearing_inner_diameter=15;
wheel_motor_bearing_outer_diameter=24.1;
wheel_motor_bearing_width=5;
wheel_motor_mount_hole_radius=15.5;
wheel_motor_mount_rail_interval=12.5;
wheel_motor_mount_rail_width=15;
wheel_motor_mount_rail_depth=12.75;
wheel_motor_mount_rail_height=wheel_motor_mount_rail_interval*5+wheel_motor_mount_length;

// Start of wheel dimensions
wheel_prism_height=15;
wheel_prism_width=10;
wheel_prism_length=6;
wheel_diameter=210;
wheel_radius=wheel_diameter/2;
wheel_height=30;
wheel_screw_depth=6;

// Wheel mount dimensions
wheel_mount_diameter=30;
wheel_mount_height=wheel_motor_shaft_height-wheel_motor_bearing_width+2;
wheel_mount_screw_height=12;
wheel_mount_screw_depth=wheel_mount_screw_height-wheel_screw_depth+2;
wheel_mount_total_height=wheel_motor_bearing_width+1+wheel_mount_height;


// Start of m3 screw dimensions
screw_diameter=3;
screw_head_diameter=5;
screw_head_height=3;

// Start of m3 nut dimensions
nut_diameter=6;
nut_height=2.25;

// Start of m4 screw dimensions
m4_screw_diameter=3.87;
m4_screw_head_diameter=6.85;
m4_screw_head_height=3.81;

// Start of m3 nut dimensions
m4_nut_diameter=7.83;
m4_nut_height=3.03;

// Start of mower blade dimensions
total_blade_radius=107;
blade_mount_radius=90;
blade_mount_outer_thickness=4.15;
blade_mount_inner_thickness=9.5;
blade_mount_outer_screw_radius=83.81;
blade_mount_inner_screw_radius=10.5;
blade_mount_taper_outer_radius=blade_mount_radius-26.88;
blade_mount_taper_inner_radius=blade_mount_taper_outer_radius-13.89;
blade_mount_taper_angle=45;
blade_mount_taper_radius=(blade_mount_taper_outer_radius-blade_mount_taper_inner_radius)/sin(blade_mount_taper_angle);

// Start of mower base dimensions
blade_overlap=0.10;
blade_gap=5;
blade_hypotnuse=2*total_blade_radius+blade_gap;
blade_x_offset=(2-blade_overlap)*total_blade_radius;
blade_y_offset=sqrt(blade_hypotnuse*blade_hypotnuse-blade_x_offset*blade_x_offset);
blade_offset_angle=atan(blade_y_offset/blade_x_offset);
blade_total_width=blade_x_offset+2*total_blade_radius;
base_thickness=3;
base_wall_thickness=4;
base_width=2*base_wall_thickness+2*blade_gap+blade_total_width;
base_blade_indent_length=2*total_blade_radius+blade_y_offset+2*blade_gap+2*base_wall_thickness;
base_blade_indent_height=15;
base_blade_rounding_radius=5;
base_mounting_screw_length=8;
base_mounting_nut_depth=4;
base_wheel_buffer_x=5;
base_wheel_buffer_y=10;

// Start of GPS mount dimensions
gps_board_x=43.8;
gps_board_y=43.27;
gps_board_y_plus=45.9;
gps_board_antenna_z=31;
gps_hole_offset=2.54;
gps_board_mount_lip=7.5;
gps_board_mount_lip_thickness=5;
gps_board_solder_cutout=3.5;

// Start of 40mm fan dimensions
fan_depth=10.5;
fan_height=40;
fan_width=40;
fan_hole_distance=32;
fan_hole_offset=(fan_width-fan_hole_distance)/2;
fan_mount_thickness=3;
fan_duct_depth=15;

// Start of Motor Driver mount dimensions
motor_driver_width=43;
motor_driver_length=43;
motor_driver_hole_distance=36.5;
motor_driver_hole_offsets=(motor_driver_length-motor_driver_hole_distance)/2;
motor_driver_heatsink_width=23;
motor_driver_heatsink_height=25;
motor_driver_board_thickness=1.5;
motor_base_skirt_width=10;
motor_driver_base_width=motor_driver_width+motor_base_skirt_width*2;
motor_driver_base_length=motor_driver_length+motor_base_skirt_width*2+fan_depth;
motor_driver_base_hole_offsets=4;
motor_driver_base_height=4;
motor_driver_base_standoff=8;
motor_driver_base_standoff_diameter=6;

// Start of battery measurements
battery_charger_width=51;
battery_charger_height=56.68;
battery_charger_thickness=1.25;
battery_charger_pad1=7.5;
battery_charger_pad2=12.5;
battery_charger_pad3=30;
battery_charger_pad4=37.5;
battery_charger_pad5=45;
battery_charger_lip_height=3;
battery_diameter=19.00;
battery_height=69.6;
battery_holder_spacing=2;
batteries_x_count=6;
batteries_y_count=3;
battery_holder_width=(battery_diameter+battery_holder_spacing)*batteries_x_count+battery_holder_spacing+3*battery_charger_thickness;
battery_holder_length=(battery_diameter+battery_holder_spacing)*batteries_y_count+battery_holder_spacing;
battery_holder_height=(battery_height-battery_charger_height)/2;

// Start of trimmer measurements
trimmer_plus_diameter=16;
trimmer_plus_width=7.15;
trimmer_plus_depth=8.75;
trimmer_cylinder_outer_diameter=9.5;
trimmer_cylinder_inner_diameter=5;
trimmer_cylinder_depth1=35.15;
trimmer_cylinder_depth2=43.28;
trimmer_cylinder_depth3=4.25;
trimmer_cylinder_head_depth=trimmer_cylinder_depth2-trimmer_cylinder_depth1-trimmer_cylinder_depth3;
trimmer_cylinder_bolt_length=14;
trimmer_cylinder_depth=trimmer_cylinder_bolt_length-trimmer_cylinder_head_depth;
trimmer_center_circle_diameter=23.8;
trimmer_inner_circle_diameter1=52.35;
trimmer_inner_circle_diameter2=56.21;
trimmer_outer_circle_diameter1=70.65;
trimmer_outer_circle_diameter2=74.15;
trimmer_circle_depth=6.85;
trimmer_diameter=88.5;
trimmer_lever_diameter=7.25;
trimmer_radial_line_width=2.75;
trimmer_radial_line_height_offset=1.5;
trimmer_lever_outer_diameter=10.45;
trimmer_lever_radial_offset=(trimmer_inner_circle_diameter1-trimmer_lever_outer_diameter)/2;
trimmer_lever_vertical_offset=(trimmer_radial_line_width+trimmer_lever_outer_diameter)/2;
trimmer_lever_angular_offset=asin(trimmer_lever_vertical_offset/trimmer_lever_radial_offset);

// Start Blade Driver measurements
blade_driver_heatsink_width=51;
blade_driver_heatsink_height=23.5+1;
blade_driver_heasink_inset=6.6;
blade_driver_heatsink_base_height=4.5;
blade_driver_fan_duct_depth=25;
blade_driver_mount_hole_diameter=3.25;
blade_driver_mount_hole_depth=8;
blade_driver_mount_distance=37+blade_driver_mount_hole_diameter;
blade_driver_board_width=49.75;
blade_driver_base_standoff=0;
blade_driver_fan_extension=2;
blade_driver_base_pad=blade_driver_board_width+3*screw_head_diameter;
blade_driver_base_height=motor_driver_base_height;
blade_driver_base_solder_standoff=1.6;
blade_driver_heatsink_standoff=0.5;

// Start compass measurements
compass_width=13.62;
compass_length=14.5;

// Start real time clock measurements
rtc_width=23;
rtc_length=44.5;
rtc_mounting_hole_diameter=3;
rtc_mounting_hole_inner_length=35.31;
rtc_mounting_hole_inner_width=15.06;
rtc_mounting_hole_y_offset=(rtc_mounting_hole_inner_length+rtc_mounting_hole_diameter)/2;
rtc_mounting_hole_x_offset=(rtc_mounting_hole_inner_width+rtc_mounting_hole_diameter)/2;
rtc_pin_depth=2.6;
rtc_pin_width=12;
rtc_offset_height=1;
rtc_wall_thickness=2.5;
rtc_mount_hole_depth=max(rtc_pin_depth+rtc_offset_height,blade_driver_mount_hole_depth);


// Start relay measurements
relay_width=17.45;
relay_length=43.45;
relay_pin_depth=2.6;
relay_support1_start=6.2;
relay_support1_stop=13.25;
relay_support2_start=19;
relay_support2_stop=27;
relay_support3_start=31;
relay_support3_stop=35;
relay_support4_start=39;
relay_height=17.5;
relay_unit_length=18.8;
relay_offset_height=rtc_offset_height;
relay_wall_thickness=rtc_wall_thickness;
relay_snap_offset=14.05;
relay_snap_overhang=1;
relay_snap_height=6;

// Start voltage sensor measurements
voltage_sensor_width=13.26;
voltage_sensor_length=26.8;
voltage_sensor_pin_depth=2.32;
voltage_sensor_mounting_hole_diameter=3.1;
voltage_sensor_mounting_cylinder_diameter=8.4;
voltage_sensor_mounting_hole_x_offset=11.42;

// Start current sensor measurements
current_sensor_width=12.91;
current_sensor_lenght=31.75;
current_sensor_pin_depth=1.94;
current_sensor_mounting_hole_diameter=3;
current_sensor_mounting_hole_inner_distance=6.1;
current_sensor_mounting_hole_x_offset=16.04;

// Start Nano measurements
nano_width=18.21;
nano_length=43.25;
nano_pin_depth=8.75;
nano_usb_width=nano_width-6;
nano_pin_width=7.4;
nano_pin_offset=2.55;
nano_board_height=1.75*1.5;
nano_mount_thickness=8;
nano_offset_height=1;


// Common modules
module m3_nut(){
    cylinder(d=nut_diameter*1.05, h=nut_height*1.1, $fn=6);
}

module m3_nut_plus_bolt(length, overrun){
    m3_nut();
    translate([0,0,nut_height*1.1+overrun-length]){
        cylinder(d=screw_diameter,h=length);
    }
}




deck_height=(wheel_diameter-wheel_motor_diameter)/2;
echo("Deck height = ", deck_height/10, " cm");
echo("Deck height = ", deck_height/25.4, " inches");