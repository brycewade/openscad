include <mower_base.scad>

quick_cutout();

    translate([0,0,base_top+1]){
        rotate([0,0,blade_motor1deg]){
            blade_motor_mount_bottom();
        }
    }