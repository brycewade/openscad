$fn=360;

include <mower_measurements.scad>

module pi_mount_plus(){
    cube([raspberry_pi_width,raspberry_pi_length,raspberry_pi_base_thickness]);
    for(x=raspberry_pi_x_holes){
        for(y=raspberry_pi_y_holes){
            translate([x,y,raspberry_pi_base_thickness]){
                cylinder(r=raspberry_pi_offset_radius, h=raspberry_pi_offset);
            }
        }
    }
}

module pi_mount_minus(){
    for(x=raspberry_pi_x_holes){
        for(y=raspberry_pi_y_holes){
            translate([x,y,0]){
                cylinder(d=screw_diameter, h=raspberry_pi_base_thickness+raspberry_pi_offset);
            }
        }
    }    
}

module pi_mount_holes(){
    translate([-raspberry_pi_width/2,0,0]){
        for(x=raspberry_pi_x_holes){
            for(y=raspberry_pi_y_holes){
                translate([x,y,0]){
                    m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
                }
            }
        }  
    }
}

module pi_mount(){
    translate([-raspberry_pi_width/2,0,0]){
        difference(){
            pi_mount_plus();
            pi_mount_minus();
        }
    }
}