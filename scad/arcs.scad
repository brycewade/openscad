$fn=360;

$bits=5;

module arc($radius, $degrees, $thickness, $height){
    rotate_extrude(angle=$degrees, convexity=10){
        translate([$radius-$thickness/2,0,0]){
            square([$thickness,$height]);
        }
    }
}

module digit(bits, number,radius, thickness, height){
    degrees=360/pow(2,bits);
    echo(number);
    for(bit=[0:bits-1]){
        echo(number,bit);
       if(floor(number/pow(2,bit))%2>0){
           
           arc(radius+2*thickness*bit,degrees,thickness,height);
       }
   }
}

module bit_pattern(){
    for($number=[0:pow(2,$bits)-1]){
        $degrees=360/pow(2,$bits);
        rotate([0,0,$degrees*$number]){
            digit($bits,$number,15,5,5);
        }
    }
}

difference(){
    cylinder(r=15+10*$bits, h=5);
    bit_pattern();
}