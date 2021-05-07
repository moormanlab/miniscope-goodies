////-- BasePlate Holder for MiniScope v4.0 BasePlates
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.1 - March 2021

use <utils.scad>

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
    translate([mountSizeW/2-1,7,0])rotate([0,90,0])rotate([0,0,0])nutM3(show=true);
    translate([-mountSizeW/2+2.95,7,0])rotate([0,90,0])rotate([0,0,0])screwM3(mountSizeW-3,show=true);
  }
}

basePlateHolder(sleeve=true,lenght=20);

//use <baseplate.scad>;
//
//translate([0,0,-3])
//basePlate(lensD=1.,bottomTick=.3,gap=1.0,sleeve=true);
