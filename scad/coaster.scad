$fn=360;

difference(){
    cylinder(d=101,h=10);
    translate([0,0,8]){
        cylinder(d=95,h=2);
    }
    translate([0,0,6]){
       linear_extrude(height=2){
           text("860",halign="center",valign="center", size=40,font="Droid Sans");
       }
   }
}
