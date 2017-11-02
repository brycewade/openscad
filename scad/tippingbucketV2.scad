include <threads.scad>

$fn=360;
$cmperinch=2.54;

$marginforerror=3;
$theta=30;

$magnetd=6.38+0.5;
$magnetthickness=1.58+0.5;
$magnetholderwidth=10;

$hallsensorwidth=4.53+0.5;
$hallsensorthickness=1.6+0.5;
$hallsensorheight=4.78;
$hallsensorpinwidth=3.2;
$hallsensorpinheight=14.76;

$threadpitch=2;
$threadstarts=1;

$wireholesize=5;

$thickness=3;
$insideD1=125;
$outsideD1=$insideD1+$thickness*2;
$insideD2=10;
$outsideD2=$insideD2+$thickness*2;
$coneheight=$insideD1-$insideD2;
$nozzleheight=15;

$bucketthickness=3;
$bucketwidth=$insideD2+$marginforerror+$bucketthickness*2;
//$bucketwidth=20;

$mountscrewradius=1.5;

$buffer=2*($magnetthickness+1);
$basethickness=$hallsensorthickness+2;

$cwt=$bucketwidth/2+$bucketthickness;
$cw=$bucketwidth/2;

//$basewidth=$bucketwidth+$bucketthickness*2+$buffer+$basethickness*2;
$basewidth=$bucketwidth+$bucketthickness*2+$basethickness*2+1;

$sqrt2=sqrt(2);
$tantheta=tan($theta);
$baseheight=($insideD2+$marginforerror)/$tantheta;
$baselength=$baseheight/$tantheta;
echo("Base height=", $baseheight);
echo("Base length=", $baselength);
$pivotradius=0.76;

$ewt=sqrt(($baselength*$baselength)+($baseheight*$baseheight));
$bht=$tantheta*$ewt;

echo("ewt=", $ewt);
echo("bht=", $bht);

$buckethalflength=$ewt-$bucketthickness/2;
$bucketheight=$bht-$bucketthickness;

echo ("buckethalflength=",$buckethalflength);
echo ("bucketheight=",$bucketheight);

module cone_inside(){
    cylinder(d1=$insideD1,d2=$insideD2,h=$coneheight);
    translate([0,0,$coneheight]) cylinder(d=$insideD2,h=$nozzleheight);
}

module cone_outside(){
    cylinder(d1=$outsideD1,d2=$outsideD2,h=$coneheight);
    translate([0,0,$coneheight]) cylinder(d=$outsideD2,h=$nozzleheight);
}

module outershell_outside(){
    cylinder(d1=$outsideD1,d2=$outsideD1+2*$thickness*2,h=$coneheight+$nozzleheight+2*$baseheight+$buffer+$basethickness);
}

module outershell_inside(){
    cylinder(d1=$insideD1,d2=$outsideD1,h=$coneheight+$nozzleheight+2*$baseheight+$buffer+$basethickness*2);
}

module outershell_threads(){
    translate([0,0,$coneheight+$nozzleheight+2*$baseheight+$buffer+$basethickness]){
        rotate([180,0,0]){
// I'm still not sure why I have to mirror this, but...
            mirror([1,0,0]){
                metric_thread($outsideD1+2+2.25,$threadpitch,$basethickness*2,internal=true,n_starts=$threadstarts,thread_size=2*$threadpitch);
            }
        }
    }
}

module cone(){
    difference(){
        cone_outside();
        cone_inside();
    }
    difference(){
        outershell_outside();
        outershell_inside();
        outershell_threads();
    }
}

 module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
 }
 
module buckethalf(){
    difference(){
        polyhedron(points=[[$cwt,$ewt,0],[-$cwt,$ewt,0],[-$cwt,0,0],[$cwt,0,0],[$cwt,0,$bht],[-$cwt,0,$bht]],faces=[[1,5,2],[0,3,4],[0,1,2,3],[0,4,5,1],[3,2,5,4]]);
        translate([-$cw,$bucketthickness/2,$bucketthickness]){
            cube([$bucketwidth,$buckethalflength,$bucketheight]);
        }
    }
}


module bucket(){
    difference(){
        union(){
            buckethalf();
            rotate([0,0,180]) buckethalf();
            translate([0,0,2*$pivotradius]){
                rotate([0,90,0]){
                    translate([0,0,-$cwt]){
                        cylinder(r=2*$pivotradius,h=2*$cwt);
                    }
                }
            }
            translate([$cwt-$buffer/2,-$magnetholderwidth/2,0]) {
                cube([$buffer/2,$magnetholderwidth,1.25*$bht]);
            }
        }
        translate([$cwt-$buffer/2+0.5,-$magnetd/2,1.25*$bht-$magnetd-2]) {
            cube([$magnetthickness,$magnetd,$magnetd+2]);
        }
        translate([0,0,2*$pivotradius]){
            rotate([0,90,0]){
                translate([0,0,-$cwt]){
                    cylinder(r=$pivotradius,h=2*$cwt);
                }
            }
        }
    }
    
}

