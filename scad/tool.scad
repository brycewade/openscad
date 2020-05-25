$fn=360;
x=2;
r=1/sqrt(3)*x;

w=10;
l=90;
h=20;

bigr=(2*h*h+l*l/2)/h;
smallr=(l-w)/4;
difference(){
    translate([-w/2,-l/2,0]){
        cube([w,l,h]);
    }
    translate([-w/2,0,3*h/4+bigr]){
        rotate([0,90,0]){
            cylinder(r=bigr,h=w);
        }
    }
    translate([-w/2,-w/2-smallr,h/2-smallr]){
        rotate([0,90,0]){
            cylinder(r=smallr,h=w);
        }
    }
    translate([-w/2,w/2+smallr,h/2-smallr]){
        rotate([0,90,0]){
            cylinder(r=smallr,h=w);
        }
    }
}

translate([0,0,-60]){
    difference(){
        intersection(){
            translate([-w/2,-w/2,0]) cube([w,w,60]);
            cylinder(d1=w, d2=sqrt(2)*w, h=60);
        }
        cylinder(r=r,h=12, $fn=6);
    }
}


