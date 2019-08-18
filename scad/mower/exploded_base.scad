include <mower_base.scad>

for(x=[0,1]){
    for(y=[0:2]){
        translate([5*x,5*y,0]){
            bottom_part(x,y);
        }
    }
}

for(x=[-0.5:1.5]){
    for(y=[-0.5:2.5]){
        translate([10*x,10*y,base_layer1+50]){
            top_part(x,y);
        }
    }
}