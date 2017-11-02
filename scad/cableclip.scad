include <OpenSCAD_Wedge_ModuleLibrary/wedge.scad>

$fn=360;

$height=8;
$radius=19.24/2;
$thickness=5;
$cliparc=240;
$cablearch=260;

difference(){
    wedge($height,$radius+$thickness,$cliparc);
    cylinder(h=$height,r=$radius);
}
translate([$radius,0,0]){
    rotate([0,0,-90]){
        translate([-$radius-2*$thickness,0,0]){
            difference(){
                wedge($height,$radius+2*$thickness,$cablearch);
                cylinder(h=$height,r=$radius+$thickness);
            }
        }  
    }
}