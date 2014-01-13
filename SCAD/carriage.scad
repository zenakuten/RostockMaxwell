include <configuration.scad>

width = 76;
height = carriage_height;

offset = 25;
dimple = 16;
middle = 2*offset - width/2;
//magnetsize = 9.52/2; // 3/8" (9.52mm) dia. for mini

//from jaws.scad
//h = 7;
//r = h/2 / cos(30);

module dimple_joints() {
			for (x = [-offset, offset]) {
			  rotate([-30,0,0]) translate([x, 2, 7])
					union() {
						difference() {
							cylinder(r1=(dimple-5)/2, r2=(dimple-4)/2, h=2, center=true, $fn=24);
							translate([0,0,-1]) sphere(magnetsize);
							
						}
						//uncomment to show the magnet
						//translate([0,0,-1]) sphere(magnetsize);
					}
			}
}

module dimple_holes(msize) {
			for (x = [-offset, offset]) {
			  rotate([-30,0,0]) translate([x, 2, 7])
						translate([0,0,-1]) sphere(msize);
			}
}

module parallel_joints(reinforced) {
	difference() {
		union() {
			union() {
				intersection() {
					translate([0, 18, 6]) rotate([-30, 0, 0]) cube([width, reinforced+18.25, reinforced-3.25], center=true);
					translate([0, 0, 6]) cube([width, reinforced+16, reinforced-4], center=true);
				}
				//translate([0, 8, 12]) cube([width, 16, 5], center=true);
				translate([0, 8, 14.5]) cube([width, 16, 11], center=true);
			}

			dimple_joints();
	//    translate([0, 0, 0]) cube([2*middle  -4, 20, 100], center=true);
		}
//    translate([0, 0, 0]) cube([2*middle  -4, 20, 100], center=true);
		dimple_holes(magnetsize);
	}
}

module lm8uu_mount(d, h) {
  union() {
    difference() {
      intersection() {
        cylinder(r=11, h=h, center=true);
        translate([0, -8, 0]) cube([19, 13, h+1], center=true);
      }
      cylinder(r=d/2, h=h+1, center=true);
    }
  }
}

module belt_mount() {
  difference() {
    union() {
      difference() {
        translate([8, 2, 0]) cube([4, 13, height], center=true);
        for (z = [-3.5, 3.5])
          translate([8, 5, z])
            cube([5, 13, 3], center=true);
      }
      for (y = [1.5, 5, 8.5]) {
        translate([8, y, 0]) cube([4, 1.2, height], center=true);
      }
    }
  }
}

module carriage() {
  translate([0, 0, height/2]) 
  union() {
    for (x = [-30, 30]) {
      translate([x, 0, 0]) lm8uu_mount(d=15, h=24);
    }
    belt_mount();
    difference() {
      union() {
        translate([0, -5.6, 0])
          cube([50, 5, height], center=true);
        translate([0, -carriage_hinge_offset, -height/2+4])
	      parallel_joints(16);
      }

      // Screw hole for adjustable top endstop.
      translate([-15, -16, height/2  ])
        cylinder(r=1.5, h=15, center=true, $fn=12);

      for (x = [-30, 30]) {
        translate([x, 0, 0])
          cylinder(r=8, h=height+1, center=true);
        // Zip tie tunnels.
        for (z = [-height/2+3, height/2-3])
          translate([x, 0, z])
            cylinder(r=13, h=4, center=true);
      }
    }
  }
}

carriage();

// Uncomment the following lines to check endstop alignment.
// use <idler_end.scad>;
// translate([0, 0, -20]) rotate([180, 0, 0]) idler_end();
