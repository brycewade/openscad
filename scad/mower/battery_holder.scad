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
/*
battery_holder_bottom();
translate([0,-5,0]){
    battery_holder_top();
}
*/


module battery_mount_clip(){
    overhang=15;
    offset=7.5;
    basesize=overhang+3*screw_diameter;
    
    difference(){
        union(){
            translate([-basesize+offset,-basesize+offset,0]){
                cube([basesize,basesize,4]);
            }
            translate([-offset,-offset,0]){
                cube([overhang,overhang,battery_holder_height+4]);
            }
        }
        translate([-basesize+offset+1.5*screw_diameter,-basesize+offset+1.5*screw_diameter,0]){
            cylinder(d=screw_diameter, h=battery_holder_height+4);
        }
    }
}

module battery_mount_clips(){
    battery_mount_clip();
    translate([battery_holder_width,0,0]){
        rotate([0,0,90]){
           battery_mount_clip();
        }
    }
    translate([battery_holder_width,battery_holder_length,0]){
        rotate([0,0,180]){
           battery_mount_clip();
        }
    }
    translate([0,battery_holder_length,0]){
        rotate([0,0,270]){
           battery_mount_clip();
        }
    }
}

difference(){
    battery_mount_clips();
    battery_holder_plus();
    battery_holder_minus();
}