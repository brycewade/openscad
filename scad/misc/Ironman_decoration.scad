x=3;
y=4.4;
z=1;

sf=40/x;
hd=1;
rd=9;
$fn=60;

module ring(){
    rotate_extrude(angle = 360, convexity = 2){
        translate([rd,0,0]){
            circle(r=hd);
        }
    }
}

difference(){
    scale([sf,sf,sf]){
        import("files/Ironman.stl", convexity=3);
    }
    translate([x/2*sf,y*sf+3,sf/2]){
        ring();
    }
}