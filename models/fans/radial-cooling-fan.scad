// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

body_outer_r = 50 / 2;
outer_thickness = 15;
wall_thickness = 1.5;
rotor_axle_outer_r = 25 / 2;
rotor_center_offset = [1.5, -2.5];
intake_slit_width = 4;
intake_slit_depth = 10;
outlet_h = 20;
outlet_protrusion = 2;
mount_flap_outer_r = 7.15 / 2;
mount_hole_r = 4.5 / 2;
   
mount_hole_perimeter_points =
    pro_pavpen_radial_cooling_fan_mount_hole_perimeter_points();
mount_hole_centers = [
    mount_hole_perimeter_points[0] - [1 / sqrt(2), -1 / sqrt(2)] * mount_flap_outer_r,
    mount_hole_perimeter_points[1] + [1 / sqrt(2), -1 / sqrt(2)] * mount_flap_outer_r
];

outlet_seam_length = 11.5;
outlet_seam_width = 2;
outlet_seam_h = 1.3;
outlet_seam_offset_from_edge = 0.2;
outlet_seam_offset_from_top = 5.85;


$fn = 50;

function pro_pavpen_radial_cooling_fan_mount_hole_perimeter_points() =
    let (n = [1, -1],
         c = rotor_center_offset,
         r = body_outer_r,
         a = c[0] * n[0] + c[1] * n[1],
         d = n[0] * n[0] + n[1] * n[1],
         b = a - d * (c[0] * c[0] + c[1] * c[1] - r * r),
         t = [(-a - sqrt(b)) / d, (-a + sqrt(b)) / d])
    [
        [c[0] + n[0] * t[0], c[1] + n[1] * t[0]],
        [c[0] + n[0] * t[1], c[1] + n[1] * t[1]]
    ];


// Export functions:

function pro_pavpen_radial_cooling_fan_body_outer_r() = body_outer_r;

function pro_pavpen_radial_cooling_fan_outer_thickness() = outer_thickness;

function pro_pavpen_radial_cooling_fan_outlet_h() = outlet_h;

function pro_pavpen_radial_cooling_fan_outlet_protrusion() =
    outlet_protrusion;

function pro_pavpen_radial_cooling_fan_outlet_seam_length() =
    outlet_seam_length;

function pro_pavpen_radial_cooling_fan_outlet_seam_width() =
    outlet_seam_width;

function pro_pavpen_radial_cooling_fan_outlet_seam_h() = outlet_seam_h;

function pro_pavpen_radial_cooling_fan_outlet_seam_offset_from_edge() =
    outlet_seam_offset_from_edge;



// Demo:
pro_pavpen_radial_cooling_fan();


module pro_pavpen_radial_cooling_fan()
{
    difference()
    {
        pro_pavpen_radial_cooling_fan_outline();
        pro_pavpen_radial_cooling_fan_holes();
    }
}

module pro_pavpen_radial_cooling_fan_outline()
{
    union()
    {
        linear_extrude(outer_thickness)
        union()
        {
            // Body:
            circle(r = body_outer_r);
            
            // Outlet:
            translate([
                outlet_protrusion,
                body_outer_r - outlet_h])
            square([body_outer_r, outlet_h]);
            
            // Mount flaps:
            hull()
            {
                for (xy = mount_hole_centers)
                {
                    translate([xy[0], xy[1], 0])
                    circle(r = mount_flap_outer_r);
                }
            }
        }
        
        // Intake seam:
        pro_pavpen_radial_cooling_fan_position_as_outlet_seam()
        pro_pavpen_radial_cooling_fan_outlet_seam();
    }
}

module pro_pavpen_radial_cooling_fan_holes(
    extend_top_h = 1,
    extend_bottom_h = 1,
    extend_right_h = 1
)
{
    union()
    {
        // Intake slit:
        translate([
            rotor_center_offset[0],
            rotor_center_offset[1],
            -extend_bottom_h])
        difference()
        {
            cylinder(
                r = rotor_axle_outer_r + intake_slit_width,
                h = intake_slit_depth + extend_bottom_h);

            translate([0, 0, -1])
            cylinder(
                r = rotor_axle_outer_r,
                h = intake_slit_depth + extend_bottom_h + 2);
        }
        
        // Mount flap holes:
        for (xy = mount_hole_centers)
        {
            translate([xy[0], xy[1], -extend_bottom_h])
            cylinder(
                r = mount_hole_r,
                h = outer_thickness + extend_bottom_h + extend_top_h);
        }
        
        // Body:
        translate([0, 0, wall_thickness])
        linear_extrude(outer_thickness - 2 * wall_thickness)
        union()
        {
            // Body:
            circle(r = body_outer_r - wall_thickness);
            
            // Outlet:
            translate([
                outlet_protrusion,
                body_outer_r - outlet_h + wall_thickness])
            square([
                body_outer_r + extend_right_h,
                outlet_h - 2 * wall_thickness]);
        }
    }
}

module pro_pavpen_radial_cooling_fan_position_as_outlet_seam()
{
    translate([
        body_outer_r + outlet_protrusion - outlet_seam_length - outlet_seam_offset_from_edge,
        body_outer_r,
        outer_thickness - outlet_seam_width - outlet_seam_offset_from_top])
    children();
}

module pro_pavpen_radial_cooling_fan_outlet_seam()
{
    cube([
        outlet_seam_length,
        outlet_seam_h,
        outlet_seam_width]);
}
