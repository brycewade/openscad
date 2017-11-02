$fn=360;

$bolt_radius=2.05;
$bolt_head_height=3.85;
$bolt_head_radius=6.9/2;

module support($width,$support_thickness){
    translate([$thickness,0,0]){
        rotate([0,-90,0]){
            linear_extrude(height=$support_thickness) {
                square([$width,$width]);
            }
        }
    }
}

module slat($length,$width,$thickness,$supports){
    $slat_width=sqrt(2)*($width-$thickness/sqrt(2));
    translate([0,($thickness/sqrt(2)),0]){
        rotate([45,0,0]) {
            linear_extrude(height=$thickness) {
                square([$length,$slat_width]);
            }
        }
    }
    if($supports>0){
        $increment=$length/($supports+1);
        for(loc =[$increment:$increment:$length-$thickness]){
            translate([loc-$thickness/2,0,0]) support($width,$thickness);
        }
    }   
}

module corner($corner_height,$corner_dimension){
    difference(){
        union(){
            cube([$corner_dimension,$corner_dimension,0.75*$corner_height]);
            translate([$corner_dimension/2,$corner_dimension/2,0.75*$corner_height]) cylinder(r=$bolt_head_radius, h=$bolt_head_height);
        }
        translate([$corner_dimension/2,$corner_dimension/2,-1]) cylinder(r=$bolt_radius,h=$corner_height+$bolt_head_height+2);
        translate([$corner_dimension/2,$corner_dimension/2,-1]) cylinder(r=$bolt_head_radius+1/4,h=$bolt_head_height+1);
        translate([$corner_dimension/2,$corner_dimension/2,$bolt_head_height]) cylinder(r=$bolt_head_radius-1,h=1);
        translate([$corner_dimension/2,$corner_dimension/2,$bolt_head_height]) cylinder(r=$bolt_head_radius,h=0.5);
    }
}

module tier($internal_length,$internal_depth,$slat_width,$slat_thickness,$slat_supports,$support_dimension){
    echo($bolt_radius);
    translate([0,0,0]){
        corner($slat_width,$support_dimension);
    }
    translate([$support_dimension,0,0]){
       rotate([0,0,0]) {
           slat($internal_length,$slat_width,$slat_thickness,$slat_supports);
       }
    }
    translate([$internal_length+$support_dimension,0,0]){
        corner($slat_width,$support_dimension);
    }
    translate([2*$support_dimension+$internal_length,$support_dimension,0]){
       rotate([0,0,90]) {
           slat($internal_depth,$slat_width,$slat_thickness,$slat_supports);
       }
    }
    translate([0,$internal_depth+$support_dimension,0]){
        corner($slat_width,$support_dimension);
    }
    translate([$support_dimension+$internal_length,2*$support_dimension+$internal_depth,0]){
       rotate([0,0,180]) {
           slat($internal_length,$slat_width,$slat_thickness,$slat_supports);
       }
    }
    translate([$internal_length+$support_dimension,$internal_depth+$support_dimension,0]){
        corner($slat_width,$support_dimension);
    }
    translate([0,($internal_depth+$support_dimension),0]){
       rotate([0,0,270]) {
           slat($internal_depth,$slat_width,$slat_thickness,$slat_supports);
       }
   }
}

translate([0,0,0]) tier(20,10,7,1,0,12);
translate([50,0,0]) tier(20,10,7,1,0,12);
translate([0,40,0]) tier(20,10,7,1,0,12);
translate([50,40,0]) tier(20,10,7,1,0,12);