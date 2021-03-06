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

// Start of Pololu hub dimensions
pololu_nub_diameter=12;
pololu_nub_height=4.2;
pololu_mount_hole_radius=9.5;
pololu_mount_height=5;
pololu_mount_inner_diameter=6;
pololu_mount_outer_diameter=25.4;

// Wheel mount dimensions
wheel_mount_diameter=30;
wheel_mount_height=wheel_motor_shaft_height-wheel_motor_bearing_width+2;
wheel_mount_screw_height=12;
wheel_mount_screw_depth=wheel_mount_screw_height-wheel_screw_depth+2;
wheel_mount_total_height=wheel_motor_bearing_width+1+wheel_mount_height;

// Start of m2 screw dimensions
m2_screw_diameter=1.95;
m2_screw_head_diameter=3.5;
m2_screw_head_height=2;

// Start of m3 screw dimensions
screw_diameter=3;
screw_head_diameter=5.5;
screw_head_height=3;
screw_countersunk_head_diameter=6;
screw_countersunk_head_height=2;

// Start of m3 nut dimensions
nut_diameter=6;
nut_height=2.25;

// Start of m4 screw dimensions
m4_screw_diameter=3.87;
m4_screw_head_diameter=6.85;
m4_screw_head_height=3.81;

// Start of m4 nut dimensions
m4_nut_diameter=7.83;
m4_nut_height=3.03;

// Start of m6 screw dimensions
m6_screw_diameter=5.9;
m6_screw_head_diameter=9.25;
m6_screw_head_height=6;

// Start of m6 nut dimensions
m6_nut_diameter=11.25;
m6_nut_height=4.76;

// Start of m8 nut dimensions
m8_nut_height=6;

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
base_thickness=4;
base_second_layer_thickness=6;
base_wall_thickness=4;
base_width=2*base_wall_thickness+2*blade_gap+blade_total_width;
base_blade_indent_length=2*total_blade_radius+blade_y_offset+2*blade_gap+2*base_wall_thickness;
base_blade_indent_height=15;
base_blade_rounding_radius=5;
base_front_curve_radius=50.8;
trimmer_radius=150;
trimmer_hypotnuse=trimmer_radius+blade_gap+total_blade_radius;
trimmer_x_offset=(base_width/2-base_front_curve_radius)-blade_x_offset/2;
trimmer_y_offset=sqrt(trimmer_hypotnuse*trimmer_hypotnuse-trimmer_x_offset*trimmer_x_offset);
trimmer_z_offset=9;
base_mounting_screw_length=6;
base_mounting_nut_depth=6;
base_wheel_buffer_x=5;
base_wheel_buffer_y=10;
base_screw_offset=10;

// Start of distance sensor measurements
distance_sensor_board_width=20.34;
distance_sensor_board_length=45.43;
distance_sensor_board_depth=1.5;
distance_sensor_component_depth=1.9;
distance_sensor_oscillator_depth=3;
distance_sensor_oscillator_diameter=4.55;
distance_sensor_oscillator_length=11;
distance_sensor_oscillator_x_offset=0.65;
distance_sensor_oscillator_center_x=(distance_sensor_board_width-distance_sensor_oscillator_diameter)/2-distance_sensor_oscillator_x_offset;
distance_sensor_oscillator_center_y=(distance_sensor_oscillator_length-distance_sensor_oscillator_diameter)/2;
distance_sensor_tranducer_diameter=16;
distance_sensor_tranducer_depth=12.25;
distance_sensor_tranducer_distance=10;
distance_sensor_tranducer_center_y=(distance_sensor_tranducer_diameter+distance_sensor_tranducer_distance)/2;
distance_sensor_pin_depth=4.9;
distance_sensor_pin_length=10;
distance_sensor_pin_base_width=2.5;
distance_sensor_pin_width=8.75;
distance_sensor_pin_diameter=0.66;
distance_sensor_hole_x_offsets=16.5/2;
distance_sensor_hole_y_offsets=41/2;
distance_sensor_hole_diameter=2;

// Start of front wheel dimensions
front_wheel_prism_height=7;
front_wheel_prism_width=3;
front_wheel_prism_length=3;
front_wheel_diameter=75;
front_wheel_radius=front_wheel_diameter/2;
front_wheel_height=10;
front_wheel_screw_depth=6;
front_wheel_mount_bearing_buffer=3.5;
front_wheel_mount_inner_diameter=wheel_motor_bearing_inner_diameter+front_wheel_mount_bearing_buffer;
front_wheel_mount_outer_diameter=wheel_motor_bearing_outer_diameter-front_wheel_mount_bearing_buffer;
front_wheel_mount_arc_angle=75;
front_wheel_mount_buffer=2;
front_wheel_mount_pivot_height=50;
front_mount_x=base_wall_thickness+wheel_motor_bearing_outer_diameter/2-front_wheel_mount_inner_diameter/2+front_wheel_mount_inner_diameter/2+front_wheel_mount_buffer/2+front_wheel_radius;
front_mount_y=front_wheel_height+wheel_motor_bearing_width+2*front_wheel_mount_buffer;
front_mount_radius=sqrt(front_mount_x*front_mount_x+front_mount_y*front_mount_y)+base_wheel_buffer_x;

