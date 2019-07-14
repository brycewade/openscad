$fn=360;

include <mower_measurements.scad>
use <motor_mount.scad>

module wheel_mount(){
    cylinder(d=wheel_motor_bearing_inner_diameter, h=wheel_motor_bearing_width+1);
    translate([0,0,wheel_mount_total_height-wheel_mount_height]){
        cylinder(d=wheel_mount_diameter, h=wheel_mount_height);
    }
}

module wheel_mount_screw_hole(){
        translate([wheel_mount_diameter/3,0,wheel_mount_total_height-wheel_mount_screw_depth]){
            cylinder(d=screw_diameter,h=2*wheel_mount_screw_depth);
        }
}

module wheel_mount_nut(){
    hull(){
        translate([wheel_mount_diameter/3,0,wheel_mount_total_height-6]){
            cylinder(d=nut_diameter*1.1,h=nut_height*1.1,$fn=6);
        }
    }
}

module wheel_mount_shaft_nut(){
    translate([-wheel_motor_shaft_D_width+wheel_motor_shaft_diameter/2,0,wheel_motor_bearing_width+nut_diameter]){
        rotate([0,-90,0]){
            cylinder(d=nut_diameter*1.1,h=nut_height*1.1,$fn=6);
            cylinder(d=screw_diameter, h=wheel_mount_diameter/2);
            translate([0,0,8]){
                cylinder(d=screw_head_diameter, h=wheel_mount_diameter/2);
            }
        }
    }
}

difference(){
    wheel_mount();
    rotate([0,0,90]) shaft();
    for(angle=[0:120:360]){
        rotate([0,0,angle]){
            wheel_mount_screw_hole();
            wheel_mount_nut();
        }
    }
    wheel_mount_shaft_nut();
}

