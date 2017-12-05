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


body_width = 8;
body_height = 4.5;
body_corner_r = 0.5;
nozzle_inlet_start_h = body_corner_r;
nozzle_inlet_end_h = 3;
nozzle_outlet_start_h = body_height + 1;
nozzle_outlet_end_h = nozzle_outlet_start_h + 0.25;
nozzle_horizontal_extent = 7;

$fn = 25;

// Demo:
pro_pavpen_machine_oil_dispenser_symbol();

// Mark the nozzle outlet tip:
translate(concat(
    pro_pavpen_machine_oil_dispenser_symbol_nozzle_tip_xy(),
    [0]))
color([0, 0, 1, 0.5])
%sphere(r = 0.75, $fn = 50);


echo(str(
    "<strong>Machine oil dispenser symbol bounding box: ",
    pro_pavpen_machine_oil_dispenser_symbol_bounding_box(), "</strong>"));


function pro_pavpen_machine_oil_dispenser_symbol_nozzle_tip_xy(
    body_width = body_width,
    body_height = body_height,
    body_corner_r = body_corner_r,
    nozzle_inlet_start_h = nozzle_inlet_start_h,
    nozzle_inlet_end_h = nozzle_inlet_end_h,
    nozzle_outlet_start_h = nozzle_outlet_start_h,
    nozzle_outlet_end_h = nozzle_outlet_end_h,
    nozzle_horizontal_extent = nozzle_horizontal_extent
) =
    [
        -nozzle_horizontal_extent,
        (nozzle_outlet_end_h + nozzle_outlet_start_h) / 2
    ];

function pro_pavpen_machine_oil_dispenser_symbol_points(
    body_width = body_width,
    body_height = body_height,
    body_corner_r = body_corner_r,
    nozzle_inlet_start_h = nozzle_inlet_start_h,
    nozzle_inlet_end_h = nozzle_inlet_end_h,
    nozzle_outlet_start_h = nozzle_outlet_start_h,
    nozzle_outlet_end_h = nozzle_outlet_end_h,
    nozzle_horizontal_extent = nozzle_horizontal_extent
) =
    concat(
        // Nozzle inlet bottom:
        [
            [0, nozzle_inlet_start_h]
        ],
        // Body bottom left corner:
        [for (angle = [180 : 360 / $fn : 270])
            [body_corner_r + body_corner_r * cos(angle),
             body_corner_r + body_corner_r * sin(angle)]
        ],
        // Body bottom right corner:
        [for (angle = [270 : 360 / $fn : 360])
            [body_width - body_corner_r + body_corner_r * cos(angle),
             body_corner_r + body_corner_r * sin(angle)]
        ],
        // Body top right corner:
        [for (angle = [0 : 360 / $fn : 90])
            [body_width - body_corner_r + body_corner_r * cos(angle),
             body_height - body_corner_r + body_corner_r * sin(angle)]
        ],
        // Body top left corner:
        [for (angle = [90 : 360 / $fn : 180])
            [body_corner_r + body_corner_r * cos(angle),
             body_height - body_corner_r + body_corner_r * sin(angle)]
        ],
        [
            // Nozzle inlet top:
            [0, nozzle_inlet_end_h],
            // Nozzle outlet top:
            [-nozzle_horizontal_extent,
             nozzle_outlet_end_h],
            // Nozzle outlet bottom:
            [-nozzle_horizontal_extent,
             nozzle_outlet_start_h]
        ]
    );

