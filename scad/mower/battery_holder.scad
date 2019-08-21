$fn=360;

include <mower_measurements.scad>

module battery_holder_plus(){
    cube([battery_holder_width,battery_holder_length,battery_holder_height]);
}

module battery_holder_minus(){
    for(x=[battery_holder_spacing+battery_diameter/2:battery_diameter+battery_holder_spacing:battery_holder_width]){
        for(y=[battery_holder_spacing+battery_diameter/2:battery_diameter+battery_holder_spacing:battery_holder_length]){
            translate([x,y,-5]){
                cylinder(d=battery_diameter,h=battery_height);
            }
        }
    }
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
}

module battery_mount_clips_mount_holes(){
    translate([0,-battery_holder_length/2,0]){
        for(x=[-battery_holder_mount_basesize/2,battery_holder_width+battery_holder_mount_basesize/2]){
            for(y=[-battery_holder_mount_basesize/2,battery_holder_length+battery_holder_mount_basesize/2]){
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