include <mower_measurements.scad>
$fn=360;

    // Component locations
    relay_x=1.5*screw_head_diameter+relay_width/2+relay_wall_thickness+m2_screw_head_diameter;
    voltage_x=relay_x+relay_width/2+relay_wall_thickness+m2_screw_head_diameter+5+voltage_sensor_width/2+voltage_sensor_wall_thickness;
    current_x=voltage_x+voltage_sensor_width/2+voltage_sensor_wall_thickness+5+current_sensor_width/2+current_sensor_wall_thickness+1.5*m2_screw_head_diameter;

    relay_y=0;
    voltage_y=0;
    current_y=0;
    
    nano_x=nano_usb_width/2+nano_mount_thickness+m2_screw_diameter+1.5*screw_head_diameter;
    rtc_x=nano_x+nano_usb_width/2+nano_mount_thickness+m2_screw_diameter+5+rtc_width/2+rtc_wall_thickness;
    dc2dcc_x=dc2dcc_width/2+dc2dcc_wall_thickness+1.5*screw_head_diameter;
    
    
    nano_y=-1;
    rtc_y=0;
    dc2dcc_y=0;
    
    // Base size
    12v_mount_length=relay_length+2*relay_wall_thickness;
    12v_mount_width=current_x+current_sensor_width/2+current_sensor_wall_thickness+1.5*m2_screw_head_diameter+1.5*screw_head_diameter;
    
    5v_mount_length=dc2dcc_length+2*dc2dcc_wall_thickness;
    5v_mount_width=dc2dcc_x+dc2dcc_width/2+dc2dcc_wall_thickness+1.5*screw_head_diameter;
    
    nano_mount_length=nano_length+2*nano_mount_thickness-2*nano_pin_offset+1+m2_screw_diameter;
    nano_mount_width=nano_x+nano_usb_width/2+nano_mount_thickness+m2_screw_diameter+1.5*screw_head_diameter;

module nano_mount_plus(){
    // support pillars on pin side
    translate([-nano_pin_width/2-nano_mount_thickness,-nano_length/2-nano_mount_thickness+nano_pin_offset-0.5,0]){
        cube([nano_mount_thickness,nano_mount_thickness,nano_pin_depth+nano_board_height+nano_offset_height+2]);
    }
    translate([nano_pin_width/2,-nano_length/2-nano_mount_thickness+nano_pin_offset-0.5,0]){
        cube([nano_mount_thickness,nano_mount_thickness,nano_pin_depth+nano_board_height+nano_offset_height+2]);
    }
    //USB side
    translate([-nano_usb_width/2-nano_mount_thickness-m2_screw_diameter,nano_length/2-nano_pin_offset+0.5,0]){
        cube([nano_mount_thickness+m2_screw_diameter,nano_mount_thickness+m2_screw_diameter,nano_pin_depth+nano_offset_height+nano_board_height]);
    }
    translate([nano_usb_width/2,nano_length/2-nano_pin_offset+0.5,0]){
        cube([nano_mount_thickness+m2_screw_diameter,nano_mount_thickness+m2_screw_diameter,nano_pin_depth+nano_offset_height+nano_board_height]);
    }
}

module nano_mount_minus(){
    translate([-nano_width/2,-nano_length/2,nano_pin_depth+nano_offset_height]){
        cube([nano_width,nano_length,nano_board_height]);
    }
    translate([-nano_usb_width/2-nano_mount_thickness+m2_screw_diameter,nano_length/2-nano_pin_offset+0.5+nano_mount_thickness-m2_screw_diameter,nano_pin_depth+nano_board_height+nano_offset_height+2-8]){
        cylinder(d=m2_screw_diameter,h=8);
    }
    translate([nano_usb_width/2+nano_mount_thickness-m2_screw_diameter,nano_length/2-nano_pin_offset+0.5+nano_mount_thickness-m2_screw_diameter,nano_pin_depth+nano_board_height+nano_offset_height+2-8]){
        cylinder(d=m2_screw_diameter,h=8);
    }
}

