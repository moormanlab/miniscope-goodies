//-- BasePlate with lens guide for MiniScope v4.0
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.0 - February 2021

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

module basePlate (lensD=.5,bottomTick=0.25) {
  //lensD: between .2 and 1.5
  //bottomTick
  
  difference(){
    union(){
      //body
      hull(){
        for(i=[-1,1])
          for(j=[-1,1])
            translate([i*1.5,j*1.5,-bottomTick])cylinder(h=3+bottomTick,d=3,$fn=100);
      }
      
      //cube for screw
      rotate([0,0,45])translate([2,0,1.5])cube([4.5,3,3],center=true);
      
      //wings
      translate([0,-4,.5])wing();
      translate([-4,0,.5])rotate([0,0,-90])wing();
      translate([-.75,4,.5])rotate([0,0,180])wing();
      translate([4,-.75,.5])rotate([0,0,90])wing();
      
      //lens guide
      translate([0,0,-bottomTick-.6])cylinder(h=1.2,d=2.4,$fn=100,center=true);
      translate([0,0,-bottomTick-1.2-.3])cylinder(h=.6,d2=2.4,d1=lensD+.8,$fn=100,center=true);      
    }
    
    //miniscope chamber    
    hull(){
      for(i=[-1,1])
        for(j=[-1,1])
          translate([i*1.5,j*1.5,0])cylinder(h=3.01,d=2,$fn=60);
    }

    //lens hole
    translate([0,0,-2])cylinder(h=5,d=lensD+.2,$fn=100, center=true);
    
    //screw hole
    translate([2,2,1.5])rotate([0,90,45])cylinder(h=4,d=1.77,center=true,$fn=150);

    //fix extra material
    translate([3.505,-2.1,.50])cylinder(h=1.0001,d=1.2,$fn=150,center=true);
    translate([-2.1,3.505,.50])cylinder(h=1.0001,d=1.2,$fn=150,center=true);

  }
}

basePlate(lensD=1.0,bottomTick=.5);