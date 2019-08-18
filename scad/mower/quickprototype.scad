include <mower_base.scad>

module quick_base(){
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_-0.5_-0.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_0.5_-0.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_1.5_-0.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_-0.5_0.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_0.5_0.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_1.5_0.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_-0.5_1.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_0.5_1.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_1.5_1.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_-0.5_2.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_0.5_2.5.stl");
    import("/home/vagrant/openscad/scad/mower/stl/base/upper_part_1.5_2.5.stl");
}

difference(){
    quick_base();
    translate([base_width/2,-very_back_y,0]) mount_holes();
}
translate([base_width/2,-very_back_y,0]) all_the_parts();
translate([base_width/2,very_front_y-very_back_y,0]){
    wheel_pivot_base_mount();
}