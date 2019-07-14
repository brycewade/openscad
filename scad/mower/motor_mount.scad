$fn=360;

include <mower_measurements.scad>


module shaft(){
    intersection(){
        cylinder(d=wheel_motor_shaft_diameter, h=wheel_motor_shaft_height);
        translate([-wheel_motor_shaft_diameter/2,-wheel_motor_shaft_diameter/2,0]){
            cube([wheel_motor_shaft_diameter,wheel_motor_shaft_D_width,wheel_motor_shaft_height]);
        }
    }
}

module motor(){
    cylinder(d=wheel_motor_narrow_diameter, h=wheel_motor_narrow_height+wheel_motor_nub_height);
    translate([0,0,wheel_motor_narrow_height-wheel_motor_nub_height]){
        cylinder(d=wheel_motor_diameter, h=wheel_motor_height+wheel_motor_nub_height);
    }
    translate([0,0,wheel_motor_height+wheel_motor_narrow_height]){
        cylinder(d=wheel_motor_nub_diameter, h=wheel_motor_nub_height);
    }
    translate([0,0,wheel_motor_height+wheel_motor_narrow_height+wheel_motor_nub_height]){
        shaft();
    }
}


module m3_nut_plus_bolt_insert(length, overrun){
    rotate([0,0,30]) m3_nut_plus_bolt(length, overrun);
    translate([-nut_diameter*1.05*sin(60)/2,0,0]) {
        cube([nut_diameter*1.05*sin(60),nut_diameter*1.05/2,nut_height*1.1]);
    }
}

module motor_mount_rail_mount(up){
    translate([-wheel_motor_mount_width/2+4,3*wheel_motor_mount_length/4,2.5]) {
        rotate([0,90,0]){
            rotate([0,0,-90*up]) m3_nut_plus_bolt_insert(12,2);
        }
    }
    translate([-wheel_motor_mount_width/2+4,wheel_motor_mount_length/4,-2.5]) {
        rotate([0,90,0]){
            rotate([0,0,-90*up]) m3_nut_plus_bolt_insert(12,2);
        }
    }
}

module motor_mount_rail_nuts(){
    translate([0,0,wheel_motor_mount_height/4]){
        motor_mount_rail_mount(-1);
        rotate([0,180,0]) motor_mount_rail_mount(1);
    }
    translate([0,0,3*wheel_motor_mount_height/4]){
        motor_mount_rail_mount(-1);
        rotate([0,180,0]) motor_mount_rail_mount(1);
    }
}

module motor_mount_plus(){
    translate([-wheel_motor_mount_width/2,0,0]){
        cube([wheel_motor_mount_width,wheel_motor_mount_length,wheel_motor_mount_height]);
    }
    translate([0,0,wheel_motor_height+wheel_motor_narrow_height]){
        cylinder(d=wheel_motor_mount_width,h=wheel_motor_nub_height);
    }
    translate([0,0,wheel_motor_total_height]){
       cylinder(r=2*wheel_motor_mount_hole_radius-wheel_motor_bearing_outer_diameter/2,h=wheel_motor_bearing_width);
    } 
}

module motor_mount_minus(){
    translate([-wheel_motor_mount_width/2,wheel_motor_mount_length,0]){
          cube([wheel_motor_mount_width,wheel_motor_mount_length,wheel_motor_mount_height]);
    }
    motor();
    translate([0,0,wheel_motor_total_height]){
           cylinder(d=wheel_motor_bearing_outer_diameter,h=wheel_motor_bearing_width);
    }
    for(angle=[0:60:360]){
        rotate([0,0,angle]){
            translate([wheel_motor_mount_hole_radius,0,wheel_motor_total_height-wheel_motor_nub_height]){
                cylinder(d=screw_diameter,h=wheel_motor_nub_height+wheel_motor_bearing_width);
            }
            translate([wheel_motor_mount_hole_radius,0,wheel_motor_total_height-wheel_motor_nub_height+wheel_motor_nub_height+wheel_motor_bearing_width-screw_head_height]){
                cylinder(d=screw_head_diameter,h=screw_head_height);
            }
        }
    }
    motor_mount_rail_nuts();
}

