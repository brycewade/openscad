$fn=360;

include <mower_measurements.scad>

module side_brace_plus(){
       polyhedron(points=[
               [-side_brace_width/2,0,side_brace_side_length],           // 0    front top corner
               [-side_brace_width/2,0,0],[-side_brace_width/2,side_brace_base_length,0],   // 1, 2 front left & right bottom corners
               [side_brace_width/2,0,side_brace_side_length],           // 3    back top corner
               [side_brace_width/2,0,0],[side_brace_width/2,side_brace_base_length,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module m3_nut_plus_boltslot(length, overrun, slot_length){
    x=nut_diameter/2*1.05*sin(60);
    rotate([0,0,30]){
        m3_nut_plus_bolt(length, overrun);
    }
    translate([-x,0,0]){
        cube([2*x,slot_length,nut_height*1.1]);
    }
}

module nut_hole(){
    cylinder(d=screw_diameter,h=side_brace_thickness);
    translate([0,0,side_brace_thickness]){
        cylinder(d=nut_diameter*1.05, h=side_brace_base_length, $fn=6);
    }
}


module side_brace_minus(){
    translate([0,side_brace_base_hole,0]){
        cylinder(d=screw_diameter,h=side_brace_thickness);
    }
        translate([0,side_brace_base_hole,side_brace_thickness]){
        cylinder(d=screw_head_diameter,h=side_brace_side_length);
    }
    translate([0,0,side_brace_side_hole]){
        rotate([-90,0,0]){
            nut_hole();
        }
    }
}

module m3_bolt_cutout(){
    translate([0,0,-20]){
        cylinder(d=screw_head_diameter,h=20);
    }
    m3_bolt(8);
}
module motor_brace_minus(){
    translate([0,side_brace_base_hole,4+screw_head_height]){
        rotate([0,180,0]){
            m3_bolt_cutout();
        }
    }
    translate([0,4+screw_head_height,side_brace_side_hole]){
        rotate([90,0,0]){
            m3_bolt_cutout();
        }
    }
}

module side_brace(){
    difference(){
        side_brace_plus();
        side_brace_minus();
    }
}

module motor_brace(){
    difference(){
        side_brace_plus();
        motor_brace_minus();
    }
}

module front_brace_plus(){
       polyhedron(points=[
               [-side_brace_width*3/4,0,side_brace_side_length],           // 0    front top corner
               [-side_brace_width*3/4,0,0],[-side_brace_width*3/4,side_brace_base_length+5,0],   // 1, 2 front left & right bottom corners
               [side_brace_width*3/4,0,side_brace_side_length],           // 3    back top corner
               [side_brace_width*3/4,0,0],[side_brace_width*3/4,side_brace_base_length+5,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module front_brace_minus(){
//    translate([0,side_brace_base_hole,4+screw_head_height]){
//        rotate([0,180,0]){
//            m3_bolt_cutout();
//        }
//    }
    translate([0,4+screw_head_height,side_brace_side_hole]){
        rotate([90,0,0]){
            m3_bolt_cutout();
        }
    }
}

module front_brace(){
    difference(){
        front_brace_plus();
        front_brace_minus();
    }
}
//front_brace();
//translate([0,0,-25]) front_wheel_mount_holes();
back_y=-total_blade_radius-blade_y_offset-blade_gap-base_wall_thickness;
very_back_y=back_y-3*wheel_motor_mount_width;
front_y=back_y+base_blade_indent_length;
very_front_y=trimmer_y_offset-blade_y_offset+base_front_curve_radius;
base_layer1=base_thickness+base_blade_indent_height;
/*
difference(){
    translate([0,very_front_y+2*front_wheel_mount_back_circle_offset,0]){
        //cylinder(r=front_mount_radius, h=front_wheel_mount_pivot_height);
        for(deg=[-front_wheel_mount_angle_offset,front_wheel_mount_angle_offset]){
            rotate([0,0,deg-90]){
                //pivot_mount_rail_slot();
                translate([front_mount_radius-1+front_wheel_motor_mount_rail_depth,0,0]) rotate([0,0,-90]) front_brace();
            }
        }
    }
    translate([0,very_front_y+front_mount_base_legy,0]){
        for(deg=[-front_wheel_mount_angle_offset,front_wheel_mount_angle_offset]){
            rotate([0,0,180+deg]){
                translate([0, front_mount_radius+base_screw_offset+side_brace_base_hole,4+screw_head_height]){
                    rotate([0,180,0]){
                        m3_bolt_cutout();
                    }
                }
            }
        }
    }
}
translate([0,very_front_y+2*front_wheel_mount_back_circle_offset,0]){
    difference(){
        cylinder(r=front_mount_radius+20,h=side_brace_side_length);
        cylinder(r=front_mount_radius+9,h=side_brace_side_length);
    }
}
*/