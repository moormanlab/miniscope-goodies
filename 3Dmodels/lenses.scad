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

