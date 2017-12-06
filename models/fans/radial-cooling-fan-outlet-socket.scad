// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

use <radial-cooling-fan.scad>

fan_clearance = 0;
fan_outer_thickness =
    pro_pavpen_radial_cooling_fan_outer_thickness() + 2 * fan_clearance;
fan_outlet_h = pro_pavpen_radial_cooling_fan_outlet_h() + 2 * fan_clearance;

wall_thickness = 2;
back_wall_thickness = 3;
wall_above_outlet_seam_h = 3;
outlet_seam_clearance = 0.2;


// Export functions:
function pro_pavpen_radial_cooling_fan_outlet_socket_wall_thickness() =
    wall_thickness;

function pro_pavpen_radial_cooling_fan_outlet_socket_back_wall_thickness() =
    back_wall_thickness;


// Demo:
pro_pavpen_radial_cooling_fan_outlet_socket();

//pro_pavpen_radial_cooling_fan_outlet_socket_position_as_fan()
//%pro_pavpen_radial_cooling_fan();



module pro_pavpen_radial_cooling_fan_outlet_socket()
{
    difference()
    {
        pro_pavpen_radial_cooling_fan_outlet_socket_outline();
    
        pro_pavpen_radial_cooling_fan_outlet_socket_holes();
    }
}

module pro_pavpen_radial_cooling_fan_outlet_socket_outline()
{
    hull()
    {
        translate([
            0,
            fan_outlet_h + wall_thickness,
            0])
        cube([
            fan_outer_thickness + 2 * wall_thickness,
            back_wall_thickness,
            pro_pavpen_radial_cooling_fan_outlet_seam_offset_from_edge() +
                pro_pavpen_radial_cooling_fan_outlet_seam_length() +
                wall_above_outlet_seam_h]);
        
        cube([
            fan_outer_thickness + 2 * wall_thickness,
            wall_thickness,
            pro_pavpen_radial_cooling_fan_outlet_protrusion()]);
    }
}

module pro_pavpen_radial_cooling_fan_outlet_socket_holes(
    extra_top_h = 1,
    extra_bottom_h = 1
)
{
    translate([
        wall_thickness,
        wall_thickness,
        -extra_bottom_h])
    cube([
        fan_outer_thickness,
        fan_outlet_h,
        pro_pavpen_radial_cooling_fan_outlet_seam_offset_from_edge() +
            pro_pavpen_radial_cooling_fan_outlet_seam_length() +
            wall_above_outlet_seam_h + extra_bottom_h + extra_top_h]);
    
    // Outlet seam:
    pro_pavpen_radial_cooling_fan_outlet_socket_position_as_fan()
    pro_pavpen_radial_cooling_fan_position_as_outlet_seam()
    pro_pavpen_radial_cooling_fan_outlet_seam();
}

module pro_pavpen_radial_cooling_fan_outlet_seam()
{
    translate([0, -1, 0])
    cube([
        pro_pavpen_radial_cooling_fan_outlet_seam_length() +
            2 * outlet_seam_clearance,
        pro_pavpen_radial_cooling_fan_outlet_seam_h() +
            outlet_seam_clearance + 1,
        pro_pavpen_radial_cooling_fan_outlet_seam_width() +
            2 * outlet_seam_clearance]);
}

module pro_pavpen_radial_cooling_fan_outlet_socket_position_as_fan()
{
    translate([
        wall_thickness + fan_clearance,
        -pro_pavpen_radial_cooling_fan_body_outer_r() +
            pro_pavpen_radial_cooling_fan_outlet_h() + wall_thickness +
            fan_clearance,
        pro_pavpen_radial_cooling_fan_body_outer_r() +
            pro_pavpen_radial_cooling_fan_outlet_protrusion()])
    rotate([0, 90, 0])
    children();
}
