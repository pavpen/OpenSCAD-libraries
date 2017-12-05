// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

// Report bugs to <https://www.thingiverse.com/pavpen/about>.

use <../bounding_box.scad>
use <../polygon.scad>
use <../polygonal_object.scad>


tip_angle = 45;
tip_line_width = 0.5;
tip_h = 2;
total_length = 5;
shaft_line_width = 0.5;


// Demo:
pro_pavpen_arrow_symbol();

// Mark the arrow tip:
translate(concat(
    pro_pavpen_arrow_symbol_tip_xy(),
    [0]))
color([0, 0, 1, 0.5])
%sphere(r = 0.75, $fn = 50);

// Mark the arrow tail:
translate(concat(
    pro_pavpen_arrow_symbol_tail_xy(),
    [0]))
color([1, 0, 0, 0.5])
%sphere(r = 0.75, $fn = 50);


echo(str(
    "<strong>Arrow symbol bounding box: ",
    pro_pavpen_arrow_symbol_bounding_box(), "</strong>"));


function pro_pavpen_arrow_symbol_tip_xy(
    tip_angle = tip_angle,
    tip_line_width = tip_line_width,
    tip_h = tip_h,
    total_length = total_length,
    shaft_line_width = shaft_line_width
) =
    [0, 0];

function pro_pavpen_arrow_symbol_tail_xy(
    tip_angle = tip_angle,
    tip_line_width = tip_line_width,
    tip_h = tip_h,
    total_length = total_length,
    shaft_line_width = shaft_line_width
) =
    [0, -total_length];

function pro_pavpen_arrow_symbol_points(
    tip_angle = tip_angle,
    tip_line_width = tip_line_width,
    tip_h = tip_h,
    total_length = total_length,
    shaft_line_width = shaft_line_width
) =
    let (left_half =
    [
        // Arrow tip:
        [0,   0],
        [-tip_h * tan(tip_angle / 2) - tip_line_width / 2,   -tip_h],
        [-tip_h * tan(tip_angle / 2) + tip_line_width / 2,   -tip_h],
        [-shaft_line_width / 2,   -(tip_line_width + shaft_line_width / 2) / tan(tip_angle / 2)],
        [-shaft_line_width / 2, -total_length]
    ])
    
    // Reflect left_half around the vertical axis:
    let(right_half_reverse = left_half *
        [[-1, 0],
         [0, 1]])
    
    let(right_half = [for (i = [len(right_half_reverse) - 1 : -1 : 0 ]) right_half_reverse[i]])
    
    concat(left_half, right_half);

function pro_pavpen_arrow_symbol_polygon(
    tip_angle = tip_angle,
    tip_line_width = tip_line_width,
    tip_h = tip_h,
    total_length = total_length,
    shaft_line_width = shaft_line_width
) =
    pro_pavpen_polygon_from_points(
        pro_pavpen_arrow_symbol_points(
            tip_angle = tip_angle,
            tip_line_width = tip_line_width,
            tip_h = tip_h,
            total_length = total_length,
            shaft_line_width = shaft_line_width
        )
    );

function pro_pavpen_arrow_symbol_polygonal_object(
    tip_angle = tip_angle,
    tip_line_width = tip_line_width,
    tip_h = tip_h,
    total_length = total_length,
    shaft_line_width = shaft_line_width
) =
    pro_pavpen_polygonal_object_from_points(
        pro_pavpen_arrow_symbol_points(
            tip_angle = tip_angle,
            tip_line_width = tip_line_width,
            tip_h = tip_h,
            total_length = total_length,
            shaft_line_width = shaft_line_width            
        )
    );

function pro_pavpen_arrow_symbol_bounding_box(
    tip_angle = tip_angle,
    tip_line_width = tip_line_width,
    tip_h = tip_h,
    total_length = total_length,
    shaft_line_width = shaft_line_width
) =
    pro_pavpen_polygon_bounding_box(
        pro_pavpen_arrow_symbol_polygon(
            tip_angle = tip_angle,
            tip_line_width = tip_line_width,
            tip_h = tip_h,
            total_length = total_length,
            shaft_line_width = shaft_line_width
        )
    );


module pro_pavpen_arrow_symbol(
    tip_angle = tip_angle,
    tip_line_width = tip_line_width,
    tip_h = tip_h,
    total_length = total_length,
    shaft_line_width = shaft_line_width,
    centered_x = true,
    centered_y = false
)
{
    bbox = pro_pavpen_arrow_symbol_bounding_box(
        tip_angle = tip_angle,
        tip_line_width = tip_line_width,
        tip_h = tip_h,
        total_length = total_length,
        shaft_line_width = shaft_line_width
    );
    symbol_width = pro_pavpen_bounding_box_width(bbox);
    symbol_height = pro_pavpen_bounding_box_height(bbox);

    translate([
        centered_x ? 0 : symbol_width / 2,
        centered_y ? symbol_height / 2 : 0])
    polygon(
        points = pro_pavpen_arrow_symbol_points(
            tip_angle = tip_angle,
            tip_line_width = tip_line_width,
            tip_h = tip_h,
            total_length = total_length,
            shaft_line_width = shaft_line_width
        )
    );
}
