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


module prismBaseHolder(lensD=1,height=3){
  slH = 2;      // height of the encoder strip
  slW = .2;     // width of the encoder strip
  slDist = .15; // focal distance of the lens
  difference(){
    union(){
      difference(){
        lensHolder(lensD,height);
        // lens size
        translate([0,0,height/2])cube([lensD+.2,lensD+.2,height+.1],center=true);
        // encoder strip
        translate([(lensD+slW)/2+0.05/2+slDist,0,slH/2-.001])cube([slW,20,slH],center=true);
        // slot for lens
        translate([(lensD+.1)/4+slDist/2,0,slH/2-.001])cube([(lensD+.1)/2+slDist,lensD+.05,slH],center=true);
      }
      // prism base
      translate([0,0,0])rotate([0,0,180])prism(1.3*lensD);
    }
    // opening for lens holder
    translate([0,0,height-2+.001])cylinder(h=2,d=lensD+1.6,$fn=64);
  }
}

module prismBaseHolderNS(lensD=1,height=3){
  slH = 2;      // height of the encoder strip
  slW = .2;     // width of the encoder strip
  slDist = .15; // focal distance of the lens
  difference(){
    union(){
      difference(){
        lensHolder(lensD,height);
        // lens size
        translate([0,0,height/2])cube([lensD+.2,lensD+.2,height+.1],center=true);
        for (i=[-5:5]) translate([.7,i/10,slH/2])cube([.05,.05,slH+.1],center=true);
        // slot for lens
        translate([(lensD+.1)/4+slDist/2,0,slH/2-.001])cube([(lensD+.1)/2+slDist,lensD+.05,slH+.1],center=true);
      }
      // prism base
      translate([0,0,0])rotate([0,0,180])prism(1.3*lensD);
    }
    // opening for lens holder
    translate([0,0,height-2+.001])cylinder(h=2,d=lensD+1.6,$fn=64);
  }
}

module prismLensHolder(lensD,height=4){
  difference() {
    union(){
      translate([0,0,height-1])cylinder(h=1,d=3+lensD*2,$fn=64);
      cylinder(h=height,d=lensD+1.5,$fn=64);
    }
    translate([0,0,-.01])cylinder(h=height+.02,d=lensD+.05,$fn=64);
    translate([-lensD/2-2,-.1,-.1])cube([lensD+4,lensD+2,height+.2]);

  }
}

prismBaseHolder(1,4);

*translate([0,0,6]){
  prismLensHolder(1,2);
  rotate([0,0,180])prismLensHolder(1,2);
}

*lensHolder(lensD=1,height=3);