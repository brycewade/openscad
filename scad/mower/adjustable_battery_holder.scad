$fn=360;

include <mower_measurements.scad>

back_y=-total_blade_radius-blade_y_offset-blade_gap-base_wall_thickness;
very_back_y=back_y-3*wheel_motor_mount_width;
front_y=back_y+base_blade_indent_length;
very_front_y=trimmer_y_offset-blade_y_offset+base_front_curve_radius;
base_layer1=base_thickness+base_blade_indent_height;
base_top=base_layer1+base_second_layer_thickness;
front_mount_base_y=very_front_y+front_mount_base_legy;

section_width=base_width/2;
section_length=(very_front_y-very_back_y)/3;

battery_y=very_back_y+section_length/3;
back_apc_battery_strap_y=battery_y+misc_mount_base_thickness-battery_holder_mount_basesize+apc_battery_length/4;
plate_y=very_back_y+1.5*wheel_motor_mount_width;
plate_back_holes_y=back_apc_battery_strap_y-plate_y;
plate_front_holes_y=plate_back_holes_y+apc_battery_length/2;

module battery_holder_plus(){
    cube([battery_holder_width,battery_holder_length,battery_holder_height]);
}

module battery_holder_minus(){
    // Battery holes
    for(x=[1:batteries_x_count]){
        for(y=[1:batteries_y_count]){
            translate([-battery_diameter/2+x*(battery_diameter+battery_holder_spacing),3*screw_diameter-battery_diameter/2+y*(battery_diameter+battery_holder_spacing),-5]){
                cylinder(d=battery_diameter,h=battery_height);
            }
        }
    }
    // Mounting screws
    for(x=[1.5*battery_holder_spacing+battery_diameter,battery_holder_width-1.5*battery_holder_spacing-battery_diameter-3*battery_charger_thickness]){
        for(y=[2*screw_diameter,battery_holder_length-2*screw_diameter]){
            translate([x,y,0]){
                cylinder(d=screw_diameter, battery_holder_height);
            }
        }
    }
    // Charger slot
    translate([battery_holder_width-3*battery_charger_thickness,(battery_holder_length-battery_charger_width)/2,battery_holder_height-battery_charger_lip_height]){
        cube([battery_charger_thickness,battery_charger_width,battery_charger_height]);
    }
    translate([battery_holder_width-2*battery_charger_thickness,(battery_holder_length-battery_charger_width)/2,battery_holder_height-battery_charger_lip_height]){
        cube([2*battery_charger_thickness,battery_charger_pad1,battery_charger_height]);
    }
    translate([battery_holder_width-2*battery_charger_thickness,(battery_holder_length-battery_charger_width)/2+battery_charger_pad2,0]){
        cube([2*battery_charger_thickness,battery_charger_pad3-battery_charger_pad2,battery_charger_height]);
    }
    translate([battery_holder_width-2*battery_charger_thickness,(battery_holder_length-battery_charger_width)/2+battery_charger_pad4,battery_holder_height-battery_charger_lip_height]){
        cube([2*battery_charger_thickness,battery_charger_pad5-battery_charger_pad4,battery_charger_height]);
    }
}

module battery_holder_bottom(){
    difference(){
        battery_holder_plus();
        battery_holder_minus();
    }
}

module battery_holder_top(){
    mirror([0,1,0]){
        difference(){
            battery_holder_plus();
            battery_holder_minus();
        }
    }
}

module battery_holder_visualized(){
    translate([0,battery_charger_height/2+battery_charger_lip_height,0]){
        rotate([90,0,0]){
            battery_holder_bottom();
        }
    }
    translate([0,-battery_charger_height/2-battery_charger_lip_height,0]){
        rotate([-90,0,0]){
            battery_holder_top();
        }
    }
    translate([battery_holder_width-3*battery_charger_thickness,-battery_charger_height/2,(battery_holder_length-battery_charger_width)/2]){
        cube([battery_charger_thickness,battery_charger_height,battery_charger_width]);
    }
}
module battery_holder_mount_plus(){
    translate([-screw_diameter*3, -screw_diameter*3,0]){
        cube([battery_holder_width+screw_diameter*6,battery_holder_length+screw_diameter*6,4]);
    }
}

