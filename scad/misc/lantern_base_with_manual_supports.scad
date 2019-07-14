fl=7;
fw=3;

thickness=0.5;
lh=77.2-3*fw;
base=43;
pw=18;
bw=12;

module foot(){
    translate([-fl-fw/2,0,0]){
        cube([2*fl+fw,fw,fw]);
    }
    translate([-fw/2,fw,0]){
        cube([fw,fl,fw]);
    }
}

module roundfoot(){
    intersection(){
        cylinder(d=2*fl+fw,h=fw);
         translate([-fl-fw/2,0,0]){
            cube([2*fl+fw,2*fl+fw,fw]);
        }
    }
}   

module leg(){
    difference(){
        union(){
            roundfoot();
            translate([-fw/2,0,0]){
                cube([fw,fw,lh]);
            }
        }
        translate([-fw/2+thickness,thickness,thickness]){
            cube([fw-2*thickness,fw-2*thickness,lh-2*thickness]);
        }
    }
}

module crossbar(){
    translate([-base+pw-fw/2,-base-fw,lh]){
        cube([fw,2*base+2*fw,fw]);
    }
}

module support(){
    translate([-base+pw,base,0]){
        leg();
    }
    translate([-base+pw,-base,0]){
        rotate([0,0,180]){
            leg();
        }
    }
    crossbar();
}

module build_base(){
    translate([-base+pw-fw/2,-base+3,lh+fw]){
        cube([2*(base-pw)+fw,bw,fw/2]);
        for(x=[0:5:2*(base-pw)+fw]){
            translate([x,0,fw/2]){
                cube([thickness,bw,fw*1.5-thickness/2]);
            }
        }
    }
}

translate([0,10,0]){
    import("lantern_base.stl", convexity=3);
}

for(deg=[0:90:360]){
    rotate([0,0,deg]){
        support();
        build_base();
    }
}

translate([0,0,-fw]){
    crossbar();
    rotate([0,0,180]){
        crossbar();
    }
}

