//include <mower_measurements.scad>
include <motor_driver_mount.scad>
include <blade_driver_mount.scad>
include <motor_mount.scad>
include <blade_mount_connector.scad>
include <front_wheel.scad>
include <pi_mount.scad>
include <battery_holder.scad>
include <gps_mount.scad>


visualize=false;
quick=true;

back_y=-total_blade_radius-blade_y_offset-blade_gap-base_wall_thickness;
very_back_y=back_y-3*wheel_motor_mount_width;
front_y=back_y+base_blade_indent_length;
very_front_y=trimmer_y_offset-blade_y_offset+base_front_curve_radius;
base_layer1=base_thickness+base_blade_indent_height;
base_top=base_layer1+base_second_layer_thickness;
front_mount_base_y=very_front_y+front_mount_base_legy;

section_width=base_width/2;
section_length=(very_front_y-very_back_y)/3;

// blade motor locations
blade_motor1x=blade_x_offset/2;
blade_motor1y=0;
blade_motor1deg=12;

blade_motor2x=-blade_x_offset/2;
blade_motor2y=-blade_y_offset;
blade_motor2deg=0;

//motor driver locations
motor_driver1x=-base_width/4;
motor_driver1y=very_back_y+section_length;
motor_driver1deg=-90;

motor_driver2x=base_width/4;
motor_driver2y=motor_driver1y;
motor_driver2deg=90;

// Blade driver locations
blade_driver1x=-20-blade_driver_base_pad/2;
blade_driver1y=very_front_y-blade_driver_base_pad/2-blade_driver_fan_duct_depth-blade_driver_fan_extension-20;
blade_driver1deg=-90;

blade_driver2x=blade_motor1x-10+(blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension);
blade_driver2y=blade_motor1y-blade_motor_mount_radius-10-blade_driver_base_pad/2;
blade_driver2deg=180;

blade_driver3x=blade_motor2x+10-(blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension);
blade_driver3y=blade_motor2y+blade_motor_mount_radius+10+blade_driver_base_pad/2;
blade_driver3deg=0;

pi_x=0;
pi_y=-raspberry_pi_length;
pi_deg=0;

gps_x=20+gps_board_x/2+gps_board_mount_lip;
gps_y=very_front_y-30-gps_board_y/2-gps_board_mount_lip;
gps_deg=90;

battery_x=0;
battery_y=very_back_y+section_length/3;
battery_deg=90;

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
module cutout(){
    cylinder(r=blade_mount_inner_screw_radius+m4_nut_diameter/2+2*blade_buffer, h=base_top);
    rotate_extrude(){
        square([total_blade_radius+blade_gap,base_blade_indent_height]);
        translate([total_blade_radius+blade_gap,0,0]){
            difference(){
                square([base_blade_rounding_radius,base_blade_rounding_radius]);
                translate([base_blade_rounding_radius,base_blade_rounding_radius,0]){
                    circle(r=base_blade_rounding_radius);
                }
            }
        }
    }
}

module quick_cutout(){
    cylinder(d=blade_mount_connector_outter_diameter+4, h=base_top);
    cylinder(r=total_blade_radius+blade_gap+base_blade_rounding_radius,h=base_blade_indent_height);
}

module all_the_parts(){
    translate([motor_driver1x,motor_driver1y,base_top]){
        rotate([0,0,motor_driver1deg]){
            if (quick){
                quick_motor_driver();
            }else{
                motor_driver();
            }
        }
    }
    translate([motor_driver2x,motor_driver2y,base_top]){
        rotate([0,0,motor_driver2deg]){
            if (quick){
                quick_motor_driver();
            }else{
                motor_driver();
            }
        }
    }

    // Blade Drivers
    translate([blade_driver1x,blade_driver1y,base_top]){
        rotate([0,0,blade_driver1deg]){
            if (quick){
                    quick_blade_driver();
                }else{
                    blade_driver();
            }
        }
    }

