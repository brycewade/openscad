$length=190;
$width=130;
$height=160;

$bladewidth=2.75;

$slices=12;

$guidewidth=2;

$slicewidth=$length/$slices;
$radius=$slicewidth/2;

module guide(){
    translate([0,-$bladewidth/2,$guidewidth*2]){
        cube([$width+2*$guidewidth,$bladewidth,$height+2*$guidewidth]);
    }
    translate([0,-$radius,$height+4*$guidewidth-$radius]){
        difference(){
            cube([$width+2*$guidewidth,$radius*2,$radius+1]);
            rotate([0,90,0]){
                cylinder(r=$radius,h=$width+2*$guidewidth);
                translate([0,2*$radius,0]){
                    cylinder(r=$radius,h=$width+2*$guidewidth);
                }
            }
        }
    }
    
}

difference(){
    cube([$width+2*$guidewidth,$length+2*$guidewidth,$height+4*$guidewidth]);
    translate([$guidewidth,$guidewidth,3*$guidewidth]){
        cube([$width,$length,$height+2*$guidewidth]);
    }
    for(slice=[1:1:$slices-1]){
        translate([0,$guidewidth+slice*$slicewidth,0]) {
            guide();
        }
    }
}