$fn=360;
include <mower_measurements.scad>

module blade_mount_connector_plus(){
    cylinder(d=blade_mount_connector_outter_diameter, h=blade_mount_connector_height);
    cylinder(r=blade_mount_inner_screw_radius+m4_nut_diameter/2+blade_buffer, h=1.5*m8_nut_height+m4_nut_height+blade_buffer);
}

module blade_mount_connector_minus(){
    cylinder(d=blade_mount_connector_inner_diameter, h=blade_mount_connector_height);
    cylinder(d=socket_14mm_diameter, h=1.2*m8_nut_height);
    translate([0,0,blade_mount_connector_cross_bar]){
        rotate([90,0,0]){
            translate([0,0,-blade_mount_connector_outter_diameter/2]) {
                cylinder(d=screw_head_diameter,h=screw_head_height+2);
                cylinder(d=screw_diameter,h=blade_mount_connector_outter_diameter);
                translate([0,0,blade_mount_connector_outter_diameter-nut_height*1.1]){
                    m3_nut();
                }
            }
        }
    }
    rotate([0,0,0]){
        translate([blade_mount_inner_screw_radius,0,1.5*m8_nut_height+m4_nut_height+blade_buffer]){
            m4_nut_plus_bolt(25, 3);
        }
    }
    rotate([0,0,180]){
        translate([blade_mount_inner_screw_radius,0,1.5*m8_nut_height+m4_nut_height+blade_buffer]){
            m4_nut_plus_bolt(25, 3);
        }
    }
}

module blade_mount_connector(){
    difference(){
        blade_mount_connector_plus();
        blade_mount_connector_minus();
    }
}

module blade_motor_mount_top_plus(){
    cylinder(d=blade_motor_diameter+2*base_wall_thickness,h=blade_motor_mount_height);
    for(rotation=[0,90]){
        rotate([0,0,rotation]){
            translate([-blade_motor_mount_radius,-blade_motor_mount_leg_width/2,0]){
                cube([2*blade_motor_mount_radius, blade_motor_mount_leg_width, base_second_layer_thickness]);
            }
        }
    }
}

module blade_motor_mount_bottom_plus(){
    cylinder(r=blade_motor_mount_radius, h=base_second_layer_thickness);
    translate([0,0,base_second_layer_thickness]){
        cylinder(d=blade_motor_diameter+2*base_wall_thickness+blade_motor_mount_leg_width/2, h=blade_motor_mount_extension-base_second_layer_thickness);
    }
    for(rotation=[0:90:359]){
        rotate([0,0,rotation]){
            translate([blade_mount_inner_screw_radius+m4_nut_diameter/2+2*blade_buffer,-blade_motor_mount_leg_width/2,0]){
                linear_extrude(height=blade_motor_mount_extension, center=false, scale=[1,1]) {
                    square([2*blade_motor_mount_leg_width,blade_motor_mount_leg_width]);
                }
            }
        }
    }
}
module blade_motor_mount_top_minus(){
    cylinder(d=blade_motor_nub_diameter+2,h=blade_motor_nub_height);
    translate([0,0,blade_motor_nub_height]){
        cylinder(d=blade_motor_diameter+1,h=blade_motor_mount_height-blade_motor_nub_height);
    }
    for(rotation=[45,225]){
        rotate([0,0,rotation]){
            translate([blade_motor_mount_bolt_distance/2,0,0]){
                cylinder(d=m4_screw_diameter+1,h=blade_motor_mount_bolt_height);
            }
        }
    }
    for(rotation=[0:90:359]){
        rotate([0,0,rotation]){
            translate([blade_mount_inner_screw_radius+m4_nut_diameter/2+2*blade_buffer+1.5*blade_motor_mount_leg_width,0,0]){
                cylinder(d=screw_diameter,h=base_second_layer_thickness);
            }
        }
    }
}

module blade_motor_mounting_holes(){
    for(rotation=[22.5:45:359]){
        rotate([0,0,rotation]){
            translate([blade_mount_inner_screw_radius+m4_nut_diameter/2+2*blade_buffer+1.5*blade_motor_mount_leg_width,0]){
                m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
            }
        }
    }
}

module blade_motor_mount_bottom_minus(){
    cylinder(r=blade_mount_inner_screw_radius+m4_nut_diameter/2+2*blade_buffer, h=blade_motor_mount_extension);
    translate([0,0,base_second_layer_thickness]){
        cylinder(d=blade_motor_diameter, h=blade_motor_mount_extension-base_second_layer_thickness);
    }
    for(rotation=[22.5:45:359]){
        rotate([0,0,rotation]){
            translate([blade_mount_inner_screw_radius+m4_nut_diameter/2+2*blade_buffer+1.5*blade_motor_mount_leg_width,0]){
                cylinder(d=screw_diameter,h=base_second_layer_thickness);
                translate([0,0,base_second_layer_thickness]){
                    cylinder(d=1.1*screw_head_diameter,h=blade_motor_mount_extension);
                }
            }
        }
    }
    for(rotation=[0:90:359]){
        rotate([0,0,rotation]){
            translate([blade_mount_inner_screw_radius+m4_nut_diameter/2+2*blade_buffer+1.5*blade_motor_mount_leg_width,0,blade_motor_mount_extension-4]){
                m3_nut_plus_bolt(8,4);
            }
        }
    }
}

module blade_motor_mount_top(){
    difference(){
        blade_motor_mount_top_plus();
        blade_motor_mount_top_minus();
    }
}
module blade_motor_mount_bottom(){
    difference(){
        blade_motor_mount_bottom_plus();
        blade_motor_mount_bottom_minus();
    }
}
//blade_mount_connector();
//blade_motor_mount_top();
//translate([2*blade_motor_mount_radius+5,0,0]){
//    blade_motor_mount_bottom();
//}