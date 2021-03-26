////-- Holder for MiniScope v4.0
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.0 - March 2021

include <utils.scad>;

module miniscopeToStereotax(){
  deltay = 15;
  mountSizeD = 8.1; //D = 8.1 classic
  mountSizeW = 16;  //W= 12 classic
  
  miniscopeSocketH = -0.7+3;
  miniscopeSocketSG = .8;
  difference(){
    translate([0,mountSizeW/4-.5-deltay/2,1+miniscopeSocketH/2])cube([mountSizeW,deltay+mountSizeW/2-1,2+miniscopeSocketH],center=true);
    translate([0,0,miniscopeSocketSG])cylinder(h=5,d=9.05,$fn=100);
    hull(){
      for(i=[-1,1])
        for(j=[-1,1])
          translate([i*1.5,j*1.5,-.01])cylinder(h=1.52,d=3.1,$fn=60);
    }
    for(i=[0:2])rotate([0,0,i*120-90]) {
      translate([5.38,0,miniscopeSocketSG+.5]){
        cylinder(h=miniscopeSocketH+1,d=2.2,$fn=60);
        translate([-1,0,miniscopeSocketH/2+.5])cube([2,2.2,miniscopeSocketH+1],center=true);
        difference(){
          translate([-1.3,0,miniscopeSocketH/2+.5])cube([2,3,miniscopeSocketH+1],center=true);
          translate([-.31,-2.09,-.1])cylinder(h=miniscopeSocketH+1.2,d=2,$fn=60);
          translate([-.31,2.09,-.1])cylinder(h=miniscopeSocketH+1.2,d=2,$fn=60);
        }
      }
    }
    translate([0,7.5,2.5])cube([1,10,6],center=true);
    translate([0,7.5,2.5+2.5-.2])cube([8,10,6],center=true);
  }

  // screw to fix miniscope
  translate([0,10,4])
  difference(){
    union(){
      translate([0,-2,-2])cube([mountSizeW,4,4],center=true);
      rotate([0,90,0])cylinder(h=mountSizeW,d=8,$fn=100,center=true);  
    }
    translate([mountSizeW/2-1.1,0,0])rotate([0,90,0])nutM3(globShow);
    translate([-mountSizeW/2+2.8,0,0])rotate([0,90,0])screwM3(mountSizeW-3,globShow);
    translate([0,0,0])cube([8,10,10],center=true);
  }
  
  // union
  translate([0,-deltay,0]){
    translate([0,0,15])cube([mountSizeW,4,30],center=true);
    translate([0,2,2+miniscopeSocketH])rotate([45,0,0])cube([mountSizeW,4,4],center=true);
    translate([0,-2,14])rotate([45,0,0])cube([mountSizeW,3.3,3.3],center=true);
  }
  
  // attach to metal rod 
  translate([0,-deltay-8.5,30-8])
  mirror([0,1,0])difference(){
    union(){
      translate([0,2.5,0])cube([mountSizeW,19,16],center=true);
    }
    cylinder(d=mountSizeD,h=16+.1,center=true,$fn=100);
    translate([0,5.5,0])cube([1.5,14,16+.1],center=true);
    translate([0,7.5,0])rotate([0,90,0])cylinder(d=3.06,h=10,center=true,$fn=100);
    translate([mountSizeW/2-1,7,0])rotate([0,90,0])rotate([0,0,0])nutM3(globShow);
    translate([-mountSizeW/2+2.95,7,0])rotate([0,90,0])rotate([0,0,0])screwM3(mountSizeW-3,globShow);
  }
}

miniscopeToStereotax();