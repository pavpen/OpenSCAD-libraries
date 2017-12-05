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


nozzle_d = 0.4;

// Demo:
pro_pavpen_3d_printer_nozzle_symbol();

echo(str(
    "<strong>3D printer nozzle symbol bounding box: ",
    pro_pavpen_3d_printer_nozzle_symbol_bounding_box(), "</strong>"));


function pro_pavpen_3d_printer_nozzle_symbol_points(
    nozzle_d = nozzle_d
) =
    let (left_half =
    [
        [               -3, 12.5],
        [               -3,  6.5],
        [             -2.5,  6.5],
        [             -2.5,  5],
        [             -3.5,  5],
        [             -3.5,  2],
        [-1.5 - nozzle_d/2,  2],
        [      -nozzle_d/2,  0]
    ])

    // Reflect left_half around the vertical axis:
    let(right_half_reverse = left_half *
        [[-1, 0],
         [ 0, 1]])

    let(right_half = [for (i = [len(right_half_reverse) - 1 : -1 : 0 ]) right_half_reverse[i]])

    concat(left_half, right_half);

function pro_pavpen_3d_printer_nozzle_symbol_polygon(
    nozzle_d = nozzle_d
) =
    pro_pavpen_polygon_from_points(
        pro_pavpen_3d_printer_nozzle_symbol_points(
            nozzle_d = nozzle_d
        )
    );

function pro_pavpen_3d_printer_nozzle_symbol_polygonal_object(
    nozzle_d = nozzle_d
) =
    pro_pavpen_polygonal_object_from_points(
        pro_pavpen_3d_printer_nozzle_symbol_points(
            nozzle_d = nozzle_d
        )
    );

function pro_pavpen_3d_printer_nozzle_symbol_bounding_box(
    nozzle_d = nozzle_d
) =
    pro_pavpen_polygon_bounding_box(
        pro_pavpen_3d_printer_nozzle_symbol_polygon(
            nozzle_d = nozzle_d
        )
    );

// 0.4-mm 3D printer nozzle 2D symbol (based on E3D v6):
module pro_pavpen_3d_printer_nozzle_symbol(
    nozzle_d = nozzle_d,
    centered_x = true,
    centered_y = false)
{
    bbox = pro_pavpen_3d_printer_nozzle_symbol_bounding_box(
        nozzle_d = nozzle_d
    );
    symbol_width = pro_pavpen_bounding_box_width(bbox);
    symbol_height = pro_pavpen_bounding_box_height(bbox);

    translate([
        centered_x ? 0 : symbol_width / 2,
        centered_y ? -symbol_height / 2 : 0])
    polygon(points = pro_pavpen_3d_printer_nozzle_symbol_points(
        nozzle_d = nozzle_d));
}
