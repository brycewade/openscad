$fn=360;

include <mower_measurements.scad>

big_od=62.85;
big_id=58.5;
thickness=(big_od-big_id)/2;
height=11.5;

sid=48.85;
swidth=16.0;
sod=58.85;
depth=4;

x1=sid;
y1=0;

x2=sid+depth;
y2=swidth/2;

x3=sid+depth;
y3=-swidth/2;

x12 = x1 - x2;  
x13 = x1 - x3;  

y12 = y1 - y2;  
y13 = y1 - y3;  

y31 = y3 - y1;  
y21 = y2 - y1;  

x31 = x3 - x1;  
x21 = x2 - x1; 

// x1^2 - x3^2  
sx13 = pow(x1, 2) - pow(x3, 2);  

// y1^2 - y3^2  
sy13 = pow(y1, 2) - pow(y3, 2);  

sx21 = pow(x2, 2) - pow(x1, 2);  
sy21 = pow(y2, 2) - pow(y1, 2);

f = (((sx13) * (x12) + (sy13) * (x12) + (sx21) * (x13) + (sy21) * (x13)) / (2 * ((y31) * (x12) - (y21) * (x13)))); 
          
g = (((sx13) * (y12) + (sy13) * (y12) + (sx21) * (y13) + (sy21) * (y13)) / (2 * ((x31) * (y12) - (x21) * (y13))));  

c = (-pow(x1, 2) - pow(y1, 2) - 2 * g * x1 - 2 * f * y1);  

h = -g;  
k = -f;  
sqr_of_r = h * h + k * k - c; 

r=sqrt(sqr_of_r);
echo(r);

module hub(){
    difference(){
        cylinder(d=big_od,h=height);
        cylinder(d=big_id,h=height);
        for(deg=[0:60:359]){
            rotate([0,0,deg]){
                translate([sid/2+r,0,0]){
                    cylinder(r=r, h=height);
                }
            }
        }
    }
    intersection(){
        for(deg=[0:60:359]){
            rotate([0,0,deg]){
                translate([sid/2+r,0,0]){
                    difference(){
                        cylinder(r=r, h=height);
                        cylinder(r=r-thickness, h=height);
                    }
                }
            }
        }
        cylinder(d=big_od,h=height);
    }
}

difference(){
    cylinder(d=big_od+4,h=height+2);
    translate([0,0,m6_nut_height+4]) cylinder(d=sid-4,h=height+2);
    translate([0,0,2]){
        hub();
    }
    cylinder(d=m6_screw_diameter,h=m6_nut_height+4);
    rotate([0,0,30]) cylinder(d=m6_nut_diameter*1.1,h=m6_nut_height,$fn=6);
    for(angle=[0:120:360]){
        rotate([0,0,angle]){
            translate([wheel_mount_diameter/3,0,0]){
                cylinder(d=screw_diameter,h=wheel_height);
                translate([0,0,4]) {
                    rotate([0,0,30]) cylinder(d=nut_diameter*1.1,h=m6_nut_height,$fn=6);
                }
            }
        }
    }
}