// Figure out where base side of the front wheel mount
front_mount_base_legx=-base_width/2+base_front_curve_radius;
front_mount_base_hypotnuse=front_mount_radius+trimmer_radius;
front_mount_base_legy=sqrt(front_mount_base_hypotnuse*front_mount_base_hypotnuse-front_mount_base_legx*front_mount_base_legx)-base_front_curve_radius+10;
front_wheel_mount_back_circle_offset=front_mount_radius-wheel_motor_bearing_outer_diameter/2-base_wall_thickness;
front_wheel_mount_distance_sensor_offset=sqrt(front_mount_radius*front_mount_radius-distance_sensor_board_length*distance_sensor_board_length/4)-distance_sensor_board_depth-front_wheel_mount_back_circle_offset;
front_wheel_mount_angle_offset=30;
front_wheel_motor_mount_rail_depth=4+screw_head_height+nut_height*1.1;
//front_wheel_motor_mount_rail_depth=wheel_motor_mount_rail_depth;
cutting_blade_length=34.5;
cutting_blade_width=18;
cutting_blade_depth=0.75;

// Start of GPS mount dimensions
gps_board_x=43.8;
gps_board_y=43.27;
gps_board_y_plus=45.9;
gps_board_antenna_z=31;
gps_hole_offset=2.54;
gps_board_mount_lip=7.5;
gps_board_mount_lip_thickness=5;
gps_board_solder_cutout=3.5;
gps_board_screw_depth=9;

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
battery_diameter=18.45;
old_battery_diameter=19.00;
battery_height=69.6;
battery_holder_spacing=2;
batteries_x_count=5;
batteries_y_count=6;
old_batteries_x_count=6;
old_batteries_y_count=3;
battery_holder_width=(battery_diameter+battery_holder_spacing)*batteries_x_count+battery_holder_spacing+3*battery_charger_thickness;
battery_holder_length=(battery_diameter+battery_holder_spacing)*batteries_y_count+battery_holder_spacing+6*screw_diameter;
battery_holder_height=(battery_height-battery_charger_height)/2;
old_battery_holder_width=(old_battery_diameter+battery_holder_spacing)*old_batteries_x_count+battery_holder_spacing+3*battery_charger_thickness;
old_battery_holder_length=(old_battery_diameter+battery_holder_spacing)*old_batteries_y_count+battery_holder_spacing;
battery_holder_mount_offset=8;
battery_holder_mount_thickness=4;
battery_holder_mount_basesize=3*screw_head_diameter;

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
trimmer_inner_circle_diameter1=51;
trimmer_inner_circle_diameter2=58;
trimmer_outer_circle_diameter1=70;
trimmer_outer_circle_diameter2=75;
trimmer_circle_depth=6.85;
trimmer_diameter=88.5;
trimmer_lever_diameter=7.25;
trimmer_radial_line_width=2.75;
trimmer_radial_line_height_offset=1.5;
trimmer_lever_outer_diameter=10.45;
trimmer_lever_radial_offset=(trimmer_inner_circle_diameter1-trimmer_lever_outer_diameter)/2;
trimmer_lever_vertical_offset=(trimmer_radial_line_width+trimmer_lever_outer_diameter)/2;
trimmer_lever_angular_offset=asin(trimmer_lever_vertical_offset/trimmer_lever_radial_offset);
trimmer_wall_thickness=3;

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
compass_length=13.62;
compass_width=14.5;
compass_depth=3.4;
compass_pins_width=3;
compass_pins_depth=2.5;
compass_wall_thickness=2.5;
compass_mount_screw_depth=8;
compass_mount_x_offset=compass_width/2+1.5*screw_head_diameter;
compass_mount_y_offset=compass_length/2+1.5*m2_screw_head_diameter;

mpu9250_width=15.5;
mpu9250_length=26;
mpu9250_board_height=1.65;
mpu9250_pin_width=2.5;
mpu9250_pin_depth=2;
mpu9250_mount_hole_x_offset=1.2;
mpu9250_mount_hole_y_offset=1.3;

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
relay_mount_screw_depth=8;