module motor_mount(){
    difference(){
        motor_mount_plus();
        motor_mount_minus();
    }
}


module m3_bolt(height){
    cylinder(d=screw_diameter,h=height+screw_head_height);
    cylinder(d=screw_head_diameter, h=screw_head_height);
}

module motor_mount_rail_plus(){
    translate([-wheel_motor_mount_rail_width/2,0,0]){
        cube([wheel_motor_mount_rail_width,wheel_motor_mount_rail_height,wheel_motor_mount_rail_depth]);
    }
}

module motor_mount_rail_minus(){
    for(i=[0:2]){
        translate([-2.5,wheel_motor_mount_length/4+i*wheel_motor_mount_rail_interval*2,wheel_motor_mount_rail_depth]){
            rotate([180,0,0]){
                m3_bolt(wheel_motor_mount_rail_width);
            }
        }
        translate([2.5,3*wheel_motor_mount_length/4+i*wheel_motor_mount_rail_interval*2,wheel_motor_mount_rail_depth]){
            rotate([180,0,0]){
                m3_bolt(wheel_motor_mount_rail_width);
            }
        }
    }
    rail_nut_height=wheel_motor_mount_rail_depth-nut_height*1.1-4;
    for(y=[wheel_motor_mount_length/2:wheel_motor_mount_rail_interval:wheel_motor_mount_rail_height-nut_diameter]){
        translate([0,y,rail_nut_height]){
            rotate([0,0,30]) m3_nut_plus_bolt(10,5);
        }
    }
}

module motor_mount_rail(){
    difference(){
        motor_mount_rail_plus();
        motor_mount_rail_minus();
    }
}

module motor_mount_and_rails(){
    translate([0,0,wheel_motor_mount_length]){
        rotate([-90,0,0]){
            motor_mount();
            translate([-wheel_motor_mount_width/2,wheel_motor_mount_length,wheel_motor_mount_height/4]){
                rotate([180,90,0]){
                    motor_mount_rail();
                }
            }
            translate([-wheel_motor_mount_width/2,wheel_motor_mount_length,3*wheel_motor_mount_height/4]){
                rotate([180,90,0]){
                    motor_mount_rail();
                }
            }
            translate([wheel_motor_mount_width/2,wheel_motor_mount_length,wheel_motor_mount_height/4]){
                rotate([180,-90,0]){
                    motor_mount_rail();
                }
            }
            translate([wheel_motor_mount_width/2,wheel_motor_mount_length,3*wheel_motor_mount_height/4]){
                rotate([180,-90,0]){
                    motor_mount_rail();
                }
            }
        }
    }
}

module motor_mount_cutout(){
    projection(cut=false) motor_mount_and_rails();
}

module quick_motor_mount_cutout(){
    translate([-wheel_motor_mount_width/2,0,0]){
        square([wheel_motor_mount_width,wheel_motor_mount_height]);
        translate([-wheel_motor_mount_rail_depth,wheel_motor_mount_height/4-wheel_motor_mount_rail_width/2,0]){
            square([2*wheel_motor_mount_rail_depth+wheel_motor_mount_width,wheel_motor_mount_rail_width]);
        }
        translate([-wheel_motor_mount_rail_depth,3*wheel_motor_mount_height/4-wheel_motor_mount_rail_width/2,0]){
            square([2*wheel_motor_mount_rail_depth+wheel_motor_mount_width,wheel_motor_mount_rail_width]);
        }
        /*
        translate([wheel_motor_mount_width/2,wheel_motor_mount_height,0]){
            square([wheel_motor_mount_width,wheel_motor_bearing_width]);
        }
        */
    }
}
