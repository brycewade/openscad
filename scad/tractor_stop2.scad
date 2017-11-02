$fn=360;

$spike_height=40;
$slope=46/107;
$r=15;
$x=$slope*$r*sqrt(1/($slope*$slope+1));
$y=$slope*$x;
$v=$x/$slope;

module peak(){
    linear_extrude(height=56){
        difference(){
            polygon([[-$x-1,-$y],[-$x,-$y],[$x,-$y],[$x+1,-$y],[0,1]]);
            translate([0,-$y-$v,0]){
                circle($r);
            }
        }
    }
}

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
        translate([81,-47,34]){
            rotate([0,90,0]){
                cylinder(d=4.1,h=51,center=False);
            }
        }
    }
}

module screwhole(){
    cylinder(d=4.1,h=48);
    cylinder(d=7,h=3.9);
}
module nuthole(){
    cylinder(d=4.1,h=53);
    cylinder(d=8.2,h=3.1,$fn=6);
}

difference(){
    union(){
        translate([107,34,47]){
            rotate([0,90,0]){
                cylinder(d=4.1,h=25,center=False);
            }
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
            translate([107,48,19]) peak();
        }
        translate([107/3,0,16]){
            rotate([90,0,0]){
                spike();
            }
        }
        translate([214-107/3,0,16]){
            rotate([90,0,0]){
                spike();
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
supports();

module supports(){
    translate([107/3,-$spike_height,0]){
        union(){
            translate([-0.5,0,0])cube([1,$spike_height-1,13]);
            translate([-5,0,0]) cube([10,$spike_height-1,1]);
            translate([0.125,0,13.25]){
                rotate([0,-90,0]) {
                    linear_extrude(height=0.25) {
                        polygon([[-1,0],[-1,$spike_height],[0,$spike_height],[3,0]]);
                    }
                }
            }
        }
    }
    translate([214-107/3,-$spike_height,0]){
        union(){
            translate([-0.5,0,0])cube([1,$spike_height-1,13]);
            translate([-5,0,0]) cube([10,$spike_height-1,1]);
            translate([0.125,0,13.25]){
                rotate([0,-90,0]) {
                    linear_extrude(height=0.25) {
                        polygon([[-1,0],[-1,$spike_height],[0,$spike_height],[3,0]]);
                    }
                }
            }
        }
    }
    translate([87,34,0]) {
        union(){
            difference(){
                cylinder(d=5,h=3.65,$fn=6);
                cylinder(d=4.75,h=3.65,$fn=6);  
            }
            difference(){
                cylinder(d=3,h=3.65,$fn=6);
                cylinder(d=2.75,h=3.65,$fn=6);  
            }
            difference(){
                cylinder(d=1,h=3.65,$fn=6);
                cylinder(d=0.75,h=3.65,$fn=6);  
            }
        }
    }
    translate([127,34,0]) {
        union(){
            difference(){
                cylinder(d=6.25,h=2.85,$fn=6);
                cylinder(d=6,h=2.85,$fn=6);  
            }
            difference(){
                cylinder(d=4.25,h=2.85,$fn=6);
                cylinder(d=4,h=2.85,$fn=6);  
            }
            difference(){
                cylinder(d=2.25,h=2.85,$fn=6);
                cylinder(d=2,h=2.85,$fn=6);  
            }
        }
    }
}

module spike(){
    difference(){
        cylinder(r1=3,r2=0,h=$spike_height);
//        translate([1,1,0]) cube([2,2,$spike_height]);
        translate([1,-3,0]) cube([2,6,$spike_height]);
//        translate([-3,1,0]) cube([2,2,$spike_height]);
        translate([-3,-3,0]) cube([2,6,$spike_height]);
    }
}