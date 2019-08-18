$fn=360;

include <mower_measurements.scad>


module tread(){
    translate([wheel_radius-wheel_prism_width-0.5,0,0]) {
        rotate([90,0,0]){
            prism(wheel_prism_length, wheel_prism_width, wheel_prism_height);
        }
    }
}

difference(){
    cylinder(r=wheel_radius-wheel_prism_width, h=wheel_height);
    cylinder(r=wheel_radius-2*wheel_prism_width, h=wheel_height);
}
difference(){
    union(){
        for(spoke=[0:72:360]){
            rotate([0,0,spoke]){
                hull(){
                    cylinder(d=wheel_prism_width,h=wheel_height);
                    translate([wheel_radius-2*wheel_prism_width,0,0]){
                        cylinder(d=wheel_prism_width,h=wheel_height);
                    }
                }
            }
        }
        cylinder(d=wheel_prism_width*3,h=wheel_height);
    }
    for(angle=[0:120:360]){
        rotate([0,0,angle]){
            translate([wheel_mount_diameter/3,0,0]){
                cylinder(d=screw_diameter,h=wheel_height);
            }
            translate([wheel_mount_diameter/3,0,wheel_screw_depth]){
                cylinder(d=screw_head_diameter,h=wheel_height-wheel_screw_depth);
            }
        }
    }
}

for(offset=[wheel_prism_length:(wheel_height-wheel_prism_length)/5:wheel_height]){
    for(angle=[0:10:360]){
        translate([0,0,offset]){
            rotate([0,0,offset/1.2+angle]){
                tread();
            }
        }
    }
}
