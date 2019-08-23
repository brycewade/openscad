include <mower_measurements.scad>
$fn=360;

module nano_mount_plus(){
    // support pillars
    translate([-nano_pin_width/2-nano_mount_thickness,-nano_length/2-nano_mount_thickness+nano_pin_offset-0.5,0]){
        cube([nano_mount_thickness,nano_mount_thickness,nano_pin_depth+nano_board_height+nano_offset_height+2]);
    }
    translate([nano_pin_width/2,-nano_length/2-nano_mount_thickness+nano_pin_offset-0.5,0]){
        cube([nano_mount_thickness,nano_mount_thickness,nano_pin_depth+nano_board_height+nano_offset_height+2]);
    }
    translate([-nano_usb_width/2-nano_mount_thickness,nano_length/2-nano_pin_offset+0.5,0]){
        cube([nano_mount_thickness,nano_mount_thickness,nano_pin_depth+nano_offset_height+nano_board_height]);
    }
    translate([nano_usb_width/2,nano_length/2-nano_pin_offset+0.5,0]){
        cube([nano_mount_thickness,nano_mount_thickness,nano_pin_depth+nano_offset_height+nano_board_height]);
    }
}

module nano_mount_minus(){
    translate([-nano_width/2,-nano_length/2,nano_pin_depth+nano_offset_height]){
        cube([nano_width,nano_length,nano_board_height]);
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
        translate([relay_width/2+relay_wall_thickness+screw_head_diameter/2,relay_unit_length/2+relay_snap_offset-relay_length/2,0]){
            cylinder(d=screw_head_diameter, h=relay_pin_depth+relay_offset_height+relay_height);
        }
        translate([-relay_width/2-relay_wall_thickness-screw_head_diameter/2,relay_unit_length/2+relay_snap_offset-relay_length/2,0]){
            cylinder(d=screw_head_diameter, h=relay_pin_depth+relay_offset_height+relay_height);
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
    translate([relay_width/2+relay_wall_thickness+screw_head_diameter/2,relay_unit_length/2+relay_snap_offset-relay_length/2,relay_pin_depth+relay_offset_height+relay_height-relay_mount_screw_depth]){
        cylinder(d=screw_diameter, h=relay_mount_screw_depth);
    }
    translate([-relay_width/2-relay_wall_thickness-screw_head_diameter/2,relay_unit_length/2+relay_snap_offset-relay_length/2,relay_pin_depth+relay_offset_height+relay_height-relay_mount_screw_depth]){
        cylinder(d=screw_diameter, h=relay_mount_screw_depth);
    }
}

module relay_mount(){
    difference(){
        relay_mount_plus();
        relay_mount_minus();
    }
}


module current_sensor_plus(){
}

module current_sensor_minus(){
}

module current_sensor(){
    difference(){
        current_sensor_plus();
        current_sensor_minus();
    }
}

module voltage_sensor_plus(){
}

module voltage_sensor_minus(){
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

module misc_mount_plus(){
    rtc_x=rtc_width/2+rtc_wall_thickness;
    relay_x=rtc_x+rtc_width/2+rtc_wall_thickness+5+relay_width/2+relay_wall_thickness+screw_head_diameter;
    dc2dcc_x=relay_x+relay_width/2+relay_wall_thickness+screw_head_diameter+5+dc2dcc_width/2+dc2dcc_wall_thickness;
    
    rtc_y=0;
    relay_y=0;
    dc2dcc_y=0;
    
    translate([rtc_x,rtc_y,0]) rtc_mount();
    translate([relay_x, relay_y,0]) relay_mount();
    translate([dc2dcc_x, dc2dcc_y,0]) dc_to_dc_converter();
//    translate([voltage_x,voltage_y,0]) voltage_sensor();
//    translate([current_x, current_y,0]) current_sensor();
}


misc_mount_plus();