module battery_holder_mount_minus(){
    for(x=[-screw_diameter*1.5:battery_holder_width+screw_diameter*3:battery_holder_width+screw_diameter*3]){
        for(y=[-screw_diameter*1.5:battery_holder_length+screw_diameter*3:battery_holder_length+screw_diameter*3]){
            translate([x,y,0]){
                cylinder(d=screw_diameter, h=4);
            }
        }
    }
}

module m3_bolt_hole(){
    cylinder(d=screw_diameter,h=battery_holder_mount_thickness);
    translate([0,0,battery_holder_mount_thickness]){
        cylinder(d=screw_head_diameter,h=battery_holder_mount_offset+battery_holder_height);
    }
}

module battery_mount_clip(){
    translate([-battery_holder_mount_basesize,-battery_holder_mount_basesize,-battery_holder_mount_offset]){
        cube([battery_holder_width+2*battery_holder_mount_basesize,battery_holder_mount_basesize+3*battery_holder_spacing,battery_holder_mount_offset+battery_holder_height+battery_holder_mount_thickness]);
    }
}

module battery_mount_clips_plus(){
    battery_mount_clip();
    translate([0,battery_holder_length,0]){
        mirror([0,1,0]){
            battery_mount_clip();
        }
    }
}
        
module battery_mount_clips_minus(){
    // Cut out the battery holder plus a little slop
    translate([-0.5,-0.5,0]){
        cube([battery_holder_width+1,battery_holder_length+1,battery_holder_height+1]);
    }
    // Cut out a little extra for the power bars
       translate([battery_holder_spacing+battery_diameter/2,3,-battery_holder_mount_offset]){
        cube([battery_holder_width-battery_diameter-2*battery_holder_spacing,battery_holder_length-6,battery_holder_mount_offset]);
    }
    // Cut out the batteries plus a little slop
    for(x=[battery_holder_spacing+battery_diameter/2:battery_diameter+battery_holder_spacing:battery_holder_width]){
        for(y=[battery_holder_spacing+battery_diameter/2:battery_diameter+battery_holder_spacing:battery_holder_length]){
            translate([x,y,-battery_holder_mount_offset]){
                cylinder(d=battery_diameter*1.05,h=battery_height);
            }
        }
    }
    // Cut out the mounting holes
    for(x=[-battery_holder_mount_basesize/2,battery_holder_width+battery_holder_mount_basesize/2]){
        for(y=[-battery_holder_mount_basesize/2,battery_holder_length+battery_holder_mount_basesize/2]){
            translate([x,y,-battery_holder_mount_offset]){
                m3_bolt_hole();
            }
        }
    }
    //strap screw holes
    for(y=[-battery_holder_mount_basesize/2,battery_holder_length+battery_holder_mount_basesize/2]){
        for(x=[-1,1]){
            translate([-battery_holder_mount_basesize+misc_mount_base_thickness+x*(1.5*screw_head_diameter+apc_strap_width/2)+(2+x)*apc_battery_length/4,y,battery_holder_height+battery_holder_mount_thickness-2*misc_mount_base_thickness]){
                m3_nut_plus_bolt(2*misc_mount_base_thickness+4, 2*misc_mount_base_thickness);
            }
        }
    }
}

module battery_mount_clips_mount_holes(){
    translate([0,-old_battery_holder_length/2,0]){
        for(x=[-battery_holder_mount_basesize/2,old_battery_holder_width+battery_holder_mount_basesize/2]){
            for(y=[-battery_holder_mount_basesize/2,old_battery_holder_length+battery_holder_mount_basesize/2]){
                translate([x,y,0]){
                    m3_nut_plus_bolt(base_mounting_screw_length, base_mounting_nut_depth);
                }
            }
        }
    }
}

