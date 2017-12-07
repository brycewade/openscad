$fn=360;

innerD=40;
midD=60;
outerD=80;
thickness=2;
boltD=3;


difference(){
    union(){
        difference(){
            linear_extrude(height=(outerD-midD)/2,scale=[1.5,1.5]) circle(d=midD);
            translate([0,0,thickness]) {
                linear_extrude(height=(outerD-midD)/2,scale=[1.5,1.5]) circle(d=midD);
            }
            cylinder(d=innerD,h=thickness);
        }
        for(deg=[0:120:360]){
            rotate([0,0,deg]) {
                translate([(innerD+midD)/4,0,0]) {
                    cylinder(d=2*thickness+boltD,h=(outerD-midD)/3);
                }
            }
        }
    }
    for(deg=[0:120:360]){
        rotate([0,0,deg]) {
            translate([(innerD+midD)/4,0,0]) {
                cylinder(d=boltD,h=(outerD-midD)/3);
            }
        }
    }
}