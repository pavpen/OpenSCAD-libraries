// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

use <bounding_box.scad>
use <list.scad>
use <polygon.scad>


// Polygonal object data structure:
//
// [
//     // Polygon 1:
//     [
//         // Metadata:
//         [
//             // +1, if the polygon is to be added to the polygonal object
//             // constructed so far, -1, if the polygon is to be subtracted:
//             +/-1
//         ],
//         <polygon data structure>
//     ],
//
//     // Polygon 2. Same structure as above, etc.
//     . . .
// ]


// Returns a polygonal object containing the polygon specified by the given
// points:
function pro_pavpen_polygonal_object_from_points(points) =
    [
        // Polygon 1:
        [
            // Metadata:
            [ +1 ], // Add the polygon.
            pro_pavpen_polygon_from_points(points)
        ]
    ];

// For debugging:
triangle_1_vertices =
    [
        [ 0,  0],
        [10,  0],
        [10, 10]
    ];

triangle_2_vertices =
    [
        [10,  0],
        [10, 10],
        [ 0, 10]
    ];

triangle_1_polygonal_object = pro_pavpen_polygonal_object_from_points(
            triangle_1_vertices);

triangle_2_polygonal_object = pro_pavpen_polygonal_object_from_points(
            triangle_2_vertices);


echo(
    str(
        "<strong>Triangle 1 polygonal object:</strong> ",
        str(triangle_1_polygonal_object)
    )
);


// Returns a polygonal object that results from adding all of the operations
// in the given polygonal objects.
//     If the objects don't overlap, this is equivallent to union.
//     The objects can be specified either as a list, or up to 10 function
// arguments.
function pro_pavpen_polygonal_objects_add(
    polygonal_objects,
    o1 = undef, o2 = undef, o3 = undef, o4 = undef,
    o5 = undef, o6 = undef, o7 = undef, o8 = undef,
    o9 = undef
) =
    // Check if `polygonal_objects` is a list of objects, or if the objects
    // have been supplied as individual arguments:
    polygonal_objects[0][0][0][0] == undef ?
        pro_pavpen_polygonal_objects_add(
            [for (o = [polygonal_objects, o1, o2, o3, o4,
                       o5, o6, o7, o8, o9])
                if (o != undef)
                    o
            ]
        )
    :
        // Concatenate polygons:
        [
            for (object = polygonal_objects)
                for (polygon_container = object)
                    polygon_container
        ];

sum_polygonal_object =
    pro_pavpen_polygonal_objects_add(
        triangle_1_polygonal_object,
        triangle_2_polygonal_object
    );

echo(
    str(
        "<strong>Sum polygonal object:</strong> ",
        str(sum_polygonal_object)
    )
);

translate([0, 0, 1])
pro_pavpen_polygonal_object(sum_polygonal_object);


// Returns a difference between the first polygonal object and all of the
// operations in the following ones.
//     The objects can be specified either as a list, or up to 10 function
// arguments.
function pro_pavpen_polygonal_object_subtract(
    polygonal_objects,
    o1 = undef, o2 = undef, o3 = undef, o4 = undef,
    o5 = undef, o6 = undef, o7 = undef, o8 = undef,
    o9 = undef
) =
    // Check if `polygonal_objects` is a list of objects, or if the objects
    // have been supplied as individual arguments:
    polygonal_objects[0][0][0][0] == undef ?
        pro_pavpen_polygonal_object_subtract(
            [for (o = [polygonal_objects, o1, o2, o3, o4,
                       o5, o6, o7, o8, o9])
                if (o != undef)
                    o
            ]
        )
    :
        [for (i = [0 : len(polygonal_objects)])
            for (polygon_container = polygonal_objects[i])
                i == 0 ?
                    polygon_container :
                    // Negate polygons in polygonal objects after the first
                    // one:
                    [
                        // Metadata:
                        [
                            // Negate polygon:
                            -polygon_container[0][0]
                        ],
                        // Polygon data structure:
                        polygon_container[1]
                    ]
        ];


// Returns the polygonal object with an affine transform applied.
function pro_pavpen_polygonal_object_transform(polygonal_object, matrix) =
    [for (polygon_container = polygonal_object)
        [
            // Polygon metadata doesn't transform:
            polygon_container[0],
            // Transform the polygon:
            pro_pavpen_polygon_transform(polygon_container[1], matrix)
        ]
    ];

// Returns a bounding box around all the added polygons in a polygonal object.
function pro_pavpen_polygonal_object_additions_bounding_box(
    polygonal_object
) =
    pro_pavpen_bounding_box_union([
        for (polygon_container = polygonal_object)
            if (polygon_container[0][0] > 0)
                pro_pavpen_polygon_bounding_box(polygon_container[1])
    ]);


// Renders a polygonal object:
module pro_pavpen_polygonal_object(polygonal_object, start_polygon_index = 0)
{
    if (start_polygon_index < len(polygonal_object))
    {
        polygon_container = polygonal_object[start_polygon_index];
        polygon_sign = polygon_container[0][0];
        polygon = polygon_container[1];

        if ($children > 0)
        {
            if (polygon_sign < 0)
            {
                pro_pavpen_polygonal_object(
                    polygonal_object,
                    start_polygon_index + 1)
                difference()
                {
                    children();

                    pro_pavpen_polygon(polygon);
                }
            }
            else
            {
                pro_pavpen_polygonal_object(
                    polygonal_object,
                    start_polygon_index + 1)
                union()
                {
                    children();

                    pro_pavpen_polygon(polygon);
                }
            }
        }
        else
        {
            if (polygon_sign > 0)
            {
                pro_pavpen_polygonal_object(
                    polygonal_object,
                    start_polygon_index + 1)
                pro_pavpen_polygon(polygon);
            }
            else
            {
                pro_pavpen_polygonal_object(
                    polygonal_object,
                    start_polygon_index + 1)
                {}
            }
        }
    }
    else
    {
        children();
    }
}

// Demo:
translate([0, 0, 3])
pro_pavpen_polygonal_object(triangle_1_polygonal_object);

