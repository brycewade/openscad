$fn=360;

include <mower_measurements.scad>


    
module m3_nut_plus_bolt_insert(length, overrun){
    rotate([0,0,30]) m3_nut_plus_bolt(length, overrun);
    translate([-nut_diameter*1.05*sin(60)/2,0,0]) {
        cube([nut_diameter*1.05*sin(60),nut_diameter*1.05/2,nut_height*1.1]);
    }
}




module tread(){
    translate([front_wheel_radius-front_wheel_prism_width-0.25,0,0]) {
        rotate([90,0,0]){
            prism(front_wheel_prism_length, front_wheel_prism_width, front_wheel_prism_height);
        }
    }
}

module half_wheel(){
    difference(){
        cylinder(r=front_wheel_radius-front_wheel_prism_width, h=front_wheel_height);
        cylinder(r=front_wheel_radius-2*front_wheel_prism_width, h=front_wheel_height);
    }
    for(spoke=[0:72:360]){
        rotate([0,0,spoke]){
            hull(){
                cylinder(d=front_wheel_prism_width,h=front_wheel_height);
                translate([front_wheel_radius-2*front_wheel_prism_width,0,0]){
                    cylinder(d=front_wheel_prism_width,h=front_wheel_height);
                }
            }
        }
    }
    cylinder(d=front_wheel_mount_inner_diameter,h=front_wheel_height+front_wheel_mount_buffer);
    translate([0,0,front_wheel_height+front_wheel_mount_buffer]){
        cylinder(d=wheel_motor_bearing_inner_diameter,h=wheel_motor_bearing_width);
    }
    for(offset=[front_wheel_prism_length:(front_wheel_height-front_wheel_prism_length)/3:front_wheel_height]){
        for(angle=[0:10:360]){
            translate([0,0,offset]){
                rotate([0,0,offset*3+angle]){
                    tread();
                }
            }
        }
    }
}

module left_half(){
    difference(){
        half_wheel();
        for(angle=[0:120:360]){
            rotate([0,0,angle]){
                translate([front_wheel_mount_inner_diameter/4,0,0]){
                    cylinder(d=screw_diameter,h=front_wheel_height+front_wheel_mount_buffer+wheel_motor_bearing_width);
                }
                translate([front_wheel_mount_inner_diameter/4,0,0]){
                    cylinder(d=screw_head_diameter,h=screw_head_height+1);
                }
            }
        }
    }
}

module right_half(){
    difference(){
        half_wheel();
        for(angle=[0:120:360]){
            rotate([0,0,angle]){
                translate([front_wheel_mount_inner_diameter/4,0,0]){
                    cylinder(d=screw_diameter,h=front_wheel_height+front_wheel_mount_buffer+wheel_motor_bearing_width);
                }
                translate([front_wheel_mount_inner_diameter/4,0,0]){
                    cylinder(d=nut_diameter*1.05,h=nut_height+1, $fn=6);
                }
            }
        }
    }
}

module wheel_support_arc(){
    rotate_extrude(angle=45, convexity=2){
        translate([front_wheel_mount_inner_diameter,0,0]){
            square([base_wall_thickness*2+wheel_motor_bearing_outer_diameter,2*wheel_motor_bearing_width+2*front_wheel_mount_buffer]);
        }
    }
    translate([front_wheel_mount_inner_diameter+base_wall_thickness+wheel_motor_bearing_outer_diameter/2,0,0]){
        cylinder(d=base_wall_thickness*2+wheel_motor_bearing_outer_diameter, h=2*wheel_motor_bearing_width+2*front_wheel_mount_buffer);
    }
}

