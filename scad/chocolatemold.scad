$border=4.63;
$wholeheight=5.41;
$divotdepth=1;
$letterdepth=0.5;
$miniwidth=17.81;
$minilength=34.04;

$barlength=138.07;
$barwidth=55.66;
$seamheight=3.42;

$mold_border=4;

$bevel=1.05;
$divotwidth=($miniwidth-2*$border)/$bevel;
$divotlength=($minilength-2*$border)/$bevel;

module scaled_cube($length,$width,$height,$scale){
    linear_extrude(height=$height,scale=[$scale,$scale]){
        translate([-$length/2,-$width/2,0]) {
            square([$length,$width]);
        }
    }
}
module minibar($text,$size){
    difference(){
        scaled_cube($minilength,$miniwidth,$wholeheight,.9);
        translate([0,0,$wholeheight-$divotdepth]) {
            scaled_cube($divotlength,$divotwidth,$divotdepth,$bevel);
        }
        translate([0,0,$wholeheight-$divotdepth-$letterdepth]){
            linear_extrude($height=$letterdepth){
                text($text,halign="center",valign="center", size=$size,font="Droid Sans");
            }
        }
    }
}

module positive(){
    scaled_cube($barlength,$barwidth,$seamheight,1);
    for(x=[-1.5:2:1.5]){
        for(y=[-1:1:1]){
            translate([x*$minilength,y*$miniwidth,0]){
                minibar("IOWA",5);
            }
            translate([(x+1)*$minilength,y*$miniwidth,0]){
                minibar("HAWKEYES",3);
            }
        }
    }
}

difference(){
    translate([-($barlength+2*$mold_border)/2,-($barwidth+2*$mold_border)/2,0]){
        cube([$barlength+2*$mold_border,$barwidth+2*$mold_border,$wholeheight+1]);
    }
    positive();
}