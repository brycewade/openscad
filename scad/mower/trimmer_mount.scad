$fn=360;

include <mower_measurements.scad>

module trimmer_cross(){
    translate([0,0,trimmer_circle_depth-trimmer_radial_line_height_offset]){
        intersection(){
            cylinder(d=trimmer_plus_diameter, h=trimmer_plus_depth);
            union(){
                rotate([0,0,0]){
                    translate([-trimmer_plus_width/2,-trimmer_plus_diameter/2,0]){
                        cube([trimmer_plus_width,trimmer_plus_diameter,trimmer_plus_depth]);
                    }
                }
                rotate([0,0,90]){
                    translate([-trimmer_plus_width/2,-trimmer_plus_diameter/2,0]){
                        cube([trimmer_plus_width,trimmer_plus_diameter,trimmer_plus_depth]);
                    }
                }
            }
        }
    }
}

module trimmer_cylinder_plus(){
    translate([0,0,trimmer_circle_depth-trimmer_radial_line_height_offset]){
        cylinder(d=trimmer_cylinder_outer_diameter, h=trimmer_cylinder_depth1);
    }
}

module trimmer_cylinder_minus(){
    translate([0,0,trimmer_circle_depth-trimmer_radial_line_height_offset+trimmer_cylinder_depth1-trimmer_cylinder_depth]){
        cylinder(d=trimmer_cylinder_inner_diameter, h=trimmer_cylinder_depth);
    }
}

module inner_circle_minus(){
    difference(){
        cylinder(d=trimmer_inner_circle_diameter2,h=trimmer_circle_depth);
        cylinder(d=trimmer_inner_circle_diameter1,h=trimmer_circle_depth);
    }
}

module center_circle_minus(){
    translate([0,0,trimmer_circle_depth-trimmer_radial_line_height_offset]){
        cylinder(d=trimmer_center_circle_diameter,h=trimmer_radial_line_height_offset);
    }
}

module outer_circle_minus(){
    difference(){
        cylinder(d=trimmer_outer_circle_diameter2,h=trimmer_circle_depth);
        cylinder(d=trimmer_outer_circle_diameter1,h=trimmer_circle_depth);
    }
}

module lever_notch(){
    rotate([0,0,trimmer_lever_angular_offset]){
        translate([0,trimmer_lever_radial_offset,0]){
            cylinder(d=trimmer_lever_outer_diameter,h=trimmer_circle_depth);
        }
    }
}

module trimmer_plus(){
    trimmer_cylinder_plus();
    translate([0,0,-1]){
        cylinder(d=trimmer_diameter,h=trimmer_circle_depth+1);
    }
}

module trimmer_minus(){
    trimmer_cylinder_minus();
    center_circle_minus();
    inner_circle_minus();
    outer_circle_minus();
    lever_notch();
}

difference(){
    trimmer_plus();
    trimmer_minus();
}

trimmer_cross();