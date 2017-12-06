// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

outer_dimensions = [23, 16, 11.5];
nozzle_hole_r = 6.2 / 2;
nozzle_hole_center = [outer_dimensions[0] - 8, 8];
heater_hole_r = 6 / 2;
heater_hole_center = [8.5, 4];
heater_bracket_gap_h = 1;
heater_bracket_gap_center_z = heater_hole_center[1];
heater_screw_hole_r = 3 / 2;
heater_screw_hole_center = [2.5, 8];
thermistor_hole_r = 3.1 / 2;
thermistor_hole_center = [outer_dimensions[0] - 2, 5.75];
thermistor_grub_screw_hole_r = 3 / 2;
thermistor_grub_screw_hole_center = [
    outer_dimensions[0] - 2,
    8
];

$fn = 25;

// Export functions:
function pro_pavpen_e3d_v6_heater_block_outer_dimensions() = outer_dimensions;


// Demo:
pro_pavpen_e3d_v6_heater_block();


module pro_pavpen_e3d_v6_heater_block()
{
    difference()
    {
        cube(outer_dimensions);
        
        pro_pavpen_e3d_v6_heater_block_holes();
    }
}

module pro_pavpen_e3d_v6_heater_block_holes(
    top_extra_h = 1,
    bottom_extra_h = 1,
    front_extra_h = 1,
    back_extra_h = 1,
    left_extra_h = 1
)
{
    union()
    {
        // Nozzle hole:
        translate([0, 0, -bottom_extra_h])
        pro_pavpen_e3d_v6_heater_block_position_as_nozzle_hole()
        cylinder(
            r = nozzle_hole_r,
            h = outer_dimensions[2] + bottom_extra_h + top_extra_h);
        
        // Heater hole:
        translate([0, outer_dimensions[1] + back_extra_h, 0])
        pro_pavpen_e3d_v6_heater_block_position_as_heater_hole()
        rotate([90, 0, 0])
        cylinder(
            r = heater_hole_r,
            h = outer_dimensions[1] + back_extra_h + front_extra_h);
        
        // Heater bracket gap:
        translate([
            -left_extra_h,
            -front_extra_h,
            heater_bracket_gap_center_z - heater_bracket_gap_h / 2])
        cube([
            heater_hole_center[0] + left_extra_h,
            outer_dimensions[1] + back_extra_h + front_extra_h,
            heater_bracket_gap_h]);
        
        // Heater screw hole:
        translate([0, 0, -bottom_extra_h])
        pro_pavpen_e3d_v6_heater_block_position_as_heater_screw_hole()
        cylinder(
            r = heater_screw_hole_r,
            h = outer_dimensions[2] + bottom_extra_h + top_extra_h);
        
        // Thermistor hole:
        translate([
            0,
            outer_dimensions[1] + back_extra_h,
            0])
        pro_pavpen_e3d_v6_heater_block_position_as_thermistor_hole()
        rotate([90, 0, 0])
        cylinder(
            r = thermistor_hole_r,
            h = outer_dimensions[1] + back_extra_h + front_extra_h);
        
        // Thermistor grub screw hole:
        translate([0, 0, -bottom_extra_h])
        pro_pavpen_e3d_v6_heater_block_position_as_thermistor_grub_screw_hole()
        cylinder(
            r = thermistor_grub_screw_hole_r,
            h = thermistor_hole_center[1] + bottom_extra_h);
    }
}

module pro_pavpen_e3d_v6_heater_block_position_as_nozzle_hole()
{
    translate([
        nozzle_hole_center[0],
        nozzle_hole_center[1],
        0])
    children();
}

module pro_pavpen_e3d_v6_heater_block_position_as_heater_hole()
{
    translate([
        heater_hole_center[0],
        0,
        heater_hole_center[1]])
    children();
}

module pro_pavpen_e3d_v6_heater_block_position_as_heater_screw_hole()
{
    translate([
        heater_screw_hole_center[0],
        heater_screw_hole_center[1],
        0])
    children();
}

module pro_pavpen_e3d_v6_heater_block_position_as_thermistor_hole()
{
    translate([
        thermistor_hole_center[0],
        0,
        thermistor_hole_center[1]])
    children();
}

module pro_pavpen_e3d_v6_heater_block_position_as_thermistor_grub_screw_hole()
{
    translate([
        thermistor_grub_screw_hole_center[0],
        thermistor_grub_screw_hole_center[1],
        0])
    children();
}
