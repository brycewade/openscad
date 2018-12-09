$fn=360;

board_width=25.4*1.5;
board_height=25.4*0.75;
//board_length=2000;
board_length=40;

LEDwidth=12;
LEDheight=3;

powerwidth=7;
powerheight=7;

buffer=5;

screwheadradius=4;
screwheadheight=3.2;
screwradius=2;

/*
buckwidth=63;
bucklength=32;
buckheight=18;

buckwidth=1.02*25.4;
bucklength=1.36*25.4;
buckheight=0.55*25.4;
*/
buckwidth=32;
bucklength=46;
buckheight=18;

module screw(){
    cylinder(r=screwradius,h=screwheadheight+buffer);
    translate([0,0,buffer]){
        cylinder(r=screwheadradius,h=screwheadheight);
    }
}
module screwhole(){
    hull(){
        cylinder(r=screwradius,h=screwheadheight+buffer);
        translate([2*screwheadradius,0,0]) {
            cylinder(r=screwradius,h=screwheadheight+buffer);
        }
    }
    hull(){
        translate([0,0,buffer]){
            cylinder(r=screwheadradius,h=screwheadheight);
        }
        translate([2*screwheadradius,0,buffer]){
            cylinder(r=screwheadradius,h=screwheadheight);
        }
    }
    translate([2*screwheadradius,0,0]){
        cylinder(r=screwheadradius,h=screwheadheight+buffer);
    }
}

difference(){
    cube([board_length,board_width,board_height]);
    translate([0,board_width-buffer-LEDwidth,board_height-LEDheight]){
        cube([board_length,LEDwidth,LEDheight]);
    }
    translate([0,buffer,0]){
        cube([board_length,powerwidth,powerheight]);
    }
    translate([4*buffer,board_width/2,0]){
        screwhole();
    }
 /*
    translate([board_length/2,board_width/2,0]){
        screwhole();
    }
    translate([board_length-4*buffer,board_width/2,0]){
        screwhole();
    }
    translate([0,board_width-buckwidth,0]){
        cube([bucklength,buckwidth,buckheight]);
    }
*/
}