$fn=360;

bh=18;
th=75;
is=th-bh;

ts=7.5*25.4;

nd=6.15;
sd=3;

ls=(ts-is)/2;
thickness=3;

width=nd+2*thickness;
height=8-2;
depth=2.2;
bar=18;
lip=30;

module positive(){
    cylinder(d=width,h=height);
    translate([0,-width/2]){
        cube([ls+is+2*thickness,width,height]);
    }
    translate([ls+is,-width/2,0]){
        cube([2*thickness,width,bar+2*height]);
    }
    translate([ls+is-lip+width/2,-width/2,bar+height]){
        cube([lip-width/2,width,height]);
    }
    translate([ls+is-lip+width/2,0,bar+height]){
        cylinder(d=width,h=height);
    }
}

module screwhole(){
    translate([0,0,height-depth]){
        rotate([0,0,30]) cylinder(d=nd, h=depth, $fn=6);
    }
    cylinder(d=sd, h=height);
}

difference(){
    positive();
    screwhole();
    translate([is,0,0]) screwhole();
}