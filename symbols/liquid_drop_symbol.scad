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


drop_r = 1;
drop_h = drop_r + 2;

$fn = 25;

// Demo:
pro_pavpen_liquid_drop_symbol();

// Mark the liquid drop tip:
translate(concat(
    pro_pavpen_liquid_drop_symbol_tip_xy(),
    [0]))
color([0, 0, 1, 0.5])
%sphere(r = 0.75, $fn = 50);


echo(str(
    "<strong>Liquid drop symbol bounding box: ",
    pro_pavpen_liquid_drop_symbol_bounding_box(), "</strong>"));


function pro_pavpen_liquid_drop_symbol_tip_xy(
    drop_r = drop_r,
    drop_h = drop_h
) =
    [0, 0];

function pro_pavpen_liquid_drop_symbol_points(
    drop_r = drop_r,
    drop_h = drop_h
) =
    // Drop tip distance from circle's center:
    let (d_c = drop_h - drop_r,
        start_angle = acos(drop_r / d_c)) 
    concat(
        [
            [0, 0] // Drop tip.
        ],
        // Circular part:
        [for (angle = [90 - start_angle : -360 / $fn : -270 + start_angle])
            [drop_r * cos(angle),
             -drop_h + drop_r + drop_r * sin(angle)]
        ]
    );

function pro_pavpen_liquid_drop_symbol_polygon(
    drop_r = drop_r,
    drop_h = drop_h
) =
    pro_pavpen_polygon_from_points(
        pro_pavpen_liquid_drop_symbol_points(
            drop_r = drop_r,
            drop_h = drop_h
        )
    );

function pro_pavpen_liquid_drop_symbol_polygonal_object(
    drop_r = drop_r,
    drop_h = drop_h
) =
    pro_pavpen_polygonal_object_from_points(
        pro_pavpen_liquid_drop_symbol_points(
            drop_r = drop_r,
            drop_h = drop_h
        )
    );

function pro_pavpen_liquid_drop_symbol_bounding_box(
    drop_r = drop_r,
    drop_h = drop_h
) =
    pro_pavpen_polygon_bounding_box(
        pro_pavpen_liquid_drop_symbol_polygon(
            drop_r = drop_r,
            drop_h = drop_h
        )
    );


module pro_pavpen_liquid_drop_symbol(
    drop_r = drop_r,
    drop_h = drop_h
)
{
    polygon(
        points = pro_pavpen_liquid_drop_symbol_points(
            drop_r = drop_r,
            drop_h = drop_h
        ));
}
