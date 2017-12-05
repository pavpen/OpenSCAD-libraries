// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

// Polygon functions and modules

use <bounding_box.scad>
use <linear_transform.scad>
use <list.scad>


// Polygon data structure:
//
// [
//     // Meta information:
//     [
//         // The polygon's bounding box. (See <bounding_box.scad>.)
//         <bounding box> 
//     ],
//
//     // Polygon data:
//     [
//         // Vertex coordinates:
//         [x, y], [x, y], . . .
//     ]
// ]


// Constructs a polygon data structure from a list of vertex coordinates.
//     points = [ [x, y], [x, y], . . . ]
function pro_pavpen_polygon_from_points(points) =
    [
        // Meta information:
        [
            // Bounding box:
            pro_pavpen_points_bounding_box(points)
        ],

        // Polygon vertices:
        points
    ];

function pro_pavpen_polygon_bounding_box(polygon) =
    polygon[0][0];

// Applies an affine transformation matrix to all points in the polygon.
function pro_pavpen_polygon_transform(polygon, matrix) =
    let (points = polygon[1])
    pro_pavpen_polygon_from_points(
        [for (point = points)
            let (
                pad_dimension_count = len(matrix[0]) - len(point),
                affine_coordinates =
                    matrix * concat(point,
                        [for (i = [1 : pad_dimension_count])
                            i == pad_dimension_count ? 1 : 0])
            )
            // Drop the last padding coordinate:
            pro_pavpen_list_drop_last(affine_coordinates, pad_dimension_count)
        ]
    );

module pro_pavpen_polygon(polygon)
{
    polygon(polygon[1]);
}