module mesh_holes($width,$length,$height,$ratio,$columns,$rows){
    $whole=$width/($columns+($columns-1)/$ratio);
    $wfill=$whole/$ratio;
    $lhole=$length/($rows+($rows-1)/$ratio);
    $lfill=$lhole/$ratio;
    $winc=$whole+$wfill;
    $linc=$lhole+$lfill;
    echo($whole,$winc,$width);
    echo($lhole,$linc,$length);
    for(x=[0:$winc:$width]){
        for(y=[0:$linc:$length]){
            echo("Hole at ",x,",",y);
            translate([x,y,0]) cube([$whole,$lhole,$height]);
        }
    }
}

module mesh(){
    translate([0,0,-$basethickness*2]){
        intersection(){
            translate([-$cwt,$baselength,0]) {
                mesh_holes($cwt*2,$insideD1/2-$baselength-$basethickness,$basethickness*3,2,7,6);
            }
            cylinder(d=$insideD1,h=$basethickness*3);
        }
    }
}

module basewedge(){
    linear_extrude(height=$basethickness,scale=[1,0]){
            square([$basethickness,4*$basethickness]);
    }
}

module hallsensor(){
    translate([-$hallsensorthickness,-$hallsensorwidth/2,-$hallsensorheight/2]){
        cube([$hallsensorthickness,$hallsensorwidth,$hallsensorheight+10]);
    }
    translate([-$hallsensorthickness,-$hallsensorpinwidth/2,-$hallsensorheight/2-$hallsensorpinheight]){
        cube([$hallsensorthickness+2,$hallsensorpinwidth,$hallsensorpinheight*.75]);
        cube([$hallsensorthickness,$hallsensorpinwidth,$hallsensorpinheight*2]);
    }
}

module hallsensorsupport(){
    translate([0,0,-4*$basethickness]){
        difference(){
            translate([0,-$hallsensorwidth/2-$basethickness,$basethickness]){
                cube([$basethickness,$hallsensorwidth+$basethickness*2,1.25*$bht+$basethickness*2]);
            }
            translate([0,-4*$basethickness,0]){
                cube([$basethickness,8*$basethickness,4*$basethickness]);
            }
            translate([1,0,1.25*$bht+$basethickness*2-$magnetd/2]){
                rotate([0,0,180]) hallsensor();    
            }
        }
    }
}
    
module basewall(){
    translate([-$basewidth/2,-$outsideD1/2,0]){
        cube([$basethickness,$outsideD1,$baseheight]);
    }
    translate([-$basewidth/2,-$outsideD1/2+$basethickness,0]){
        cube([$basewidth,$basethickness,$baseheight]);
    }
    translate([-$basewidth/2,-$buckethalflength*1.1,$baseheight]){
        cube([$basethickness,$buckethalflength*2.2,$pivotradius*2]);
    }
}
module base(){
    difference(){
        translate([0,0,-$basethickness]){
            metric_thread($outsideD1+2,$threadpitch,$basethickness*2,internal=false,n_starts=$threadstarts,thread_size=2*$threadpitch);
        }
        cylinder(d=$outsideD1-$basethickness*2,h=$basethickness+1);
// main drain mesh
        mesh();
// mounting screw holes
        rotate([0,0,180]) mesh();
        for(deg=[45:90:360]){
            rotate([0,0,deg]){
                translate([$outsideD1/4,0,-$basethickness-1]){
                    cylinder(r=$mountscrewradius,h=$basethickness*2);
                }
            }
        }
// drain holes
        for(deg=[45:90:360]){
            rotate([0,0,deg]){
                translate([$outsideD1*0.4,-1,-$basethickness*2]){
                    cube([2,2,$basethickness*3]);
                }
            }
        }
// wire hole
        translate([-$outsideD1*0.4,-$wireholesize/2,-$basethickness*2]){
            cube([$wireholesize,$wireholesize,$basethickness*3]);
        }
    }
    difference(){
        intersection(){
            union(){
                basewall();
                translate([-$basewidth/2,0,$baseheight+$pivotradius*2]){
                    hallsensorsupport();
                }
                rotate([0,0,180]) basewall();
            }
            outershell_inside();
        }
        translate([0,0,$baseheight]){
            rotate([0,90,0]){
                translate([0,0,-$basewidth/2]){
                    cylinder(r=$piviotradius*1.1,h=$basewidth);
                }
            }
        }
    }
}

module stickthecone(){
    
        cylinder(d=$insideD1-5,h=0.5);
        for(deg=[0:11.25:360]){
            rotate([0,0,deg]){
                cube([$outsideD1/2,0.8,0.5]);
            }
        }
    
}

/*    
translate([0,0,$baseheight]) {
   rotate([0,0,180]){
       translate([0,0,-2*$pivotradius]) bucket();
   }
}

base();


*/
rotate([180,0,0]) {
    intersection(){
        translate([-($outsideD1+2*$thickness*2),-($outsideD1+2*$thickness*2),-$basethickness]){
            cube([2*($outsideD1+2*$thickness*2),2*($outsideD1+2*$thickness*2),$basethickness*3]);
        }
        translate([0,0,$coneheight+$nozzleheight+2*$baseheight+$buffer]){
            rotate([180,0,0]) {
                cone();
            }
        }
    }
}


//cone();
//stickthecone();