module nano_mount_top(){
    difference(){
        translate([-nano_usb_width/2-nano_mount_thickness-m2_screw_diameter,-(nano_mount_thickness+m2_screw_diameter)/2,0]){
            cube([nano_usb_width+(nano_mount_thickness+m2_screw_diameter)*2,nano_mount_thickness+m2_screw_diameter,2]);
        }
            translate([-nano_usb_width/2-nano_mount_thickness+m2_screw_diameter,-(nano_mount_thickness+m2_screw_diameter)/2+nano_mount_thickness-m2_screw_diameter,0]){
            cylinder(d=m2_screw_diameter,h=8);
        }
        translate([nano_usb_width/2+nano_mount_thickness-m2_screw_diameter,-(nano_mount_thickness+m2_screw_diameter)/2+nano_mount_thickness-m2_screw_diameter,0]){
            cylinder(d=m2_screw_diameter,h=8);
        }
    }
}

module nano_mount(){
    difference(){
        nano_mount_plus();
        nano_mount_minus();
    }
}

module rtc_mount_plus(){
    translate([-rtc_width/2-rtc_wall_thickness,-rtc_length/2-rtc_wall_thickness,0]){
        cube([rtc_width+2*rtc_wall_thickness,rtc_length+2*rtc_wall_thickness,rtc_mount_hole_depth+rtc_wall_thickness]);
    }
}

module rtc_mount_minus(){
    translate([-rtc_width/2,-rtc_length/2,rtc_mount_hole_depth]){
        cube([rtc_width,rtc_length,rtc_wall_thickness]);
    }
    translate([-rtc_pin_width/2,-rtc_length/2,0]){
        cube([rtc_pin_width,rtc_length,rtc_mount_hole_depth]);
    }
    translate([-rtc_width/2,-rtc_length/2+2*rtc_mounting_hole_diameter,0]){
        cube([rtc_width,rtc_length-4*rtc_mounting_hole_diameter,rtc_mount_hole_depth]);
    }
    for(x=[-rtc_mounting_hole_x_offset,rtc_mounting_hole_x_offset]){
        for(y=[-rtc_mounting_hole_y_offset,rtc_mounting_hole_y_offset]){
            translate([x,y,0]) cylinder(d=screw_diameter,h=rtc_mount_hole_depth);
        }
    }
}

module rtc_mount(){
    difference(){
        rtc_mount_plus();
        rtc_mount_minus();
    }
}

module relay_mount_plus(){
    translate([-relay_width/2-relay_wall_thickness,-relay_length/2-relay_wall_thickness,0]){
        cube([relay_width+2*relay_wall_thickness,relay_length+2*relay_wall_thickness,relay_wall_thickness+relay_pin_depth+relay_offset_height]);
    }
    hull(){
        translate([relay_width/2+relay_wall_thickness,relay_unit_length/2+relay_snap_offset-relay_length/2,0]){
            cylinder(d=1.5*m2_screw_head_diameter, h=relay_pin_depth+relay_offset_height+relay_height);
        }
        translate([-relay_width/2-relay_wall_thickness,relay_unit_length/2+relay_snap_offset-relay_length/2,0]){
            cylinder(d=1.5*m2_screw_head_diameter, h=relay_pin_depth+relay_offset_height+relay_height);
        }
    }
}

