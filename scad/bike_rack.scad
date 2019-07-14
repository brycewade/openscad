$fn=36;

tubed=8.40;
tubedip=9.76;

innerwidth=116.26;
innerlength=56.10;

centerwidth=innerwidth+tubed;
centerlength=innerlength+tubed;

arcradius=(tubedip/2)+(centerwidth*centerwidth/(8*tubedip));
arccenter=arcradius-tubedip;
arcangle=atan(centerwidth/2/arccenter);

module tube(length){
    rotate([0,90,0]){
        cylinder(d=tubed, h=length);
    }
}

module arc_tube($radius, $angle){
    rotate_extrude(angle=$angle, convexity = 2){
        translate([$radius,0,0]){
            rotate([0,0,0]) circle(d=tubed);
        }
    }
}

translate([-centerwidth/2,0,0]){
   rotate([0,0,90]) tube(centerlength*4);
}
translate([centerwidth/2,0,0]){
   rotate([0,0,90]) tube(centerlength*4);
}

arc_tube(arcradius, arcangle);