// Start voltage sensor measurements
voltage_sensor_width=13.26;
voltage_sensor_length=26.8;
voltage_sensor_depth=1.6;
voltage_sensor_pin_depth=2.5;
voltage_sensor_mounting_hole_diameter=3.1;
voltage_sensor_mounting_cylinder_diameter=8.4;
voltage_sensor_mounting_hole_y_offset=11.42+voltage_sensor_mounting_hole_diameter/2;
voltage_sensor_wall_thickness=rtc_wall_thickness;
voltage_sensor_mount_screw_depth=8;

// Start current sensor measurements
current_sensor_width=12.91;
current_sensor_length=31.75;
current_sensor_depth=3.15;
current_sensor_pin_depth=1.94;
current_sensor_mounting_hole_diameter=3;
current_sensor_mounting_hole_distance=6+current_sensor_mounting_hole_diameter;
current_sensor_mounting_hole_y_offset=16.04;
current_sensor_wall_thickness=rtc_wall_thickness;
current_sensor_mount_screw_depth=8;

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

// Start of DC to DC converter measurements
dc2dcc_width=21.25;
dc2dcc_length=43;
dc2dcc_wall_thickness=rtc_wall_thickness;
dc2dcc_offset=3;
dc2dcc_holes=[[2.1,5.9,0],[dc2dcc_width-2.6,dc2dcc_length-6.2,0]];
dc2dcc_mount_height=8;
dc2dcc_board_thickness=1.33;



// Start blade mount connector measurements
blade_mount_connector_outter_diameter=26;
blade_mount_connector_inner_diameter=8;
blade_mount_connector_height=35;
blade_mount_connector_cross_bar=29.5;
socket_14mm_diameter=21;

// Start blade motor mount measurements
blade_motor_diameter=51;
blade_motor_mount_height=35;
blade_motor_nub_height=6.7;
blade_motor_nub_diameter=26.15;
blade_motor_mount_bolt_distance=40.84;
blade_motor_mount_bolt_height=10;
blade_motor_nub_to_connector=4.7;
blade_buffer=3;
blade_motor_mount_extension=blade_mount_connector_cross_bar+blade_motor_nub_to_connector+blade_buffer-base_wall_thickness-base_second_layer_thickness;
blade_motor_mount_extension_overlap=10;
blade_motor_mount_leg_width=10;
blade_motor_mount_radius=blade_mount_inner_screw_radius+m4_nut_diameter/2+2*blade_buffer+2*blade_motor_mount_leg_width;

// Start of side brace measurements
side_brace_base_hole=20;
side_brace_side_hole=25;
side_brace_base_length=side_brace_base_hole+10;
side_brace_side_length=side_brace_side_hole+10;
side_brace_width=15;
side_brace_thickness=4;

// Start of side wall measurements
side_wall_thickness=4;

// Start of Rasberry Pi measurements
raspberry_pi_width=56;
raspberry_pi_length=85;
raspberry_pi_offset_radius=3.5;
raspberry_pi_x_holes=[3.5,52.5];
raspberry_pi_y_holes=[3.5,61.5];
raspberry_pi_offset=3;
raspberry_pi_board_thickness=1.35;
raspberry_pi_base_thickness=16-base_second_layer_thickness-raspberry_pi_offset-raspberry_pi_board_thickness;

// Start Arduino Mega measurements
mega_width=53.34;
mega_length=101.6;
mega_holes=[[13.97,2.54,0],[66.04,35.56,0],[96.52,2.54,0]];
mega_offsets=[[15.24,50.8,0],[66.04,7.62,0],[90.17,50.8,0]];
mega_board_thickness=1.6;
mega_base_thickness=4;
mega_board_offset=16-base_second_layer_thickness-mega_base_thickness-mega_board_thickness;
mega_offset_radius=2.54;
female_jumper_pitch=2.54;
female_jumper_height=8.5;

misc_mount_base_thickness=4;
power_brass_width=12.8;
power_brass_height=1;
power_screw_diameter=3.9;
power_spacing=11;
power_holes=7;
power_screw_spacing=[-power_screw_diameter/2,7.45,18.45,29.79,40.82,52.58,63.39];
power_screw_length=8;
power_height=power_screw_length+2;
power_width=power_brass_width+2*misc_mount_base_thickness;
power_length=power_spacing*power_holes+2*misc_mount_base_thickness+2;
echo("power_length", power_length);

apc_battery_width=51.5;
apc_battery_length=151;
apc_battery_height=94.5;
apc_battery_terminal_offset=10;
apc_strap_width=15;
power_wire_diameter=3;

plate_diameter=102;
plate_height=3;
plate_hole_diameter=5.75;

antenna_width=38.5;
antenna_length=51;
antenna_bevel_width=27.75;

emergency_stop_flange_diameter=60;
emergency_stop_mount_diamter=24.5;
emergency_stop_body_width=31;
emergency_stop_body_length=38;