module battery_mount_clips(){
    translate([0,-battery_holder_length/2,battery_holder_mount_offset]){
        difference(){
            battery_mount_clips_plus();
            battery_mount_clips_minus();
        }
    }
}

module new_battery_base_plus(){
    // The base
    translate([-battery_holder_mount_basesize-30,-battery_holder_mount_basesize-old_battery_holder_length/2,0]){
        cube([old_battery_holder_width+2*battery_holder_mount_basesize+30,2*battery_holder_mount_basesize+old_battery_holder_length,misc_mount_base_thickness]);
    // The battery holder mount
        translate([0,(2*battery_holder_mount_basesize+old_battery_holder_length)/2-(battery_charger_height-2*battery_charger_lip_height)/2,misc_mount_base_thickness]){
            cube([old_battery_holder_width+30,misc_mount_base_thickness,3*screw_diameter]);
        }
        translate([0,(2*battery_holder_mount_basesize+old_battery_holder_length)/2+(battery_charger_height-2*battery_charger_lip_height)/2-misc_mount_base_thickness,misc_mount_base_thickness]){
            cube([old_battery_holder_width+30,misc_mount_base_thickness,3*screw_diameter]);
        }
    }
}
module new_battery_base_minus(){
    for(y=[-(battery_holder_mount_basesize+old_battery_holder_length)/2,(battery_holder_mount_basesize+old_battery_holder_length)/2]){
        //mounting holes
        for(x=[-battery_holder_mount_basesize/2,old_battery_holder_width+battery_holder_mount_basesize/2]){
            translate([x,y,0]){
                cylinder(d=screw_diameter, h=misc_mount_base_thickness);
            }
        }
    }
    for(offset=[0,-12.5,-25,-37.5,-50]){
        for(y=[-1,1]){
            for(x=[-1,1]){
                translate([batteries_x_count*(battery_diameter+battery_holder_spacing)/2+x*(batteries_x_count-2)*(battery_diameter+battery_holder_spacing)/2+offset,0,misc_mount_base_thickness+2*screw_diameter]){
                    rotate([90*y,0,0]){
                        translate([0,0,-(2*battery_holder_mount_basesize+old_battery_holder_length)/2+(battery_charger_height-2*battery_charger_lip_height)/2]){
                            m3_nut_plus_bolt(misc_mount_base_thickness*2, 0);
                        }
                    }
                }
            }
        }
    }
}

module new_battery_base(){
    difference(){
        new_battery_base_plus();
        new_battery_base_minus();
    }
}

