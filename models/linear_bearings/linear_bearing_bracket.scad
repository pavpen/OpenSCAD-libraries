// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

use <rj260_linear_bearing.scad>

wall_thickness = 3;
tensioner_flap_r = 18 / 2;
tensioner_travel_distance = 10;
tensioner_bolt_r = 5 /2 + 0.2;
tensioner_bolt_head_r = 9.5 / 2 + 0.2;
tensioner_bolt_head_bed_depth = 4;
tensioner_bolt_flap_r = tensioner_flap_r;
tensioner_nut_side_count = 6;
tensioner_nut_outer_r = 9 / 2 + 0.3;
tensioner_nut_bed_depth = 4;
tensioner_nut_flap_r = tensioner_flap_r;
tensioner_body_length = 25;
tensioner_body_fn = 50;
tensioner_fn = 25;

// Export functions:
function pro_pavpen_linear_bearing_bracket_wall_thickness() =
    wall_thickness;

function pro_pavpen_linear_bearing_bracket_tensioner_body_length() =
    tensioner_body_length;



function pro_pavpen_linear_bearing_bracket_z_offset_to_center(
    bearing_outer_r = pro_pavpen_rj260_linear_bearing_outer_r()
) =
    sqrt(pow(bearing_outer_r, 2) - pow(tensioner_travel_distance / 2, 2));


// Demo:

//pro_pavpen_linear_bearing_bracket_demo_nut_flap();
pro_pavpen_linear_bearing_bracket_printable();


module pro_pavpen_linear_bearing_bracket_printable(
    bearing_outer_r = pro_pavpen_rj260_linear_bearing_outer_r()
)
{
    rotate([180, 0, 0])
    union()
    {
        pro_pavpen_linear_bearing_bracket();
        
        // Top plate:
        translate([
            -tensioner_body_length / 2,
            -bearing_outer_r - wall_thickness,
            bearing_outer_r +
                pro_pavpen_linear_bearing_bracket_z_offset_to_center()])
        cube([
            tensioner_body_length,
            2 * bearing_outer_r + 2 * wall_thickness,
            wall_thickness]);
    }
}

module pro_pavpen_linear_bearing_bracket_demo_nut_flap()
{
    rotate([-90, 0, 0])
    difference()
    {
        pro_pavpen_linear_bearing_bracket_tensioner_nut_flap();
        
        cylinder(
                        r = tensioner_bolt_r,
                        h = 2 * wall_thickness +
                            tensioner_bolt_head_bed_depth +
                            tensioner_nut_bed_depth +
                            tensioner_travel_distance + 2,
                        center = true,
                        $fn = tensioner_fn);

        translate([
            -tensioner_nut_flap_r - 1,
            tensioner_nut_outer_r + 3,
            -1])
        cube([
            2 * tensioner_nut_flap_r + 2,
            2 * tensioner_nut_flap_r,
            wall_thickness + tensioner_nut_bed_depth + 2]);
    }
}


module pro_pavpen_linear_bearing_bracket(
    bearing_outer_r = pro_pavpen_rj260_linear_bearing_outer_r(),
    wall_thickness = wall_thickness
)
{
    module tensioner_flaps()
    {
        translate([0, 0, -3 * tensioner_bolt_r])
        rotate([90, 0, 0])
        difference()
        {
            union()
            {
                translate([0, 0, tensioner_travel_distance / 2])
                pro_pavpen_linear_bearing_bracket_tensioner_bolt_flap(
                    wall_thickness = wall_thickness,
                    tensioner_travel_distance = tensioner_travel_distance,
                    tensioner_bolt_head_r = tensioner_bolt_head_r,
                    tensioner_bolt_head_bed_depth = tensioner_bolt_head_bed_depth,
                    tensioner_bolt_flap_r = tensioner_bolt_flap_r,
                    tensioner_fn = tensioner_fn);
                
                translate([
                    0,
                    0,
                    -wall_thickness - tensioner_nut_bed_depth - tensioner_travel_distance / 2])
                pro_pavpen_linear_bearing_bracket_tensioner_nut_flap(
                    wall_thickness = wall_thickness,
                    tensioner_travel_distance = tensioner_travel_distance,
                    tensioner_nut_side_count = tensioner_nut_side_count,
                    tensioner_nut_outer_r = tensioner_nut_outer_r,
                    tensioner_nut_bed_depth = tensioner_nut_bed_depth,
                    tensioner_nut_flap_r = tensioner_nut_flap_r,
                    tensioner_fn = tensioner_fn);
            }

            cylinder(
                r = tensioner_bolt_r,
                h = 2 * wall_thickness +
                    tensioner_bolt_head_bed_depth +
                    tensioner_nut_bed_depth +
                    tensioner_travel_distance + 2,
                center = true,
                $fn = tensioner_fn);
        }
    }

    module tensioner_body()
    {
        translate([
            -tensioner_body_length / 2,
            0,
            sqrt(pow(bearing_outer_r, 2) -
                pow(tensioner_travel_distance / 2, 2))])
        rotate([0, 90, 0])
        pro_pavpen_linear_bearing_bracket_tensioner_body(
            bearing_outer_r = bearing_outer_r,
            wall_thickness = wall_thickness,
            tensioner_travel_distance = tensioner_travel_distance,
            tensioner_body_length = tensioner_body_length,
            tensioner_body_fn = tensioner_body_fn
        );
    }
    
    module tensioner_body_hole()
    {
        translate([
            -tensioner_body_length / 2,
            0,
            pro_pavpen_linear_bearing_bracket_z_offset_to_center()])
        rotate([0, 90, 0])
        pro_pavpen_linear_bearing_bracket_tensioner_body_hole(
            bearing_outer_r = bearing_outer_r,
            wall_thickness = wall_thickness,
            tensioner_travel_distance = tensioner_travel_distance,
            tensioner_body_length = tensioner_body_length,
            tensioner_body_fn = tensioner_body_fn
        );
    }

    difference()
    {
        union()
        {
            tensioner_flaps();
            tensioner_body();
        }

        tensioner_body_hole();
    }
}

