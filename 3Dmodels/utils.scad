////-- General parts
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.0 - March 2021


module screwM3(Length=1,show=false){
  cylinder(h=Length,d=3.4,$fn=40);
  translate([0,0,-3+.001])cylinder(h=3,d=6,$fn=40);
  if (show==true) {
    %cylinder(h=Length,d=3,$fn=40);
    %translate([0,0,-3])cylinder(h=3,d=5.5,$fn=40);
    echo("M3 screw [mm]",L=Length);
  }
}


module nutM3(show=false) {
  cylinder(h=2.6,d=6.6,$fn=6,center=true);
  if (show==true) {
    %difference(){
      cylinder(h=2.5,d=6.5,$fn=6,center=true);
      cylinder(h=3,d=3.6,$fn=40,center=true);
    }
  }
}

module rrect(size,center=false,fn=64){

  dx = size[0];
  dy = size[1];
  dz = size[2];

  if (center==true)
    _rrect(size,fn);
  else
    translate([dx/2,dy/2,dz/2]) _rrect(size,fn);

  module _rrect(size,fn){

    d = min(dx,dy);
    a = (d == dx ? 0 : 1);

    hull()
      for(i=[-1,1])
        translate([a*i*(dx-d)/2,(1-a)*i*(dy-d)/2,0])
             cylinder(h=dz,d=d,$fn=fn,center=true);
  }

}

module r2cube(size,center=false,r=0,fn=64){

  dx = size[0];
  dy = size[1];
  dz = size[2];

  assert(r>0,"Corner radius must be grater than 0 (otherwise just use cube)");
  assert(r<=min(dx,dy)/2,"Corner radius must not be greater than min(x,y)/2");

  if (center==true)
    _r2cube(size,r,fn);
  else
    translate([dx/2,dy/2,dz/2]) _r2cube(size,r,fn);

  module _r2cube(size,r,fn){

    hull()
      for(i=[-1,1])
        translate([i*(dx/2-r),0,0])
          rrect([2*r,dy,dz],fn=fn,center=true);

  }

}
