$fn=128;

charger_diameter=96.9;
charger_radius=charger_diameter/2;
charger_height=6;


qi_verticle_offset=33.5;
qi_horizontal_offset=73;

tablet_width=114.5;
tablet_length=78.73+113.32;
tablet_height=10.74;
charger_thickness=charger_height+4;
rounding_radius=charger_thickness/4;
tablet_top=charger_thickness+tablet_height;

charger_cord_length=40;
charger_plug_length=12;
charger_plug_usb_length=5.3;
charger_plug_taper_length=8.32;
charger_plug_taper_width=6.64;
charger_plug_taper_length2=9;
charger_plug_taper_width2=5.8;
charger_plug_width=10.5;
charger_cord_diameter=2.8;
cord_bend_radius=charger_cord_length-(charger_plug_length+charger_plug_taper_length+charger_plug_taper_length2);
charger_angle=180-asin(-charger_radius/(charger_radius+charger_cord_length));

stand_angle=60;
stand_depth=1.25*cos(stand_angle)*tablet_width;
stand_back_width=tablet_length*7/12;
stand_back_offset=(tablet_length-stand_back_width)/2;
stand_front_lip_height=6;
stand_front_lip_depth=10+rounding_radius;
stand_front_height=14;

module plug(){
    translate([-charger_plug_usb_length,-charger_plug_width/2,0]){
        cube([charger_plug_length+charger_plug_usb_length,charger_plug_width,charger_height]);
    }
    hull(){
        translate([charger_plug_length,-charger_plug_width/2,0]) cube([0.001,charger_plug_width,charger_height]);
        translate([charger_plug_length+charger_plug_taper_length,-charger_plug_width/2,0]) cube([0.001,charger_plug_taper_width,charger_height]);
    }
    hull(){
        translate([charger_plug_length+charger_plug_taper_length,-charger_plug_width/2,0]) cube([0.001,charger_plug_taper_width,charger_height]);
        translate([charger_plug_length+charger_plug_taper_length+charger_plug_taper_length2,-charger_plug_width/2,0]) cube([0.001,charger_plug_taper_width2,charger_height]);
    }
    translate([charger_plug_length+charger_plug_taper_length+charger_plug_taper_length2,-charger_plug_width/2+charger_plug_taper_width2/2+charger_cord_diameter/2,charger_height-cord_bend_radius]){
    rotate([90,0,0]){
            intersection(){
                cube([cord_bend_radius,cord_bend_radius,charger_cord_diameter]);
                cylinder(r=cord_bend_radius,h=charger_cord_diameter);
            }
        }
    }
    //A place to pass the plug head through
    translate([charger_plug_length+charger_plug_taper_length-charger_plug_width,-charger_plug_width/2,-4]){
        cube([charger_plug_width,charger_height,4]);
    }
    translate([charger_plug_length+charger_plug_taper_length,-charger_plug_width/2+charger_plug_taper_width2/2-charger_cord_diameter/2,-4]){
        cube([charger_plug_taper_length2,charger_cord_diameter,4]);
    }
}

module plus(){
    hull(){
        for(x=[rounding_radius,tablet_length-rounding_radius]){
            for(y=[qi_verticle_offset-charger_radius,tablet_width-rounding_radius]){
                for(z=[rounding_radius,charger_thickness-rounding_radius]){
                    translate([x,y,z]){
                        sphere(r=rounding_radius);
                    }
                }
            }
        }
    }
}

module minus(){
    translate([tablet_length-qi_horizontal_offset,qi_verticle_offset,4]){
        rotate([0,0,charger_angle]){
            cylinder(d=charger_diameter,h=charger_height);
            translate([charger_radius,0,0]){
                plug();
            }
        }
    }
}

module charger(){
    difference(){ 
        plus();
        minus();
    }
}


module lip(){
    translate([rounding_radius,rounding_radius,tablet_top]){
        rotate([180,0,0]){
            rotate([0,90,0]){
                translate([-rounding_radius,-rounding_radius,0]){
                    intersection(){
                        difference(){
                            cube([rounding_radius,2*rounding_radius,tablet_length-2*rounding_radius]);
                            cylinder(r=rounding_radius,h=tablet_length-2*rounding_radius);
                            translate([0,2*rounding_radius,0]){
                                cylinder(r=rounding_radius,h=tablet_length-2*rounding_radius);
                            }
                        }
                        hull(){
                            for(z=[2*rounding_radius,tablet_length-4*rounding_radius]){
                                translate([0,2*rounding_radius,z]){
                                    rotate([0,90,0]){
                                        cylinder(r=2*rounding_radius,h=2*rounding_radius);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module stand_plus(){
    front_y=1.5*tablet_top*sin(stand_angle)+rounding_radius;
    hull(){
        translate([0,0,stand_front_lip_height-(qi_verticle_offset-charger_radius)*sin(stand_angle)]){
            rotate([stand_angle,0,0]){
                for(x=[rounding_radius,tablet_length-rounding_radius]){
                    translate([x,0,tablet_top-rounding_radius]) sphere(r=rounding_radius);
                }
            }
        }
        for(x=[rounding_radius,tablet_length-rounding_radius]){
            translate([x,-front_y,rounding_radius]){
                sphere(r=rounding_radius);
            }
        }
    
        translate([stand_back_offset,stand_depth,0.01]){
            rotate([0,90,0]) cylinder(r=0.01,h=stand_back_width);
        }
    }
    translate([0,0,stand_front_lip_height-(qi_verticle_offset-charger_radius)*sin(stand_angle)]){
        rotate([stand_angle,0,0]){
            lip();
        }
    }
}

module cord_chase(){
    cord_x_offset=tablet_length-qi_horizontal_offset+cos(charger_angle)*(charger_cord_length+charger_radius);
    cord_y_offset=qi_verticle_offset-charger_radius-charger_plug_width/2+charger_cord_diameter;
    translate([0,0,stand_front_lip_height-(qi_verticle_offset-charger_radius)*sin(stand_angle)]){
        rotate([stand_angle,0,0]){
            translate([cord_x_offset-charger_height/2,cord_y_offset-80,0]){
                cube([charger_plug_width,charger_plug_width+80,charger_height]);
            }
        }
    }
    translate([cord_x_offset,-12,charger_cord_diameter/2]){
        rotate([-90,0,0]){
            cylinder(d=charger_cord_diameter,h=stand_depth+12);
        }
    }
    translate([cord_x_offset-charger_cord_diameter*0.475,-12,0]){
        cube([0.95*charger_cord_diameter,stand_depth+12,charger_cord_diameter/2]);
    }
}

module stand(){
    difference(){
        stand_plus();
        translate([0,0,stand_front_lip_height-(qi_verticle_offset-charger_radius)*sin(stand_angle)]){
            rotate([stand_angle,0,0]){
                plus();
            }
        }
        cord_chase();
    }
}

stand();
//lip();


/*
translate([0,0,stand_front_lip_height-(qi_verticle_offset-charger_radius)*sin(stand_angle)]){
    rotate([stand_angle,0,0]){
        minus();
        hull(){
            translate([rounding_radius,0,tablet_top-rounding_radius]) sphere(r=rounding_radius);
            translate([tablet_length-rounding_radius,0,tablet_top-rounding_radius]) sphere(r=rounding_radius);
        }
    }
}
*/
