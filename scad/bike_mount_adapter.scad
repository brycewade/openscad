$fn=360;

width=43.3*0.254;
inner_diameter=87.45*0.254;
outer_diameter=126.25*0.254;
scale=1.75;
gap=2;

module mount(){
    difference(){
        cylinder(d=outer_diameter*2,h=width);
        cylinder(d=outer_diameter,h=width);
    }
}

module adapter(){
    rotate_extrude(angle=360, convexity=2){
        polygon(points=[[inner_diameter/2,-width],[scale*inner_diameter/2,-width/2],[scale*inner_diameter/2,width/2],[inner_diameter/2,width]]);
    }
}

module keep(){
    translate([gap/2,-outer_diameter,-width*1.5]){
        cube([outer_diameter,outer_diameter*2,width*3]);
    }
}

intersection(){
    difference(){
        adapter();
        translate([0,0,-width/2]){
            mount();
        }
    }
    keep();
}