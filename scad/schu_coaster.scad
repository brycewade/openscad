$fn=360;

difference(){
    cylinder(d=101,h=10);
    translate([0,0,8]){
        cylinder(d=95,h=2);
    }
    translate([0,0,6]){
       linear_extrude(height=2){
           text("schü",halign="center",valign="center", size=25,font="Droid Sans");
       }
   }
}
