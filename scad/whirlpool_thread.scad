include <threads.scad>

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
$m2height=6+$m2radius;
$flangeheight=$m2height+$m2radius+4;


$outerheight=2;
$threaddiameter=37.5;
$threadheight=14.2;
$threaddiameter2=37;
$threadheight2=16;
$halfdiameter=23.2;
$halfheight=10;
$totalheight=$halfheight+$threadheight2;
$greylid=1.25;
$threadpitch=9.84/4;
$threadingdiameter=40.7;
$threadingheight=9.9;

$m2length=9.8;
$m2diameter=2;
$m2headheight=2;
$m2headdiameter=3.5;

module grey(){
    cylinder(d=$outerdiameter,h=$outerheight);
    cylinder(d=$threaddiameter,h=$threadheight);
    cylinder(d=$threaddiameter2,h=$threadheight2);
    cylinder(d=$halfdiameter,h=$totalheight);

    translate([0,0,$threadpitch]){
        rotate([0,0,-90]){
            metric_thread($threadingdiameter,$threadpitch,$threadingheight);
        }
    }

}

module m2x8(){
    cylinder(d=$m2diameter,h=$m2length);
    translate([0,0,-5]) cylinder(d=$m2headdiameter,h=$m2headheight+5);
}

module grey_cutout(){
    cylinder(d=$whitenozzleouterdiameter+2,h=$totalheight-$greylid);
    cylinder(r=$cutoutfromcenter+0.5,h=$flangeheight);
    translate([0,$threaddiameter/2,$m2height]){
        rotate([90,0,0]) m2x8();
    }
    translate([-$halfdiameter/2-1,0,$threadheight2]){
        cube([$halfdiameter+2,$halfdiameter/2+1,$halfheight+1]);
    }
}

module support_circles($r,$h){
    for(radius=[$r:-2:1]){
        difference(){
            cylinder(r=radius,h=$h);
            cylinder(r=radius-0.25,h=$h);
        }
    }
}

module support(){
    
    difference(){
        union(){
            cylinder(d=$whitenozzleouterdiameter-1,h=$totalheight-$greylid-2);
            cylinder(r=$cutoutfromcenter-1,h=$flangeheight-2);
        }
        translate([-$cutoutfromcenter/2,-1,-1]) cube([$cutoutfromcenter,2,$flangeheight/2]);
    }
    translate([0,0,$flangeheight-2]) support_circles($cutoutfromcenter-1,2);
    translate([0,0,$totalheight-$greylid-2]) support_circles(($whitenozzleouterdiameter-1)/2,2);
}

difference(){
    grey();
    grey_cutout();
}
support();