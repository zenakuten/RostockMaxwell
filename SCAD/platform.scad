
include <configuration.scad>
use <carriage.scad>

h=platform_thickness;
offset = 25;

module platform() {
  rotate([0,180,0])
  translate([0, 0, 0]) 
  difference() {
	  intersection() {
			union() {
				translate([0,0,-1]) 
				{
					  rotate([0,0,-30]) 
					  {
						  cylinder(r1=50,r2=78,h=platform_thickness-2,$fn=3,center=true);
					  }
				}

			  cylinder(r=32, h=h, center=true, $fn=128);
			  
			  rotate([0,0,-60])
				for (a = [0:120:359]) {
						rotate([0, 0, a]) {
						  translate([0, 32, 0]) { 
							  rotate([30,0,0]) translate([offset,0,-1]) minkowski() {cylinder(r=6,h=2,center=true, $fn=32); sphere(r=0.5,center=true);}
							  rotate([30,0,0]) translate([-offset,0,-1]) minkowski() {cylinder(r=6,h=2,center=true, $fn=32); sphere(r=0.5,center=true);}
							}
						}
				}

				translate([0,0,3]) 
				{
					  rotate([0,0,-30]) 
					  {
							  cylinder(r1=78,r2=78,h=2,$fn=3,center=true);
					  }
				}

			  cylinder(r=30, h=h, center=true);



			}
			cylinder(r1=50,r2=50,h=platform_thickness+3,$fn=128,center=true);
		}

	//center ring
    cylinder(r=20, h=h+12, center=true, $fn=128);

	//center ring holes
    for (a = [0:2]) {
      rotate(a*120) {
        translate([0, -25, 0])
          cylinder(r=2.2, h=h+1, center=true, $fn=32);
      }
    }
    rotate([0,0,180]) for (a = [0:2]) {
      rotate(a*120) {
        translate([0, -25, 0])
          cylinder(r=2.2, h=h+1, center=true, $fn=32);
      }
    }

	//magnet holes
	for (a = [0:120:359]) {
	rotate([0, 0, a]) {
		  translate([0, -platform_hinge_offset, -2.0]) 
			  union() {
				for (x = [-offset, offset]) {
					rotate([-30,0,0]) translate([x, 0, 7])
					translate([0,0,-8]) sphere(magnetsize, $fn=32);//cylinder(r=4.0,h=6,center=true,$fn=32);
				}
		    }
		}
	}
  }
}

platform();