    translate([blade_driver2x,blade_driver2y,base_top]){
        rotate([0,0,blade_driver2deg]){
            if (quick){
                quick_blade_driver();
            }else{
                blade_driver();
            }
        }
    }

    translate([blade_driver3x,blade_driver3y,base_top]){
        rotate([0,0,blade_driver3deg]){
            if (quick){
                quick_blade_driver();
            }else{
                blade_driver();
            }
        }
    }
    // Blade motor mounts
    translate([blade_motor1x,blade_motor1y,base_top]){
        rotate([0,0,blade_motor1deg]){
            blade_motor_mount_bottom();
        }
    }
    translate([blade_motor2x,blade_motor2y,base_top]){
        rotate([0,0,blade_motor2deg]){
            blade_motor_mount_bottom();
        }
    }
    // Raspberry pi mount
    translate([pi_x,pi_y,base_top]){
        rotate([0,0,pi_deg]){
            pi_mount();
        }
    }
    // Battery mount
    translate([battery_x,battery_y,base_top]){
        rotate([0,0,battery_deg]){
            battery_mount_clips();
        }
    }
    // GPS mount
    translate([gps_x,gps_y,base_top]){
        rotate([0,0,gps_deg]){
            gps_mount();
        }
    }
    
}

module plus(){
    // For the blade area
    translate([-base_width/2,back_y,0]){
        cube([base_width,base_blade_indent_length,base_top]);
    }
    // For the trimmer area
    translate([-base_width/2,front_y,0]){
        cube([base_width,(trimmer_y_offset-blade_y_offset)-front_y,base_top]);
    }
    // For the curved front corners
    translate([-base_width/2+base_front_curve_radius,trimmer_y_offset-blade_y_offset,0]){
        cylinder(r=base_front_curve_radius, h=base_top);
        cube([base_width-2*base_front_curve_radius,base_front_curve_radius,base_top]);
    }
    translate([base_width/2-base_front_curve_radius,trimmer_y_offset-blade_y_offset,0]){
        cylinder(r=base_front_curve_radius, h=base_top);
    }
    // For the wheel motor mount area
    translate([-base_width/2,very_back_y,0]){
        cube([base_width,3*wheel_motor_mount_width,base_top]);
    }
    // For the front wheel mount
    translate([0,very_front_y,0]){
        wheel_pivot_base_mount();
    }
    // Should we visualize the parts too?
    if (visualize){
        all_the_parts();
    }
}

module blade_motors_minus(){
    translate([blade_motor1x,blade_motor1y,base_layer1]){
        rotate([0,0,blade_motor1deg]) blade_motor_mounting_holes();
    }
    translate([blade_motor2x,blade_motor2y,base_layer1]){
        rotate([0,0,blade_motor2deg]) blade_motor_mounting_holes();
    }
}

module motor_drivers_minus(){
    translate([motor_driver1x,motor_driver1y,base_layer1]){
        rotate([0,0,motor_driver1deg]) motor_driver_mounting_holes();
    }
    translate([motor_driver2x,motor_driver2y,base_layer1]){
        rotate([0,0,motor_driver2deg]) motor_driver_mounting_holes();
    }
}

module blade_drivers_minus(){
    /*
    // Leave this out for now
    translate([blade_driver1x,blade_driver1y,base_layer1]){
        rotate([0,0,blade_driver1deg]) blade_driver_mounting_holes();
    }
    */
    translate([blade_driver2x,blade_driver2y,base_layer1]){
        rotate([0,0,blade_driver2deg]) blade_driver_mounting_holes();
    }
    translate([blade_driver3x,blade_driver3y,base_layer1]){
        rotate([0,0,blade_driver3deg]) blade_driver_mounting_holes();
    }
}

module pi_minus(){
    translate([pi_x,pi_y,base_layer1]){
        rotate([0,0,pi_deg]){
            pi_mount_holes();
        }
    }
}

