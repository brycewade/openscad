$fn=360;

$logodiameter=370;
$h=12;
$d=90;

module logo($diameter,$height){
    linear_extrude(height=$height) {
        scale($diameter/$logodiameter){
            translate([-$logodiameter/2,-$logodiameter/2,0]) {
                import("../images/swed-n-co.dxf");
            }
        }
    }
}

module o_support($scale){
    translate([0.21*$scale,-0.22*$scale,0]){
        square([1,0.14*$scale]);
    }
}

module and_support($scale){
    translate([-0.07*$scale,-0.045*$scale,0]){
        square([0.07*$scale,1]);
    }
    translate([-0.1*$scale,-0.19*$scale,0]){
        rotate([0,0,45]){
            square([0.14*$scale,1]);
        }
    }
}

module e_support($scale){
    translate([0.075*$scale,0.01*$scale,0]){
        square([1,0.14*$scale]);
    }
}

module d_support($scale){
    translate([0.13*$scale,0.065*$scale,0]){
        square([0.1*$scale,1]);
    }
}

module logo_support($scale){
    for(deg=[45:90:360]){
        rotate([0,0,deg]){
            translate([0.33*$scale,-0.5,0]){
                square([0.06*$scale,1]);
            }
        }
    }
}

module support($diameter,$height){
    translate([0,0,$height*0.75]) {
        linear_extrude(height=$height*0.25){
            o_support($diameter);
            and_support($diameter);
            e_support($diameter);
            d_support($diameter);
            logo_support($diameter);
        }
    }
}

module handle($diameter,$height){
    $handle_d=$diameter/5;
    rotate([0,0,210]){
        translate([$diameter/2+$handle_d*1.15,0,0]){
            hull(){
                cylinder(d=$handle_d,h=$height);
                translate([-$handle_d*1.25,-$handle_d/2,0]){
                    cube([$handle_d,$handle_d,$height]);
                }
            }
        }
    }
}

logo($d*0.75,$h);
support($d,$h);


difference(){
    cylinder(d=$d,h=$h);
    cylinder(d=$d*0.74,h=$h);
}

handle($d,$h);