smooth = 1;

base_w=20;
base_l=100;
base_h = 4;

gap_h = 4.2;

cap_d = 12;
cap_h = 4;

post_d = 5;


//clip_w = 12-2*smooth;
//clip_l = 98;
//clip_h = 4-2*smooth;

clip_w = 12;
clip_l = 99.5;
clip_h = 4;
mount_space = 50;

angle_l = 65;
angle = 30;

screw_d = 2.75;
screw_offset_l = 15;
screw_offset_ctr=clip_w/2-3.25;
//screw_offset_ctr=50;

clear = 1.1;
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
            translate([(clip_l-2*clip_w-angle_l-3),-clip_w/2,-5])rotate([angle,0,0])cube([angle_l,clip_w+5,clip_h+5]); 
            //translate([(base_l-clip_l)/2,-clip_w/2,-5])rotate([angle,0,0])cube([angle_l,clip_w+5,clip_h+5]); 
        }
    //text    
//    translate([base_l/2-base_w/2,0, base_h+0.5])rotate([-angle,0,180])linear_extrude(10)text(text=str(angle),size=8,halign="center",valign="center");
    translate([base_l/2-base_w/2,0,-delta])mirror([1,0,0])linear_extrude(0.4)text(text=str(angle),size=8,halign="center",valign="center");

    //angle leanup
    //translate([base_l/2,,base_w/2,0])cube(100,100,100);
    translate([0,clip_w/2,-delta]) cube(100);
    translate([0,-clip_w/2-100,-delta]) cube(100);
    translate([0,-clip_w/2-50,-100]) cube(100);
        
    //post cuts
    translate([0,0,-delta])cylinder(d=post_d+clear,h=2*gap_h,center=false);
    translate([-(post_d+clear)/2,0,-delta])cube([post_d+clear,clip_w,clip_h+3]);

    //cuts to the edge
    translate([base_l-base_w,0,-delta])cylinder(d=post_d+clear,h=2*gap_h,center=false);    
    translate([base_l-base_w-(post_d+clear)/2,0,-delta])cube([post_d+clear,clip_w,clip_h+3]);

    //cuts to allow for rounded inside corners
    translate([-(post_d+clear)/2-1.5,clip_w/2-1.25,-delta])cube([(post_d+clear+2.5),2,clip_h+3]);
    translate([base_l-base_w-(post_d+clear-1.8),clip_w/2-1,-delta])cube([(post_d+clear+2.4),2,clip_h+3]);
    
    //screw_holes
//    translate([screw_offset_l,-screw_offset_ctr,-delta])cylinder(d=screw_d,h=2*gap_h,center=false);
//    translate([base_l-base_w-post_d/2-screw_offset_l,-screw_offset_ctr,-delta])cylinder(d=screw_d,h=2*gap_h,center=false);

//    translate([base_l/2-mount_space/2-base_w/2,-screw_offset_ctr,-delta])cylinder(d=screw_d,h=2*gap_h,center=false);
//    translate([base_l/2+mount_space/2-base_w/2,-screw_offset_ctr,-delta])cylinder(d=screw_d,h=2*gap_h,center=false);
        
    translate([clip_l/2-25-10,-screw_offset_ctr,-delta])cylinder(d=screw_d,h=2*gap_h,center=false);
    translate([clip_l/2+25-10,-screw_offset_ctr,-delta])cylinder(d=screw_d,h=2*gap_h,center=false);
        
    }
    color("red",1.0) translate([(post_d+clear)/2+1,clip_w/2-1,0]) cylinder(d=2,h=clip_h,center=false);
    color("red",1.0) translate([-(post_d+clear)/2-1,clip_w/2-1.4,0]) cylinder(d=2,h=clip_h,center=false);

    color("red",1.0) translate([clip_l-clip_w-5.45-(post_d+clear),clip_w/2-1,0]) cylinder(d=2,h=clip_h,center=false);
    color("red",1.0) translate([clip_l-clip_w-3.45,clip_w/2-1.05,0]) cylinder(d=2,h=clip_h,center=false);
 }
 
 
//base();
clip();
//translate([0,0,base_h]) color("green",1.0) clip();

/*
difference() { 
union() {  
    base();
    //clip();
    translate([0,0,base_h]) color("green",1.0) clip();
}
    translate([-25,-25,base_h+2]) cube([150,100,8]);
}
*/