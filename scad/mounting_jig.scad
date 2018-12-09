$fn=360;

bl=44;
bw=22;
bh=15;

/*
pl=70;
pw=32;
ph=17.4;
*/

pl=0;
pw=0;
ph=0;

el=bl+pl+6;
ew=38.1;
eh=19.05;

sr=2;
shr=4;
shh=2;
smr=shr+1;
smh=5;

sml=5*shr+3;
wt=1.75;

module positive(){
    // Drill hole surround
    hull(){
        translate([0,ew/4,0]){
            cylinder(r=shr,h=eh);
        }
        translate([-ew/2,-ew/2,0]){
            cube([ew,ew,smh]);
        }
    }
    // gauge tab
    translate([ew/2,ew/4,0]){
        hull(){
            translate([0,-shr-1,0]){
                cube([shr+1,2*shr+2,smh]);
            }
            translate([shr+1,0,0]){
                cylinder(r=shr+1,h=smh);
            }
        }
    }
    // bottom guides
    translate([-ew/2,-ew/2-smh,-smh]){
        cube([2*smh,smh,2*smh]);
    }
        translate([ew/2-2*smh,-ew/2-smh,-smh]){
        cube([2*smh,smh,2*smh]);
    }
}

module negative(){
    // Drill hole
    translate([0,ew/4,0]){
        cylinder(r=sr/2,h=el);
    }
    // guide divot
    translate([0,-ew/2,0]){
        cylinder(r=1,h=2*smh);
    }
    // guage tab screwhole
    translate([ew/2+shr+1,ew/4,0]){
        hull(){
            cylinder(r=sr,h=smh);
            translate([2*shr,-sr,0]){
                cube([2*sr,2*sr,smh]);
            }
        }
    }
}

difference(){
    positive();
    negative();
}