module relay_mount_minus(){
    translate([-relay_width/2,-relay_length/2,relay_pin_depth+relay_offset_height]){
        cube([relay_width,relay_length,relay_height]);
    }
    translate([-relay_width/2,-relay_length/2,0]){
        cube([relay_width,relay_support1_start,relay_pin_depth+relay_offset_height]);
    }
    translate([-relay_width/2,-relay_length/2+relay_support1_stop,0]){
        cube([relay_width,relay_support2_start-relay_support1_stop,relay_pin_depth+relay_offset_height]);
    }
    translate([-relay_width/2,-relay_length/2+relay_support2_stop,0]){
        cube([relay_width,relay_support3_start-relay_support2_stop,relay_pin_depth+relay_offset_height]);
    }
    translate([-relay_width/2,-relay_length/2+relay_support3_stop,0]){
        cube([relay_width,relay_support4_start-relay_support3_stop,relay_pin_depth+relay_offset_height]);
    }
    translate([relay_width/2+relay_wall_thickness,relay_unit_length/2+relay_snap_offset-relay_length/2,relay_pin_depth+relay_offset_height+relay_height-relay_mount_screw_depth]){
        cylinder(d=m2_screw_diameter, h=relay_mount_screw_depth);
    }
    translate([-relay_width/2-relay_wall_thickness,relay_unit_length/2+relay_snap_offset-relay_length/2,relay_pin_depth+relay_offset_height+relay_height-relay_mount_screw_depth]){
        cylinder(d=m2_screw_diameter, h=relay_mount_screw_depth);
    }
}

module relay_mount_top(){
    difference(){
        hull(){
            translate([relay_width/2+relay_wall_thickness,0,0]){
                cylinder(d=1.5*m2_screw_head_diameter, h=2);
            }
            translate([-relay_width/2-relay_wall_thickness,0,0]){
                cylinder(d=1.5*m2_screw_head_diameter, h=2);
            }
        }
        translate([relay_width/2+relay_wall_thickness,0,0]){
            cylinder(d=m2_screw_diameter, h=2);
        }
        translate([-relay_width/2-relay_wall_thickness,0,0]){
            cylinder(d=m2_screw_diameter, h=2);
            }
    }
}
module relay_mount(){
    difference(){
        relay_mount_plus();
        relay_mount_minus();
    }
}


module current_sensor_plus(){
    translate([-current_sensor_width/2-current_sensor_wall_thickness,-current_sensor_length/2-current_sensor_wall_thickness,0]){
        cube([current_sensor_width+2*current_sensor_wall_thickness,current_sensor_length+2*current_sensor_wall_thickness,current_sensor_mount_screw_depth]);
    }
    hull(){
        for(x=[-current_sensor_width/2-current_sensor_wall_thickness,current_sensor_width/2+current_sensor_wall_thickness]){
            translate([x,0,0]){
                cylinder(d=1.5*m2_screw_head_diameter,h=current_sensor_mount_screw_depth);
            }
        }
    }
}

module current_sensor_minus(){
    translate([-current_sensor_width/2,-current_sensor_length/2,current_sensor_mount_screw_depth-current_sensor_depth-current_sensor_pin_depth]){
        cube([current_sensor_width,current_sensor_length/4,current_sensor_pin_depth+current_sensor_depth]);
    }
    translate([-current_sensor_width/2,current_sensor_length/4,current_sensor_mount_screw_depth-current_sensor_depth-current_sensor_pin_depth]){
        cube([current_sensor_width,current_sensor_length/4,current_sensor_pin_depth+current_sensor_depth]);
    }
    translate([-current_sensor_width/2,-current_sensor_length/4,current_sensor_mount_screw_depth-current_sensor_depth]){
        cube([current_sensor_width,current_sensor_length/2,current_sensor_depth]);
    }
    for(x=[-current_sensor_width/2-current_sensor_wall_thickness,current_sensor_width/2+current_sensor_wall_thickness]){
        translate([x,0,0]){
            cylinder(d=m2_screw_diameter,h=current_sensor_mount_screw_depth);
        }
    }
}

module current_sensor_top(){
    difference(){
        hull(){
            for(x=[-current_sensor_width/2-current_sensor_wall_thickness,current_sensor_width/2+current_sensor_wall_thickness]){
                translate([x,0,0]){
                    cylinder(d=1.5*m2_screw_head_diameter,h=2);
                }
            }
        }
        for(x=[-current_sensor_width/2-current_sensor_wall_thickness,current_sensor_width/2+current_sensor_wall_thickness]){
            translate([x,0,0]){
                cylinder(d=m2_screw_diameter,h=2);
            }
        }
    }
}

module current_sensor(){
    difference(){
        current_sensor_plus();
        current_sensor_minus();
    }
}

