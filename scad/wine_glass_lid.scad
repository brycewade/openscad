$fn=360;

$wall_thickness=2;
$internal_rim_diameter=64.20;
$external_rim_diameter=70.44;
$internal_diameter=$internal_rim_diameter-$wall_thickness;
$external_diameter=$external_rim_diameter+$wall_thickness;
$rim_height=7.5;
$lid_top=$wall_thickness;
$straw_diameter=6.07;


module rim(){
    translate([0,0,-5]){
        linear_extrude($rim_height+5){
            difference(){
                circle(d=$external_rim_diameter);
                circle(d=$internal_rim_diameter);
            }
        }
    }
}

module cap(){
    translate([0,0,$rim_height]){
        linear_extrude($lid_top){
                circle(d=$external_diameter);
        }
    }
}

module straw_hole(){
    translate([(-$internal_diameter*2/6),0,0]){
        linear_extrude($lid_top+$rim_height+5){
                circle(d=$straw_diameter);
        }
    }
}

module rim_lips(){
    linear_extrude($rim_height){
        difference(){
            circle(d=$external_diameter);
            circle(d=$internal_diameter);
        }
    }
}

difference(){
    union(){
        rim_lips();
        cap();
    }
    rim();
    straw_hole();
}