module battery_minus(){
    translate([battery_x,battery_y,base_layer1]){
        rotate([0,0,battery_deg]){
            battery_mount_clips_mount_holes();
        }
    }
}

module gps_minus(){
    translate([gps_x,gps_y,base_layer1]){
        rotate([0,0,gps_deg]){
            gps_mount_holes();
        }
    }
}

module base_holes(){
    x1=-section_width+base_screw_offset;
    x1_offset=-section_width+wheel_height+base_wheel_buffer_x+base_screw_offset;
    x2=-section_width/2-base_screw_offset;
    x3=-section_width/2+base_screw_offset;
    x4=-base_screw_offset;
    x5=base_screw_offset;
    x6=section_width/2-base_screw_offset;
    x7=section_width/2+base_screw_offset;
    x8_offset=section_width-wheel_height-base_wheel_buffer_x-base_screw_offset;
    x8=section_width-base_screw_offset;
    y1=very_back_y+base_screw_offset;
    y2=very_back_y+section_length/2-base_screw_offset;
    y3=very_back_y+section_length/2+base_screw_offset;
    y4=very_back_y+section_length-base_screw_offset;
    y5=very_back_y+section_length+base_screw_offset;
    y6=very_back_y+3*section_length/2-base_screw_offset;
    y7=very_back_y+3*section_length/2+base_screw_offset;
    y8=very_back_y+2*section_length-base_screw_offset;
    y9=very_back_y+2*section_length+base_screw_offset;
    y10=very_back_y+5*section_length/2-base_screw_offset;
    y11=very_back_y+5*section_length/2+base_screw_offset;
    y12=very_back_y+3*section_length-base_screw_offset;
    // How long are my screws?
    base_screw_length=base_blade_indent_height-trimmer_z_offset+base_second_layer_thickness;
    blade_screw_length=base_thickness+base_second_layer_thickness;
    //Very back row
    screw_hole(x1_offset, y1, base_top, base_screw_length, "socket", base_top);
    screw_hole(x2, y1, base_top, base_screw_length, "socket", base_top);
    screw_hole(x3, y1, base_top, base_screw_length, "socket", base_top);
    screw_hole(x4, y1, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y1, base_top, base_screw_length, "socket", base_top);
    screw_hole(x6, y1, base_top, base_screw_length, "socket", base_top);
    screw_hole(x7, y1, base_top, base_screw_length, "socket", base_top);
    screw_hole(x8_offset, y1, base_top, base_screw_length, "socket", base_top);
    //Next to last back row
    screw_hole(x1_offset, very_back_y+wheel_motor_mount_width-base_screw_offset, base_top, base_screw_length, "socket", base_top);
    screw_hole(-base_width/2+wheel_motor_mount_height/2+wheel_height+base_wheel_buffer_x+wheel_mount_screw_height, very_back_y+wheel_motor_mount_width-base_screw_offset, base_top, base_screw_length, "socket", base_top);
    screw_hole(-section_width/2+2*base_screw_offset, y2, base_top, base_screw_length, "socket", base_top);
    screw_hole(x4, y2, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y2, base_top, base_screw_length, "socket", base_top);
    screw_hole(section_width/2-2*base_screw_offset, y2, base_top, base_screw_length, "socket", base_top);
    screw_hole(base_width/2-wheel_motor_mount_height/2-wheel_height-base_wheel_buffer_x-wheel_mount_screw_height, very_back_y+wheel_motor_mount_width-base_screw_offset, base_top, base_screw_length, "socket", base_top);
    screw_hole(x8_offset, very_back_y+wheel_motor_mount_width-base_screw_offset, base_top, base_screw_length, "socket", base_top);
    //Third to last back row
    screw_hole(x1_offset, very_back_y+2*wheel_motor_mount_width+base_screw_offset, base_top, base_screw_length, "socket", base_top);
    screw_hole(-base_width/2+wheel_motor_mount_height/2+wheel_height+base_wheel_buffer_x+wheel_mount_screw_height, very_back_y+2*wheel_motor_mount_width+base_screw_offset, base_top, base_screw_length, "socket", base_top);
    screw_hole(-section_width/2+2*base_screw_offset, y3, base_top, base_screw_length, "socket", base_top);
    screw_hole(x4, y3, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y3, base_top, base_screw_length, "socket", base_top);
    screw_hole(section_width/2-2*base_screw_offset, y3, base_top, base_screw_length, "socket", base_top);
    screw_hole(base_width/2-wheel_motor_mount_height/2-wheel_height-base_wheel_buffer_x-wheel_mount_screw_height, very_back_y+2*wheel_motor_mount_width+base_screw_offset, base_top, base_screw_length, "socket", base_top);
    screw_hole(x8_offset, very_back_y+2*wheel_motor_mount_width+base_screw_offset, base_top, base_screw_length, "socket", base_top);
    //Forth to last back row
    screw_hole(x1_offset, y4, base_top, base_screw_length, "socket", base_top);
    screw_hole(x2, y4, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x3, y4, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x4, y4, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y4, base_top, base_screw_length, "socket", base_top);
    screw_hole(x6, y4, base_top, base_screw_length, "socket", base_top);
    screw_hole(x7, y4, base_top, base_screw_length, "socket", base_top);
    screw_hole(x8_offset, y4, base_top, base_screw_length, "socket", base_top);
    //Fifth to last back row
    screw_hole(x1, y5, base_top, base_screw_length, "socket", base_top);
    screw_hole(x2, y5, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x3, y5, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x4, y5, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y5, base_top, base_screw_length, "socket", base_top);
    screw_hole(x6, y5, base_top, base_screw_length, "socket", base_top);
    screw_hole(x7, y5, base_top, base_screw_length, "socket", base_top);
    screw_hole(x8, y5, base_top, base_screw_length, "socket", base_top);
    //Sixth to last back row
    screw_hole(x1, y6, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x2-base_screw_offset, y6, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x3+2.5*base_screw_offset, y6, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x4, y6, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x5-base_screw_offset/2, y6, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x6, y6, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x7, y6, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x8, y6, base_top, base_screw_length, "socket", base_top);
    //Seventh to last back row
    screw_hole(x1, y7, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x2, y7, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x3+1.5*base_screw_offset, y7, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x4, y7, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x5, y7+base_screw_offset/2, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x6, y7, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x7, y7, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x8, y7, base_top, base_screw_length, "socket", base_top);
    //Eighth to last back row
    screw_hole(x1, y8, base_top, base_screw_length, "socket", base_top);
    screw_hole(x2, y8, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x3, y8, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x4-base_screw_offset, y8, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y8, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x6-2*base_screw_offset, y8, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x7+0.5*base_screw_offset, y8, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x8-base_screw_offset, y8, base_top, blade_screw_length, "countersunk", base_top);
    //Ninth to last back row
    screw_hole(x1, y9, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x2, y9, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x3, y9, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x4-base_screw_offset, y9, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y9, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x6, y9, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x7, y9, base_top, blade_screw_length, "countersunk", base_top);
    screw_hole(x8-base_screw_offset/2, y9, base_top, blade_screw_length, "countersunk", base_top);
    //Tenth to last back row
    screw_hole(x1, y10, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x2, y10, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x3, y10, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x4, y10, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y10, base_top, base_screw_length, "socket", base_top);
    screw_hole(x6, y10, base_top, base_screw_length, "socket", base_top);
    screw_hole(x7, y10, base_top, base_screw_length, "socket", base_top);
    screw_hole(x8, y10, base_top, base_screw_length, "socket", base_top);
    //Eleventh to last back row
    screw_hole(x1-base_screw_offset/2, y11-base_screw_offset/2, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x2, y11, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x3, y11, base_top, base_screw_length, "countersunk", base_top);
    screw_hole(x4, y11, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y11, base_top, base_screw_length, "socket", base_top);
    screw_hole(x6, y11, base_top, base_screw_length, "socket", base_top);
    screw_hole(x7, y11, base_top, base_screw_length, "socket", base_top);
    screw_hole(x8, y11, base_top, base_screw_length, "socket", base_top);
    //Twelvth to last back row
    //screw_hole(x1, y12, base_top, base_screw_length, "socket", base_top);
    screw_hole(x2, y12, base_top, base_screw_length, "socket", base_top);
    screw_hole(x3, y12, base_top, base_screw_length, "socket", base_top);
    screw_hole(x4, y12, base_top, base_screw_length, "socket", base_top);
    screw_hole(x5, y12, base_top, base_screw_length, "socket", base_top);
    screw_hole(x6, y12, base_top, base_screw_length, "socket", base_top);
    screw_hole(x7, y12, base_top, base_screw_length, "socket", base_top);
    screw_hole(x8-base_screw_offset, y12-base_screw_offset, base_top, base_screw_length, "socket", base_top);
}