function pro_pavpen_machine_oil_dispenser_symbol_polygon(
    body_width = body_width,
    body_height = body_height,
    body_corner_r = body_corner_r,
    nozzle_inlet_start_h = nozzle_inlet_start_h,
    nozzle_inlet_end_h = nozzle_inlet_end_h,
    nozzle_outlet_start_h = nozzle_outlet_start_h,
    nozzle_outlet_end_h = nozzle_outlet_end_h,
    nozzle_horizontal_extent = nozzle_horizontal_extent
) =
    pro_pavpen_polygon_from_points(
        pro_pavpen_machine_oil_dispenser_symbol_points(
            body_width = body_width,
            body_height = body_height,
            body_corner_r = body_corner_r,
            nozzle_inlet_start_h = nozzle_inlet_start_h,
            nozzle_inlet_end_h = nozzle_inlet_end_h,
            nozzle_outlet_start_h = nozzle_outlet_start_h,
            nozzle_outlet_end_h = nozzle_outlet_end_h,
            nozzle_horizontal_extent = nozzle_horizontal_extent
        )
    );

function pro_pavpen_machine_oil_dispenser_symbol_polygonal_object(
    body_width = body_width,
    body_height = body_height,
    body_corner_r = body_corner_r,
    nozzle_inlet_start_h = nozzle_inlet_start_h,
    nozzle_inlet_end_h = nozzle_inlet_end_h,
    nozzle_outlet_start_h = nozzle_outlet_start_h,
    nozzle_outlet_end_h = nozzle_outlet_end_h,
    nozzle_horizontal_extent = nozzle_horizontal_extent
) =
    pro_pavpen_polygonal_object_from_points(
        pro_pavpen_machine_oil_dispenser_symbol_points(
            body_width = body_width,
            body_height = body_height,
            body_corner_r = body_corner_r,
            nozzle_inlet_start_h = nozzle_inlet_start_h,
            nozzle_inlet_end_h = nozzle_inlet_end_h,
            nozzle_outlet_start_h = nozzle_outlet_start_h,
            nozzle_outlet_end_h = nozzle_outlet_end_h,
            nozzle_horizontal_extent = nozzle_horizontal_extent
        )
    );

function pro_pavpen_machine_oil_dispenser_symbol_bounding_box(
    body_width = body_width,
    body_height = body_height,
    body_corner_r = body_corner_r,
    nozzle_inlet_start_h = nozzle_inlet_start_h,
    nozzle_inlet_end_h = nozzle_inlet_end_h,
    nozzle_outlet_start_h = nozzle_outlet_start_h,
    nozzle_outlet_end_h = nozzle_outlet_end_h,
    nozzle_horizontal_extent = nozzle_horizontal_extent
) =
    pro_pavpen_polygon_bounding_box(
        pro_pavpen_machine_oil_dispenser_symbol_polygon(
            body_width = body_width,
            body_height = body_height,
            body_corner_r = body_corner_r,
            nozzle_inlet_start_h = nozzle_inlet_start_h,
            nozzle_inlet_end_h = nozzle_inlet_end_h,
            nozzle_outlet_start_h = nozzle_outlet_start_h,
            nozzle_outlet_end_h = nozzle_outlet_end_h,
            nozzle_horizontal_extent = nozzle_horizontal_extent
        )
    );

module pro_pavpen_machine_oil_dispenser_symbol(
    body_width = body_width,
    body_height = body_height,
    body_corner_r = body_corner_r,
    nozzle_inlet_start_h = nozzle_inlet_start_h,
    nozzle_inlet_end_h = nozzle_inlet_end_h,
    nozzle_outlet_start_h = nozzle_outlet_start_h,
    nozzle_outlet_end_h = nozzle_outlet_end_h,
    nozzle_horizontal_extent = nozzle_horizontal_extent
)
{
    points = pro_pavpen_machine_oil_dispenser_symbol_points(
        body_width = body_width,
        body_height = body_height,
        body_corner_r = body_corner_r,
        nozzle_inlet_start_h = nozzle_inlet_start_h,
        nozzle_inlet_end_h = nozzle_inlet_end_h,
        nozzle_outlet_start_h = nozzle_outlet_start_h,
        nozzle_outlet_end_h = nozzle_outlet_end_h,
        nozzle_horizontal_extent = nozzle_horizontal_extent
    );

    polygon(points = points);
}
