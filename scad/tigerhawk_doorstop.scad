$fn=360;

$length=100;
$width=30;
$height=30;
$radius=5;

$logo_width=$width*3/4;
$logo_height=$logo_width*33/52;

$length_scale=($logo_height+$width/4)/$length;


linear_extrude(height=$height,scale=[1,$length_scale],slices=20,twist=0){
    translate([$radius,$radius,0]){
        minkowski(){
            square([$width-2*$radius,$length-2*$radius]);
            circle($radius);
        }
    }
}



translate([$width/8,$width/8,$height]){
    linear_extrude(height=2){
            scale($logo_width/52){
            import("/home/bryce/Downloads/8_TH_SOLID_0004_black.dxf");
        }
    }
}