module voltage_sensor_plus(){
    difference(){
        translate([-voltage_sensor_width/2-voltage_sensor_wall_thickness,-voltage_sensor_length/2-voltage_sensor_wall_thickness,0]){
            cube([voltage_sensor_width+2*voltage_sensor_wall_thickness,voltage_sensor_length+2*voltage_sensor_wall_thickness,voltage_sensor_mount_screw_depth]);
        }
        translate([-voltage_sensor_width/2,-voltage_sensor_length/2,voltage_sensor_mount_screw_depth-voltage_sensor_depth-voltage_sensor_pin_depth]){
            cube([voltage_sensor_width,voltage_sensor_length,voltage_sensor_pin_depth+voltage_sensor_depth]);
        }
    }
    translate([0,-voltage_sensor_length/2+voltage_sensor_mounting_hole_y_offset,0]){
        cylinder(d=voltage_sensor_mounting_cylinder_diameter,h=voltage_sensor_mount_screw_depth-voltage_sensor_depth);
    }
}

module voltage_sensor_minus(){
    translate([0,-voltage_sensor_length/2+voltage_sensor_mounting_hole_y_offset,0]){
        rotate([0,0,180]) cylinder(d=screw_diameter,h=voltage_sensor_mount_screw_depth-voltage_sensor_depth);
    }
}

module voltage_sensor(){
    difference(){
        voltage_sensor_plus();
        voltage_sensor_minus();
    }
}

module dc_to_dc_converter_plus(){
    difference(){
        translate([-dc2dcc_width/2-dc2dcc_wall_thickness,-dc2dcc_length/2-dc2dcc_wall_thickness,0]){
               cube([dc2dcc_width+2*dc2dcc_wall_thickness,dc2dcc_length+2*dc2dcc_wall_thickness,dc2dcc_mount_height+dc2dcc_board_thickness]);
        }
        translate([-dc2dcc_width/2,-dc2dcc_length/2,dc2dcc_mount_height-dc2dcc_offset]){
               cube([dc2dcc_width,dc2dcc_length,dc2dcc_offset+dc2dcc_board_thickness]);
        }
    }
    translate([-dc2dcc_width/2,-dc2dcc_length/2,0]){
        hull(){
            for(support=dc2dcc_holes){
                translate(support){
                    cylinder(d=screw_head_diameter, h=dc2dcc_mount_height);
                }
            }
        }
    }
}

module dc_to_dc_converter_minus(){
    translate([-dc2dcc_width/2,-dc2dcc_length/2,0]){
        for(support=dc2dcc_holes){
            translate(support){
                cylinder(d=screw_diameter, h=dc2dcc_mount_height);
            }
        }
    }
}

module dc_to_dc_converter(){
    rotate([0,0,180]){
        difference(){
            dc_to_dc_converter_plus();
            dc_to_dc_converter_minus();
        }
    }
}

module compass_plus(){
    translate([-compass_width/2-compass_wall_thickness,-compass_length/2-compass_wall_thickness,0]){
        cube([compass_width+2*compass_wall_thickness,compass_width+2*compass_wall_thickness,compass_mount_screw_depth]);
    }
    hull(){
        for(x=[-compass_mount_x_offset,compass_mount_x_offset]){
            translate([x,0,0]){
                cylinder(d=1.5*screw_head_diameter,h=4);
            }
        }
    }
    hull(){
        for(y=[-compass_mount_y_offset,compass_mount_y_offset]){
            translate([0,y,0]){
                cylinder(d=1.5*m2_screw_head_diameter,h=compass_mount_screw_depth);
            }
        }
    }
}

module compass_minus(){
    translate([-compass_width/2,-compass_length/2,compass_mount_screw_depth-compass_depth]){
        cube([compass_width,compass_length,compass_depth]);
    }
    translate([-compass_width/2,-compass_length/2,compass_mount_screw_depth-compass_depth-compass_pins_depth]){
        cube([compass_pins_width,compass_length,compass_pins_depth]);
    }
    for(x=[-compass_mount_x_offset,compass_mount_x_offset]){
        translate([x,0,0]){
            cylinder(d=screw_diameter,h=4);
        }
    }
    for(y=[-compass_mount_y_offset,compass_mount_y_offset]){
        translate([0,y,0]){
            cylinder(d=m2_screw_diameter,h=compass_mount_screw_depth);
        }
    }
}

