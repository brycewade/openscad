include <OpenSCAD_Wedge_ModuleLibrary/wedge.scad>

$fn=360;

$width=3;
$thickness=3;
$radius=6.23/2;
$cliparc=240;

$earradius=19;
$scale=($earradius-7.25)/$earradius;



difference(){
    union(){
        rotate([0,0,90-$cliparc/2]){
            wedge($width,$radius+$thickness,$cliparc);
        }
        translate([-$earradius*$scale,0,0]){
            scale([$scale,1]){
                difference(){
                    wedge($width,$earradius+$thickness,$cliparc);
                    cylinder(h=$width,r=$earradius);
                }
            }
        }      
    }
    cylinder(h=$width,r=$radius);
}