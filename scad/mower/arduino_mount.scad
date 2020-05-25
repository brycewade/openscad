$fn=360;
include <mower_measurements.scad>

module female_jumpers(x,y){
    translate([-x*female_jumper_pitch/2,-y*female_jumper_pitch/2,0]){
        cube([x*female_jumper_pitch+1,y*female_jumper_pitch,mega_base_thickness+mega_board_offset+mega_board_thickness+female_jumper_height]);
    }
}

module arduino_base_plus(){
    // Base
    cube([mega_length,mega_width,mega_base_thickness]);
    // Power distribution
    translate([mega_length/2-0.5,-2*female_jumper_pitch,0]){
        female_jumpers(12,4);
    }
    translate([mega_length/2-0.5,mega_width+2*female_jumper_pitch,0]){
        female_jumpers(12,4);
    }
    // i2c distribution
    translate([mega_length/2-0.5-9*female_jumper_pitch,mega_width+3.2*female_jumper_pitch,0]){
        female_jumpers(7,6.4);
    }
    // Screw hole offsets
    for(offset=mega_holes){
        translate(offset){
            cylinder(r=mega_offset_radius,h=mega_base_thickness+mega_board_offset);
        }
    }
    // tabbed offsets
    for(offset=mega_offsets){
        translate(offset){
            cylinder(r=mega_offset_radius,h=mega_base_thickness+mega_board_offset);
            cylinder(d=screw_diameter,h=mega_base_thickness+mega_board_offset+mega_board_thickness);
        }
    }
}

module arduino_base_minus(){
    // Power distribution
    translate([mega_length/2-0.5,-2*female_jumper_pitch,0]){
        female_jumpers(10,2);
    }
    translate([mega_length/2-0.5,mega_width+2*female_jumper_pitch,0]){
        female_jumpers(10,2);
    }
    // i2c distribution
    translate([mega_length/2-0.5-9*female_jumper_pitch,mega_width+3.2*female_jumper_pitch,0]){
        female_jumpers(5,4.4);
    }
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
//arduino_base();
