$fn=360;

$radius=30;

$base=22.3;
$basewidth=12.4;
$basegroovewidth1=6.21;
$basegroovedepth1=1.16;
$basegroovestart=6.16;
$basegroovewidth2=14.5;
$basegroovedepth2=$basewidth-$basegroovestart;

$boltwidth=6;
$boltheadwidth=11;
// $boltheadheight=$basegroovestart-2.21;
$boltheadheight=4.2;

$holderoutsided=40;
$holderinsided=27;
$holerthinthickness=2;

$overlap=2;
$gap=5.5;

$arcwidth=58.51;
$archeight=20.43/2;
$arcradius=($archeight/2)+($arcwidth*$arcwidth/(8*$archeight));

module base() {
    difference(){
        union(){
            translate([-$base/2,-$base/2,0]) {
                cube([$base,$base,$basewidth]);
            }
            translate([0,0,-2]){
                lefthalf();
                righthalf();
            }
        }
/*
        translate([-$basegroovewidth1/2,-$base/2,0]){
            cube([$basegroovewidth1,$base,$basegroovedepth1]);
        }
*/
        translate([0,-$base/2,2-$arcradius]){
            rotate([-90,0,0]){
                cylinder(r=$arcradius,h=$base);
            }
        }
        translate([-$basegroovewidth2/2,-$base/2,$basegroovestart]){
            cube([$basegroovewidth2,$base,$holderinsided/2]);
        }
        cylinder(d=$boltwidth,h=$holderoutsided+$overlap+$gap);
        translate([0,0,$boltheadheight]){
            cylinder(d=$boltheadwidth,h=$basewidth);
        }
        translate([-($holderoutsided+$overlap+$gap)/2,$base/2,-2]) {
            cube([$holderoutsided+$overlap+$gap,2,$holderoutsided+$overlap+$gap+2]);
        }
        translate([-$base/2,-$base/2,-2]) {
            cube([$base,$base,2]);
        }
    }
}

module holder($od,$id) {
    translate([0,$base/2,$od/2]){
        rotate([90,0,0]) {
            difference(){
                cylinder(d=$od,h=$base);
                translate([0,($od-$id)/2-$holerthinthickness,0]) {
                    cylinder(d=$id,h=$base);
                }
            }
        }
    }
}

module lefthalf() {
    difference(){
        holder($holderoutsided,$holderinsided);
        translate([$overlap,-$base/2,0]){
            cube([$holderoutsided,$base,$holderoutsided]);
        }
    }
}

module righthalf() {
    difference(){
        holder($holderoutsided+$holerthinthickness+$gap,$holderinsided+$holerthinthickness+$gap);
        translate([-$overlap-$holderoutsided,-$base/2,0]){
            cube([$holderoutsided,$base,$holderoutsided+$holerthinthickness+$gap]);
        }
    }   
}

base();