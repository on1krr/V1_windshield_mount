w=20;
l=100;
base_h = 5;
gap_h = 10;
cap_d = 15;
cap_h = 5;

smooth = 1;

$fn=100;

//base
cylinder(d=w,h=base_h,center=false);
translate([l-w,0,0]) cylinder(d=w,h=base_h,center=false);
translate([0,-w/2,0]) cube([l-w,w,base_h]);

//posts
translate([0,0,base_h])cylinder(d=5,h=gap_h,center=false);
translate([l-w,0,base_h])cylinder(d=5,h=gap_h,center=false);

//caps
translate([0,0,base_h+gap_h]) minkowski(){ cylinder(d=cap_d-2*smooth,h=cap_h-2*smooth,center=false); sphere(2);}
translate([l-w,0,base_h+gap_h]) minkowski() { cylinder(d=cap_d-2*smooth,h=cap_h-2*smooth,center=false); sphere(2);}
