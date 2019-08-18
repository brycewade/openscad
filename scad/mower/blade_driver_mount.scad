$fn=360;
include <mower_measurements.scad>

module blade_driver_fan_mount_minus(){
    translate([blade_driver_base_pad/2+blade_driver_fan_duct_depth,0,fan_width/2]){
        rotate([90,0,-90]){
            translate([0,0,-blade_driver_fan_extension]){
                cylinder(d=fan_width,h=blade_driver_fan_extension);
            }
            hull(){
                cylinder(d=fan_width,h=0.1);
                translate([-blade_driver_heatsink_width/2,-fan_height/2,blade_driver_fan_duct_depth-0.1]){
                    cube([blade_driver_heatsink_width,blade_driver_heatsink_height-blade_driver_heatsink_base_height,0.1]);
                }
            }
            for(x=[-fan_width/2+fan_hole_offset:fan_hole_distance:fan_width/2+fan_hole_offset]){
                for(y=[-fan_height/2+fan_hole_offset:fan_hole_distance:fan_height/2+fan_hole_offset]){
                    translate([x,y,-blade_driver_fan_extension]){
                        cylinder(d=screw_diameter, h=fan_duct_depth);
                    }
                }
            }
        }
    }
}

module blade_driver_fan_mount_plus(){
    translate([blade_driver_base_pad/2+blade_driver_fan_duct_depth,0,fan_width/2]){
        rotate([90,0,-90]){
            translate([-fan_width/2-fan_mount_thickness,-fan_height/2-fan_mount_thickness,-blade_driver_fan_extension]){
                cube([fan_width+2*fan_mount_thickness,fan_height+2*fan_mount_thickness,blade_driver_fan_extension]);
            }
            hull(){
                translate([-fan_width/2-fan_mount_thickness,-fan_height/2-fan_mount_thickness,0]){
                    cube([fan_width+2*fan_mount_thickness,fan_height+2*fan_mount_thickness,0.1]);
                }
                translate([-blade_driver_heatsink_width/2-fan_mount_thickness,-fan_height/2-fan_mount_thickness,blade_driver_fan_duct_depth-0.1]){
                    cube([blade_driver_heatsink_width+2*fan_mount_thickness,blade_driver_heatsink_height+fan_mount_thickness,0.1]);
                }
            }
        }
    }
}

module blade_driver_fan_duct(){
    difference(){
        blade_driver_fan_mount_plus();
        blade_driver_fan_mount_minus();
    }
}

module blade_driver_base_plus(){
    // base pad
    translate([-blade_driver_base_pad/2,-blade_driver_base_pad/2,-blade_driver_base_height]){
        cube([blade_driver_base_pad+blade_driver_fan_duct_depth+blade_driver_fan_extension,blade_driver_base_pad,blade_driver_base_height]);
    }
    // under board fan duct
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset+blade_driver_heatsink_standoff,-blade_driver_heatsink_width/2-fan_mount_thickness,0]){
        cube([blade_driver_heasink_inset-blade_driver_heatsink_standoff,blade_driver_heatsink_width+2*fan_mount_thickness,blade_driver_heatsink_height]);
    }
    // hot air exit side board mounting
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset/2-blade_driver_mount_distance,-blade_driver_mount_distance/2,0]){
        cylinder(d=2*screw_diameter,h=blade_driver_heatsink_height);
    }
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset/2-blade_driver_mount_distance,blade_driver_mount_distance/2,0]){
        cylinder(d=2*screw_diameter,h=blade_driver_heatsink_height);
    }
}

module blade_driver_base_minus(){
    // base mounting holes
    translate([-blade_driver_base_pad/2+screw_head_diameter,-blade_driver_base_pad/2+screw_head_diameter,-blade_driver_base_height]){
        cylinder(d=screw_diameter,h=blade_driver_base_height);
    }
    translate([-blade_driver_base_pad/2+screw_head_diameter,blade_driver_base_pad/2-screw_head_diameter,-blade_driver_base_height]){
        cylinder(d=screw_diameter,h=blade_driver_base_height);
    }
    translate([blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension-screw_head_diameter,-blade_driver_base_pad/2+screw_head_diameter,-blade_driver_base_height]){
        cylinder(d=screw_diameter,h=blade_driver_base_height);
    }
    translate([blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension-screw_head_diameter,blade_driver_base_pad/2-screw_head_diameter,-blade_driver_base_height]){
        cylinder(d=screw_diameter,h=blade_driver_base_height);
    }
    // under board fan duct
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset,-blade_driver_heatsink_width/2,0]){
        cube([blade_driver_heasink_inset,blade_driver_heatsink_width,blade_driver_heatsink_height-blade_driver_heatsink_base_height]);
    }
    // fun duct side board mounting holes
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset/2,-blade_driver_mount_distance/2,blade_driver_heatsink_height-blade_driver_mount_hole_depth]){
        cylinder(d=screw_diameter,h=blade_driver_mount_hole_depth);
    }
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset/2,blade_driver_mount_distance/2,blade_driver_heatsink_height-blade_driver_mount_hole_depth]){
        cylinder(d=screw_diameter,h=blade_driver_mount_hole_depth);
    }
    // Slot for soldered pins
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset,-blade_driver_mount_distance/2+blade_driver_heasink_inset/2,blade_driver_heatsink_height-blade_driver_base_solder_standoff]){
        cube([blade_driver_heasink_inset,blade_driver_mount_distance-blade_driver_heasink_inset,blade_driver_base_solder_standoff]);
    }
    // hot air exit side board mounting holes
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset/2-blade_driver_mount_distance,-blade_driver_mount_distance/2,blade_driver_heatsink_height-blade_driver_mount_hole_depth]){
        cylinder(d=screw_diameter,h=blade_driver_mount_hole_depth);
    }
    translate([blade_driver_base_pad/2-blade_driver_heasink_inset/2-blade_driver_mount_distance,blade_driver_mount_distance/2,blade_driver_heatsink_height-blade_driver_mount_hole_depth]){
        cylinder(d=screw_diameter,h=blade_driver_mount_hole_depth);
    }
}

module blade_driver_base(){
    difference(){
        blade_driver_base_plus();
        blade_driver_base_minus();
    }
}

module blade_driver(){
    translate([0,0,blade_driver_base_height]){
        blade_driver_base();
        blade_driver_fan_duct();
    }
}

module quick_blade_driver(){
    translate([0,0,blade_driver_base_height]){
        blade_driver_base_plus();
        blade_driver_fan_mount_plus();
    }
}

module blade_driver_mounting_holes(){
    translate([-blade_driver_base_pad/2+screw_head_diameter,-blade_driver_base_pad/2+screw_head_diameter,0]){
        m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
    }
    translate([-blade_driver_base_pad/2+screw_head_diameter,blade_driver_base_pad/2-screw_head_diameter,0]){
        m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
    }
    translate([blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension-screw_head_diameter,-blade_driver_base_pad/2+screw_head_diameter,0]){
        m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
    }
    translate([blade_driver_base_pad/2+blade_driver_fan_duct_depth+blade_driver_fan_extension-screw_head_diameter,blade_driver_base_pad/2-screw_head_diameter,0]){
        m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
    }
}
