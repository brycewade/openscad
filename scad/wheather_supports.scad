$fn=360;
$cmperinch=2.54;

$marginforerror=3;
$theta=30;

$wireholesize=5.75;

$thickness=2.4;
$insideD1=125;
$outsideD1=$insideD1+$thickness*2;
$insideD2=10;
$outsideD2=$insideD2+$thickness*2;
$coneheight=($insideD1-$insideD2)/2;
$nozzleheight=15;
$insidelip=$outsideD1+4;

$mountscrewradius=1.5;
$mountscrewheadradius=2.7;
$mountscrewheadheight=3;
$nutwidth=5.4;
$nutheight=2.25;

$level_diameter=12.78;
$level_height=7;

$max_diameter=max($outsideD1,$outsideD2);

$pole_x=1*$cmperinch*10;
$pole_y=$pole_x;

$support_x=$pole_x+2*(2*$thickness+$wireholesize);
$support_y=$pole_y+2*(2*$thickness+$wireholesize);
$support_z=40;

$arm_height=$wireholesize+2*$thickness;
$diameter=max($mountscrewheadradius+$thickness,$arm_height);

$battery_width=65;
$battery_length=151;
$battery_height=99;

$sqrt2=sqrt(2);

module pole_cube(){
    cube([$support_x,$support_y,$support_z],center=true);
}

module pole_mount(){
    difference(){
        pole_cube();
        pole_holes();
    }
}

module pole_holes(){
// hole for the pole
    cube([$pole_x,$pole_y,$support_z],center=true);
}

module bucket_support_mount_arms(){
    difference(){
        hull(){
            cylinder(d=$diameter*1.75,h=$wireholesize+2*$thickness);
            translate([(($outsideD1/4)+($outsideD1/2-($thickness+$mountscrewradius)))/2,0,0]) {
                cylinder(d=$diameter,h=$arm_height);
            }
        }
        translate([(($outsideD1/4)+($outsideD1/2-($thickness+$mountscrewradius)))/2,0,0]) {
            cylinder(r=$mountscrewradius,h=$arm_height);
            cylinder(r=$mountscrewheadradius,h=$mountscrewheadheight);
        }
    }
}

module  bucket_support_arm(){
    difference(){
        hull(){
            pole_cube();
            translate([$support_x+$max_diameter/2+10,0,$support_z/2-$arm_height]){
                cylinder(d=$diameter*1.75,h=$wireholesize+2*$thickness);
            }
        }
        // hole for the level
        translate([($support_x+$level_diameter)/2+5,0,$support_z/2-$level_height/2]){
            cylinder(d=$level_diameter,h=$level_height);
        }
    }
}

module battery_box(){
    translate([0,0,-($battery_height+2*$thickness+$marginforerror)/2]){
        difference(){
            cube([$battery_length+2*$thickness+$marginforerror,$battery_width+2*$thickness+$marginforerror,$battery_height+2*$thickness+$marginforerror],center=true);
            translate([0,0,-$thickness]){
                cube([$battery_length+$marginforerror,$battery_width+$marginforerror,$battery_height+$marginforerror],center=true);
            }
        }
    }
}
module bucket_support(){
    bucket_support_arm();
    translate([$support_x+$max_diameter/2+10,0,$support_z/2-$arm_height]){
        for(deg=[45:90:360]){
            rotate([0,0,deg]){
                bucket_support_mount_arms();
            }
        }
    }
}

module battery_support(){
    translate([0,($support_y+$battery_width)/2+$thickness,$support_z/2]){
        battery_box();
    }
}

difference(){
    union(){
        bucket_support();
//        battery_support();
    }
    pole_holes();
}