module mount_holes(){
    // mounting holes for the blade motors
    blade_motors_minus();
    // mounting holes for the motor driver mounts
    motor_drivers_minus();
    // Mounting holes for the blade driver mounts
    blade_drivers_minus();
    // Mounting holes for the raspberry pi
    pi_minus();
    // Mounting holes for the battery mount
    battery_minus();
    // Mounting holes for the GPS mount
    gps_minus();
}

module blade_holes(){
    // Cut out the blade holes
    translate([blade_motor1x,blade_motor1y,0]){
        if (quick){
            quick_cutout();
        } else {
            cutout();
        }
    }
    translate([blade_motor2x,blade_motor2y,0]){
        if (quick){
            quick_cutout();
        } else {
            cutout();
        }
    }
}

module motor_mount_holes(){
    // Punch holes for the wheel motor mounts
    translate([-base_width/2+wheel_motor_mount_height+wheel_height+base_wheel_buffer_x+wheel_mount_screw_height,very_back_y+1.5*wheel_motor_mount_width,0]){
        linear_extrude(height=base_top){
            rotate([0,0,90]){
                if (quick){
                    quick_motor_mount_cutout();
                } else {
                    motor_mount_cutout();
                }
            }
        }
    }
    translate([base_width/2-wheel_motor_mount_height-wheel_height-base_wheel_buffer_x-wheel_mount_screw_height,very_back_y+1.5*wheel_motor_mount_width,0]){
        linear_extrude(height=base_top){
            rotate([0,0,-90]){
                if (quick){
                    quick_motor_mount_cutout();
                } else {
                    motor_mount_cutout();
                }
            }
        }
    }
    // Cut out a little extra for the power lines
    translate([-base_width/2+wheel_motor_mount_height+wheel_height+base_wheel_buffer_x+wheel_mount_screw_height,very_back_y+1.5*wheel_motor_mount_width-(2*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter/2),0]){
        cube([base_wall_thickness,4*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter,base_top]);
    }
    translate([base_width/2-wheel_motor_mount_height-wheel_height-base_wheel_buffer_x-wheel_mount_screw_height-base_wall_thickness,very_back_y+1.5*wheel_motor_mount_width-(2*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter/2),0]){
        cube([base_wall_thickness,4*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter,base_top]);
    }
}

