include <blade_mount_connector.scad>

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
    translate([0,0,-m6_nut_height]){
        cylinder(d=m6_screw_diameter, h=60);
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
    // trimmer_cylinder_plus();
    translate([0,0,-m6_nut_height]){
        cylinder(d=trimmer_diameter,h=trimmer_circle_depth+m6_nut_height);
    }
}

module m6_nut(){
    translate([0,0,-m6_nut_height]){
        cylinder(d=m6_nut_diameter,h=m6_nut_height, $fn=6);
    }
}

module mounting_bolts(){
    for(deg=[45,225]){
        rotate([0,0,deg]){
            translate([blade_mount_inner_screw_radius,0,trimmer_circle_depth-trimmer_radial_line_height_offset]){
                rotate([0,180,0]){
                    m4_bolt(trimmer_circle_depth+m6_nut_height);
                }
                cylinder(d=m4_screw_head_diameter, h=trimmer_plus_depth);
            }
        }
    }
}
    
module trimmer_minus(){
    trimmer_cylinder_minus();
    center_circle_minus();
    inner_circle_minus();
    outer_circle_minus();
    lever_notch();
    m6_nut();
    mounting_bolts();
}

module trimmer_side_mount(){
    difference(){
        trimmer_plus();
        trimmer_minus();
    }
    
    difference(){
        trimmer_cross();
        trimmer_cylinder_minus();
        mounting_bolts();
    }
}

module motor_side_mount_plus(){
    blade_mount_connector_plus();
    cylinder(d=trimmer_diameter-3*trimmer_wall_thickness, h=2*trimmer_wall_thickness);
}

module motor_side_mount(){
    difference(){
        motor_side_mount_plus();
        blade_mount_connector_minus();
    }
}

motor_side_mount();