module new_battery_antenna_mount_plus(){
    ydistance=(apc_battery_width/2-apc_battery_terminal_offset/2)-(-apc_battery_width/2+apc_battery_terminal_offset/2);
    xdistance=plate_front_holes_y-plate_back_holes_y;
    x_offset=very_back_y+1.5*wheel_motor_mount_width-battery_y;
    rail_x_offset1=battery_diameter+battery_holder_spacing-0.75*nut_diameter;
    rail_x_offset2=(batteries_x_count-1)*(battery_diameter+battery_holder_spacing)-0.75*nut_diameter;
    translate([0,-(2*battery_holder_mount_basesize+old_battery_holder_length)/2,0]){
//        cube([old_battery_holder_width+2*battery_holder_mount_basesize,2*battery_holder_mount_basesize+old_battery_holder_length,2*misc_mount_base_thickness]);
    // Make an X
        translate([(plate_front_holes_y+plate_back_holes_y)/2+x_offset,battery_holder_mount_basesize+old_battery_holder_length/2,0]){
            hull(){
                translate([-xdistance/2,-ydistance/2,0]){
                    cylinder(d=1.5*nut_diameter, h=2*misc_mount_base_thickness);
                }
                translate([xdistance/2,ydistance/2,0]){
                    cylinder(d=1.5*nut_diameter, h=2*misc_mount_base_thickness);
                }
            }
            hull(){
                translate([xdistance/2,-ydistance/2,0]){
                    cylinder(d=1.5*nut_diameter, h=2*misc_mount_base_thickness);
                }
                translate([-xdistance/2,ydistance/2,0]){
                    cylinder(d=1.5*nut_diameter, h=2*misc_mount_base_thickness);
                }
            }
        }
    // The battery holder mount
        translate([rail_x_offset1,(2*battery_holder_mount_basesize+old_battery_holder_length)/2-(battery_charger_height-2*battery_charger_lip_height)/2,0]){
            cube([1.5*nut_diameter,(2*battery_holder_mount_basesize+old_battery_holder_length)-(battery_charger_height-2*battery_charger_lip_height)+misc_mount_base_thickness,2*misc_mount_base_thickness+3*screw_diameter]);
        }
        translate([rail_x_offset2,(2*battery_holder_mount_basesize+old_battery_holder_length)/2-(battery_charger_height-2*battery_charger_lip_height)/2,0]){
            cube([1.5*nut_diameter,(2*battery_holder_mount_basesize+old_battery_holder_length)-(battery_charger_height-2*battery_charger_lip_height)+misc_mount_base_thickness,2*misc_mount_base_thickness+3*screw_diameter]);
        }
        translate([rail_x_offset1-50,(2*battery_holder_mount_basesize+old_battery_holder_length)/2-(battery_charger_height-2*battery_charger_lip_height)/2,2*misc_mount_base_thickness]){
            cube([1.5*nut_diameter+50+(rail_x_offset2-rail_x_offset1),(2*battery_holder_mount_basesize+old_battery_holder_length)-(battery_charger_height-2*battery_charger_lip_height)+misc_mount_base_thickness,3*screw_diameter]);
        }
    }
}

module new_battery_antenna_mount_minus(){
    x_offset=very_back_y+1.5*wheel_motor_mount_width-battery_y;
    new_battery_antenna_mount_width=(2*battery_holder_mount_basesize+old_battery_holder_length)-(battery_charger_height-2*battery_charger_lip_height)+misc_mount_base_thickness;
    // Antenna mount holes
    for(y=[-apc_battery_width/2+apc_battery_terminal_offset/2,apc_battery_width/2-apc_battery_terminal_offset/2]){
        for(x=[plate_back_holes_y,plate_front_holes_y]){
            translate([x+x_offset,y,misc_mount_base_thickness*2]){
                rotate([180,0,0]){
                    m3_nut_plus_bolt(misc_mount_base_thickness*2, misc_mount_base_thickness*2);
                }
                m3_nut();
            }
        }
    }
    // Battery mount holes
    for(offset=[0, -12.5, -25, -37.5, -50]){
        for(y=[-1,1]){
            for(x=[-1,1]){
                translate([batteries_x_count*(battery_diameter+battery_holder_spacing)/2+x*(batteries_x_count-2)*(battery_diameter+battery_holder_spacing)/2+offset,0,2*misc_mount_base_thickness+2*screw_diameter]){
                    rotate([90*y,0,0]){
                        translate([0,0,-(2*battery_holder_mount_basesize+old_battery_holder_length)/2+(battery_charger_height-2*battery_charger_lip_height)/2]){
                            m3_nut_plus_bolt(misc_mount_base_thickness*2, 0);
                        }
                    }
                    translate([-0.75*nut_diameter,-new_battery_antenna_mount_width/2+misc_mount_base_thickness,-2*screw_diameter]){
                        cube([1.5*nut_diameter+12.5,new_battery_antenna_mount_width-2*misc_mount_base_thickness,3*screw_diameter]);
                    }
                }
            }
        }
    }
}

module new_battery_antenna_mount(){
    difference(){
        new_battery_antenna_mount_plus();
        new_battery_antenna_mount_minus();
    }
}

