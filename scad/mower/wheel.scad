$fn=360;

include <mower_measurements.scad>

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
