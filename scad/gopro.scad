$fn=360;

$width=20;
$depth=13;
$height=34;

$screwdiameter=4.85;
$screwcenter=$height-5-$screwdiameter/2;

$thickness=5.5;
$mountradius=$screwdiameter/2+$thickness;
//$mountoffset=6;
//$mountoffset=18-$depth+$screwdiameter/2;

$mountheight=16;
$mountwidth=8.8;
$mountcenter=$mountheight-$mountradius;
$mouncutout=$mountwidth-5.6;
$mountoffset=$mouncutout/2+$mountradius;

$arcwidth=$width;
$archeight=$depth-9.6;
$arcradius=($archeight/2)+($arcwidth*$arcwidth/(8*$archeight));
$arccenter=$depth+$arcradius-$archeight;

module plus(){
    translate([-$width/2,0,0]) {
        cube([$width,$depth,$height]);
    }
    rotate([0,0,180]){
        hull(){
            translate([-$mountwidth/2,0,0]){
                cube([$mountwidth,$mountoffset,$mountheight]);
            }
            translate([-$mountwidth/2,$mountoffset,$mountcenter]){
                rotate([0,90,0]){
                    cylinder(r=$mountradius,h=$mountwidth);
                }
            }
        }
         translate([-($mountwidth+$mouncutout)/2,0,0]){
             cube([$mountwidth+$mouncutout,$mouncutout/2,$mountheight]);
         }
    }
}

module minus(){
    translate([0,$arccenter,0]){
        cylinder(r=$arcradius,h=$height);
    }
    translate([0,0,$screwcenter]){
        rotate([-90,0,0]){
            cylinder(d=$screwdiameter,h=$depth);
        }
    }
    rotate([0,0,180]){
        translate([-$mountwidth/2,$mountoffset,$mountcenter]){
            rotate([0,90,0]){
                cylinder(r=$screwdiameter/2,h=$mountwidth);
            }
        }
        hull(){
            translate([0,$mouncutout/2,0]){
                cylinder(d=$mouncutout,h=$mountheight);
            }
            translate([-$mouncutout/2,$mountoffset,0]){
                cube([$mouncutout,$mountradius,$mountheight]);
            }
        }
        translate([-($mountwidth+$mouncutout)/2,$mouncutout/2,0]){
            cylinder(d=$mouncutout,h=$mountheight);
        }
                translate([($mountwidth+$mouncutout)/2,$mouncutout/2,0]){
            cylinder(d=$mouncutout,h=$mountheight);
        }
    }
}

difference(){
    plus();
    minus();
}


