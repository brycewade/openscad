$fn=360;

brass_width=12.8;
brass_height=1;
screw_diameter=4;
spacing=11;
holes=2;
height=25;
jig_width=brass_width+8;
jig_length=spacing*holes+10;

difference(){
    translate([-jig_width/2,0,0]){
        cube([jig_width,jig_length,height]);
    }
    translate([-brass_width/2,0,10]){
        cube([brass_width,jig_length,brass_height]);
    }
    for(y=[10+spacing/2:spacing:10+spacing*holes]){
        translate([0,y,5]){
            cylinder(d=screw_diameter, h=height);
        }
    }
}
for(y=[10+spacing/2:spacing:10+spacing*holes]){
    translate([0,y,10+brass_height]){
        cylinder(d=screw_diameter, h=0.2);
    }
}    
