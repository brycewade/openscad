$fn=360;

bl=44;
bw=22;
bh=15;

pl=70;
pw=32;
ph=17.4;

el=bl+pl+6;
ew=38.1;
eh=19.05;

sr=2;
shr=4;
smr=shr+1;
smh=5;

wt=1.75;

module screwmount(){
    translate([0,-smr,0]){
        difference(){
            union(){
                cylinder(r=smr,h=smh);
                translate([-smr*2,0,0]){
                    cube([4*smr,smr,smh]);
                }
            }
            translate([-smr*2,0,0]){
                cylinder(r=smr,h=smh);
            }
            translate([smr*2,0,0]){
                cylinder(r=smr,h=smh);
            }
            cylinder(r=sr,h=smh);
        }
    }
}

difference(){
    union(){
        difference(){
            translate([-el/2,-ew/2,0]){
                cube([el,ew,eh]);
            }
            translate([el/2-3-bl,-bw/2,0]){
                cube([bl,bw,bh]);
            }
            translate([-el/2+3,-pw/2,0]){
                cube([pl,pw,ph]);
            }
        }
        translate([-el/2,0,0]){
            rotate([0,0,-90]){
                screwmount();
            }
        }
        translate([el/2,0,0]){
            rotate([0,0,90]){
                screwmount();
            }
        }
    }
    translate([-el/2-smr,pw/2-wt,0]){
        cube([2*smr,wt,2*wt]);
    }
    translate([-el/2-smr,-pw/2,0]){
        cube([2*smr,wt,3*wt]);
    }
}