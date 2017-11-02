$fn=360;

$length=100;
$width=30;
$height=30;
$radius=5;

$logo_width=$width*3/4;
$logo_height=$logo_width*637/682;

$length_scale=($logo_height+$width/4)/$length;


linear_extrude(height=$height,scale=[1,$length_scale],slices=20,twist=0){
    translate([$radius,$radius,0]){
        minkowski(){
            square([$width-2*$radius,$length-2*$radius]);
            circle($radius);
        }
    }
}



translate([$width/8,$width/8,$height+3]){
    scale($logo_width/682){
        surface(file="badgebw.png",invert=true);
    }    
}
