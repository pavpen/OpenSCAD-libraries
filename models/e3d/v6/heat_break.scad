// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

threaded_base_r = 6 / 2;
threaded_base_h = 5;
neck_r = 2.95 / 2;
neck_h = 2.1;
radiator_r = 6.95 / 2;
radiator_h = 13.5;

filament_hole_r = 2 / 2;
filament_hole_h = 16.1;
bowden_tube_hole_r = 4 / 2;
bowden_tube_hole_h = 4;
hole_transition_h = 0.5;

$fn = 50;


// Export functions:
function pro_pavpen_e3d_v6_heat_break_threaded_base_h() = threaded_base_h;

function pro_pavpen_e3d_v6_heat_break_neck_h() = neck_h;

function pro_pavpen_e3d_v6_heat_break_radiator_h() = radiator_h;


// Demo:
pro_pavpen_e3d_v6_heat_break();


module pro_pavpen_e3d_v6_heat_break()
{
    difference()
    {
        pro_pavpen_e3d_v6_heat_break_body();

        pro_pavpen_e3d_v6_heat_break_hole();
    }
}

module pro_pavpen_e3d_v6_heat_break_body()
{
    union()
    {
        // Threaded base:
        cylinder(
            r = threaded_base_r,
            h = threaded_base_h);
        
        // Neck:
        translate([0, 0, threaded_base_h])
        cylinder(r = neck_r, h = neck_h);
        
        // Heat radiator:
        translate([0, 0, threaded_base_h + neck_h])
        cylinder(r = radiator_r, h = radiator_h);
    }
}

module pro_pavpen_e3d_v6_heat_break_hole(
    bottom_extra_h = 1,
    top_extra_h = 1
)
{
    hole_overlap_h = 0.001;
    
    union()
    {
        // Filament hole:
        translate([0, 0, -bottom_extra_h])
        cylinder(
            r = filament_hole_r,
            h = filament_hole_h + bottom_extra_h + hole_overlap_h);
        
        // Transition region:
        translate([0, 0, filament_hole_h])
        cylinder(
            r1 = filament_hole_r,
            r2 = bowden_tube_hole_r,
            h = hole_transition_h);
        
        // Bowden tube hole:
        translate([
            0,
            0,
            filament_hole_h + hole_transition_h - hole_overlap_h])
        cylinder(
            r = bowden_tube_hole_r,
            h = bowden_tube_hole_h + top_extra_h + hole_overlap_h);
    }
}