module wheel_support_transition(){
    rotate([0,0,-135]){
        translate([-base_wall_thickness*2-wheel_motor_bearing_outer_diameter-front_wheel_mount_inner_diameter,0,0]){
            rotate([90,0,0]){
                hull(){
                    cube([(base_wall_thickness*2+wheel_motor_bearing_outer_diameter)*0.76,2*wheel_motor_bearing_width+2*front_wheel_mount_buffer,0.01]);
                    intersection(){
                        translate([front_wheel_mount_inner_diameter/2,wheel_motor_bearing_width+front_wheel_mount_buffer,base_wall_thickness+wheel_motor_bearing_outer_diameter/2]){
                            cylinder(d=front_wheel_mount_inner_diameter,h=0.01);
                        }
                        cube([base_wall_thickness*2+wheel_motor_bearing_outer_diameter,2*wheel_motor_bearing_width+2*front_wheel_mount_buffer,base_wall_thickness+wheel_motor_bearing_outer_diameter]);
                    }
                }
            }
        }
    }
}
module wheel_bearing_cutout(){
    translate([front_wheel_mount_inner_diameter+base_wall_thickness+wheel_motor_bearing_outer_diameter/2,0,0]){
        cylinder(d=wheel_motor_bearing_outer_diameter,h=wheel_motor_bearing_width);
        cylinder(d=front_wheel_mount_outer_diameter,h=2*wheel_motor_bearing_width+2*front_wheel_mount_buffer);
        translate([0,0,wheel_motor_bearing_width+2*front_wheel_mount_buffer]){
            cylinder(d=wheel_motor_bearing_outer_diameter,h=wheel_motor_bearing_width);
        }
    }
}

module wheel_support_arc_cutoff(){
    cube([front_wheel_mount_inner_diameter,front_wheel_mount_inner_diameter,2*wheel_motor_bearing_width+2*front_wheel_mount_buffer]);
}

module wheel_support(){
    difference(){
        wheel_support_arc();
        wheel_bearing_cutout();
        wheel_support_arc_cutoff();
    }
}

module wheel_pivot(){
    intersection(){
        rotate([0,0,-135]){
            translate([-base_wall_thickness*2-wheel_motor_bearing_outer_diameter-front_wheel_mount_inner_diameter+front_wheel_mount_inner_diameter/2,-base_wall_thickness-wheel_motor_bearing_outer_diameter/2,wheel_motor_bearing_width+front_wheel_mount_buffer]){
                rotate([90,0,0]){
                    cylinder(d=front_wheel_mount_inner_diameter,h=front_wheel_mount_buffer);
                    cylinder(d=wheel_motor_bearing_inner_diameter,h=front_wheel_mount_buffer+front_wheel_mount_pivot_height);
                }
            }
        }
        translate([-100,-100,0]){
            cube([200,200,2*wheel_motor_bearing_width+2*front_wheel_mount_buffer]);
        }
    }
}

module pivot_mount_rail_slot(){
    translate([front_mount_radius-wheel_motor_mount_rail_depth,-wheel_motor_mount_rail_width/2,0]){
        cube([wheel_motor_mount_rail_width,wheel_motor_mount_rail_depth,wheel_motor_mount_rail_height]);
    }
}
module pivot_mount_rail_plus(){
    translate([-wheel_motor_mount_rail_width/2,0,0]){
        cube([wheel_motor_mount_rail_width,wheel_motor_mount_rail_height,wheel_motor_mount_rail_depth]);
    }
}

module pivot_mount_rail_minus(){
    for(i=[0:2]){
        translate([-2.5,wheel_motor_mount_length/4+i*wheel_motor_mount_rail_interval*2,wheel_motor_mount_rail_depth]){
            rotate([180,0,0]){
                m3_bolt(wheel_motor_mount_rail_width);
            }
        }
        translate([2.5,3*wheel_motor_mount_length/4+i*wheel_motor_mount_rail_interval*2,wheel_motor_mount_rail_depth]){
            rotate([180,0,0]){
                m3_bolt(wheel_motor_mount_rail_width);
            }
        }
    }
    rail_nut_height=wheel_motor_mount_rail_depth-nut_height*1.1-4;
    for(y=[wheel_motor_mount_length/2:wheel_motor_mount_rail_interval:wheel_motor_mount_rail_height-nut_diameter]){
        translate([0,y,rail_nut_height]){
            rotate([0,0,30]) m3_nut_plus_bolt(10,5);
        }
    }
}

