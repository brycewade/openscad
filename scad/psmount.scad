$fn=360;

thickness=3;
psw=113.75;
psh=49.75;

sr=2;
hc=11;

cl=2*(sr+thickness);
mhd=130;
mw=mhd+4*sr+2*thickness;

module barb(){
    rotate([-90,-90,0]){
        linear_extrude(height=cl){
            polygon(points=[[0,0],[0,3*thickness],[3*thickness,thickness],[3*thickness,0]],paths=[[0,1,2,3]]);
        }
    }
}

module arm(){
    difference(){
        cube([thickness,cl,psh+2*thickness]);
        translate([0,cl/2,hc+thickness]){
            rotate([0,90,0]){
                cylinder(r=sr,h=thickness);
            }
        }
    }
    translate([0,0,psh+thickness]){
        barb();
    }
}

difference(){
    translate([-mw/2,0,0]){
        cube([mw,cl,thickness]);
    }
    translate([-mhd/2,cl/2,0]){
        cylinder(r=sr,h=thickness);
    }
    translate([mhd/2,cl/2,0]){
        cylinder(r=sr,h=thickness);
    }
}
translate([-psw/2-thickness,0,0]){
    rotate([0,0,0]){
        arm();
    }
}
translate([psw/2+thickness,cl,0]){
    rotate([0,0,180]){
        arm();
    }
}