$fn=360;

dowel_diameter=9.8;
holder_diameter=3*dowel_diameter;
height=10;

difference(){
    cylinder(d=holder_diameter, h=height);
    hull(){
        cylinder(d=dowel_diameter, h=height);
        translate([holder_diameter,0,0]){
            cylinder(d=dowel_diameter, h=height);
        }
    }
}