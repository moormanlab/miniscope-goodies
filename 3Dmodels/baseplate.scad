////-- BasePlate with lens guide for MiniScope v4.0
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.1 - March 2021

include <utils.scad>

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


module basePlateHolder(sleeve=true, lenght=20){
  //sleeve: true if miniscope is using sleeve, false otherwise
  //lenght: distance between attach to rod and baseplate
  
  mountSizeW = 16;
  mountSizeD = 8.1;

  p1 = (sleeve==true ? 1.5 : 1.0);

  hull(){
    for(i=[-1,1])
      for(j=[-1,1])
        translate([i*p1,j*p1,0])cylinder(h=3,d=2,$fn=100);
  }
  translate([0,0,3]){
    hull(){
      for(i=[-1,1])
        for(j=[-1,1])
          translate([i*1.5,j*1.5,0])cylinder(h=16+lenght,d=4,$fn=100);
    }
    difference(){
      translate([0,-3.5,8+lenght])cube([11,4,16],center=true);
      for(i=[-1,1])
        translate([i*5.5,2-3.5,-.1])cylinder(h=16+lenght+.2,d=4,$fn=150);
    }
  }
  
  // attach to rod
  translate([0,-7-3.5,11+lenght])
  rotate([0,0,180])
  difference(){
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


module cap(sleeve=false) {
  //sleeve: true if miniscope is using sleeve, false otherwise

  holeL = (sleeve==true ? 5.0 : 4.0); // 5.06 or 4.96
  p1 = (sleeve==true ? 1.5 : 1.0);

  //difference(){
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



module lensHolder(lensD=1,height=10){
  dTop = 2+lensD*2;
  dBottom = dTop*2+round(height/5);
  difference(){
    union(){
      cylinder(h=height,d1=dBottom,d2=dTop,$fn=100);
      translate([0,0,.5])cube([dBottom*2,dBottom/2,1],center=true);
    }
    translate([0,0,-.1])cylinder(h=height+.2,d=lensD+.05,$fn=100);
  }
}


translate([0,0,0])
basePlate(lensD=1.,bottomTick=.5,gap=1.0,sleeve=true);
*translate([0,0,6])
cap(sleeve=true);

*translate([0,0,3])
basePlateHolder();

*translate([0,0,1])
lensHolder(1,1.5);
