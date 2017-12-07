x=25.8;
y=x;
lip=4;
width=4;
twist=0;
extra=1;

module clip(x,width,lip){
    translate([-width,-width,0]) square([x+2*width,width]);
    translate([-width,-width,0]) square([width,x+2*width]);
    translate([-width,x,0]) square([lip+width,width]);
    translate([x,-width,0]) square([width,lip+width]);
}

module hook(x,width,leg){
    rotate([twist,-45,0]){
        translate([0,0,0]) cube([leg,width,width]);
        translate([x*sqrt(2)/2,0,0]) cube([width,width,leg]);
    }
}


module mount(x,width,lip){
    leg=x*sqrt(2)/2+width;
    z=leg*sqrt(2);
    linear_extrude(height=z*extra,twist=twist) clip(x,width,lip);
    translate([x+width,-width,0]) rotate([0,0,0]) hook(x,width,leg);
    translate([0,x+width,0]) rotate([0,0,90]) hook(x,width,leg);
}

module oneleg() {
    mount(x,width,lip);
    translate([3*lip,3*lip,0]) mount(x,width,lip);
    translate([6*lip,6*lip,0]) mount(x*0.8,width,lip);
}

/*
for (deg=[0:90:360]){
    rotate([0,0,deg]) {
        translate([2*lip,2*lip,0]) oneleg();
    }
}
*/
//oneleg();

module support(){
    intersection(){
        union(){
            difference(){
                translate([-10,-10,0]) cube([20+6*lip+x,20+6*lip+x,0.25]);
                translate([-width-1, -width-1,0]) cube([x+2*width+2,x+2*width+2,.5]);
                translate([3*lip-width-1,3*lip-width-1,0]) cube([x+2*width+2,x+2*width+2,.5]);
                translate([6*lip-width-1,6*lip-width-1,0]) cube([0.8*x+2*width+2,0.8*x+2*width+2,.5]);
            }
            translate([6*lip+width+lip+1,6*lip+width+lip+1,0]) cube([0.8*x+2*width+2,0.8*x+2*width+2,.25]);
            for(dx=[-10:5:x]){
                translate([-10,dx,0]) rotate([0,0,-45]) cube([0.8,3*x,0.5]);
                translate([dx,-10,0]) rotate([0,0,-45]) cube([0.8,3*x,0.5]);
            }
        }
        translate([-10,-10,0]) cube([20+6*lip+x,20+6*lip+x,0.25]);
    }
}

//support();
oneleg();