////-- Lenses holders for MiniScope v4.0
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.0 - April 2021

use <utils.scad>

module lensHolder(lensD=1,height=10){
  dTop = 2+lensD*2;
  dBottom = dTop*2+round(height/5);
  difference(){
    union(){
      cylinder(h=height,d1=dBottom,d2=dTop,$fn=64);
      translate([0,0,.5])cube([dBottom*2,dBottom/2,1],center=true);
    }
    translate([0,0,-.1])cylinder(h=height+.2,d=lensD+.05,$fn=64);
  }
}


module prism(size){
  translate([-size/2,0,0]) difference(){
    translate([0,-size/2,0])cube([size,size,size]);
    rotate([0,-45,0])translate([0,-1.1*size/2,0])cube([1.5*size,1.1*size,size]);
  }
}

module prismLens(D,H){
  cylinder(h=H,d=D,$fn=32);
  rotate([180,0,0])prism(D);
}

module prismLensHolder(lensD,height=4){
  capThick = .7;
  difference() {
    union(){
      translate([0,0,height-capThick+.001])cylinder(h=capThick,d=3+lensD*2,$fn=64);
      cylinder(h=height,d=lensD+1.5,$fn=64);
    }
    translate([0,0,-.01])cylinder(h=height+.02,d=lensD+.05,$fn=64);
    translate([-lensD/2-2,-.1,-.1])cube([lensD+4,lensD+2,height+.2]);
  }
}

module slideHolder(L=80,T=1.4){
  difference(){
    rotate([0,-90,0])cylinder(h=L,d=18,center=true,$fn=3);
    translate([0,0,6])cube([L+1,T,15],center=true);
    translate([0,0,0])cube([L+1,3,3],center=true);
    translate([0,0,7])cube([L+1,4,3],center=true);
  }
}


module prismBase(lensD=1,thick=1.5,height=8){
  slW = 1.4;     // width of the encoder strip //updated 210625
  slDist = .15; // focal distance of the lens
  dx = 5 + lensD;
  dy = 6 + lensD;
  closeL = 2+lensD/2+.2;
  difference(){
    translate([0.5,0,height/2])cube([dx,dy,height],center=true);
    translate([0,0,height-thick])rotate([180,0,0])scale([1,6,1])prism(lensD+1);
    // opening for cap
    translate([0,0,height-thick-.01]) {
      cylinder(h=thick+.02,d=lensD+.1,$fn=64);
      translate([-closeL+.05,-lensD/2-1,-.15])cube([closeL,lensD+2,thick+.5]);
      translate([-closeL/2,0,.15])cube([closeL,lensD+4,.6],center = true);
    }
    translate([(lensD+slW)/2+0.05/2+slDist,0,height/2-thick])cube([slW,dy+1,height],center=true);
    translate([(lensD+slW)/2+0.05/2,0,(height-thick-lensD-1.5)/2+1.5])cube([slW,dy+1,height-thick-lensD-1.5],center=true);
  }
}

module prismBaseCap(lensD=1,thick=1.5) {
  closeL = 2+lensD/2+.2;
  translate([0,0,-thick/2-.05])difference(){
    translate([-closeL/2,0,0])union() {
      r2cube([closeL,lensD+1.9,thick+.1],r=.4,center=true);
      translate([-closeL/2+.5,0,thick/2+.25])cube([1,lensD+.5,.5],center=true);
      translate([-.1,0,-.3])r2cube([closeL-.2,lensD+3.9,.55],r=.5,center=true);
    }
    cylinder(h=thick+.2,d=lensD+.1,$fn=64,center=true);
  }
}

module slidePattern(){
  translate([0,-2.5,0])cube([1.1,5,5.1]);
  for (i=[-5:5]) translate([0,i/10,4.3])cube([.1,.05,1.5],center=true);
}

// for printing
*rotate([0,90,0]) prismBase(1,1,6);
*rotate([0,-90,0]) prismBaseCap(1,1);
