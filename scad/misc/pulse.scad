ox=58.2;
oy=77.1;
oz=3.8;

tx=4.5;
ty=4.25;

ix=ox-2*tx;
iy=oy-2*ty;

module frame(){
    difference(){
        cube([ox,oy,oz]);
        translate([tx,ty,0]){
            cube([ix,iy,oz]);
        }
    }
}

module image(){
    intersection(){
        translate([tx,ty,0]){
            cube([ix,iy,oz]);
        }
        translate([tx,ty,oz]){
            scale([ix/1000,ix/1000,(oz+1)/100]){
                surface(file="/tmp/music-pulse.png",invert=true);
            }
        }
    }
}

/*
frame();
*/

import("/home/vagrant/music_pulse.dxf");