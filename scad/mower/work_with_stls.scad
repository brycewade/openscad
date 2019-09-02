include <mower_base.scad>

difference(){
    translate([0,very_front_y,0]) import("/home/vagrant/openscad/scad/mower/stl/front_wheel_base_mount2.stl");
    import("/home/vagrant/openscad/scad/mower/stl/minus.stl");
}
