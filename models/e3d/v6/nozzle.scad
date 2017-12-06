// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

length_a = 0.40; // Nozzle diameter
length_b = 1.00;
length_c = 0.60;
length_d = 2.0;
length_e = 2.6;

total_h = 12.5;
opening_section_top_outer_r = 2.5;
opening_section_h = 2;
wrench_section_side = 7 / sqrt(3);
wrench_section_side_count = 6;
wrench_section_outer_r = wrench_section_side;
wrench_section_h = 3;
neck_outer_r = 5 / 2;
neck_h = 1.5;
threaded_section_outer_r = 6 / 2;
threaded_section_h = 6;
top_hole_h = 0.5;

$fn = 25;

// Export functions:
function pro_pavpen_e3d_v6_nozzle_total_h() = total_h;


// Demo:
pro_pavpen_e3d_v6_nozzle();



module pro_pavpen_e3d_v6_nozzle()
{
    difference()
    {
        pro_pavpen_e3d_v6_nozzle_body();
        
        pro_pavpen_e3d_v6_nozzle_hole();
    }
}

module pro_pavpen_e3d_v6_nozzle_body(length_b = length_b)
{
    union()
    {
        // Opening section:
        cylinder(
            r1 = length_b / 2,
            r2 = opening_section_top_outer_r,
            h = opening_section_h);
        
        // Wrench section:
        translate([0, 0, opening_section_h])
        cylinder(
            r = wrench_section_outer_r,
            h = wrench_section_h,
            $fn = wrench_section_side_count);
        
        // Neck:
        translate([
            0,
            0,
            opening_section_h + wrench_section_h])
        cylinder(r = neck_outer_r, h =  neck_h);
        
        // Threaded section:
        translate([
            0,
            0,
            opening_section_h + wrench_section_h + neck_h])
        cylinder(
            r = threaded_section_outer_r,
            h = threaded_section_h);
    }
}

module pro_pavpen_e3d_v6_nozzle_hole(
    bottom_extra_h = 1,
    top_extra_h = 1
)
{
    overlap_h = 0.001;
    
    union()
    {
        // Extrusion opening:
        translate([0, 0, -bottom_extra_h])
        cylinder(
            r = length_a / 2,
            h = length_c + bottom_extra_h + overlap_h);
        
        // Transition hole:
        transition_hole_h = length_d / 2 * sqrt(3);
        
        translate([0, 0, length_c])
        cylinder(
            r1 = length_a / 2,
            r2 = length_d / 2,
            h = transition_hole_h);
        
        // Filament hole:
        translate([0, 0, length_c + transition_hole_h - overlap_h])
        cylinder(
            r = length_d / 2,
            h = total_h - transition_hole_h - length_c + 2 * overlap_h);
        
        // Top opening:
        translate([0, 0, total_h - top_hole_h])
        cylinder(
            r1 = length_d / 2,
            r2 = length_e / 2,
            h = top_hole_h + overlap_h);
        
        // Top extra hole:
        translate([0, 0, total_h])
        cylinder(r = length_e / 2, h = top_extra_h);
    }
}
