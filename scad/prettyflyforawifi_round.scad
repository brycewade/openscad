$fn=360;

difference(){
    cylinder(r=50, h=5);
    translate([-37.5,-37.5,5]){
        scale([75/350,75/350,0.01]){
            surface(file="/home/vagrant/openscad/images/qr.png", invert=true);
        } 
    }
}
