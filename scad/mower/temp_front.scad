include <mower_base.scad>

difference(){
    translate([0,very_front_y,0]){
        wheel_pivot_base_mount();
        translate([-section_width/2,-section_length/2,base_layer1]){
            cube([section_width,section_length/2,base_second_layer_thickness]);
        }
    }
    base_holes();
}