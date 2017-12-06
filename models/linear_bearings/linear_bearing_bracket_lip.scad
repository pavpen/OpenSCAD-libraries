// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

use <linear_bearing_bracket.scad>
use <rj260_linear_bearing.scad>


lip_thickness = 3;
lip_height = 3;
fn = 50;

// Export functions:
function pro_pavpen_linear_bearing_bracket_lip_thickness() =
    lip_thickness;

function pro_pavpen_linear_bearing_bracket_lip_height() =
    lip_heght;


// Demo:
pro_pavpen_linear_bearing_bracket();
pro_pavpen_linear_bearing_bracket_front_lip();
pro_pavpen_linear_bearing_bracket_back_lip();


module pro_pavpen_linear_bearing_bracket_front_lip()
{
    translate([
        pro_pavpen_rj260_linear_bearing_length() / 2,
        0,
        pro_pavpen_linear_bearing_bracket_z_offset_to_center() +
            pro_pavpen_rj260_linear_bearing_outer_r() +
            pro_pavpen_linear_bearing_bracket_wall_thickness() -
            lip_height])
    pro_pavpen_linear_bearing_bracket_lip();
}

module pro_pavpen_linear_bearing_bracket_back_lip()
{
    translate([
        -lip_thickness - pro_pavpen_rj260_linear_bearing_length() / 2,
        0,
        pro_pavpen_linear_bearing_bracket_z_offset_to_center() +
            pro_pavpen_rj260_linear_bearing_outer_r() +
            pro_pavpen_linear_bearing_bracket_wall_thickness() -
            lip_height])
    pro_pavpen_linear_bearing_bracket_lip();
}

module pro_pavpen_linear_bearing_bracket_lip()
{
    translate([
        0,
        0,
        -pro_pavpen_rj260_linear_bearing_outer_r() -
            pro_pavpen_linear_bearing_bracket_wall_thickness() +
            lip_height])
    rotate([0, 90, 0])
    difference()
    {
        cylinder(
            r = pro_pavpen_rj260_linear_bearing_outer_r() +
                pro_pavpen_linear_bearing_bracket_wall_thickness(),
            h = lip_thickness,
            $fn = fn);

        translate([
            -pro_pavpen_rj260_linear_bearing_outer_r() + lip_height,
            -pro_pavpen_rj260_linear_bearing_outer_r() -
                pro_pavpen_linear_bearing_bracket_wall_thickness() - 1,
            -1])
        cube([
            2 * (pro_pavpen_rj260_linear_bearing_outer_r() +
                pro_pavpen_linear_bearing_bracket_wall_thickness()),
            2 * (pro_pavpen_rj260_linear_bearing_outer_r() +
                pro_pavpen_linear_bearing_bracket_wall_thickness()) + 2,
            lip_thickness + 2]);
    }
}
