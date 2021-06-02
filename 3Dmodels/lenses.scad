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


module slideHolder(){
  difference(){
    rotate([0,-90,0])cylinder(h=80,d=18,center=true,$fn=3);
    translate([0,0,6])cube([81,1.1,15],center=true);
    translate([0,0,0])cube([81,3,3],center=true);
    translate([0,0,7])cube([81,4,3],center=true);
  }
}


module prismBase(lensD=1,thick=2,height=8){
  slW = 1.2;     // width of the encoder strip
  slDist = .15; // focal distance of the lens
  dx = 4 + lensD;
  capThick = 0.7;  //should be the same as in cap prismLensHolder
  difference(){
    translate([0.25,0,height/2])cube([dx+.5,dx,height],center=true);
    translate([0,0,height-thick+capThick])rotate([180,0,0])scale([1,6,1])prism(lensD+1);
    // opening for lens holder
    translate([0,0,height-thick+capThick-.01])cylinder(h=thick-capThick+.02,d=lensD+1.6,$fn=64);
    translate([(lensD+slW)/2+0.05/2+slDist,0,height/2-thick+capThick])cube([slW,dx+1,height],center=true);
  }
}

module slidePattern(){
  translate([0,-2.5,0])cube([1.1,5,5.1]);
  for (i=[-5:5]) translate([0,i/10,4.3])cube([.1,.05,1.5],center=true);
}
