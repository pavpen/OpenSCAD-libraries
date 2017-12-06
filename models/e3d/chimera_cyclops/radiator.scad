// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

radiator_width = 30;
radiator_depth = 18;
radiator_h = 30;
mounting_bolt_r = 3/2;
mounting_hole_depth = 8;
mounting_hole_fn = 25;
back_holes_bottom_offset = 10;
top_holes_back_offset = 3;
fin_count = 10;
fin_h = 0.8;
fin_depth = 6;
fin_spacing_distance = 1.6;
fins_bottom_clearance = 2.2;
filament_hole_fn = 25;
fan_bolt_hole_depth = 6;
fan_bolt_hole_fn = 25;
grub_screw_r = 1.6 / 2;
grub_screw_hole_depth = 3;
grub_screw_hole_fn = 25;

// Demo:
pro_pavpen_e3d_chimera_cyclops_radiator();


top_bolt_hole_offsets = [
    [-8.5, 12, 0],
    [+8.5, 12, 0],
    [ 0,    0, 0]
];

top_bolt_holes_offset = [0, top_holes_back_offset, radiator_h];

back_bolt_hole_offsets = [
    [-4.5, 0, 10],
    [+4.5, 0, 10],
    [ 0,   0,  0]
];

back_bolt_holes_offset = [0, 0, back_holes_bottom_offset];

filament_hole_offsets = [
    [-9, 0, 0],
    [+9, 0, 0]
];

filament_holes_offset = [0, 6, 0];


function pro_pavpen_e3d_chimera_cyclops_radiator_h() = radiator_h;

function pro_pavpen_e3d_chimera_cyclops_radiator_top_holes_offset() =
    top_bolt_holes_offset;

function pro_pavpen_e3d_chimera_cyclops_radiator_top_hole_max_x_offset() =
    max([for (offset = top_bolt_hole_offsets) offset[0]]);

function pro_pavpen_e3d_chimera_cyclops_radiator_back_holes_offset() =
    back_bolt_holes_offset;

function pro_pavpen_e3d_chimera_cyclops_radiator_filament_holes_offset() =
    filament_holes_offset;

function pro_pavpen_e3d_chimera_cyclops_radiator_filament_hole_max_x_offset() =
    max([for (offset = filament_hole_offsets) offset[0]]);


module pro_pavpen_e3d_chimera_cyclops_radiator()
{
    difference()
    {
        translate([-radiator_width / 2, 0, 0])
        cube([radiator_width, radiator_depth, radiator_h]);
        
        pro_pavpen_e3d_chimera_cyclops_radiator_top_holes();
        pro_pavpen_e3d_chimera_cyclops_radiator_back_holes();
        pro_pavpen_e3d_chimera_cyclops_radiator_fins();
        pro_pavpen_e3d_chimera_cyclops_radiator_filament_holes();
        
        pro_pavpen_e3d_chimera_cyclops_radiator_fan_bolt_holes();
        pro_pavpen_e3d_chimera_cyclops_radiator_grub_screw_holes();
    }
}


module pro_pavpen_e3d_chimera_cyclops_radiator_replicate_as_top_holes()
{
    union()
    {
        for (offset = top_bolt_hole_offsets)
        {
            translate(offset)
            children();
        }
    }
}

module pro_pavpen_e3d_chimera_cyclops_radiator_replicate_as_back_holes()
{    
    union()
    {
        for (offset = back_bolt_hole_offsets)
        {
            translate(offset)
            children();
        }
    }
}

module pro_pavpen_e3d_chimera_cyclops_radiator_replicate_as_fin_holes()
{
    for (i = [0 : fin_count - 1])
    {
        translate([
            0,
            0,
            fin_spacing_distance + i * (fin_h + fin_spacing_distance)])
        children();
    }
}

module pro_pavpen_e3d_chimera_cyclops_radiator_replicate_as_filament_holes(
    reflect = false // Set to true, if the hole is non-symmetrical, and you want left-right radiator symmetry.
)
{
    union()
    {
        for (i = [0 : len(filament_hole_offsets) - 1])
        {
            translate(filament_hole_offsets[i])
            if (i % 2 == 1 && reflect)
            {
                scale([-1, 1, 1])
                children();
            }
            else
            {
                children();
            }
        }
    }
}


module pro_pavpen_e3d_chimera_cyclops_radiator_top_holes()
{
    translate(top_bolt_holes_offset + [0, 0, -mounting_hole_depth])
    pro_pavpen_e3d_chimera_cyclops_radiator_replicate_as_top_holes()
    cylinder(
        r = mounting_bolt_r,
        h = mounting_hole_depth + 1,
        $fn = mounting_hole_fn);
}