module pro_pavpen_linear_bearing_bracket_tensioner_body(
    bearing_outer_r = pro_pavpen_rj260_linear_bearing_outer_r(),
    wall_thickness = wall_thickness,
    tensioner_travel_distance = tensioner_travel_distance,
    tensioner_body_length = tensioner_body_length,
    tensioner_body_fn = tensioner_body_fn
)
{
    difference()
    {
        cylinder(
            r = bearing_outer_r + wall_thickness,
            h = tensioner_body_length,
            $fn = tensioner_body_fn);

        pro_pavpen_linear_bearing_bracket_tensioner_body_hole(
            bearing_outer_r = bearing_outer_r,
            wall_thickness = wall_thickness,
            tensioner_travel_distance = tensioner_travel_distance,
            tensioner_body_length = tensioner_body_length,
            tensioner_body_fn = tensioner_body_fn
        );
    }
}

module pro_pavpen_linear_bearing_bracket_tensioner_body_hole(
    bearing_outer_r = pro_pavpen_rj260_linear_bearing_outer_r(),
    wall_thickness = wall_thickness,
    tensioner_travel_distance = tensioner_travel_distance,
    tensioner_body_length = tensioner_body_length,
    tensioner_body_fn = tensioner_body_fn
)
{
    union()
    {
        translate([0, 0, -1])
        cylinder(
            r = bearing_outer_r,
            h = tensioner_body_length + 2,
            $fn = tensioner_body_fn);

        translate([
            0,
            -tensioner_travel_distance / 2,
            -1])
        cube([
            bearing_outer_r + wall_thickness + 1,
            tensioner_travel_distance,
            tensioner_body_length + 2]);
    }
}

module pro_pavpen_linear_bearing_bracket_tensioner_bolt_flap(
    wall_thickness = wall_thickness,
    tensioner_travel_distance = tensioner_travel_distance,
    tensioner_bolt_head_r = tensioner_bolt_head_r,
    tensioner_bolt_head_bed_depth = tensioner_bolt_head_bed_depth,
    tensioner_bolt_flap_r = tensioner_bolt_flap_r,
    tensioner_fn = tensioner_fn
)
{
    difference()
    {
        linear_extrude(wall_thickness + tensioner_bolt_head_bed_depth)
        {
            circle(r = tensioner_bolt_flap_r, $fn = tensioner_fn);

            translate([-tensioner_bolt_flap_r, 0, 0])
            square(2 * tensioner_bolt_flap_r);
        }

        translate([0, 0, wall_thickness])
        cylinder(
            r = tensioner_bolt_head_r,
            h = tensioner_bolt_head_bed_depth + 1,
            $fn = tensioner_fn);
    }
}

module pro_pavpen_linear_bearing_bracket_tensioner_nut_flap(
    wall_thickness = wall_thickness,
    tensioner_travel_distance = tensioner_travel_distance,
    tensioner_nut_side_count = tensioner_nut_side_count,
    tensioner_nut_outer_r = tensioner_nut_outer_r,
    tensioner_nut_bed_depth = tensioner_nut_bed_depth,
    tensioner_nut_flap_r = tensioner_nut_flap_r,
    tensioner_fn = tensioner_fn
)
{
    difference()
    {
        linear_extrude(wall_thickness + tensioner_nut_bed_depth)
        {
            circle(r = tensioner_nut_flap_r, $fn = tensioner_fn);

            translate([-tensioner_nut_flap_r, 0, 0])
            square(2 * tensioner_nut_flap_r);
        }

        translate([0, 0, -1])
        cylinder(
            r = tensioner_nut_outer_r,
            h = tensioner_nut_bed_depth + 1,
            $fn = tensioner_nut_side_count);
    }
}