module wheel_slots(){
    // Cut out wheel slots
    translate([-base_width/2,very_back_y+1.5*wheel_motor_mount_width-wheel_radius-base_wheel_buffer_y,0]){
        cube([wheel_height+base_wheel_buffer_x,wheel_diameter+2*base_wheel_buffer_y,base_top]);
    }
    translate([base_width/2-wheel_height-base_wheel_buffer_x,very_back_y+1.5*wheel_motor_mount_width-wheel_radius-base_wheel_buffer_y,0]){
        cube([wheel_height+base_wheel_buffer_x,wheel_diameter+2*base_wheel_buffer_y,base_top]);
    }
    // Cut out wheel mount slots
    translate([-base_width/2+wheel_height+base_wheel_buffer_x,very_back_y+1.5*wheel_motor_mount_width-(2*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter/2),0]){
        cube([wheel_motor_mount_height+wheel_mount_screw_height,4*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter,base_top]);
    }
    translate([base_width/2-wheel_height-base_wheel_buffer_x-wheel_motor_mount_height-wheel_mount_screw_height,very_back_y+1.5*wheel_motor_mount_width-(2*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter/2),0]){
        cube([wheel_motor_mount_height+wheel_mount_screw_height,4*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter,base_top]);
    }
}

module rounded_edge(r,l){
    difference(){
        cube([r,r,l]);
        translate([r,r,0]){
            cylinder(r=r,h=l);
        }
    }
}

