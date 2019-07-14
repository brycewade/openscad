$fn=365;

topd=125;
topcornerr=21;
topcornerc=120/2-topcornerr;
bottomd=110;
bspr=5;
bottomcornerc=105/2-bspr;


module top(){
    translate([0,0,21]){
        hull(){
            circle(d=125);
            translate([-topcornerc,-topcornerc,0]) circle(r=topcornerr);
            translate([-topcornerc,topcornerc,0]) circle(r=topcornerr);
            translate([topcornerc,topcornerc,0]) circle(r=topcornerr);
            translate([topcornerc,-topcornerc,0]) circle(r=topcornerr);
        }
    }
}

module bottom(){
    translate([topcornerc,-topcornerc,bspr]) sphere(r=bspr);
}
top();