module compass_mounting_holes(){
    for(x=[-compass_mount_x_offset,compass_mount_x_offset]){
        translate([x,0,0]){
            m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
        }
    }
}

module compass_top(){
    translate([-compass_width/2+compass_pins_width,-compass_length/2-compass_wall_thickness,0]){
        cube([compass_width+compass_wall_thickness-compass_pins_width,compass_width+2*compass_wall_thickness,2]);
    }
    difference(){
        hull(){
            for(y=[-compass_mount_y_offset,compass_mount_y_offset]){
                translate([0,y,0]){
                    cylinder(d=1.5*m2_screw_head_diameter,h=2);
                }
            }
        }
        for(y=[-compass_mount_y_offset,compass_mount_y_offset]){
            translate([0,y,0]){
                cylinder(d=m2_screw_diameter,h=2);
            }
        }
    }
}

module compass(){
    difference(){
        compass_plus();
        compass_minus();
    }
}

module 12v_mount_plus(){

    translate([current_x, current_y,misc_mount_base_thickness]) current_sensor();
    translate([voltage_x,voltage_y,misc_mount_base_thickness]) voltage_sensor();
    translate([relay_x, relay_y,misc_mount_base_thickness]) relay_mount();
    
    translate([0,-12v_mount_length/2,0]){
        cube([12v_mount_width,12v_mount_length,misc_mount_base_thickness]);
    }
}

module 12v_mount_minus(){
    for(x=[screw_head_diameter,12v_mount_width-screw_head_diameter]){
        translate([x,0,0]){
            cylinder(d=screw_diameter,h=misc_mount_base_thickness);
        }
    }
}
module 12v_mount_holes(){
    for(x=[screw_head_diameter,12v_mount_width-screw_head_diameter]){
        translate([x,0,0]){
            m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
        }
    }
}

module 12v_mount(){
    difference(){
        12v_mount_plus();
        12v_mount_minus();
    }
}

module 5v_mount_plus(){
    //translate([rtc_x,rtc_y,misc_mount_base_thickness]) rtc_mount();
//    translate([nano_x,nano_y,misc_mount_base_thickness]) nano_mount();
    translate([dc2dcc_x, dc2dcc_y,misc_mount_base_thickness]) dc_to_dc_converter();
    
    translate([0,-5v_mount_length/2,0]){
        cube([5v_mount_width,5v_mount_length,misc_mount_base_thickness]);
    }
}

module 5v_mount_minus(){
    for(x=[screw_head_diameter,5v_mount_width-screw_head_diameter]){
        translate([x,0,0]){
            cylinder(d=screw_diameter,h=misc_mount_base_thickness);
        }
    }
}
module 5v_mount_holes(){
    for(x=[screw_head_diameter,5v_mount_width-screw_head_diameter]){
        translate([x,0,0]){
            m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
        }
    }
}

module 5v_mount(){
    difference(){
        5v_mount_plus();
        5v_mount_minus();
    }
}

module nano_mount_base_plus(){
    translate([nano_x,nano_y,misc_mount_base_thickness]) nano_mount();
    
    translate([0,-nano_mount_length/2,0]){
        cube([nano_mount_width,nano_mount_length,misc_mount_base_thickness]);
    }
}

module nano_mount_base_minus(){
    for(x=[screw_head_diameter,nano_mount_width-screw_head_diameter]){
        translate([x,0,0]){
            cylinder(d=screw_diameter,h=misc_mount_base_thickness);
        }
    }
}
module nano_mount_base_holes(){
    for(x=[screw_head_diameter,nano_mount_width-screw_head_diameter]){
        translate([x,0,0]){
            m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
        }
    }
}

module nano_mount_base(){
    difference(){
        nano_mount_base_plus();
        nano_mount_base_minus();
    }
}

