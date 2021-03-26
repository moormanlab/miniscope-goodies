////-- General parts
//-- Ariel Burman
//-- Moorman Lab, University of Massachusetts Amherst
//-- v1.0 - March 2021

globShow=false;

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