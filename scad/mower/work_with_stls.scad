include <mower_base.scad>

module front_piece(){
    difference(){
        translate([0,very_front_y,0]) import("/home/vagrant/openscad/scad/mower/stl/front_wheel_base_mount2.stl");
        //import("/home/vagrant/openscad/scad/mower/stl/minus.stl");
        trimmer_cutout();
        base_holes();
        mount_holes();
    }
}

module bottom_front(x,y){
    intersection(){
        translate([base_width/2,-very_back_y,0]) front_piece();
        bottom_section(x,y);
    }
}
bottom_front(0.5,3);