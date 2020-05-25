$fn=360;

charger_diameter=96.9;
charger_height=6;

tablet_width=114.5;
tablet_length=78.73+113.32;

qi_verticle_offset=33.5;
qi_horizontal_offset=73;

rounding_diameter=charger_height+4;
rounding_radius=rounding_diameter/2;

hull(){
    for(x=[rounding_radius,tablet_length-rounding_radius]){
        for(y=[rounding_radius,tablet_width-rounding_radius]){
            translate([x,y,rounding_radius]){
                sphere(r=rounding_radius);
            }
        }
    }
}