scale([45/70,45/70,45/70]){
    import("../../stl/Cow_t.stl", convexity=3);
}
$fn=360;
d=7.5;
translate([-1.5,0,3.5]){
    rotate([0,90,0]){
        difference(){
            cylinder(d=d,h=3);
            cylinder(d=d-3, h=3);
        }
    }
}