module apc_battery_plus(){
    // The base
    translate([-battery_holder_mount_basesize,-battery_holder_mount_basesize-old_battery_holder_length/2,0]){
        cube([old_battery_holder_width+2*battery_holder_mount_basesize,2*battery_holder_mount_basesize+old_battery_holder_length,misc_mount_base_thickness]);
    }
    // The battery holder
    translate([-battery_holder_mount_basesize,-misc_mount_base_thickness-apc_battery_width/2,misc_mount_base_thickness]){
        cube([2*misc_mount_base_thickness+apc_battery_length,2*misc_mount_base_thickness+apc_battery_width,misc_mount_base_thickness]);
    }
    // The strap mounts
    for(x=[1,3]){
        translate([-battery_holder_mount_basesize+misc_mount_base_thickness+x*apc_battery_length/4-apc_strap_width/2,-battery_holder_mount_basesize-old_battery_holder_length/2,misc_mount_base_thickness]){
            cube([apc_strap_width,2*battery_holder_mount_basesize+old_battery_holder_length,misc_mount_base_thickness]);
        }
    }
}

module apc_battery_minus(){
    for(y=[-(battery_holder_mount_basesize+old_battery_holder_length)/2,(battery_holder_mount_basesize+old_battery_holder_length)/2]){
        //strap screw holes
        for(x=[1,3]){
            translate([-battery_holder_mount_basesize+misc_mount_base_thickness+x*apc_battery_length/4,y,0]){
                m3_nut_plus_bolt(2*misc_mount_base_thickness, 2*misc_mount_base_thickness);
            }
        }
        //mounting holes
        for(x=[-battery_holder_mount_basesize/2,old_battery_holder_width+battery_holder_mount_basesize/2]){
            translate([x,y,0]){
                cylinder(d=screw_diameter, h=misc_mount_base_thickness);
            }
        }
    }

    translate([-battery_holder_mount_basesize+misc_mount_base_thickness,-apc_battery_width/2,misc_mount_base_thickness]){
        cube([apc_battery_length,apc_battery_width,misc_mount_base_thickness]);
    }
}

module apc_battery_mount(){
    difference(){
        apc_battery_plus();
        apc_battery_minus();
    }
}
module lipo_battery_strap_leg(){
    strap_base_width=battery_holder_mount_basesize;
    translate([-apc_strap_width/2,0,0]){
        hull(){
            cube([apc_strap_width,strap_base_width,misc_mount_base_thickness]);
            cube([apc_strap_width,2*misc_mount_base_thickness,apc_battery_height-misc_mount_base_thickness]);
        }
        cube([apc_strap_width+3*screw_head_diameter,strap_base_width,misc_mount_base_thickness]);
    }
}

module lipo_battery_strap_plus(){
    translate([0,-battery_holder_length/2,0]){
        mirror([0,1,0]){
            lipo_battery_strap_leg();
        }
    }
    translate([0,battery_holder_length/2,0]){
        rotate([0,0,0]){
            lipo_battery_strap_leg();
        }
    }
    translate([-apc_strap_width/2,-battery_holder_length/2-2*misc_mount_base_thickness,apc_battery_height-misc_mount_base_thickness]){
        cube([apc_strap_width,4*misc_mount_base_thickness+battery_holder_length,2*misc_mount_base_thickness]);
    }
}

module lipo_battery_strap_minus(){
    // base mount holes
    for(y=[-(battery_holder_mount_basesize+battery_holder_length)/2,(battery_holder_mount_basesize+battery_holder_length)/2]){
        translate([apc_strap_width/2+1.5*screw_head_diameter,y,0]) cylinder(d=screw_diameter,h=misc_mount_base_thickness);
        translate([apc_strap_width/2+1.5*screw_head_diameter,y,misc_mount_base_thickness]) cylinder(d=screw_head_diameter,h=apc_battery_height);
    }
    // antenna mount holes
    for(y=[-apc_battery_width/2+apc_battery_terminal_offset/2,apc_battery_width/2-apc_battery_terminal_offset/2]){
        translate([0,y,apc_battery_height-misc_mount_base_thickness]){
            m3_nut_plus_bolt(2*misc_mount_base_thickness,2*misc_mount_base_thickness);
        }
    }        
}

