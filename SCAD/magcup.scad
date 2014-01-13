include <configuration.scad>

union() {
rotate([0,180,0]) translate([0,0,3])
difference() {
	union() {
		translate([0,0,1.0]) cylinder(h=2,r1=(8.6+3)/2,r2=(8.6+2)/2,center=true, $fn=32);
		translate([0,0,-2.5]) cylinder(h=5,r=(8.6+3)/2,center=true, $fn=32);
	}

	translate([0,0,-5 + 4/2]) cylinder(h=6,r=8.6/2,center=true, $fn=32);
	translate([0,0,magnetsize/2   ]) sphere(r=8.6/2,center=true, $fn=32);
}

//	translate([0,0,magnetsize/2 + 4/2  ]) sphere(r=8.33/2,center=true, $fn=32);
}
