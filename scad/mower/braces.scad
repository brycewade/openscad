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

module side_brace(){
    difference(){
        side_brace_plus();
        side_brace_minus();
    }
}

side_brace();