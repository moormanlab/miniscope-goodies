////-- BasePlate with lens guide for MiniScope v4.0
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.1 - March 2021

use <utils.scad>;

module wing() {
  difference(){
    union(){ 
      cube([1.5,2,1],center=true);
      translate([0,1,0])cube([2.5,1,1],center=true);
    }
    
    //rounding
    translate([1.25,.5,0])cylinder(h=1.0001,d=1,$fn=60,center=true);
    translate([-1.25,.5,0])cylinder(h=1.001,d=1,$fn=60,center=true);
    
    //slots for dental cement
    for (i=[1,-1]){
      translate([i*.8,.15,0])cylinder(h=1.0001,d=.5,$fn=60,center=true);
      translate([i*.8,-.55,0])cylinder(h=1.0001,d=.5,$fn=60,center=true);
    }
  }
}

module basePlate (lensD=.5,bottomTick=0.25,gap=.5,sleeve=false) {
  //lensD: between .2 and 1.5
  //bottomTick: between .5 and 1?
  //gap: non negative [0,inf)
  //sleeve: true if miniscope is using sleeve, false otherwise
  
  setScrewD = 1.7;   //var1: 1.2  var2: 1.77// var2/sleeve 2-56 or M2-0.4, 3mm long set screw
  setScrewL = 3; //1/8" ??? 3.175??
  holeL = (sleeve==true ? 5.0 : 4.0); // 5.06 or 4.96
  wallThick = .75;
  guideL = .75;

  p1 = (sleeve==true ? 1.5 : 1.0);
  d1 = 2+wallThick*2;
  d2 = 2+.06;
  
  difference(){
    union(){
      //body
     hull(){
        for(i=[-1,1])
          for(j=[-1,1])
            translate([i*p1,j*p1,-bottomTick])cylinder(h=3+bottomTick+gap,d=d1,$fn=100);
      }
      
      //wall for screw
      translate([p1-.2,p1-.2,1.25+gap])
      rotate([0,90,45])cylinder(h=setScrewL+d2/2+.3,d=3.5,$fn=100);
      
      //wings
      translate([0,-1-holeL/2-wallThick,.5])wing();
      for (i=[0:3])rotate([0,0,i*90])translate([0,-1-holeL/2-wallThick,.5])wing();
      for (i=[0:2])rotate([0,0,i*90-135])translate([0,-1-holeL/2-wallThick,1.5])wing();
      
      //lens guide
      translate([0,0,-bottomTick-guideL/2])cylinder(h=guideL,d2=max(2,lensD+1.2),d1=lensD+.8,$fn=100,center=true);      
    }
    
    //miniscope chamber
    hull(){
      for(i=[-1,1])
        for(j=[-1,1])
          translate([i*p1,j*p1,0])cylinder(h=3.01+gap,d=d2,$fn=60);
    }

    //lens hole
    translate([0,0,-2])cylinder(h=5,d=lensD+.2,$fn=100, center=true);
    
    //screw hole
    translate([(sqrt(2)+holeL/2-1)*sin(45)-.5,(sqrt(2)+holeL/2-1)*sin(45)-.5,1.25+gap])rotate([0,90,45])cylinder(h=setScrewL+1,d=setScrewD,$fn=100);
    
  }
}


module cap(sleeve=false) {
  //sleeve: true if miniscope is using sleeve, false otherwise

  p1 = (sleeve==true ? 1.5 : 1.0);

  hull(){
    for(i=[-1,1])
      for(j=[-1,1])
        translate([i*p1,j*p1,3])cylinder(h=1.5,d=4,$fn=100);
  }
  hull(){
    for(i=[-1,1])
      for(j=[-1,1])
        translate([i*p1,j*p1,0])cylinder(h=3,d=2,$fn=60);
  }
  
}


translate([0,0,0])
basePlate(lensD=1.,bottomTick=.3,gap=1.0,sleeve=true);
*translate([0,0,6])
cap(sleeve=true);

