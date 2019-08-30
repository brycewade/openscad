include <mower_measurements.scad>
include <distance_sensor.scad>
$fn=360;




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

difference(){
shell();
distance_sensors();
}