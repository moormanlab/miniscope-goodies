//-- BasePlate with lens guide for MiniScope v4.0
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.1 - February 2021

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

module basePlate (lensD=.5,bottomTick=0.25,gap=.5) {
  //lensD: between .2 and 1.5
  //bottomTick: betweem .2 and 1?
  //gap: non negative [0,inf)
  
  wormD = 1.2;   //var1: 1.2  var2: 1.77
  wallThick = 1; //var1: 1.0  var2: 0.5
  
  difference(){
    union(){
      //body
      hull(){
        for(i=[-1,1])
          for(j=[-1,1])
            translate([i*1.5,j*1.5,-bottomTick])cylinder(h=3+bottomTick+gap,d=3,$fn=100);
      }
      
      //cube for screw
      rotate([0,0,45])translate([2,0,1.5+gap])cube([4.5,3,3],center=true);
      
      //wings
      translate([0,-4,.5])wing();
      translate([-4,0,.5])rotate([0,0,-90])wing();
      translate([-.35,4,.5])rotate([0,0,180])wing();
      translate([4,-.35,.5])rotate([0,0,90])wing();
      
      //lens guide
      translate([0,0,-bottomTick-.6])cylinder(h=1.2,d=2.4,$fn=100,center=true);
      translate([0,0,-bottomTick-1.2-.3])cylinder(h=.6,d2=2.4,d1=lensD+.8,$fn=100,center=true);      
    }
    
    //miniscope chamber    
    hull(){
      for(i=[-1,1])
        for(j=[-1,1])
          translate([i*1.5,j*1.5,0])cylinder(h=3.01+gap,d=3-2*wallThick,$fn=60);
    }

    //lens hole
    translate([0,0,-2])cylinder(h=5,d=lensD+.2,$fn=100, center=true);
    
    //screw hole
    translate([2,2,1.5+gap])rotate([0,90,45])cylinder(h=4,d=wormD,center=true,$fn=150);
    
  }
}

basePlate(lensD=1.0,bottomTick=.5,gap=0.8);