module pivot_mount_rail(){
    difference(){
        pivot_mount_rail_plus();
        pivot_mount_rail_minus();
    }
}

module wheel_pivot_mount(){
    difference(){
        intersection(){
            cylinder(r=front_mount_radius, h=front_wheel_mount_pivot_height);
            translate([front_mount_radius-wheel_motor_bearing_outer_diameter/2-base_wall_thickness,0,0]){
                cylinder(r=front_mount_radius, h=front_wheel_mount_pivot_height);
            }
        }
        cylinder(d=front_wheel_mount_outer_diameter, h=front_wheel_mount_pivot_height);
        cylinder(d=wheel_motor_bearing_outer_diameter, h=wheel_motor_bearing_width);
        translate([0,0,front_wheel_mount_pivot_height-wheel_motor_bearing_width]){
            cylinder(d=wheel_motor_bearing_outer_diameter, h=wheel_motor_bearing_width);
        }
        for(rotation=[-22.5,22.5]){
            rotate([0,0,rotation]){
                pivot_mount_rail_slot();
            }
            for(z=[-1,1]){
                rotate([0,0,rotation]){
                    translate([front_mount_radius-base_wall_thickness-wheel_motor_mount_rail_depth,z*2.5,(2+z)*wheel_motor_mount_length/4]){
                        rotate([90,0,0]){
                            rotate([0,-90,0]){
                                m3_nut_plus_bolt_insert(3*base_wall_thickness,2);
                            }
                        }
                    }
                }
            }
        }
    }
}

module wheel_pivot_base_mount(){
    wpbm_depth=front_mount_radius-wheel_motor_bearing_outer_diameter/2-base_wall_thickness;
    wpbm_width=sqrt(4*front_mount_radius*front_mount_radius-wpbm_depth*wpbm_depth);
    rotate([0,0,-90]){
        translate([-front_mount_base_legy,0,]){
            difference(){
                translate([wpbm_depth/2,-wpbm_width/2,0]){
                    cube([front_mount_base_legy-wpbm_depth/2,wpbm_width,base_thickness+base_blade_indent_height+base_second_layer_thickness]);
                }
                cylinder(r=front_mount_radius, h=front_wheel_mount_pivot_height);
            }
        }
    }
}

module wheel_spacer(){
    difference(){
        cylinder(d=front_wheel_mount_inner_diameter,h=2*front_wheel_mount_buffer);
        for(angle=[0:120:360]){
            rotate([0,0,angle]){
                translate([front_wheel_mount_inner_diameter/4,0,0]){
                    cylinder(d=screw_diameter,h=front_wheel_height+front_wheel_mount_buffer+wheel_motor_bearing_width);
                }
            }
        }
    }
}

module wheel_support_and_pivot(){
    wheel_support();
    wheel_pivot();
    wheel_support_transition();
}

module pivot_and_wheels(){
    y=base_wall_thickness+wheel_motor_bearing_outer_diameter/2-front_wheel_mount_inner_diameter/2+front_wheel_mount_inner_diameter/2+front_wheel_mount_buffer/2;
    z=-2.5*front_wheel_mount_buffer-front_wheel_radius;
    translate([0,-y,z]){
        rotate([0,90,0]){
            translate([0,0,-wheel_motor_bearing_width-front_wheel_mount_buffer]){
                translate([0,0,-front_wheel_height-front_wheel_mount_buffer]) left_half();
                translate([0,0,front_wheel_height+front_wheel_mount_buffer+2*wheel_motor_bearing_width+2*front_wheel_mount_buffer]) rotate([0,180,0]) right_half();
                rotate([0,0,45]) translate([-front_wheel_mount_inner_diameter-base_wall_thickness-wheel_motor_bearing_outer_diameter/2,0,0]) wheel_support_and_pivot();
            }
        }
    }
}

//rotate([0,0,45]) pivot_and_wheels();
//wheel_pivot_mount();

