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

$thickness=2.4;
$insideD1=125;
$outsideD1=$insideD1+$thickness*2;
$insideD2=10;
$outsideD2=$insideD2+$thickness*2;
$coneheight=($insideD1-$insideD2)/2;
$nozzleheight=15;
$insidelip=$outsideD1+4;

$bucketthickness=3;
$bucketwidth=$insideD2+$marginforerror+$bucketthickness*2;
//$bucketwidth=20;

$mountscrewradius=1.5;
$mountscrewheadradius=2.7;
$mountscrewheadheight=3;
$nutwidth=5.4;
$nutheight=2.25;

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

module outershell_lip(){
    translate([0,0,$coneheight+$nozzleheight+2*$baseheight+$buffer]){
            cylinder(d=$insidelip, h=$basethickness*2);
    }
}
module screwmountcurve($r){
    difference(){
        translate([0,-2*$r,0]){
            square([$r,4*$r]);
        }
        translate([$r,-2*$r,0]){
            circle(r=$r);
        }
        translate([$r,2*$r,0]){
            circle(r=$r);
        }
    }
    translate([$r,0,0]){
        circle(r=$r);
    }
}

module screwmount(){
    rotate([0,0,180]){
        difference(){
            union(){
                difference(){
                    union(){
                        linear_extrude(height=$basethickness*2){
                            screwmountcurve($thickness+$mountscrewradius);
                        }
                        translate([0,0,$basethickness*2]){
                            linear_extrude(height=2*($thickness+$mountscrewradius),scale=[0.01,0.01]){
                                screwmountcurve($thickness+$mountscrewradius);
                            }
                        }
                        
                    }
/*
                    translate([$thickness+$mountscrewradius,-$nutwidth/2,$basethickness]){
                        cube([$thickness+$mountscrewradius,$nutwidth,$nutheight]);           
                    }
                    translate([$thickness+$mountscrewradius,0,$basethickness]){
                        cylinder(d=$nutwidth*2/sqrt(3),h=$nutheight,$fn=6);
                    }
*/
                }
/*
// Put some supports in there
                translate([$thickness+$mountscrewradius,0,$basethickness]){
                    for(deg=[30:60:360]){
                        rotate([0,0,deg]){
                            translate([-0.2,0,0]){
                                cube([0.4,$nutwidth/sqrt(3)-.5,$nutheight]);
                            }
                        }
                    }
                }
                translate([$thickness+$mountscrewradius,-0.2,$basethickness]){
                    cube([$thickness+$mountscrewradius,0.4,$nutheight]);
                }
*/
            }
            translate([$thickness+$mountscrewradius,0,0]){
                cylinder(r=$mountscrewradius,h=2*$basethickness);
            }            
        }
    }
}

module conemounts(){
    for(deg=[45:90:360]){
        rotate([0,0,deg]){
            translate([$outsideD1/2,0,$coneheight+$nozzleheight+2*$baseheight+$buffer-$basethickness]){
                rotate([180,0,0]){
                    screwmount();
                }
            }
        }
    }
}

module cone(){
    difference(){
        union(){
            cone_outside();
            difference(){
                outershell_outside();
                outershell_inside();
                outershell_lip();
            }
        }
        cone_inside();
    }    
    conemounts();
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
    translate([0,0,-1]){
        intersection(){
            translate([-$cwt,$baselength,0]) {
                mesh_holes($cwt*2,$insideD1/2-$baselength-$basethickness,$basethickness+2,2,7,6);
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
        cube([$basethickness,$outsideD1,$baseheight+$pivotradius*2]);
    }
    translate([-$basewidth/2,-$outsideD1/2,0]){
        cube([$basewidth,$basethickness,$baseheight]);
    }
}

module basecircle(){
    difference(){
        union(){
            difference(){
                cylinder(d=$insidelip, h=$basethickness*2);
                translate([0,0,$basethickness]){                    
                    cylinder(d=$outsideD1-$thickness*2,h=$basethickness+1);
                }
                
            }
            for(deg=[45:90:360]){
                rotate([0,0,deg]){
                   translate([$outsideD1/2,0,0]){
                       rotate([0,0,180]) {
                           linear_extrude(height=$basethickness*2){
                               screwmountcurve($thickness+$mountscrewradius);
                           }
                       }
                   } 
                }
            }
        }
// main drain mesh
        mesh();
// mounting screw holes
        rotate([0,0,180]) mesh();
        for(deg=[45:90:360]){
            rotate([0,0,deg]){
                translate([$outsideD1/4,0,-1]){
                    cylinder(r=$mountscrewradius,h=$basethickness*2);
                }
                translate([$outsideD1/2-($thickness+$mountscrewradius),0,-1]){
                    cylinder(r=$mountscrewradius,h=$basethickness*3);
                    cylinder(r=$mountscrewheadradius,h=$mountscrewheadheight+1);
                }
            }
        }
// drain holes
        for(deg=[45:90:360]){
            rotate([0,0,deg]){
                translate([(($outsideD1/4)+($outsideD1/2-($thickness+$mountscrewradius)))/2,-1,-1]){
                    cube([2,2,$basethickness+2]);
                }
            }
        }
// wire hole
        translate([-$outsideD1*0.4,-$wireholesize/2,-1]){
            cube([$wireholesize,$wireholesize,$basethickness*2]);
        }
    }
}

module basesupport(){
    translate([]){
        difference(){
            union(){
                basewall();
                rotate([0,0,180]) basewall();
                translate([-$basewidth/2,0,$baseheight+$pivotradius*2]){
                    hallsensorsupport();
                }
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
}

module base(){
    intersection(){
        union(){
            basecircle();
            basesupport();
        }
        translate([0,0,$coneheight+$nozzleheight+2*$baseheight+$buffer+$basethickness]){
            rotate([180,0,0]){
                union(){
                    outershell_inside();
                    outershell_lip();
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


bucket();

