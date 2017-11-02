$fn=360;

difference(){
    union(){
        linear_extrude(height=3){
            scale(0.375){
                import("/tmp/VA_outline.dxf");
            }
        }
        
        linear_extrude(height=6){
            scale(0.375){
                import("/tmp/VA_letters.dxf");
            }
        }
    }

    translate([6,30,0]){
        linear_extrude(height=6){
            circle(d=5);
        }
    }
}