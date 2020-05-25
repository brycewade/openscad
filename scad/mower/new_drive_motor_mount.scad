include <mower_measurements.scad>
include <mower_base.scad>

mount_separation=(66.4+73.54)/2;
mount_from_hub_center=81.5;
mount_width=5.0;
base_total_thickness=base_thickness+base_second_layer_thickness+base_blade_indent_height;
hub_diameter=13;
bump_offset=2.7;
m4_screw_length=12;
mount_angle=atan(mount_separation/2/mount_from_hub_center);
mount_distance=sqrt(mount_from_hub_center*mount_from_hub_center+mount_separation*mount_separation/4);
echo(mount_angle);


y_mount_distance=wheel_motor_mount_width+wheel_motor_mount_rail_depth*2+side_brace_base_hole*2;
x_mount_distance=wheel_motor_mount_height/2;
x_mount_offset=wheel_motor_mount_height/4;


normalized_y=y_mount_distance/2/mount_distance;
angle=asin(normalized_y);
drive_motor_offset_angle=angle-mount_angle;

module mount_t(){
    translate([-mount_separation/2,mount_from_hub_center,0]){
        cylinder(d=m4_screw_diameter,h=30);
        translate([0,0,m4_screw_length-m4_nut_height*1.1]){
            cylinder(d=m4_nut_diameter*1.05, h=40, $fn=6);
        }
    }
    translate([mount_separation/2,mount_from_hub_center,0]){
        cylinder(d=m4_screw_diameter,h=30);
        translate([0,0,m4_screw_length-m4_nut_height*1.1]){
            cylinder(d=m4_nut_diameter*1.05, h=40, $fn=6);
        }
    }
}

module back_mount(){
    hull(){
        translate([0,-y_mount_distance/2-3-screw_diameter/2,0]){
            cube([wheel_motor_mount_height,6+screw_diameter,6]);
        }
        rotate([0,90,0]){
            rotate([0,0,90-drive_motor_offset_angle]){
                translate([-mount_separation/2,mount_from_hub_center,0]){
                    cylinder(d=m4_screw_diameter+6,h=m4_screw_length-mount_width);
                }
            }
        }
    }
}

module front_mount(){
    hull(){
        translate([0,y_mount_distance/2-3-screw_diameter/2,0]){
            cube([wheel_motor_mount_height,6+screw_diameter,6]);
        }
        rotate([0,90,0]){
            rotate([0,0,90-drive_motor_offset_angle]){
                translate([mount_separation/2,mount_from_hub_center,0]){
                    cylinder(d=m4_screw_diameter+6,h=m4_screw_length-mount_width);
                }
            }
        }
    }
}

module connectors(){
    rotate([0,90,0]){
        rotate([0,0,90-drive_motor_offset_angle]){
            hull(){
                translate([-mount_separation/2,mount_from_hub_center,bump_offset]){
                    cylinder(d=m4_screw_diameter+6,h=m4_screw_length-mount_width-bump_offset);
                }
                translate([mount_separation/2,mount_from_hub_center,bump_offset]){
                    cylinder(d=m4_screw_diameter+6,h=m4_screw_length-mount_width-bump_offset);
                }
            }
        }
    }
    hull(){
        translate([x_mount_offset,-y_mount_distance/2,0]){
            cylinder(d=6+screw_diameter,h=6);
        }
        translate([x_mount_offset+x_mount_distance,y_mount_distance/2,0]){
            cylinder(d=6+screw_diameter,h=6);
        }
    }
    hull(){
        translate([x_mount_offset,y_mount_distance/2,0]){
            cylinder(d=6+screw_diameter,h=6);
        }
        translate([x_mount_offset+x_mount_distance,-y_mount_distance/2,0]){
            cylinder(d=6+screw_diameter,h=6);
        }
    }
}

module screw_holes(){
    rotate([0,90,0]){
        rotate([0,0,90-drive_motor_offset_angle]){
            mount_t();
        }
    }
    for (x=[x_mount_offset,x_mount_offset+x_mount_distance]){
        for(y=[-y_mount_distance/2,y_mount_distance/2]){
            translate([x,y,0]){
                cylinder(d=screw_diameter,h=80);
            }
            translate([x,y,6]){
                cylinder(d=screw_head_diameter*1.05,h=80);
            }
        }
    }
}

module plus(){
    back_mount();
    front_mount();
    connectors();
}

difference(){
    plus();
    screw_holes();
}