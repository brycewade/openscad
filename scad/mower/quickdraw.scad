include <mower_base.scad>

difference(){
    import("/tmp/base.stl");
    translate([base_width/2,very_front_y-very_back_y+(front_mount_radius-wheel_motor_bearing_outer_diameter/2-base_wall_thickness)/2,0]){
        cylinder(r=front_mount_radius,h=50);
    }
}