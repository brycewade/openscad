$fn=360;
include <mower_measurements.scad>

module arduino_base_plus(){
    cube([mega_length,mega_width,mega_base_thickness]);
    for(offset=mega_holes){
        translate(offset){
            cylinder(r=mega_offset_radius,h=mega_base_thickness+mega_board_offset);
        }
    }
    
    for(offset=mega_offsets){
        translate(offset){
            cylinder(r=mega_offset_radius,h=mega_base_thickness+mega_board_offset);
            cylinder(d=screw_diameter,h=mega_base_thickness+mega_board_offset+mega_board_thickness);
        }
    }
}

module arduino_base_minus(){
    for(hole=mega_holes){
        translate(hole){
            cylinder(d=screw_diameter,h=mega_base_thickness+mega_board_offset);
        }
    }
}

module arduino_base_mounting_holes(){
    translate([0,-mega_width/2,0]){
        for(hole=mega_holes){
            translate(hole){
                m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
            }
        }
    }
} 

module arduino_base(){
    translate([0,-mega_width/2,0]){
        difference(){
            arduino_base_plus();
            arduino_base_minus();
        }
    }
}