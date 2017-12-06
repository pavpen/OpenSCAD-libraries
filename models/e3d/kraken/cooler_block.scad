// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

outer_dimensions = [40, 35, 20];

mount_screw_centers = [
    [                      3,                       3],
    [outer_dimensions[0] - 3,                       3],
    [                      3, outer_dimensions[1] - 3],
    [outer_dimensions[0] - 3, outer_dimensions[1] - 3]
];
mount_screw_r = 3 / 2;
mount_screw_hole_depth = 10;
mount_screw_hole_fn = 15;

grub_screw_hole_centers_one_side = [
    [                      7.5,  3],
    [outer_dimensions[1] - 7.5,  3],
    [                      7.5, 11],
    [outer_dimensions[1] - 7.5, 11]
];
grub_screw_hole_depth = 10;
grub_screw_hole_fn = 15;
grub_screw_h = 4;
grub_screw_r = 3 / 2;

heat_break_hole_centers = [
    [                      10,                       7.5],
    [outer_dimensions[0] - 10,                       7.5],
    [                      10, outer_dimensions[1] - 7.5],
    [outer_dimensions[0] - 10, outer_dimensions[1] - 7.5]
];
heat_break_hole_r = 8 / 2;
heat_break_hole_fn = 15;

water_path_hole_centers = [
    [                      11.5, outer_dimensions[1] / 2],
    [outer_dimensions[0] - 11.5, outer_dimensions[1] / 2]
];
water_path_hole_r = 8.4 / 2;
water_path_hole_depth = 15;
water_path_hole_fn = 15;

// Export functions:
function pro_pavpen_e3d_kraken_cooler_block_outer_dimensions() =
    outer_dimensions;

function pro_pavpen_e3d_kraken_cooler_block_mount_screw_r() =
    mount_screw_r;

function pro_pavpen_e3d_kraken_cooler_block_heat_break_hole_r() =
    heat_break_hole_r;

function pro_pavpen_e3d_kraken_cooler_block_water_path_hole_r() =
    water_path_hole_r;



// Demo:
pro_pavpen_e3d_kraken_cooler_block();



module pro_pavpen_e3d_kraken_cooler_block()
{
    difference()
    {
        // Main block:
        cube(outer_dimensions);
        
        // Mount screws holes:
        pro_pavpen_e3d_kraken_cooler_block_position_as_mount_screws()
        cylinder(
            r = mount_screw_r,
            h = mount_screw_hole_depth + 1,
            $fn = mount_screw_hole_fn);
        
        // Grub screw holes:
        pro_pavpen_e3d_kraken_cooler_block_position_as_grub_screws()
        rotate([0, 90, 0])
        translate([0, 0, -1])
        cylinder(
            r = grub_screw_r,
            h = grub_screw_hole_depth + 1,
            $fn = grub_screw_hole_fn);
        
        // Heat break holes:
        translate([0, 0, -1])
        pro_pavpen_e3d_kraken_cooler_block_position_as_heat_break_holes()
        cylinder(
            r = heat_break_hole_r,
            h = outer_dimensions[2] + 2,
            $fn = heat_break_hole_fn);
        
        // Water path holes:
        pro_pavpen_e3d_kraken_cooler_block_position_as_water_path_holes()
        cylinder(
            r = water_path_hole_r,
            h = water_path_hole_depth + 1,
            $fn = water_path_hole_fn);
    }
}

module pro_pavpen_e3d_kraken_cooler_block_position_as_mount_screws(
    use_z_offset = true
)
{
    union()
    {
        for (xy_offset = mount_screw_centers)
        {
            translate([
                xy_offset[0],
                xy_offset[1],
                use_z_offset ?
                    outer_dimensions[2] - mount_screw_hole_depth : 0])
            children();
        }
    }
}

module pro_pavpen_e3d_kraken_cooler_block_position_as_grub_screws_one_side()
{
    union()
    {
        for (yz_offset = grub_screw_hole_centers_one_side)
        {
            translate([0, yz_offset[0], yz_offset[1]])
            children();
        }
    }
}

module pro_pavpen_e3d_kraken_cooler_block_position_as_grub_screws(
    mirror_along_x = true
)
{
    union()
    {
        pro_pavpen_e3d_kraken_cooler_block_position_as_grub_screws_one_side()
        children();
        
        pro_pavpen_e3d_kraken_cooler_block_position_as_grub_screws_one_side()
        translate([outer_dimensions[0], 0, 0])
        scale([mirror_along_x ? -1 : 1, 1, 1])
        children();
    }
}

module pro_pavpen_e3d_kraken_cooler_block_position_as_heat_break_holes(
    mirror_along_x = false,
    mirror_along_y = false
)
{
    union()
    {
        for (i = [0 : len(heat_break_hole_centers) - 1])
        {
            xy_offset = heat_break_hole_centers[i];
            translate([
                xy_offset[0],
                xy_offset[1],
                0])
            scale([
                mirror_along_x && i % 2 == 1 ? -1 : 1,
                mirror_along_y && floor(i / 2) % 2 == 1 ? -1 : 1,
                1])
            children();
        }
    }
}

module pro_pavpen_e3d_kraken_cooler_block_position_as_water_path_holes(
    use_z_offset = true
)
{
    union()
    {
        for (xy_offset = water_path_hole_centers)
        {
            translate([
                xy_offset[0],
                xy_offset[1],
                use_z_offset ? outer_dimensions[2] - water_path_hole_depth : 0])
            children();
        }
    }
}