module lipo_battery_strap(){
    difference(){
        lipo_battery_strap_plus();
        lipo_battery_strap_minus();
    }
}

module apc_battery_strap_leg(){
    strap_base_width=(2*battery_holder_mount_basesize+battery_holder_length-apc_battery_width)/2;
    translate([-apc_strap_width/2,0,0]){
        hull(){
            cube([apc_strap_width,strap_base_width,misc_mount_base_thickness]);
            cube([apc_strap_width,2*misc_mount_base_thickness,apc_battery_height-misc_mount_base_thickness]);
        }
    }
}

module apc_battery_strap_plus(){
    translate([0,-apc_battery_width/2,0]){
        rotate([0,0,180]){
            apc_battery_strap_leg();
        }
    }
    translate([0,apc_battery_width/2,0]){
        rotate([0,0,0]){
            apc_battery_strap_leg();
        }
    }
    translate([-apc_strap_width/2,-apc_battery_width/2-2*misc_mount_base_thickness,apc_battery_height-misc_mount_base_thickness]){
        cube([apc_strap_width,4*misc_mount_base_thickness+apc_battery_width,2*misc_mount_base_thickness]);
    }
}

module wire_track(diameter,length){
    rotate([0,-90,0]){
        translate([0,0,-length/2]){
            translate([0,-diameter/2,0]){
                cube([diameter/2,diameter,length]);
                
            }
            translate([diameter/2,0,0]){
                cylinder(d=diameter, h=length);
            }
        }
    }
}

module apc_battery_strap_minus(){
    // base mount holes
    for(y=[-(battery_holder_mount_basesize+battery_holder_length)/2,(battery_holder_mount_basesize+battery_holder_length)/2]){
        translate([0,y,0]) cylinder(d=screw_diameter,h=misc_mount_base_thickness);
        translate([0,y,misc_mount_base_thickness]) cylinder(d=screw_head_diameter,h=apc_battery_height);
    }
    // antenna mount holes
    for(y=[-apc_battery_width/2+apc_battery_terminal_offset/2,apc_battery_width/2-apc_battery_terminal_offset/2]){
        translate([0,y,apc_battery_height-misc_mount_base_thickness]){
            m3_nut_plus_bolt(2*misc_mount_base_thickness,2*misc_mount_base_thickness);
        }
    }
    // Wire tracks
    for(y=[-apc_battery_width/2+apc_battery_terminal_offset,apc_battery_width/2-apc_battery_terminal_offset]){
        translate([0,y,apc_battery_height-misc_mount_base_thickness]){
            wire_track(power_wire_diameter,apc_strap_width);
        }
    }
        
}

module apc_battery_strap(){
    difference(){
        apc_battery_strap_plus();
        apc_battery_strap_minus();
    }
}

module antenna_bottom_plus(){
    plate_width=plate_diameter+2*misc_mount_base_thickness;
    hull(){
        translate([-plate_width/2, -plate_width/2,0]){
            cube([plate_width,plate_width,misc_mount_base_thickness+plate_height]);
        }
        translate([-old_battery_holder_length/2-2*misc_mount_base_thickness,plate_front_holes_y-apc_strap_width/2-0.01,0]){
            cube([old_battery_holder_length+4*misc_mount_base_thickness,0.01,misc_mount_base_thickness+plate_height]);
        }
        translate([-plate_width/2-emergency_stop_flange_diameter/2,0,0]){
            cylinder(d=emergency_stop_flange_diameter, h=misc_mount_base_thickness+plate_height);
        }
        translate([plate_width/2,-lcd_board_width/2-2,0]){
            cube([lcd_board_length+4,lcd_board_width+4,misc_mount_base_thickness+plate_height]);
        }
    }
    translate([-old_battery_holder_length/2-2*misc_mount_base_thickness,plate_front_holes_y-apc_strap_width/2,0]){
        cube([old_battery_holder_length+4*misc_mount_base_thickness,apc_strap_width,misc_mount_base_thickness+plate_height]);
    }
}

