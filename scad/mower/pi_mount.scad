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

module power_distribution_mount_plus(){
    translate([-power_width/2,0,0]){
        cube([power_width,power_length,power_height]);
    }
//    for(y=[0,power_length]){
//        translate([0,y,0]){
//            cylinder(d=screw_head_diameter,h=6);
//        }
//    }
}

module power_screw_slot(){
    hull(){
        cylinder(d=power_screw_diameter, h=power_height);
        translate([0,power_length/2-power_spacing-misc_mount_base_thickness,0]){
            cylinder(d=power_screw_diameter, h=power_height);
        }
    }
}

module power_distribution_mount_minus(){
    translate([-power_brass_width/2,misc_mount_base_thickness,power_height-misc_mount_base_thickness]){
        cube([power_brass_width,power_length-2*misc_mount_base_thickness,misc_mount_base_thickness]);
    }
    // screw cutouts
    translate([0,power_length/2,0]) {
        cylinder(d=power_screw_diameter, h=power_height);
    }
    translate([0,misc_mount_base_thickness+power_screw_diameter/2,0]){
        power_screw_slot();
    }
    translate([0,power_length/2+power_spacing-power_screw_diameter/2,0]){
        power_screw_slot();
    }

//    // Mounting holes
//    for(y=[0,power_length]){
//        translate([0,y,0]){
//            cylinder(d=screw_diameter,h=6);
//        }
//        translate([0,y,6]){
//            cylinder(d=screw_head_diameter,h=power_height-6);
//        }
//    }
}

module power_distribution_mount(){
    difference(){
        power_distribution_mount_plus();
        power_distribution_mount_minus();
    }
}

module pi_mount2(){
    // The pi mount itself
    pi_mount();
    // Some spacers
    translate([raspberry_pi_width/2,0,0]) cube([7.5,raspberry_pi_length,raspberry_pi_base_thickness]);
    translate([-raspberry_pi_width/2-7.5,0,0]) cube([7.5,raspberry_pi_length,raspberry_pi_base_thickness]);
    // Power distribution strips
    translate([raspberry_pi_width/2+power_width/2+7.5,0,0]) power_distribution_mount();
    translate([-raspberry_pi_width/2-power_width/2-7.5,0,0]) power_distribution_mount();
}