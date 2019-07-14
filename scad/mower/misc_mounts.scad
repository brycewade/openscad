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
    translate([-relay_width/2-relay_wall_thickness,-relay_length/2+relay_snap_offset,relay_pin_depth+relay_offset_height]){
        cube([relay_width+2*relay_wall_thickness,relay_unit_length,relay_height]);
    }
    translate([0,relay_unit_length/2+relay_snap_offset-relay_length/2,0]){
        for(rotate=[0,180]){
            rotate([0,0,rotate]){
                translate([-relay_width/2-relay_wall_thickness,-relay_unit_length/2,relay_pin_depth+relay_offset_height+relay_height]){
                    hull(){
                        cube([relay_wall_thickness+relay_snap_overhang,relay_unit_length,1]);
                        translate([0,0,relay_snap_height]){
                            cube([relay_snap_overhang,relay_unit_length,0.01]);
                        }
                    }
                }
            }
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
}

module relay_mount(){
    difference(){
        relay_mount_plus();
        relay_mount_minus();
    }
}

relay_mount();