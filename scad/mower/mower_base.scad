//include <mower_measurements.scad>
include <motor_driver_mount.scad>
include <blade_driver_mount.scad>
include <motor_mount.scad>

visualize=true;
quick=false;

back_y=-total_blade_radius-blade_y_offset-blade_gap-base_wall_thickness;
very_back_y=back_y-4*wheel_motor_mount_width;
front_y=back_y+base_blade_indent_length;
base_top=base_thickness+base_blade_indent_height;

//motor driver locations
motor_driver1x=-10-motor_driver_base_width/2;
motor_driver1y=very_back_y+motor_driver_base_length/2+fan_duct_depth+10;

motor_driver2x=10+motor_driver_base_width/2;
motor_driver2y=motor_driver1y;

// Blade driver locations
blade_driver1x=-20-blade_driver_base_pad;
blade_driver1y=very_back_y+blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension+100;

blade_driver2x=-base_width/2+10+(blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension);
blade_driver2y=-blade_y_offset+total_blade_radius+blade_gap-base_blade_rounding_radius+10+blade_driver_base_pad/2;

blade_driver3x=base_width/2-10-(blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension);
blade_driver3y=-total_blade_radius-blade_gap-base_blade_rounding_radius-10-blade_driver_base_pad/2;

module cutout(){
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
    cylinder(r=total_blade_radius+blade_gap+base_blade_rounding_radius,h=base_blade_indent_height);
}

module all_the_parts(){
    translate([motor_driver1x,motor_driver1y,base_top]){
        rotate([0,0,0]){
            if (quick){
                quick_motor_driver();
            }else{
                motor_driver();
            }
        }
    }
    translate([motor_driver2x,motor_driver2y,base_top]){
        rotate([0,0,0]){
            if (quick){
                quick_motor_driver();
            }else{
                motor_driver();
            }
        }
    }
    translate([blade_driver1x,blade_driver1y,base_top]){
        rotate([0,0,90]){
            if (quick){
                    quick_blade_driver();
                }else{
                    blade_driver();
            }
        }
    }
    translate([blade_driver2x,blade_driver2y,base_top]){
        rotate([0,0,0]){
            if (quick){
                quick_blade_driver();
            }else{
                blade_driver();
            }
        }
    }
    translate([blade_driver3x,blade_driver3y,base_top]){
        rotate([0,0,180]){
            if (quick){
                quick_blade_driver();
            }else{
                blade_driver();
            }
        }
    }
}

module plus(){
    translate([-base_width/2,back_y,0]){
        cube([base_width,base_blade_indent_length,base_top]);
    }
    translate([0,front_y,0]){
        scale([1,0.5,1]) {
            cylinder(d=base_width, h=base_top);
        }
    }
    translate([-base_width/2,very_back_y,0]){
        cube([base_width,4*wheel_motor_mount_width,base_top]);
    }
    if (visualize){
        all_the_parts();
    }
}

module minus(){
    // Cut out the blade holes
    translate([blade_x_offset/2,0,0]){
        if (quick){
            quick_cutout();
        } else {
            cutout();
        }
    }
    translate([-blade_x_offset/2,-blade_y_offset,0]){
        if (quick){
            quick_cutout();
        } else {
            cutout();
        }
    }
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
    // mounting holes for the motor driver mounts
    translate([motor_driver1x,motor_driver1y,base_top]){
        rotate([0,0,0]) motor_driver_mounting_holes();
    }
    translate([motor_driver2x,motor_driver2y,base_top]){
        rotate([0,0,0]) motor_driver_mounting_holes();
    }
    // Mounting holes for the blade driver mounts
    translate([blade_driver1x,blade_driver1y,base_top]){
        rotate([0,0,90]) blade_driver_mounting_holes();
    }
    translate([blade_driver2x,blade_driver2y,base_top]){
        rotate([0,0,0]) blade_driver_mounting_holes();
    }
    translate([blade_driver3x,blade_driver3y,base_top]){
        rotate([0,0,180]) blade_driver_mounting_holes();
    }
    // Cut out wheel slots
    translate([-base_width/2,very_back_y+1.5*wheel_motor_mount_width-wheel_radius-base_wheel_buffer_y,0]){
        cube([wheel_height+base_wheel_buffer_x,wheel_diameter+2*base_wheel_buffer_y,base_top]);
    }
    translate([base_width/2-wheel_height-base_wheel_buffer_x,very_back_y+1.5*wheel_motor_mount_width-wheel_radius-base_wheel_buffer_y,0]){
        cube([wheel_height+base_wheel_buffer_x,wheel_diameter+2*base_wheel_buffer_y,base_top]);
    }
}

echo("Width=",base_width/10," cm, or ",base_width/25.4," in");
echo("Length=",(front_y-very_back_y+base_width/2)/10," cm, or ",(front_y-very_back_y+base_width/2)/25.4," in");

difference(){
    plus();
    minus();
}
