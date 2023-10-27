smooth = 1;

base_w=20;
base_l=100;
base_h = 4;

gap_h = 4;

cap_d = 12;
cap_h = 4;

post_d = 5;


//clip_w = 12-2*smooth;
//clip_l = 98;
//clip_h = 4-2*smooth;

clip_w = 12;
clip_l = 98;
clip_h = 4;

angle_l = 65;
angle = 15;

screw_d = 2.25;
screw_offset_l = 15;
screw_offset_ctr=clip_w/2-3.25;

clear = 0.2;
delta = 0.01;
$fn=100;

module base() {
    //base
    cylinder(d=base_w,h=base_h,center=false);
    translate([base_l-base_w,0,0]) cylinder(d=base_w,h=base_h,center=false);
    translate([0,-base_w/2,0]) cube([base_l-base_w,base_w,base_h]);

    //posts
    translate([0,0,base_h])cylinder(d=post_d,h=gap_h,center=false);
    translate([base_l-base_w,0,base_h])cylinder(d=post_d,h=gap_h,center=false);

    //caps
    translate([0,0,base_h+gap_h+smooth]) minkowski(){ cylinder(d=cap_d-2*smooth,h=cap_h-2*smooth,center=false); sphere(smooth);}
    translate([base_l-base_w,0,base_h+gap_h+smooth]) minkowski() { cylinder(d=cap_d-2*smooth,h=cap_h-2*smooth,center=false); sphere(smooth);}
}

module smooth_clip() {
    difference() {
        minkowski() {
        union() {
            //base
            cylinder(d=clip_w,h=clip_h,center=false);
            translate([clip_l-clip_w,0,0]) cylinder(d=clip_w,h=clip_h,center=false);
            translate([0,-clip_w/2,0]) cube([clip_l-clip_w,clip_w,clip_h]);
        }
        sphere(smooth);
        }

    //posts
    translate([0,0,-smooth-delta])cylinder(d=post_d,h=gap_h+2,center=false);
    translate([-post_d/2,0,-smooth-delta])cube([post_d,clip_w,clip_h+3*smooth]);

    translate([clip_l-clip_w,0,-smooth-delta])cylinder(d=post_d,h=gap_h+3*smooth,center=false);
    translate([clip_l-clip_w-post_d/2,0,-smooth-delta])cube([post_d,clip_w,clip_h+3*smooth]);

    }
 }
 
 module clip() {
    difference() {
        union() {
            //base
            translate([-2,0,0])cylinder(d=clip_w,h=clip_h,center=false);
            translate([clip_l-clip_w-4,0,0]) cylinder(d=clip_w,h=clip_h,center=false);
            translate([-2,-clip_w/2,0]) cube([clip_l-clip_w-2,clip_w,clip_h]);
            translate([(clip_l-2*clip_w-angle_l-2),-clip_w/2+tan(angle-5)*clip_h,0])rotate([angle,0,0])cube([angle_l,clip_w,clip_h]);
        }

    //posts
    translate([0,0,-delta])cylinder(d=post_d+clear,h=2*gap_h,center=false);
    translate([-(post_d+clear)/2,0,-delta])cube([post_d+clear,clip_w,clip_h+3]);

    translate([base_l-base_w,0,-delta])cylinder(d=post_d+clear,h=2*gap_h,center=false);    
    translate([base_l-base_w-(post_d+clear)/2,0,-delta])cube([post_d+clear,clip_w,clip_h+3]);
    
    //screw_holes
    translate([screw_offset_l,-screw_offset_ctr,-delta])cylinder(d=screw_d,h=2*gap_h,center=false);
    translate([base_l-base_w-post_d/2-screw_offset_l,-screw_offset_ctr,-delta])cylinder(d=screw_d,h=2*gap_h,center=false);
        
    }
 }
 
// base();
 translate([0,0,base_h]) color("green",1.0) clip();
 