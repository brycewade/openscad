$fn=360;

module old_one_connect(){
    rotate([0,0,180]) {
        translate([0,7.6,0]){
            import("files/Holder_Samung_OneConnect_v11.stl", convexity=3);
        }
    }
}

module one_connect_plus(){
    translate([-104,-28.5,0]) {
        cube([208,28.5,85]);
    }
}


module screwhole(){
    rotate([-90,0,0]){
        cylinder(d1=3,d2=6,h=2);
        translate([0,0,2]) cylinder(d=8,h=100);
    }
}

module one_connect_minus(){
    rotate([0,-90,0]){
        hull(){
            translate([18,-14,-105]) cylinder(r=10,h=210);
            translate([56,-14,-105]) cylinder(r=10,h=2010);
        }
    }
    translate([-104,-26.5,71]) {
        cube([208,28,15]);
    }
    translate([-102.5,-26.5,3]){
        cube([205,25,71]);
    }
    hull(){
        translate([-98+12.5,-14,0])cylinder(r=12.5,h=3);
        translate([98-12.5,-14,0])cylinder(r=12.5,h=3);
    }
}

module one_connect(){
    difference(){
        one_connect_plus();
        one_connect_minus();
    }
}

module fire_tv_plus(){
    intersection(){
        union(){
            translate([10,0,0]) cube([43,20,20.5]);
            translate([53,0,0]){
                cylinder(r=20,h=20.5);
            }
            translate([0,10,0]) cube([20,43,20.5]);
            translate([0,53,0]){
                cylinder(r=20,h=20.5);
            }
            translate([10,10,0]) cylinder(r=10,h=20.5);
        }
        cube([73,73,129]);
    }
}

module fire_tv_minus(){
    translate([3,3,1.5]){
        cube([77,77,16]);
    }
    translate([18,18,16]){
        cube([67,67,16]);
    }
    translate([-10,-10,9.5]){
        rotate([90,0,135]){
            hull(){
                translate([-2,0,0]) cylinder(d=16,h=40);
                translate([2,0,0]) cylinder(d=16,h=40);
            }
        }
    }
}

/*
rotate([90,0,45]){
    hull(){
        translate([-2,0,0]) cylinder(d=16,h=40);
        translate([2,0,0]) cylinder(d=16,h=40);
    }
}
*/
module fire_tv(){
    translate([0,-1.5,0]){
        rotate([-90,-135,0]){
            difference(){
                fire_tv_plus();
                fire_tv_minus();
            }
        }
    }
}

module roku_plus(){
    intersection(){
        union(){
            translate([-66,-1.5,0]){
                cube([132,1.5,85]);
            }
            translate([-66,0,0]){
                cube([132,23.5,30]);
            }
            translate([-66,0,0]){
                cube([20,23.5,55]);
            }
            translate([-66,0,55]){
                rotate([-90,0,0]){
                    cylinder(r=20,h=23.5);
                }
            }
            translate([46,0,0]){
                cube([20,23.5,55]);
            }
            translate([66,0,55]){
                rotate([-90,0,0]){
                    cylinder(r=20,h=23.5);
                }
            }
        }
        translate([-66,-1.5,0]){
            cube([132,25,85]);
        }
    }
}

module roku_minus(){
    translate([-63,0,3]){
        cube([126,22,82]);
    }
    /*
    translate([-43,23.5,40]){
        cube([86,3,45]);
    }
    */
    hull(){
        translate([66-20-11,11,0]) cylinder(d=22,h=5);
        translate([66-75+11,11,0]) cylinder(d=22,h=5);
    }
    hull(){
        translate([-66+40-11,11,0]) cylinder(d=22,h=5);
        translate([-66+20+11,11,0]) cylinder(d=22,h=5);
    }
    rotate([0,-90,0]){
        hull(){
            translate([18.5,11,-70]) cylinder(d=22, h=140);
            translate([59.5,11,-70]) cylinder(d=22, h=140);
        }
    }
}

module roku(){
    difference(){
        roku_plus();
        roku_minus();
    }
}

module old_roku(){
    translate([0,-1.5,0]){
        intersection(){
            translate([0,24.5,64.5]){
                rotate([0,0,180]){
                    import("files/RokuWallMount.stl", convexity=3);
                }
            }
            translate([-100,0,0]) cube([200,30,90]);
        }
    }
}

difference(){
    union(){
        translate([68,0,0]) fire_tv();
        translate([-50,0,0]) roku();
        one_connect();
    }
    translate([0,-28.5,18]) screwhole();
    translate([0,-28.5,75]) screwhole();
    translate([-68.3,-28.5,18]) screwhole();
    translate([-68.3,-28.5,75]) screwhole();
    translate([68.3,-28.5,18]) screwhole();
    translate([68.3,-28.5,75]) screwhole();
}