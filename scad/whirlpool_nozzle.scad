$fn=360;
$outerdiameter=47.2;
$innerdiameter=40.3;
$whiteouterheight=12.2;
$whiteinnerheight=9.6;
$whitejetdiameter=7.85;
$whitejetheight=29.1;
$whitejetdepth=4.4;
$whitenozzleouterdiameter=18.55;
$whitenozzleinnerdiameter=13.5;
$whitenozzleheight=37.1;
$whitenozzletoplid=1.5;
$whitenozzletopheight=14.7-$whitenozzletoplid;
$cutoutwidth=12.5;
$cutoutfromcenter=25.5/2;
$cutoutdepth=$outerdiameter/2-$cutoutfromcenter;
$topcutoffheight=7.75;
$innercylinderdiameter=($whitenozzleinnerdiameter-$whitejetdiameter)/2;
$innercylinderheight=($whitenozzleheight-$whitenozzletopheight)-($whiteinnerheight+$whitejetdepth);
$m2radius=1;
$m2height=7+$m2radius;
$flangeheight=$m2height+$m2radius+2;

module cutout(){
    translate([-$cutoutwidth/2,$cutoutfromcenter,0]) {
        cube([$cutoutwidth,$cutoutdepth,$whiteouterheight+1]);
    }
}

module white(){
    union(){
        cylinder(d=$outerdiameter, h=$whiteouterheight);
        cylinder(d=$whitenozzleouterdiameter,h=$whitenozzleheight);
        translate([0,0,$whiteouterheight]) {
            cylinder(r=$cutoutfromcenter,h=$flangeheight);
        }
    }
}

module innercylinder(){
    cylinder(d=$innercylinderdiameter, h=$innercylinderheight);
    translate([-$innercylinderdiameter/2,0,0]) cube([$innercylinderdiameter,$innercylinderdiameter/2,$innercylinderheight]);
}

module groove(){
    intersection(){
        cube([$outerdiameter,$outerdiameter,$outerdiameter]);
        difference(){
            cylinder(r=$cutoutfromcenter+1,h=2*$m2radius);
            cylinder(r=$whitejetdiameter,h=2*$m2radius);
        }
    }
    translate([$whitejetdiameter,0,$m2radius]) {
        rotate([0,90,0]) cylinder(r=$m2radius,h=($cutoutfromcenter-$whitejetdiameter+1));
    }
     translate([0,$whitejetdiameter,$m2radius]) {
        rotate([-90,0,0]) cylinder(r=$m2radius,h=($cutoutfromcenter-$whitejetdiameter+1));
    }
}
module white_cutout(){
    union(){
        translate([0,0,$whiteouterheight+$m2height]) {
            rotate([0,0,90]) groove();
        }translate([0,0,$whiteouterheight+$m2height]) {
            rotate([0,0,180]) groove();
        }
        translate([0,0,$whiteouterheight+$m2height-0.1]) {
            rotate([0,0,90]) groove();
        }
        cylinder(d=$innerdiameter, h=$whiteinnerheight);
        cylinder(d=$whitejetdiameter, h=$whitejetheight);
        translate([0,0,$whitenozzleheight-$whitenozzletopheight]) {
            cylinder(d=$whitenozzleinnerdiameter,h=$whitenozzletopheight-$whitenozzletoplid);
        }
        for(deg=[0:90:360]){
            rotate([0,0,deg]) cutout();
        }
        translate([-$whitenozzleouterdiameter/2-1,0,$whitenozzleheight-$topcutoffheight]) cube([$whitenozzleouterdiameter+2,$whitenozzleouterdiameter/2+1,$topcutoffheight+1]);
        translate([0,0,$whiteinnerheight+$whitejetdepth]){
            echo(($whitenozzleheight-$whitenozzletopheight)-($whiteinnerheight+$whitejetheight));
            cylinder(d=$whitejetdiameter, d2=$whitenozzleinnerdiameter, h=$innercylinderheight);
        }
    }
}

module support(){
    cylinder(d=$innerdiameter-2,h=$whiteinnerheight-1);
}

union(){
    difference(){
        white();
        white_cutout();
    }
    for(deg=[102:180:360]){
        rotate([0,0,deg]){
            translate([0,($whitejetdiameter+$innercylinderdiameter)/2,$whiteinnerheight+$whitejetdepth]){
                innercylinder();
            }
        }
    }
}

support();