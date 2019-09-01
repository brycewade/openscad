include <mower_measurements.scad>
include <distance_sensor.scad>
$fn=360;

back_y=-total_blade_radius-blade_y_offset-blade_gap-base_wall_thickness;
very_back_y=back_y-3*wheel_motor_mount_width;
front_y=back_y+base_blade_indent_length;
very_front_y=trimmer_y_offset-blade_y_offset+base_front_curve_radius;
base_layer1=base_thickness+base_blade_indent_height;
base_top=base_layer1+base_second_layer_thickness;
front_mount_base_y=very_front_y+front_mount_base_legy;

section_width=base_width/2;
section_length=(very_front_y-very_back_y)/3;

module curved_enclosure(r0, r1, height, thickness){
    radius=r1-r0<height/2?r1-r0:height/2;
    bumpout=r1-r0<height/2?0:r1-r0-height/2;
    
    rotate_extrude(angle=360){
        translate([r0+bumpout,0,0]){
            difference(){
                union(){
                    translate([thickness,0,0]){
                        curved_joint(0,0,radius,height,radius,radius,1);
                    }
                    square([thickness,height]);
                }
                curved_joint(0,0,radius,height,radius,radius,1);
            }
        }
    }
}

module shell(){
    difference(){
        cylinder(r=trimmer_diameter/2,h=3*trimmer_wall_thickness+12);
        cylinder(r=trimmer_diameter/2-trimmer_wall_thickness,h=3*trimmer_wall_thickness+12);
    }
    translate([0,0,3*trimmer_wall_thickness+10]){
        curved_enclosure(blade_motor_diameter/2, trimmer_diameter/2-trimmer_wall_thickness, 36-3*trimmer_wall_thickness, trimmer_wall_thickness);
    }
}

module distance_sensors(){
    fudge_factor=3;
    radial_offset=sqrt((trimmer_diameter/2-trimmer_wall_thickness)*(trimmer_diameter/2-trimmer_wall_thickness)-(distance_sensor_board_length/2*distance_sensor_board_length/2))-distance_sensor_board_depth-fudge_factor;
    for(deg=[0,90]){
        rotate([0,0,deg]){
            translate([radial_offset,0,distance_sensor_board_width/2+3*trimmer_wall_thickness]){
                rotate([0,90,0]){
                    rotate([0,0,180]){
                        distance_sensor();
                    }
                }
            }
        }
    }
}

//difference(){
//    hull(){
//        cylinder(d=blade_motor_diameter+2*base_wall_thickness,h=base_wall_thickness);
//        translate([-base_width/8,-section_length/4,115-22]){
//            cube([base_width/4,section_length/2,base_second_layer_thickness]);
//        }
//    }
//    translate([0,0,base_wall_thickness]){
//        cylinder(r=base_front_curve_radius+5,h=115);
//    }
//}

difference(){
    hull(){
        translate([base_front_curve_radius,base_front_curve_radius,0]){
            cylinder(d=blade_motor_diameter+2*base_wall_thickness,h=base_wall_thickness);
        }
        translate([base_front_curve_radius-blade_motor_diameter/2-base_wall_thickness,0,0]){
            cube([section_length/2-(base_front_curve_radius-blade_motor_diameter/2-base_wall_thickness),base_front_curve_radius,base_wall_thickness]);
        }
        translate([base_front_curve_radius,0,0]){
            cube([section_length/2-base_front_curve_radius,base_front_curve_radius+blade_motor_diameter/2+base_wall_thickness,base_wall_thickness]);
        }
        translate([0,0,93]){
            cube([base_width/4,section_length/2,base_second_layer_thickness]);
        }
    }
    translate([base_front_curve_radius,base_front_curve_radius,base_wall_thickness]){
        cylinder(d1=blade_motor_diameter+2*base_wall_thickness,d2=trimmer_diameter,h=35);
    }
    translate([base_front_curve_radius,base_front_curve_radius,base_wall_thickness+35]){
        cylinder(d1=trimmer_diameter,r2=base_front_curve_radius+5,h=95-35);
    }
    translate([0,base_front_curve_radius,base_wall_thickness]){
        cube([base_front_curve_radius,base_front_curve_radius,95]);
    }
}