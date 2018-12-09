$fn=360;

hd=7.5;
hl=11.05;
hh=10.43;

rd=9;
buffer=5;

shd=5.35;
shh=3;
sd=2.86;

nd=6.36;
nh=2.33;


mw=rd+4*buffer+2*shd;
ml=sd+2*buffer;
mh=rd+2*buffer;

cutout=2;

wd=15;
wh=20-hh-(mh-rd)/2;

module screw(){
    cylinder(d=sd,h=mh);
    translate([0,0,mh-shh]){
        cylinder(d=shd,h=shh);
    }
    cylinder(d=nd,h=nh,$fn=6);
}
module positive(){
// tab
    translate([-(hl-hd)/2,0,-hh]){
        hull(){
            cylinder(d=hd,h=hh);
            translate([hl-hd,0,0]){
                cylinder(d=hd,h=hh);
            }
        }
    }
// mounting block
    translate([-mw/2,-ml/2,0]){
        cube([mw,ml,mh]);
    }
// washer
    translate([0,ml+wd/2,(mh-cutout)/2-wh]){
        cylinder(d=wd,h=wh);
    }
}

module negative(){
// rod hole
    translate([0,-ml/2,mh/2]){
        rotate([-90,0,0]){
            cylinder(d=rd, h=ml);
        }
    }
// spacer cutout
    translate([-mw/2,-ml/2,mh/2-cutout/2]){
        cube([mw,ml,cutout]);
    }
// screw holes
    translate([-mw/2+buffer+shd/2,0,0]){
        screw();
    }
    translate([mw/2-buffer-shd/2,0,0]){
        screw();
    }
// mounting nut
    translate([0,0,(mh-rd)/2-nh]){
        cylinder(d=nd,h=2*nh,$fn=6);
    }
//mounting screw
    translate([0,0,-hh]){
        cylinder(d=sd,h=hh+mh/2);
    }
// washer screw
    translate([0,ml+wd/2 ,(mh-cutout)/2-wh]){
        cylinder(d=sd,h=wh);
    }
}

module shape(){
    difference(){
        positive();
        negative();
    }
}
/*
intersection(){
    shape();
    translate([-50,-50,mh/2]){
        cube([100,100,20+mh]);
    }
}
*/
intersection(){
    shape();
    translate([-50,-50,-20]){
        cube([100,100,20+mh/2]);
    }
}
