$fn=360;

// Start of Bikerack dimensions
tubed=8.40;
tuber=tubed/2;
tubedip=9.76;

innerwidth=116.26;
innerlength=56.10;
shortwidth=91.80;

mountod=12.65;
mountor=mountod/2;
mounth=18.75;
mountid=4.2;
mountir=mountid/2;

centerwidth=innerwidth+tubed;
centerlength=innerlength+tubed;

arcradius=(tubedip/2)+(centerwidth*centerwidth/(8*tubedip));
arccenter=arcradius-tubedip-2*tubed;
arcangle=atan(centerwidth/arccenter);

cornerr=(innerwidth-shortwidth)/2;
endinnerlength=57.08;
raillength=2*centerlength+tuber+endinnerlength-cornerr;
// End of Bikerack dimensions

// Start of speaker dimensions
speakerwidth=151.6;
speakerlength=162.6;
frontspeakerheight=17.66;
backspeakerheight=47.00;
grillheight=39.13;
grillwidth=120.43;
grillgap=3.33;
outergrilllip=4.46;
curveor=16.39;
sidecircled=41.53;
sidecircler=sidecircled/2;
sidecurcleloc=133.26;
//outerwidth=4.45-1.25/2;
outerwidth=4.5;
notch=25.25-outerwidth;
notchr=notch-12.96;
notchgap=3.00;
powerwidth=88.00;
fudge=0.01;
// End of speaker dimensions

mountthickness=5;
frontr=speakerlength-sidecurcleloc;
rise=backspeakerheight-frontspeakerheight;
run=speakerlength;
topangle=atan(rise/run);
frontangle=atan(grillgap/backspeakerheight);

// Start of screw dimensions
sd=3;
shd=6;
shh=2;
schd=5;
schh=3;
// End of screw dimensions

module tube(length){
    rotate([0,90,0]){
        cylinder(d=tubed, h=length);
    }
}

module arc_tube(radius, angle){
    rotate_extrude(angle=angle, convexity = 2){
        translate([radius,0,0]){
            circle(d=tubed);
        }
    }
}

module center_arc_tube(radius, angle){
    translate([-radius,0,0]){
        rotate([0,0,-angle/2]){
            arc_tube(radius, angle);
        }
    }
}

module crossbar(){
    translate([0,0,-tubedip]){
        rotate([0,90,-90]){
            center_arc_tube(arcradius, arcangle);
        }
    }
}

module bikerack() {
    translate([-centerwidth/2,0,0]){
       rotate([0,0,90]) tube(raillength);
    }
    translate([centerwidth/2,0,0]){
       rotate([0,0,90]) tube(raillength);
    }
    
    translate([0,tuber,0]) crossbar();
    translate([0,centerlength+tuber,0]) crossbar();
    translate([0,2*centerlength+tuber,0]) crossbar();
    translate([shortwidth/2,raillength,0]){
        arc_tube(cornerr+tuber,90);
    }
    translate([-shortwidth/2,raillength,0]){
        rotate([0,0,90]) arc_tube(cornerr+tuber,90);
    }
    translate([-shortwidth/2,2*centerlength+endinnerlength+tubed,0]){
        rotate([0,0,00]){
            tube(shortwidth);
        }
    }
    translate([-shortwidth/2,2*centerlength+endinnerlength+3*tuber+mountor,-mounth+tuber]){
        difference(){
            cylinder(r=mountor,mounth);
            cylinder(r=mountir,mounth);
        }
    }
    translate([+shortwidth/2,2*centerlength+endinnerlength+3*tuber+mountor,-mounth+tuber]){
        difference(){
            cylinder(r=mountor,mounth);
            cylinder(r=mountir,mounth);
        }
    }
}

module speaker_plus(){
    hull(){
        translate([-speakerwidth/2+curveor,curveor,0]) {
            cylinder(r=curveor, h=frontspeakerheight);
        }
        translate([speakerwidth/2-curveor,curveor,0]) {
            cylinder(r=curveor, h=frontspeakerheight);
        }
        translate([-speakerwidth/2,sidecurcleloc,sidecircler]){
            rotate([0,90,0]){
                cylinder(r=sidecircler,h=speakerwidth);
            }
        }
        translate([-(grillwidth-grillheight)/2,speakerlength-fudge,backspeakerheight/2]){
            rotate([90+frontangle,0,0]){
                cylinder(d=backspeakerheight,h=fudge);
            }
        }
        translate([(grillwidth-grillheight)/2,speakerlength-fudge,backspeakerheight/2]){
            rotate([90+frontangle,0,0]){
                cylinder(d=backspeakerheight,h=fudge);
            }
        }
    }
}


module notch_cap_top(height){
    translate([0,0,frontspeakerheight]){
        rotate([topangle,0,0]){
            translate([-5*mountthickness,-5*mountthickness,0]){
                cube([notch+outerwidth+10*mountthickness,notch+outerwidth+10*mountthickness,height]);
            }
        }
    }
}

