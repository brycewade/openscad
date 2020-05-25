$fn=360;

$length=100;
$width=30;
$height=30;
$radius=5;
$image_width=750;
$image_height=1000;

$image_scale=max($image_width,$image_height);

$logo_height=$height*4/4;
$logo_width=$logo_height*$image_width/$image_height;

$length_scale=($logo_height+$width/4)/$length;


linear_extrude(height=$height,scale=[1,$length_scale],slices=20,twist=0){
    translate([$radius,$radius,0]){
        minkowski(){
            square([$width-2*$radius,$length-2*$radius]);
            circle($radius);
        }
    }
}



translate([($width-$logo_width)/2,($height-$logo_height)/2,$height+2]){
    scale($logo_height/$image_scale){
        surface(file="../images/sousaphone.png",invert=true);
    }    
}
