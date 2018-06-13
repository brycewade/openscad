/*linear_extrude(height=5){
    square(100);
}
translate([0,0,5]){
    linear_extrude(height=5){
        !surface(file="/home/vagrant/openscad/images/qr.png", invert=false);
    }
}
*/

scale([2/7,2/7,0.1]){
    surface(file="/home/vagrant/openscad/images/qr.png", invert=false);
}
translate([1,1,0]){
    cube([98,98,5]);
}
