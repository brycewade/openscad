$fn=20;
$cmperinch=2.54;

$marginforerror=3;
$theta=30;

$wireholesize=5.75;

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

$hallsensorthickness=1.6+0.5;
$magnetthickness=1.58+0.5;

$buffer=2*($magnetthickness+1);
$basethickness=$hallsensorthickness+2;

$cwt=$bucketwidth/2+$bucketthickness;
$cw=$bucketwidth/2;

//$basewidth=$bucketwidth+$bucketthickness*2+$buffer+$basethickness*2;
$basewidth=$bucketwidth+$bucketthickness*2+$basethickness*2+1;

$sqrt2=sqrt(2);

$ewt=sqrt(($baselength*$baselength)+($baseheight*$baseheight));
$bht=$tantheta*$ewt;

$tb_mount_height=5;

echo("ewt=", $ewt);
echo("bht=", $bht);

$buckethalflength=$ewt-$bucketthickness/2;
$bucketheight=$bht-$bucketthickness;

echo ("buckethalflength=",$buckethalflength);
echo ("bucketheight=",$bucketheight);

$ground_mount=5*$cmperinch;
$ground_mount_outer=$ground_mount+4*$thickness+2*$wireholesize;

$tb_arm_length=($outsideD1+$ground_mount_outer)/2+30;

//=======================================
// Functions
//=======================================
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1],
    BEZ03(u)*p0[2]+BEZ13(u)*p1[2]+BEZ23(u)*p2[2]+BEZ33(u)*p3[2]];
    
  module BezQuadCurve(c, steps, gSize)
{
	for(step = [1:steps])
	{
		hull(){
            translate(PointAlongBez4(c[0], c[1], c[2],c[3], step/steps)) sphere(r=gSize);
            translate(PointAlongBez4(c[0], c[1], c[2],c[3], (step-1)/steps)) sphere(r=gSize);
        }
	}
}

module tb_mount_center(){
    translate([0,0,-$tb_mount_height-$tb_mount_height]) cylinder(r=$cwt*2/3,h=$mountscrewheadheight+$thickness+$tb_mount_height);
}

module mounting_arm(){
    difference(){
        hull(){
            tb_mount_center();
            translate([$outsideD1/4,0,-$tb_mount_height]){
                cylinder(r=$mountscrewheadradius+$thickness, h=$mountscrewheadheight+$thickness);
            }
        }
        translate([$outsideD1/4,0,-$tb_mount_height-$mountscrewheadheight]){
            cylinder(r=$mountscrewheadradius, h=$mountscrewheadheight+$tb_mount_height);
            cylinder(r=$mountscrewradius, h=$mountscrewheadheight+$thickness+$tb_mount_height);
        }
    }
}

module cable_chase(){
    $point1=[$tb_arm_length-$ground_mount_outer/2,$ground_mount_outer/2-$thickness-$wireholesize/2,-$ground_mount_outer/2];
    $point2=[$tb_arm_length-$ground_mount_outer/2-10,$ground_mount_outer/2-$thickness-$wireholesize/2,-$ground_mount_outer/2];
    $point3=[$outsideD1*0.4+$basethickness+10,0,-10];
    $point4=[$outsideD1*0.4+$basethickness,0,0];
    gSteps = 10;
    echo ($point1);
    echo ($point2);
    echo ($point3);
    echo ($point4);
    translate($point1){
            rotate([0,90,0]) {
                cylinder(d=$wireholesize,h=$ground_mount_outer);
            }
        }
        rotate([0,0,180]){
        translate([-$outsideD1*0.4,0,$basethickness]){
            rotate([0,45,0]){
                translate([0,0,-$basethickness*2]){
                    cylinder(d=$wireholesize,h=$basethickness*4);
                }
            }
        }
    }
    BezQuadCurve([$point1,$point2,$point3,$point4], gSteps, $wireholesize/2);
}

module tb_support_arm(){
    difference(){
        hull(){
             tb_mount_center();
            translate([$tb_arm_length-$ground_mount_outer/2,-$ground_mount_outer/2,-$ground_mount_outer+$mountscrewheadheight+$thickness-$tb_mount_height]) {
                cube([$ground_mount_outer,$ground_mount_outer,$ground_mount_outer]);
            }
        }
        translate([$tb_arm_length-$ground_mount/2,-$ground_mount/2,-$ground_mount_outer+$mountscrewheadheight+$thickness-$tb_mount_height]) {
            cube([$ground_mount,$ground_mount,$ground_mount_outer+1]);
        }
    cable_chase();
    }
}

module tb_mount(){
    for(deg=[45:90:360]){
        rotate([0,0,deg]){
            mounting_arm();
        }
    }
    tb_support_arm();
}

tb_mount();
//cable_chase();