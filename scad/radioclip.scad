length=29;
width=15.5;
height=5;
thickness=2;
rfpcbthickness=1.25;
pinheight=3.4;
pinlength=5;


module cutout(){
    translate([thickness+pinlength,thickness,0]) cube([length-thickness-pinlength,width,height]);
    translate([thickness,thickness,height-pinheight]) cube([pinlength,width,pinheight+thickness]);
    translate([thickness,thickness,height-rfpcbthickness]) cube([length,width,rfpcbthickness]);
    translate([0,thickness,0]) cube([thickness+pinlength,thickness/2,height+thickness]);
    translate([0,width+thickness/2,0]) cube([thickness+pinlength,thickness/2,height+thickness]);
    translate([length,thickness,0]) cube([thickness*2,thickness/2,height+thickness]);
    translate([length,width+thickness/2,0]) cube([thickness*2,thickness/2,height+thickness]);
    translate([thickness,thickness+width/2,height]) {
        linear_extrude(height=thickness,scale=[1,.9]){
            translate([0,-width/2,0]) square([length,width]);
        }
    }
}

module radiomount(){
    difference(){
        cube([length+2*thickness,width+2*thickness,height+thickness]);
        cutout();
        
    }
}

radiomount();
translate([-thickness,-thickness,-thickness]) cube([length+4*thickness,width+4*thickness,thickness]);


//cutout();