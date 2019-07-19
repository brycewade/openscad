$fn=360;
include <mower_measurements.scad>

module blade_mount_connector_plus(){
    cylinder(d=blade_mount_connector_outter_diameter, h=blade_mount_connector_height);
    cylinder(r=blade_mount_inner_screw_radius+m4_nut_diameter/2+5, h=1.5*m8_nut_height+m4_nut_height+3);
}

module blade_mount_connector_minus(){
    cylinder(d=blade_mount_connector_inner_diameter, h=blade_mount_connector_height);
    cylinder(d=socket_14mm_diameter, h=1.5*m8_nut_height);
    translate([0,0,blade_mount_connector_cross_bar]){
        rotate([90,0,0]){
            translate([0,0,-blade_mount_connector_outter_diameter/2]) {
                cylinder(d=screw_head_diameter,h=screw_head_height);
                cylinder(d=screw_diameter,h=blade_mount_connector_outter_diameter);
                translate([0,0,blade_mount_connector_outter_diameter-nut_height*1.1]){
                    m3_nut();
                }
            }
        }
    }
    rotate([0,0,0]){
        translate([blade_mount_inner_screw_radius,0,1.5*m8_nut_height+m4_nut_height+3]){
            m4_nut_plus_bolt(20, 0);
        }
    }
    rotate([0,0,180]){
        translate([blade_mount_inner_screw_radius,0,1.5*m8_nut_height+m4_nut_height+3]){
            m4_nut_plus_bolt(25, 2);
        }
    }
}

module blade_mount_connector(){
    difference(){
        blade_mount_connector_plus();
        blade_mount_connector_minus();
    }
}

blade_mount_connector();