lcd_board_length=81;
lcd_board_width=37;
lcd_board_height=1.6;
lcd_screen_length=72;
lcd_screen_width=25;
lcd_mount_hole_length=75.4;
lcd_mount_hole_width=31.4;
lcd_mount_hole_diameter=2.8;
lcd_pin_offset_x=7;
lcd_pin_offset_y=1;
lcd_pin_width=40;
lcd_pin_height=5.5;
lcd_led_bump_length=3.5;
lcd_led_bump_width=13.5;
lcd_led_bump_height=3.5;

// Common modules
module m3_nut(){
    cylinder(d=nut_diameter*1.05, h=nut_height*1.1, $fn=6);
}

module m3_bolt(height){
    cylinder(d=screw_diameter,h=height+screw_head_height);
    cylinder(d=screw_head_diameter, h=screw_head_height);
}

module m4_nut(){
    cylinder(d=m4_nut_diameter*1.05, h=m4_nut_height*1.1, $fn=6);
}

module m3_nut_plus_bolt(length, overrun){
    m3_nut();
    translate([0,0,nut_height*1.1+overrun-length]){
        cylinder(d=screw_diameter,h=length);
    }
}

module m4_bolt(height){
    cylinder(d=m4_screw_diameter,h=height+m4_screw_head_height);
    cylinder(d=m4_screw_head_diameter, h=m4_screw_head_height);
}

module m4_nut_plus_bolt(length, overrun){
    m4_nut();
    translate([0,0,m4_nut_height*1.1+overrun-length]){
        cylinder(d=m4_screw_diameter,h=length);
    }
}

module prism(l, w, h) {
       polyhedron(points=[
               [0,-l/2,h/2],           // 0    front top corner
               [0,-l/2,-h/2],[w,-l/2,0],   // 1, 2 front left & right bottom corners
               [0,l/2,h/2],           // 3    back top corner
               [0,l/2,-h/2],[w,l/2,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module arc(r, theta){
    difference(){
        intersection(){
            circle(r=r);
            square([r,r]);
        }
        rotate([0,0,theta]){
            square([r,r]);
        }
    }
}

module half_curve(r, theta, yp){
    arc(r, theta);
    intersection(){
        rotate([0,0,theta]){
            square([r,yp]);
        }
        square([r,yp]);
    }
}

module curved_joint(a,b,c,d,r0,r1,signmult){
    xp=(c*r0+a*r1)/(r0+r1);
    yp=(d*r0+b*r1)/(r0+r1);
    
//    r02yp=r0*r0*(yp-b);
    root=sqrt((xp-a)*(xp-a)+(yp-b)*(yp-b)-r0*r0);
//    r0xproot=r0*(xp-a)*root;
//    signmult=r02yp>r0xproot ? 1:-1;
    
    x12=(r0*r0*(xp-a)+signmult*r0*(yp-b)*sqrt((xp-a)*(xp-a)+(yp-b)*(yp-b)-r0*r0))/((xp-a)*(xp-a)+(yp-b)*(yp-b))+a;
    y12=(r0*r0*(yp-b)-signmult*r0*(xp-a)*sqrt((xp-a)*(xp-a)+(yp-b)*(yp-b)-r0*r0))/((xp-a)*(xp-a)+(yp-b)*(yp-b))+b;
    
    echo("root = ",root);
    echo("xp,yp = ",xp, yp);
    echo("x12 = ", x12);
    echo("y12 = ", y12);
    theta=atan((y12-b)/(x12-a));
    echo("Theta=", theta);
    translate([a,b,0]){
        half_curve(r0, theta, yp-b);
        difference(){
            translate([0,yp-b,0]){
                square([r1,yp-b]);
            }
            translate([c-a,d-b,0]){
                rotate([0,0,180]){
                    half_curve(r1, theta, yp-b);
                }
            }
        }
    }
}

module screw_hole(x, y, z, length, type, headdepth){
    if(type=="countersunk"){
        translate([x,y,z-length]){
            cylinder(d=screw_diameter,h=length);
            cylinder(d1=screw_countersunk_head_diameter,d2=screw_diameter,h=screw_countersunk_head_height);
        }
        translate([x,y,z-length-headdepth]){
            cylinder(d=screw_countersunk_head_diameter,h=headdepth);
        }
    } else {
        translate([x,y,z-length]){
            cylinder(d=screw_diameter,h=length);
        }
        translate([x,y,z-length-headdepth-screw_head_height]){
            cylinder(d=screw_head_diameter,h=headdepth+screw_head_height);
        }
    }
    translate([x,y,z-nut_height*1.1]){
        m3_nut();
    }
}

deck_height=(wheel_diameter-wheel_motor_diameter)/2;
echo("Deck height = ", deck_height/10, " cm");
echo("Deck height = ", deck_height/25.4, " inches");