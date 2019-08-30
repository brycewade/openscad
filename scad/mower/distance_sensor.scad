include <mower_measurements.scad>
$fn=360;


module distance_sensor_plus(){
    // PCB
    translate([-distance_sensor_board_width/2,-distance_sensor_board_length/2,0]){
        cube([distance_sensor_board_width,distance_sensor_board_length,distance_sensor_board_depth]);
    }
    // Transducers
    for(y=[-distance_sensor_tranducer_center_y,distance_sensor_tranducer_center_y]){
        translate([0,y,distance_sensor_board_depth]){
            cylinder(d=distance_sensor_tranducer_diameter,h=distance_sensor_tranducer_depth);
        }
    }
    // Oscillator
    hull(){
        for(y=[-distance_sensor_oscillator_center_y,distance_sensor_oscillator_center_y]){
            translate([-distance_sensor_oscillator_center_x,y,distance_sensor_board_depth]){
                cylinder(d=distance_sensor_oscillator_diameter,h=distance_sensor_oscillator_depth);
            }
        }
    }
    // Pins
    translate([distance_sensor_board_width/2-distance_sensor_pin_base_width,-distance_sensor_pin_length/2,-distance_sensor_pin_depth]){
        cube([distance_sensor_pin_base_width,distance_sensor_pin_length,distance_sensor_pin_depth]);
    }
    translate([distance_sensor_board_width/2-distance_sensor_pin_base_width,-distance_sensor_pin_length/2,-distance_sensor_pin_depth]){
        cube([distance_sensor_pin_width,distance_sensor_pin_length,distance_sensor_pin_diameter]);
    }
}

module distance_sensor_minus(){
    for(x=[-distance_sensor_hole_x_offsets,distance_sensor_hole_x_offsets]){
        for(y=[-distance_sensor_hole_y_offsets,distance_sensor_hole_y_offsets]){
            translate([x,y,0]){
                cylinder(d=distance_sensor_hole_diameter,h=distance_sensor_board_depth);
            }
        }
    }
}

module distance_sensor(){
    difference(){
        distance_sensor_plus();
        distance_sensor_minus();
    }
}

//distance_sensor();