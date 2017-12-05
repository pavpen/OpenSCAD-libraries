// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

// Functions for generating linear transformation matrices.

echo(str(
    "Matrix for translating by [1, 2, 3]: ",
    pro_pavpen_translate_transform([1, 2, 3])));


// Returns an affine transform matrix for rotating by a given angle around a
// given axis, or by given amounts around each of the coordinate axes.
function pro_pavpen_rotate_transform(
    a,
    v = [0, 0, 1]
) =
    len(a) == undef ?
    (
        // a is a scalar, rotate around v:
        let (
            rotation_axis_vector_length =
                sqrt(v * v),
            unit_axis = v / rotation_axis_vector_length,
            l = unit_axis[0],
            m = unit_axis[1],
            n = unit_axis[2]
        )
        [
            [
                l * l * (1 - cos(a)) + cos(a),
                m * l * (1 - cos(a)) - n * sin(a),
                n * l * (1 - cos(a)) + m * sin(a),
                0
            ],
            [
                l * m * (1 - cos(a)) + n * sin(a),
                m * m * (1 - cos(a)) + cos(a),
                n * m * (1 - cos(a)) - l * sin(a),
                0
            ],
            [
                l * n * (1 - cos(a)) - m * sin(a),
                m * n * (1 - cos(a)) + l * sin(a),
                n * n * (1 - cos(a)) + cos(a),
                0
            ],
            // Affine padding:
            [0, 0, 0, 1]
        ]
    )
    :
        // a is a vector:
        let (
            s_a = sin(a[0]),
            c_a = cos(a[0]),
            s_b = sin(a[1]),
            c_b = cos(a[1]),
            s_g = sin(a[2]),
            c_g = cos(a[2])
        )
        [
            [c_b * c_g,   s_a * s_b * c_g - c_a * s_g,   c_a * s_b * c_g + s_a * s_g,   0],
            [c_b * s_g,   s_a * s_b * s_g + c_a * c_g,   c_a * s_b * s_g - s_a * c_g,   0],
            [     -s_b,                     s_a * c_b,                     c_a * c_b,   0],
            [        0,                             0,                             0,   1]
        ];

// Returns an affine transform matrix for translating by a given vector.
function pro_pavpen_translate_transform(v) =
    [for (row_idx = [0 : len(v)])
        [for (col_idx = [0 : len(v)])
            row_idx >= len(v) ?
            // The last row is affine padding:
            (
                row_idx == col_idx ? 1 : 0
            )
            :
            (
                col_idx >= len(v) ?
                    // The last column is the translation column:
                    v[row_idx] :
                    // Previous columns form the identity matrix:
                    (row_idx == col_idx ? 1 : 0)
            )
        ]
    ];

// Returns an affine transform matrix for scaling by a given factor in each
// dimension.
function pro_pavpen_scale_transform(v) =
    [for (row_idx = [0 : len(v)])
        [for (col_idx = [0: len(v)])
            row_idx >= lev(v) ?
                // The last row is affine padding:
                (
                    row_idx == col_idx ? 1 : 0
                )
                :
                (
                    row_idx == col_idx ? v[row_idx] : 0
                )
        ]
    ];
