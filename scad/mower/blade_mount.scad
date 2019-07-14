$fn=360;

include <mower_measurements.scad>

module blade_mount_profile_plus(){
    square([blade_mount_radius,blade_mount_outer_thickness]);
    square([blade_mount_taper_outer_radius,blade_mount_inner_thickness]);
}

module blade_mount_profile_minus(){
   translate([blade_mount_taper_outer_radius,blade_mount_taper_radius+blade_mount_outer_thickness,0]){
       circle(r=blade_mount_taper_radius);
   }
}

module blade_mount_profile(){
    difference(){
        blade_mount_profile_plus();
        blade_mount_profile_minus();
    }
}

module blade_mount_disc(){
    rotate_extrude() blade_mount_profile();
}

module blade_mount(){
    difference(){
        blade_mount_disc();
        for(angle=[0:120:360]){
            rotate([0,0,angle]){
                translate([blade_mount_outer_screw_radius,0,0]){
                    cylinder(d=m4_screw_diameter,h=blade_mount_inner_thickness);
                }
                translate([blade_mount_outer_screw_radius,0,blade_mount_outer_thickness-2]){
                    cylinder(d=m4_nut_diameter,h=m4_nut_height, $fn=6);
                }
            }
        }
        for(angle=[0:180:360]){
            rotate([0,0,angle]){
                translate([0,blade_mount_inner_screw_radius,0]){
                    cylinder(d=m4_screw_diameter,h=blade_mount_inner_thickness);
                }
            }
        }
    }
}

blade_mount();