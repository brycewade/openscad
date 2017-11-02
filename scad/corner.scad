$fn=360;

$hypotenus=29.28;
$inside_corner=$hypotenus/sqrt(2);
$inside_radius=$inside_corner/2;
$inside_width=102;
$inside_length=131;
$corner_width=4;
$outside_radius=$inside_radius+$corner_width;
$outside_corner=$inside_corner+$corner_width;
$outside_length=133;
$outside_width=152;

$side_diameter=41;
$front_diameter=46;
$cylinder_length=43.61;
$base_height=4;

module corner(){
    linear_extrude(height=24){
        polygon([[$inside_radius,0],[$inside_corner,0],[0,$inside_corner],[0,$inside_radius]]);
        intersection(){
            translate([$inside_radius,$inside_radius]){
                circle(r=$inside_radius);
            }
            square($inside_radius);
        }
    }
}

translate([$outside_corner-$inside_corner,$outside_corner-$inside_corner,0]){
    corner();
}

translate([$outside_corner+$inside_width+$outside_corner,$outside_corner-$inside_corner,0]){
   rotate([0,0,90]){
       corner();
   }
}

translate([$outside_radius,$outside_radius,-$base_height]){
    linear_extrude(height=$base_height){
        minkowski(){
            square([$inside_width+$outside_corner,$outside_length+$outside_radius-$side_diameter/2]);
            circle($outside_radius);
        }
    }
}

translate([0,$outside_length+$front_diameter/2,0]){
    rotate([0,0,-90]){
        difference(){
            translate([0,0,-$base_height]){
                cube([$front_diameter/2,$side_diameter/2,$side_diameter/2+$base_height]);
            }
            translate([$side_diameter/2,$side_diameter/2,$side_diameter/2]){
                rotate([90,0,45]){
                    translate([0,0,-$cylinder_length/2]){
                        cylinder(d=$side_diameter,h=$cylinder_length);
                    }
                }
            }
        }
    }
}

translate([$outside_width+3.5,$outside_length+$front_diameter/2,0]){
    rotate([0,0,-180]){
!        difference(){
            translate([0,0,-$base_height]){
                cube([$front_diameter/2,$side_diameter/2,$side_diameter/2+$base_height]);
            }
            translate([0,0,($side_diameter+$front_diameter)/4]){
//            translate([0,0,($side_diameter+$front_diameter)/4]){
                rotate([0,atan2($cylinder_length,($front_diameter-$side_diameter)/2),45]){
                    translate([0,0,-$cylinder_length*3/2]){
                        cylinder(r1=($side_diameter-($front_diameter-$side_diameter))/2,r2=($front_diameter+($front_diameter-$side_diameter))/2,h=$cylinder_length*3);
                    }
                }
            }
        }
    }
}
//square([$outside_width,$outside_length]);

