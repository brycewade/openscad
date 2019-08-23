$fn=360;
include <mower_measurements.scad>

module gps_mount_plus(){
    cube([gps_board_x+2*gps_board_mount_lip,gps_board_y+2*gps_board_mount_lip,gps_board_mount_lip_thickness]);
    translate([gps_board_mount_lip,gps_board_mount_lip,gps_board_mount_lip_thickness]){
        cube([30,gps_board_y,gps_board_antenna_z]);
    }
    translate([gps_board_x,gps_board_y/2,gps_board_mount_lip_thickness]){
        cube([2*gps_board_mount_lip,2*gps_board_mount_lip,gps_board_antenna_z]);
    }
}

module gps_mount_minus(){
    // Cutouts for pins
    translate([gps_board_mount_lip+2*gps_hole_offset,gps_board_mount_lip,gps_board_mount_lip_thickness+gps_board_antenna_z-gps_board_solder_cutout]){
        cube([30-2*gps_hole_offset,2*gps_hole_offset,gps_board_solder_cutout]);
    }
    translate([gps_board_mount_lip+2*gps_hole_offset,gps_board_mount_lip+gps_board_y-2*gps_hole_offset,gps_board_mount_lip_thickness+gps_board_antenna_z-gps_board_solder_cutout]){
        cube([30-2*gps_hole_offset,2*gps_hole_offset,gps_board_solder_cutout]);
    }
    // Mounting holes for the gps board
    translate([gps_board_mount_lip+gps_hole_offset,gps_board_mount_lip+gps_hole_offset,gps_board_mount_lip_thickness+gps_board_antenna_z-gps_board_screw_depth]){
        cylinder(d=screw_diameter, h=gps_board_screw_depth);
    }
    translate([gps_board_mount_lip+gps_hole_offset,gps_board_mount_lip+gps_board_y-gps_hole_offset,gps_board_mount_lip_thickness+gps_board_antenna_z-gps_board_screw_depth]){
        cylinder(d=screw_diameter, h=gps_board_screw_depth);
    }
    // Mounting holes for mount
    for(x=[gps_board_mount_lip/2,gps_board_x+3/2*gps_board_mount_lip]){
        for(y=[gps_board_mount_lip/2,gps_board_y+3/2*gps_board_mount_lip]){
            translate([x,y,0]){
                cylinder(d=screw_diameter, h=gps_board_mount_lip_thickness);
            }
        }
    }
}

module gps_mount_holes(){
    translate([-gps_board_x/2-gps_board_mount_lip,-gps_board_y/2-gps_board_mount_lip,0]){
        for(x=[gps_board_mount_lip/2,gps_board_x+3/2*gps_board_mount_lip]){
            for(y=[gps_board_mount_lip/2,gps_board_y+3/2*gps_board_mount_lip]){
                translate([x,y,0]){
                    m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
                }
            }
        }
    }
}
    
module gps_mount(){
    translate([-gps_board_x/2-gps_board_mount_lip,-gps_board_y/2-gps_board_mount_lip,0]){
        difference(){
            gps_mount_plus();
            gps_mount_minus();
        }
    }
}
