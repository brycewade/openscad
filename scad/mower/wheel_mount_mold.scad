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
            cylinder(d=screw_diameter,h=20);
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
            //cylinder(d=nut_diameter*1.1,h=nut_height*1.1,$fn=6);
            cylinder(d=screw_diameter, h=wheel_mount_diameter/2);
            translate([0,0,8]){
                cylinder(d=screw_head_diameter, h=wheel_mount_diameter/2);
            }
        }
    }
}

module wheel_mount_shaft_bolt(){
    translate([-wheel_motor_shaft_D_width+wheel_motor_shaft_diameter/2,0,wheel_motor_bearing_width+nut_diameter]){
        rotate([0,-90,0]){
            cylinder(d=screw_diameter, h=30);
        }
    }
}

module wheel_mount_minus(){
    rotate([0,0,90]){
       scale([1.05,1.05,1]) shaft();
    }
    for(angle=[0:120:360]){
        rotate([0,0,angle]){
            wheel_mount_screw_hole();
            //wheel_mount_nut();
        }
    }
    wheel_mount_shaft_nut();
}

module screws(){
    for(angle=[0:120:360]){
        rotate([0,0,angle]){
            wheel_mount_screw_hole();
            wheel_mount_nut();
        }
    }
}

wall_distance=-wheel_motor_shaft_D_width+wheel_motor_shaft_diameter/2+30;

module bottom_plus(){
    translate([-wall_distance,-wall_distance,-4+wheel_mount_total_height-wheel_mount_screw_depth+20]){
        cube([2*wall_distance,2*wall_distance,4]);
    }
}

module bottom(){
    difference(){
       bottom_plus();
       screws();
    }
}

module top_plus(){
    translate([-wall_distance,-wall_distance,-14]){
        cube([wall_distance*2,wall_distance*2,4]);
    }
    translate([-8,-8,-24]){
        cube([16,16,10]);
    }
}

module top(){
    difference(){
        top_plus();
        translate([0,0,-24]){
            rotate([0,0,90]){
               scale([1.1,1.1,1]) shaft();
            }
        }
    }
}

module wall(){
    translate([-wall_distance,-wall_distance+4,-10]){
        cube([4,2*wall_distance-4,wheel_mount_total_height-wheel_mount_screw_depth+30]);
    }
}

module walls(){
    for(angle=[90:90:359]){
        rotate([0,0,angle]){
            wall();
        }
    }
}

module pour_spout_intersection(){
    intersection(){
        offset=0.75*wheel_mount_diameter*sin(45);
        translate([0,0,wheel_mount_total_height-2.5]){
            rotate([90,0,-45]){
                cylinder(d=5, h=wheel_mount_diameter);
            }
        }
        translate([0,-offset,wheel_mount_total_height-2.5]){
            rotate([0,-90,0]){
                cylinder(d=5, h=wall_distance);
            }
        }
    }
}

module pour_spout(){
    pour_spout_intersection();
    offset=0.75*wheel_mount_diameter*sin(45);
    translate([0,0,wheel_mount_total_height-2.5]){
        rotate([90,0,-45]){
            cylinder(d=5, h=.75*wheel_mount_diameter);
        }
    }
    translate([-offset,-offset,wheel_mount_total_height-2.5]){
        rotate([0,-90,0]){
            cylinder(d1=5, d2=10, h=wall_distance-offset);
        }
    }
}
module pour_wall(){
    difference(){
        wall();
        pour_spout();
        wheel_mount_shaft_bolt();
    }
}

module case(){
    bottom();
    pour_wall();
    walls();
    //top();
}
difference(){
    wheel_mount();
    wheel_mount_minus();
}

/*
difference(){
    case();    
    wheel_mount_shaft_bolt();
}

difference(){
    pour_spout();
    wheel_mount();
}
*/