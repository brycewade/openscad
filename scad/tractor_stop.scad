$fn=360;

module raceway(){
    rotate([0,-atan2(46,107),0]){
        linear_extrude(height=10){
            polygon([[0,-40],[52,-28],[120,-28],[120,28],[52,28],[0,40]]);
        }
    }
}
module block(){
    difference(){
        rotate([90,0,0]){
            linear_extrude(height=94){
                polygon([[0,0],[0,12],[107,54],[214,12],[214,0]]);
            }
        }
        translate([0,-47,11]){
            rotate([0,90,0]){
                cylinder(d=33,h=214,center=False);
            }
        }
        translate([0,-47,34]){
            rotate([0,90,0]){
                cylinder(d=4.1,h=21,center=False);
            }
        }
    }
}

module screwhole(){
    cylinder(d=4.1,h=48);
    cylinder(d=7,h=3.9);
}
module nuthole(){
    cylinder(d=4.1,h=48);
    cylinder(d=8.2,h=3.1,$fn=6);
}

difference(){
    rotate([-90,0,0]){
        difference(){
            block();
            translate([0,-47,2]){
                raceway();
            }
            translate([214,-47,2]){
                rotate([0,0,180]) {
                    raceway();
                }
            }
            translate([0,-94,0]){
                cube([214,47,54]);
            }
        }
    }
    translate([87,34,0]) {
        screwhole();
    }
    translate([127,34,0]) {
        nuthole();
    }
}
