include <threads.scad>

$fn=360;

$mm_per_inch=25.4;

$total_height=35;
$shaft_internal_diameter=4.57;
$shaft_external_diameter=9.5;

$compression_thread_inner_height=9.5;
$compression_thread_inner_diameter=14.2;
$compression_thread_outer_height=$compression_thread_inner_height+5;
$compression_thread_outer_diameter=17.31;


$flange_diameter=11.5;
$flange_height=3;

$needle_thread_height=6.5;
$needle_thread_diameter=10.8;
$needle_thread_flange_height=$needle_thread_height+3;
$needle_thread_outer_diameter=$needle_thread_diameter+4;

module needle_thread(){
    translate([0,0,$total_height-$needle_thread_flange_height]){
        difference() {
            union(){
                linear_extrude(height=$needle_thread_flange_height){
                    circle(d=$needle_thread_outer_diameter);
                }
                translate([0,0,$shaft_external_diameter-$needle_thread_outer_diameter]){
                    linear_extrude(height=$needle_thread_outer_diameter-$shaft_external_diameter, scale=$needle_thread_outer_diameter/$shaft_external_diameter){
                        circle(d=$shaft_external_diameter);
                    }
                }
                for(deg=[0:45:360]){
                rotate(a=[0,0,deg]){
                    translate([$needle_thread_outer_diameter/2,0,1]){
                      linear_extrude(height=$needle_thread_height-2){
                            circle(r=1);
                        }
                    } 
                } 
            }
            }
            translate([0,0,4]){
                metric_thread($needle_thread_diameter,4.22/3,$needle_thread_height);
            }
        }
    }
}

module flange(){
    linear_extrude($flange_height){
        circle(d=$flange_diameter);
    }
    translate([0,0,$flange_height]){
        linear_extrude(height=$flange_height,scale=0.5){
            circle(d=$flange_diameter);
        }
    }
}

module shaft(){
    linear_extrude($total_height-$needle_thread_flange_height){
        circle(d=$shaft_external_diameter);
    }
}

module compression_thread(){
    difference(){
        union(){
            linear_extrude($compression_thread_inner_height){
                circle(d=$compression_thread_outer_diameter);
            }
            translate([0,0,$compression_thread_inner_height]){
                linear_extrude(height=5,scale=0.75){
                    circle(d=$compression_thread_outer_diameter);
                }
            }
            for(deg=[0:45:360]){
                rotate(a=[0,0,deg]){
                    translate([$compression_thread_outer_diameter/2,0,1]){
                      linear_extrude(height=$compression_thread_inner_height-2){
                            circle(r=1);
                        }
                    } 
                } 
            }
        }
        linear_extrude($compression_thread_outer_height){
            circle(d=$shaft_external_diameter+1);
        }
        translate([0,0,$compression_thread_inner_height]){
        linear_extrude(height=$flange_height,scale=0.5){
            circle(d=$compression_thread_inner_diameter);
        }
    }
        translate([0,0,-1]){
            metric_thread($compression_thread_inner_diameter,5.10/5,$compression_thread_inner_height+1);
        }
    }
}


difference(){
    union(){
        
        flange();
        shaft();
        needle_thread();        
    }
    
    translate([0,0,-2.5]){
        linear_extrude($total_height+5){
            circle(d=$shaft_internal_diameter);
        }
    } 
}

compression_thread();