module trimmer_cutout(){
    echo("trimmer x", base_width/2-base_front_curve_radius);
    echo("blade x", blade_x_offset/2);
    echo("Trimmer x offset = ", trimmer_x_offset);
    translate([-base_width/2+base_front_curve_radius,trimmer_y_offset-blade_y_offset,0]){
        cylinder(r=base_front_curve_radius+5,h=base_top);
        cylinder(r=trimmer_radius+blade_gap, h=trimmer_z_offset);
    }
    // Curve the front where the string will be
    // coming in
    intersection(){
        translate([-base_width/2+base_front_curve_radius,trimmer_y_offset-blade_y_offset,trimmer_z_offset]){
            cylinder(r=trimmer_radius+blade_gap,h=base_top-trimmer_z_offset);
        }
        translate([-base_width/2+base_front_curve_radius,very_front_y,trimmer_z_offset]){
            rotate([0,90,0]){
                rotate([0,0,180]){
                    rounded_edge(base_top-trimmer_z_offset,trimmer_radius);
                }
            }
        }
    }
}

module minus(){
    blade_holes();
    motor_mount_holes();
    wheel_slots();
    trimmer_cutout();
    base_holes();
}


module base(){
    translate([base_width/2,-very_back_y,0]){
        difference(){
            plus();
            minus();
        }
    }
}

module bottom_section(x,y){
    translate([x*section_width,y*section_length,0]){
        cube([section_width,section_length,base_layer1]);
    }
}

module top_section(x,y){
    translate([x*section_width,y*section_length,base_layer1]){
        cube([section_width,section_length,base_second_layer_thickness]);
    }
}

module bottom_part(x,y){
    intersection(){
        base();
        bottom_section(x,y);
    }
}

module top_part(x,y){
    intersection(){
        base();
        top_section(x,y);
    }
}

echo("Width=",base_width/10," cm, or ",base_width/25.4," in");
echo("Length=",(very_front_y-very_back_y)/10," cm, or ",(very_front_y-very_back_y)/25.4," in");
echo("Wheel cutout width=",wheel_height+base_wheel_buffer_x);
cutout_start=very_back_y+1.5*wheel_motor_mount_width-wheel_radius-base_wheel_buffer_y;
cutout_end=cutout_start+wheel_diameter+2*base_wheel_buffer_y;
cutout_length=cutout_end-very_back_y;
echo("Wheel cutout length=",cutout_length);
echo("Wheel center=",1.5*wheel_motor_mount_width);
echo("Blades are in ", (base_width-blade_x_offset)/2, "mm from the side");
echo("blades are offset ", blade_y_offset, "mm from each other");

/*
for(x=[0,1]){
    for(y=[0:2]){
        translate([5*x,5*y,0]){
            bottom_part(x,y);
        }
    }
}

for(x=[-0.5:1.5]){
    for(y=[-0.5:2.5]){
        translate([10*x,10*y,base_layer1+50]){
            top_part(x,y);
        }
    }
}
*/