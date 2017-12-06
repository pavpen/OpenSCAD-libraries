// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

// Parameters for J260 Igus linear bearings
// <http://www.igus.com/wpck/3660/drylin_r_rj260um_02>:
outer_r = 19.2 / 2 + 0.2;
inner_r = 12.15 / 2;

// Length of the part actually intended to contact the axle:
sleeve_length = 25 - 0.2;
chamfer_length = 1.5;

// Total length of the bearing:
length = sleeve_length + 2 * chamfer_length;

outer_chamfer_angle = 15;
inner_chamfer_angle = 15;

fn = 100;


// Export functions:
function pro_pavpen_rj260_linear_bearing_outer_r() = outer_r;
function pro_pavpen_rj260_linear_bearing_inner_r() = inner_r;
function pro_pavpen_rj260_linear_bearing_sleeve_length() = sleeve_length;
function pro_pavpen_rj260_linear_bearing_length() = length;

// Demo:
pro_pavpen_rj260_linear_bearing();


module pro_pavpen_rj260_linear_bearing()
{
    difference()
    {
        union()
        {
            translate([0, 0, chamfer_length])
            cylinder(r = outer_r, h = sleeve_length, $fn = fn);
            
            // Top outer chamfer:
            translate([0, 0, chamfer_length + sleeve_length])
            cylinder(
                r1 = outer_r,
                r2 = outer_r - chamfer_length * tan(outer_chamfer_angle),
                h = chamfer_length,
                $fn = fn);
            
            // Bottom outer chamfer:
            cylinder(
                r1 = outer_r - chamfer_length * tan(outer_chamfer_angle),
                r2 = outer_r,
                h = chamfer_length,
                $fn = fn);
        }
        
        translate([0, 0, -1])
        cylinder(r = inner_r, h = length + 2, $fn = fn);
        
        // Top inner chamfer:
        translate([0, 0, chamfer_length + sleeve_length])
        cylinder(
            r1 = inner_r,
            r2 = inner_r + (chamfer_length + 1) * tan(inner_chamfer_angle),
            h = chamfer_length + 1,
            $fn = fn);
        
        // Bottom inner chamfer:
        translate([0, 0, -1])
        cylinder(
            r1 = inner_r + (chamfer_length + 1) * tan(inner_chamfer_angle),
            r2 = inner_r,
            h = chamfer_length + 1,
            $fn = fn);
    }
}
