$fn=360;

$length=100;
$width=30;
$height=30;
$radius=5;

$logo_width=150;
$logo_height=$logo_width*33/52;

$length_scale=($logo_height+$width/4)/$length;

module logo(){
    scale([$logo_width*1.25,$logo_height*1.25]) cylinder(d=1,h=3);
    
    translate([-$logo_width/2,-$logo_height/2]){
        linear_extrude(height=6){
                scale($logo_width/52){
                import("/home/bryce/Downloads/8_TH_SOLID_0004_black.dxf");
            }
        }
    }
}

scale([0.5,0.5]){
    difference(){
        translate([-$logo_width*.75,-$logo_height*.75,0]){
            cube([$logo_width*1.5,$logo_height*1.5,7]);
        }
        logo();
    }
}