module antenna_bottom_minus(){
    plate_width=plate_diameter+2*misc_mount_base_thickness;
    // Cutout for the plate
    translate([0,0,misc_mount_base_thickness]){
        difference(){
            cylinder(d=plate_diameter,h=plate_height);
            cylinder(d=plate_hole_diameter,h=plate_height);
        }
    }
    // Cutout for the emergency stop switch
    translate([-plate_width/2-emergency_stop_flange_diameter/2,0,0]){
        cylinder(d=emergency_stop_mount_diamter, h=misc_mount_base_thickness+plate_height);
        translate([-emergency_stop_body_width/2,-emergency_stop_body_length/2,0]){
            cube([emergency_stop_body_width,emergency_stop_body_length,misc_mount_base_thickness]);
        }
    }
    // Cutout for the LCD screen
    translate([plate_width/2+lcd_board_length/2,0,0]){
        // For the screen itself
        translate([-lcd_screen_length/2, -lcd_screen_width/2,0]){
            cube([lcd_screen_length,lcd_screen_width,misc_mount_base_thickness+plate_height]);

        }
        // Make room for the pins that stick up
        translate([-lcd_board_length/2+lcd_pin_offset_x,0,0]){
            cube([lcd_pin_width,lcd_board_width/2-lcd_pin_offset_y,lcd_pin_height]);
        }
        // Make room for the LED bump out
        translate([lcd_screen_length/2,-lcd_led_bump_width/2,0]){
            cube([lcd_led_bump_length,lcd_led_bump_width,lcd_led_bump_height]);
        }
        // Cut out the mounting holes
        for(x=[-lcd_mount_hole_length/2,lcd_mount_hole_length/2]){ 
            for(y=[-lcd_mount_hole_width/2,lcd_mount_hole_width/2]){
                translate([x,y+1,-lcd_board_height]){
                    cylinder(d=screw_diameter,h=8);
                }
            }
        }
    }
    for(deg=[45:90:315]){
        rotate([0,0,deg]){
            translate([plate_diameter/2+2*screw_head_diameter,0,0]){
                cylinder(d=screw_diameter,h=misc_mount_base_thickness+plate_height);
            }
        }
    }
    for(x=[-apc_battery_width/2+apc_battery_terminal_offset/2,apc_battery_width/2-apc_battery_terminal_offset/2]){
        rotate([180,0,0]) screw_hole(x, -plate_back_holes_y, 4, misc_mount_base_thickness+4, "countersunk", 0);
        rotate([180,0,0]) screw_hole(x, -plate_front_holes_y, 4, misc_mount_base_thickness+4, "socket", 0);
    }         
}

module antenna_bottom(){
    difference(){
        antenna_bottom_plus();
        antenna_bottom_minus();
    }
}
    
module rear_axle(){
    translate([0,very_back_y+1.5*wheel_motor_mount_width,0]){
        rotate([0,90,0]){
            translate([0,0,-section_width]){
                cylinder(d=2,h=base_width);
            }
        }
    }
}

module vizualize(){
    translate([0,battery_y,0]){
        rotate([0,0,90]){
            translate([0,0,-5]) battery_mount_clips_mount_holes();
            new_battery_base();
            translate([0,0,misc_mount_base_thickness]) battery_holder_visualized();
        }
    }

    translate([0,very_back_y+1.5*wheel_motor_mount_width,battery_holder_length+3*misc_mount_base_thickness]){
        antenna_bottom();
    }
translate([0,battery_y,battery_holder_length+3*misc_mount_base_thickness]){
    rotate([0,180,0]){
        rotate([0,0,90]){
            new_battery_antenna_mount();
        }
    }
}
    
    translate([0,0,battery_holder_length+3*misc_mount_base_thickness]) rear_axle();
}


//vizualize();
//new_battery_base();
new_battery_antenna_mount();