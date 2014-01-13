
include <configuration.scad>
use <carriage.scad>

h=platform_thickness;

cutout = 12.5;
inset = 6;

offset = 25;
dimple = 16;

module platform() {
  rotate([0,180,0])
  translate([0, 0, 0]) 
  difference() {
    union() {
      for (a = [0:120:359]) {
        rotate([0, 0, a]) {
		  union() {
			  intersection() {
				  translate([0, -platform_hinge_offset+12, 0]) rotate([-30,0,0]) cube([83,41,platform_thickness],center=true);
				  translate([0, -platform_hinge_offset+12, 0]) cube([83,23,platform_thickness],center=true);
				  translate([0, -platform_hinge_offset+0, 0]) cube([83,23,platform_thickness],center=true);
			  }
			  translate([0, -platform_hinge_offset+13, 0]) cube([72,5,platform_thickness],center=true);
			  translate([0, -platform_hinge_offset, -6.8]) 
				  			for (x = [-offset, offset]) {
							  rotate([-30,0,0]) translate([x, 2, 7])
											cylinder(r1=(dimple-5)/2, r2=(dimple-4)/2, h=2, center=true, $fn=24);
							}

		  }


	  intersection(){
			rotate([0, 0, 0]) {
			  intersection() {
				  translate([0, -platform_hinge_offset+12, 0]) rotate([-30,0,0]) cube([132,41,platform_thickness],center=true);
				  translate([0, -platform_hinge_offset+12, 0]) cube([132,23,platform_thickness],center=true);
			  }
			}
			rotate([0, 0, 120]) {
			  intersection() {
				  translate([0, -platform_hinge_offset+12, 0]) rotate([-30,0,0])  cube([132,41,platform_thickness],center=true);
				  translate([0, -platform_hinge_offset+12, 0]) cube([132,23,platform_thickness],center=true);
			  }
			}
	  }

          translate([0, 31, 0]) cube([8,14,platform_thickness], center=true);
          // Holder for adjustable bottom endstops.
          translate([0, 45, 0]) cylinder(r=5, h=h, center=true);
        }
      }

      cylinder(r=30, h=h, center=true);
    }
	
	//rounded corners
	for (a = [0:120:359]) {
		rotate([0, 0, a]) {
          translate([0, 61, 0]) 
			  difference(){
			  cube([20,14,platform_thickness+2], center=true);
			  translate([0,-14,0]) cylinder(r=10,h=platform_thickness+2,center=true);
		  }

		}
	}

    cylinder(r=20, h=h+12, center=true);

    for (a = [0:2]) {
      rotate(a*120) {
        translate([0, -25, 0])
          cylinder(r=2.2, h=h+1, center=true, $fn=12);
        // Screw holes for adjustable bottom endstops.
        translate([0, 45, 0])
          cylinder(r=1.5, h=h+1, center=true, $fn=12);

      }
    }
	// Added extra set of holes 
    rotate([0,0,180]) for (a = [0:2]) {
      rotate(a*120) {
        translate([0, -25, 0])
          cylinder(r=2.2, h=h+1, center=true, $fn=12);
      }
    }
	for (a = [0:120:359]) {
	rotate([0, 0, a]) {
		  translate([0, -platform_hinge_offset, -6.9 ]) dimple_holes(magnetsize);
		}
	}
  }
}

platform();