module pro_pavpen_e3d_chimera_cyclops_radiator_back_holes()
{
    translate(back_bolt_holes_offset + [0, mounting_hole_depth, 0])
    pro_pavpen_e3d_chimera_cyclops_radiator_replicate_as_back_holes()
    rotate([90, 0, 0])
    cylinder(
        r = mounting_bolt_r,
        h = mounting_hole_depth + 1,
        $fn = mounting_hole_fn);
}

module pro_pavpen_e3d_chimera_cyclops_radiator_fins()
{
    translate([
        -(radiator_width + 2)/ 2,
        radiator_depth - fin_depth,
        fins_bottom_clearance])
    pro_pavpen_e3d_chimera_cyclops_radiator_replicate_as_fin_holes()
    cube([radiator_width + 2, fin_depth + 1, fin_h]);
}

module pro_pavpen_e3d_chimera_cyclops_radiator_filament_holes()
{
    translate(filament_holes_offset)
    pro_pavpen_e3d_chimera_cyclops_radiator_replicate_as_filament_holes()
    pro_pavpen_e3d_chimera_cyclops_radiator_filament_hole();
}

module pro_pavpen_e3d_chimera_cyclops_radiator_filament_hole()
{
    union()
    {
        translate([0, 0, radiator_h - 6.5 + 0.001])
        cylinder(d = 8, h = 6.5 + 1, $fn = filament_hole_fn);
        
        translate([0, 0, radiator_h - 7.5])
        cylinder(d1 = 4.2, d2 = 8, h = 1, $fn = filament_hole_fn);
        
        translate([0, 0, radiator_h - 15])
        cylinder(d = 4.2, h = 7.5, $fn = filament_hole_fn);
        
        translate([0, 0, radiator_h - 16])
        cylinder(d1 = 7, d2 = 4.2, h = 1, $fn = filament_hole_fn);
        
        translate([0, 0, -1])
        cylinder(d = 7, h = 14 + 1.001, $fn = filament_hole_fn);
        
        // Clear zero-height boundaries between combined solids:
        cylinder(d = 4.2, h = 30, $fn = filament_hole_fn);
    }
}

module pro_pavpen_e3d_chimera_cyclops_radiator_fan_bolt_holes()
{
    union()
    {
        // 2.8-mm holes:
        translate([12, radiator_depth + 1, 27])
        rotate([90, 0, 0])
        cylinder(
            d = 2.8,
            h = fan_bolt_hole_depth + 1,
            $fn = fan_bolt_hole_fn);
        
        translate([-12, radiator_depth + 1, 3])
        rotate([90, 0, 0])
        cylinder(
            d = 2.8,
            h = fan_bolt_hole_depth + 1,
            $fn = fan_bolt_hole_fn);
        
        // 2.5-mm holes:
        translate([12, radiator_depth + 1, 3])
        rotate([90, 0, 0])
        cylinder(
            d = 2.5,
            h = fan_bolt_hole_depth + 1,
            $fn = fan_bolt_hole_fn);
        
        translate([-12, radiator_depth + 1, 27])
        rotate([90, 0, 0])
        cylinder(
            d = 2.5,
            h = fan_bolt_hole_depth + 1,
            $fn = fan_bolt_hole_fn);
    }
}

module pro_pavpen_e3d_chimera_cyclops_radiator_grub_screw_holes()
{
    union()
    {
        translate([radiator_width/2 - grub_screw_hole_depth, 6, 3])
        rotate([0, 90, 0])
        cylinder(
            r = grub_screw_r,
            h = grub_screw_hole_depth + 1,
            $fn = grub_screw_hole_fn);
        
        translate([radiator_width/2 - grub_screw_hole_depth, 6, 11])
        rotate([0, 90, 0])
        cylinder(
            r = grub_screw_r,
            h = grub_screw_hole_depth + 1,
            $fn = grub_screw_hole_fn);
        
        translate([-radiator_width/2 - 1, 6, 3])
        rotate([0, 90, 0])
        cylinder(
            r = grub_screw_r,
            h = grub_screw_hole_depth + 1,
            $fn = grub_screw_hole_fn);
        
        translate([-radiator_width/2 - 1, 6, 11])
        rotate([0, 90, 0])
        cylinder(
            r = grub_screw_r,
            h = grub_screw_hole_depth + 1,
            $fn = grub_screw_hole_fn);
    }
}
