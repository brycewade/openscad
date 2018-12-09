$fn=360;

difference(){
    translate([-47,-23,-2]){
        import("/tmp/Doctor_Who_Weeping_Angel_in_attack_pose/weeping_angel_attacking.stl", convexity=3);
    }
    cylinder(h=65, r1=8, r2=0);
}