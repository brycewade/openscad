$fn=360;

include <mower_measurements.scad>

module fan_mount(){
    rotate([-90,0,0]){
        difference(){
            translate([-fan_width/2-fan_mount_thickness,-fan_height/2-fan_mount_thickness,0]){
                cube([fan_width+2*fan_mount_thickness,fan_height+2*fan_mount_thickness,fan_mount_thickness]);
            }
            cylinder(d=fan_height-2, h=fan_mount_thickness);
            for(x=[-fan_width/2+fan_hole_offset:fan_hole_distance:fan_width/2+fan_hole_offset]){
                for(y=[-fan_height/2+fan_hole_offset:fan_hole_distance:fan_height/2+fan_hole_offset]){
                    translate([x,y,0]){
                        cylinder(d=screw_diameter, h=fan_mount_thickness);
                    }
                }
            }
        }
    }
}

module fan_mount_duct(){
    rotate([-90,0,0]){
        difference(){
            translate([-fan_width/2-fan_mount_thickness,-fan_height/2-fan_mount_thickness,0]){
                cube([fan_width+2*fan_mount_thickness,fan_height+2*fan_mount_thickness,fan_duct_depth]);
            }
            hull(){
                cylinder(d=fan_width,h=0.1);
                translate([-motor_driver_heatsink_width/2,-fan_height/2+motor_driver_base_standoff+fan_mount_thickness-fan_mount_thickness,fan_duct_depth-0.1]){
                    cube([motor_driver_heatsink_width,motor_driver_heatsink_height,0.1]);
                }
            }
            for(x=[-fan_width/2+fan_hole_offset:fan_hole_distance:fan_width/2+fan_hole_offset]){
                for(y=[-fan_height/2+fan_hole_offset:fan_hole_distance:fan_height/2+fan_hole_offset]){
                    translate([x,y,0]){
                        cylinder(d=screw_diameter, h=fan_duct_depth);
                    }
                }
            }
        }
    }
}

module base(){
    difference(){
        translate([-motor_driver_base_width/2,-motor_driver_base_length/2,-motor_driver_base_height]){
            cube([motor_driver_base_width,motor_driver_base_length+fan_duct_depth,motor_driver_base_height]);
        }
        for(x=[-motor_driver_base_width/2+motor_driver_base_hole_offsets:motor_driver_base_width-2*motor_driver_base_hole_offsets:motor_driver_base_width/2]){
            for(y=[-motor_driver_base_length/2+motor_driver_base_hole_offsets:motor_driver_base_length-2*motor_driver_base_hole_offsets+fan_duct_depth:motor_driver_base_length/2+fan_duct_depth]){
                translate([x,y,-motor_driver_base_height]){
                    cylinder(d=screw_diameter, h=motor_driver_base_standoff);
                }
            }
        }
    }
    for(x=[-motor_driver_width/2+motor_driver_hole_offsets:motor_driver_hole_distance:motor_driver_width/2]){
        for(y=[-motor_driver_length/2+motor_driver_hole_offsets:motor_driver_hole_distance:motor_driver_length/2]){
            translate([x,y,0]){
                difference(){
                    cylinder(d=motor_driver_base_standoff_diameter, h=motor_driver_base_standoff);
                    cylinder(d=screw_diameter, h=motor_driver_base_standoff);
                }
            }
        }
    }
}

module motor_driver(){
    
    translate([0,0,motor_driver_base_height]){
        base();
        translate([0,motor_driver_length/2+1+fan_duct_depth,fan_height/2+fan_mount_thickness]){
            rotate([0,0,180]) fan_mount_duct();
        }
    }
}

module quick_motor_driver(){
    translate([0,0,motor_driver_base_height]){
        translate([-motor_driver_base_width/2,-motor_driver_base_length/2,-motor_driver_base_height]){
            cube([motor_driver_base_width,motor_driver_base_length+fan_duct_depth,motor_driver_base_height]);
        }
        translate([0,motor_driver_length/2+1+fan_duct_depth,fan_height/2+fan_mount_thickness]){
            rotate([0,0,180]){
                rotate([-90,0,0]){
                    translate([-fan_width/2-fan_mount_thickness,-fan_height/2-fan_mount_thickness,0]){
                        cube([fan_width+2*fan_mount_thickness,fan_height+2*fan_mount_thickness,fan_duct_depth]);
                    }
                }
            }
        }
    }
}
module motor_driver_mounting_holes(){
    for(x=[-motor_driver_base_width/2+motor_driver_base_hole_offsets:motor_driver_base_width-2*motor_driver_base_hole_offsets:motor_driver_base_width/2]){
        for(y=[-motor_driver_base_length/2+motor_driver_base_hole_offsets:motor_driver_base_length-2*motor_driver_base_hole_offsets+fan_duct_depth:motor_driver_base_length/2+fan_duct_depth]){
            translate([x,y,-base_mounting_nut_depth-1.1*nut_height]){
                m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
            }
        }
    }
}

