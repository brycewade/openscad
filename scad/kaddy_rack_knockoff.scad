$fn=360;

$tube_diameter=25.4;
$thickness=5;
$rail_height=10;
$topangle=60;

$td=$tube_diameter;
$sqrt32=sqrt(3)/2;
$length=3*$tube_diameter;

module connector(x1,y1,x2,y2,radius,thickness){
    p1=[x1,y1,0];
    p2=[x2,y2,0];
    D=sqrt(pow(x2-x1,2)+pow(y2-y1,2));
    theta= ((x2==x1) ? 90:  atan((y2-y1)/(x2-x1))) + ((x2>x1) ? 0 : 180);
    echo(theta);
    difference(){
        hull(){
            translate(p1) circle(r=radius+thickness);
            translate(p2) circle(r=radius+thickness);
        }
        translate(p1) circle(r=radius);
        translate(p2) circle(r=radius);

        if(D>(4*radius+2*thickness)){
            translate(p1){
                rotate([0,0,theta]){
                    hull(){
                        translate([2*radius+thickness,0,0]) circle(r=radius);
                        translate([D-2*radius-thickness,0,0]) circle(r=radius);
                    }
                }
            }
        }
    }
}

module 2d_rail(){
    connector(0,0,0,-$length,$td/2,$thickness);
    connector(0,-$length,0,-2*$length,$td/2,$thickness);
    connector(0,0,$sqrt32*$length,-$length/2,$td/2,$thickness);
    connector(0,-$length,$sqrt32*$length,-$length/2,$td/2,$thickness);
    connector(0,0,$length*cos($topangle),$length*sin($topangle),$td/2,$thickness);
}

module screwhole(x,y,z,angle,radius,length){
    translate([x,y,z]){
        rotate([0,90,angle]){
            cylinder(r=radius,h=length);
        }
    }
}

module rail(){
    difference(){
        linear_extrude(height=$rail_height){
            2d_rail();
        }
        screwhole(0,0,$rail_height/2,180,3,$td/2+$thickness);
        screwhole(0,-$length,$rail_height/2,180,3,$td/2+$thickness);
        screwhole(0,-2*$length,$rail_height/2,180,3,$td/2+$thickness);
        screwhole($length*cos($topangle),$length*sin($topangle),$rail_height/2,150,3,$td/2+$thickness);
    }
}
 
module tube(){
    difference(){
        cylinder(d=$tube_diameter,h=254);
        cylinder(d=$tube_diameter*0.8,h=254);
    }
}


rotate([90,0,90]){
translate([0,0,-3*25.4]) color([0,0,0]) rail();
translate([0,0,3*25.4]) color([0,0,0]) rail();
translate([0,0,-5*25.4]) tube();
translate([0,-$length,-5*25.4]) tube();
translate([0,-2*$length,-5*25.4]) tube();
translate([$length*cos($topangle),$length*sin($topangle),-5*25.4]) tube(); 
}

/*
rail();
*/