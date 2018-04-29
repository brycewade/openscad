$fn=30;

radius=2;
step=0.5;

function point(t=0,r=40,s=15,h=1) =
    [r*sin(s*t),r*cos(s*t),h*t];

module spring(){
    for(t=[0:step:100]){
        echo (t);
        hull(){
            translate(point(t-step)) sphere(r=radius);
            translate(point(t)) sphere(r=radius);
        }
    }
}

difference(){
    cube([50,50,100]);
    spring();
}