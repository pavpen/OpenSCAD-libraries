// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

// Bounding box functions

// Bounding box data structure:
//
// [x_min, y_min, x_max, y_max]


// Returns the width spanned by a bounding box:
function pro_pavpen_bounding_box_width(bbox) =
    bbox[len(bbox) / 2] - bbox[0];

// Returns the height spanned by a bounding box:
function pro_pavpen_bounding_box_height(bbox) =
    bbox[len(bbox) / 2 + 1] - bbox[1];

// Constructs a bounding box data structure from a list of vertex coordinates:
function pro_pavpen_points_bounding_box(points) =
    let (x_coordinates = [ for (point = points) point[0] ],
         y_coordinates = [ for (point = points) point[1] ])
    [
        min(x_coordinates),
        min(y_coordinates),
        max(x_coordinates),
        max(y_coordinates)
    ];

// Returns a bounding box containg all of the given bounding boxes.
//     The given bounding boxes can be specified as a list, or as up to 10
// arguments to the function.
function pro_pavpen_bounding_box_union(
    boxes, b1 = undef, b2 = undef, b3 = undef, b4 = undef,
    b5 = undef, b6 = undef, b7 = undef, b8 = undef, b9 = undef
) =
    boxes[0][0] == undef ?
        // Boxes are specified as function arguments:
        pro_pavpen_bounding_box_union([
            for (o = [boxes, b1, b2, b3, b4, b5, b6, b7, b8, b9])
               if (o != undef)
                   o
        ])
        :
        [
            min([ for (box = boxes) box[0] ]),
            min([ for (box = boxes) box[1] ]),
            max([ for (box = boxes) box[2] ]),
            max([ for (box = boxes) box[3] ])
        ];
