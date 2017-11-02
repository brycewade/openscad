include <bolts/BOLTS.scad>

$fn=360;

module connector(){

    
    translate([-$basewidth/2,-$baselength/2,-$baseheight]) {
        cube([$basewidth,$baselength,$baseheight]);
    }
        
    linear_extrude(height=$taperheight,scale=[$taperwidth/$basewidth,$taperlength/$baselength]){
        translate([-$basewidth/2,-$baselength/2,0]) {
            square([$basewidth,$baselength]);
        }
    }
    
    cylinder(d=10,h=$taperheight+$cylinderheight);
    translate([-$connectorwidth/2,-$baselength/2,-$baseheight-$connectorheight]){
        cube([$connectorwidth,$connectorlength,$connectorheight]);
    }
}

$width=18;
$length=18;
$height=45;
$basewidth=13.5;
$baselength=11.5;
$baseheight=10;
$taperwidth=11.25;
$taperlength=11.25;
$taperheight=11.25;
$cylinderheight=7.75;
$connectorwidth=10.1;
$connectorlength=10.1;
$connectorheight=4.25;

module bolt_n_nut(){
    rotate([0,-90,0]){
        union(){
            translate([0,0,2]) ISO4762("M2",$length+2);
            translate([0,0,-1]) cylinder(d=3.5,h=3);
            translate([0,0,$length-1.2]) ISO4035("M2");
        }
    }
}

module case(){
    translate([0,0,-($cylinderheight+$taperheight-$height)]){
        difference(){
            translate([-$width/2,-$length/2,$cylinderheight+$taperheight-$height]) {
                cube([$width,$length,$height]);
            }
            translate([0,0,$cylinderheight+$taperheight-$height]) {
                cylinder(d=5,h=$height);
            }
            connector();
            union(){
                translate([$width/2,$length/4,$cylinderheight+$taperheight-$height*.9]) bolt_n_nut();
                
                translate([$width/2,-$length/4,$cylinderheight+$taperheight-$height*.9]) bolt_n_nut();
                translate([$width/2,-$length/2+2.5,$cylinderheight+$taperheight-$height*.1]) bolt_n_nut();
                translate([$width/2,$length/2-2.5,$cylinderheight+$taperheight-$height*.1]) bolt_n_nut();
            }
        }
    }
}

difference(){
    case();
    translate([0,-$length/2-1,-1]) cube([$width+1,$length+2,$height+2]);
}

translate([0,$length*2,0]) {
    difference(){
        rotate([0,0,180]) case();
        translate([0,-$length/2-1,-1]) cube([$width+1,$length+2,$height+2]);
    }
}