 $fn=360;

$height=1540;
$width=1460;
$size=75;
$diameter=90;

module handle($d,$height){
    $handle_d=$d/5;
    rotate([0,0,210]){
        translate([$d/2+$handle_d*1.15,0,0]){
            hull(){
                cylinder(d=$handle_d,h=$height);
                translate([-$handle_d*1.25,-$handle_d/2,0]){
                    cube([$handle_d,$handle_d,$height]);
                }
            }
        }
    }
}

module handle_stick($d,$height){
   $handle_d=$d/5;
    rotate([0,0,210]){
        translate([$d/2+$handle_d*1.2,0,$height-0.25]){ 
            difference(){
                cylinder(d=3*$handle_d,h=0.25);
                cylinder(d=1.1*$handle_d,,h=0.25);
                translate([-1.5*$handle_d,-1.5*$handle_d,0]){
                    cube([1.5*$handle_d,3*$handle_d,0.25]);
                }
            }
            for(deg=[180:22.5:360]){
                rotate([0,0,deg]){
                    translate([-0.4,0,0]){
                        cube([0.8,$handle_d,0.25]);
                    }
                }
            }
        }
    }
}

difference(){
    cylinder(d=$diameter,h=10);
    translate([0,0,-1]) {
        linear_extrude(height=12) {
                intersection(){
                translate([-50,-12,0]) square([100,24]);
                scale([$size/$height,$size/$height]) {
                    translate([-$width/2,-$height/2+122,0]){
                        mirror([0,1,0,]) {
                            import("../images/Logo-1 copy.dxf");
                        }
                    }
                }
            }
        }
    }
}
translate([-40,-2,8]) cube([40,1,2]);

handle($diameter,10);
handle_stick($diameter,10);