module notch_cap(){
    intersection(){
        hull(){
            intersection(){
                translate([notchr+outerwidth,notchr+outerwidth,0]){
                    cylinder(r=notchr+outerwidth, h=frontspeakerheight*2);
                }
                cube([notchr+outerwidth,notchr+outerwidth,frontspeakerheight*2]);
            }
            translate([fudge,notch+2*outerwidth-fudge,0]){
                cylinder(r=fudge, h=frontspeakerheight*2);
            }
            translate([notch+2*outerwidth-fudge,fudge,0]){
                cylinder(r=fudge, h=frontspeakerheight*2);
            }
        }
        translate([0,0,-notchgap]){
            notch_cap_top(notchgap);
        }
    }
}

module notch(){
    difference(){
        union(){
            translate([outerwidth,outerwidth,0]){
                hull(){
                    intersection(){
                        translate([notchr,notchr,0]){
                            cylinder(r=notchr, h=frontspeakerheight*2);
                        }
                        cube([notchr,notchr,frontspeakerheight*2]);
                    }
                    translate([fudge,notch-fudge,0]){
                        cylinder(r=fudge, h=frontspeakerheight*2);
                    }
                    translate([notch-fudge,fudge,0]){
                        cylinder(r=fudge, h=frontspeakerheight*2);
                    }
                }
            }
            notch_cap();
        }
        translate([notchr+outerwidth,notchr+outerwidth,0]){
            cylinder(d=sd, h=frontspeakerheight*2);
            translate([0,0,frontspeakerheight-notchgap-schh]){
                cylinder(d=schd, h=frontspeakerheight*2);
            }
        }
        translate([0,0,0]){
            notch_cap_top(frontspeakerheight);
        }
    }
}

module speaker_minus(){
    translate([-speakerwidth/2+outerwidth,outerwidth,0]) {
        notch();
    }
    translate([speakerwidth/2-outerwidth,outerwidth,0]) {
        rotate([0,0,90]){
            notch();
        }
    }
}
module speaker(){
    difference(){
        speaker_plus();
        speaker_minus();
    }
}

module mount(){
    hull(){
        translate([-speakerwidth/2+curveor,curveor+mountthickness,0]) {
            cylinder(r=curveor+mountthickness, h=frontspeakerheight+mountthickness);
        }
        translate([speakerwidth/2-curveor,curveor+mountthickness,0]) {
            cylinder(r=curveor+mountthickness, h=frontspeakerheight+mountthickness);
        }
        translate([-speakerwidth/2+frontr,sidecurcleloc+mountthickness,0]) {
            cylinder(r=frontr+2*mountthickness, h=backspeakerheight+mountthickness);
        }
        translate([speakerwidth/2-frontr,sidecurcleloc+mountthickness,0]) {
            cylinder(r=frontr+2*mountthickness, h=backspeakerheight+mountthickness);
        }
    }
}

module top(){
    translate([-speakerwidth/2,mountthickness,frontspeakerheight+mountthickness]){
        rotate([topangle,0,0]){
            translate([-5*mountthickness,-5*mountthickness,0]){
                    cube([speakerwidth+10*mountthickness,speakerlength+10*mountthickness,10*mountthickness]);
            }
        }
    }
}

module speaker_cutout(){
    hull(){
        translate([(grillwidth-grillheight)/2,speakerlength,mountthickness+outergrilllip+grillheight/2]){
            rotate([-90,0,0]){
                cylinder(d=grillheight,h=4*mountthickness);
            }
        }
        translate([-(grillwidth-grillheight)/2,speakerlength,mountthickness+outergrilllip+grillheight/2]){
            rotate([-90,0,0]){
                cylinder(d=grillheight,h=4*mountthickness);
            }
        }
    }
}
module rotated_speaker(){
    translate([0,speakerlength+mountthickness,backspeakerheight+mountthickness]){
        for(angle=[0:0.5:topangle]){
            rotate_extrude(angle=-angle, convexity = 2){
                translate([0,-speakerlength,-backspeakerheight]){
                    projection(cut = false) speaker();
                }
            }
        }
    }
}

module screwholes(){
    translate([0,speakerlength/2+mountthickness]){
        for(rot=[45:90:315]){
            rotate([0,0,rot]){
                translate([speakerwidth/3,0,0]){
                    cylinder(d=sd, h=mountthickness);
                    translate([0,0,mountthickness-shh]){
                        cylinder(d1=sd, d2=shd, h=shh);
                    }
                }
            }
        }
    }
}

module powercutout(){
    translate([-powerwidth/2,0,mountthickness]){
        cube([powerwidth,mountthickness,frontspeakerheight]);
    }
}

module whole_mount(){
    difference(){
        mount();
        top();
        speaker_cutout();
        rotated_speaker();
        screwholes();
        powercutout();
    }
}

/*
whole_mount();
translate([-speakerwidth/2, mountthickness, mountthickness,]) {
    notch();
}
translate([speakerwidth/2, mountthickness, mountthickness,]) {
    mirror([1,0,0]){
        notch();
    }
}
*/
rotated_speaker();