// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

use <../list.scad>

// Demo:
pro_pavpen_rounded_corner_cube(
    [10, 5, 2.5],
    corner_r = [0, 0, 0, 0, 1.25, 1.25, 1.25, 1.25],
    $fn = 25);


// Renders a cube solid with rounded corners.
//     size = cube edge (scalar), or cube [x, y, z] dimensions.
//     corner_r = radius of the rounded corner (scalar), or
// [r, r, r, r, r, r, r, r] vector of radii of the rounded corners for each
// cube vertex.  Vertices are enumerated from low z to high z (bottom face
// first), low y to high y (front first), and, finally, low x to high x
// (left side first).
//     center = whether the cube center is at the origin, or a vertex.
module pro_pavpen_rounded_corner_cube(
    size,
    corner_r = 1.5,
    center = false
)
{
    outer_dimensions = len(size) == undef ? [size, size, size] : size;

    hull()
    {
        for (z_idx = [0, 1])
        {
            for (y_idx = [0, 1])
            {
                for (x_idx = [0, 1])
                {
                    r = len(corner_r) == undef ?
                        corner_r :
                        corner_r[x_idx + 2 * y_idx + 4 * z_idx];
                    vertex_offset = pro_pavpen_list_elementwise_product(
                            (center ?
                                [x_idx, y_idx, z_idx] / 2 :
                                [x_idx, y_idx, z_idx]),
                            outer_dimensions);
                    sphere_center_offset =
                        r * [1 - 2 * x_idx, 1 - 2 * y_idx, 1 - 2 * z_idx];

                    // Ensure we don't extend outside the cube's outer
                    // dimensions:
                    intersection()
                    {
                        if (r > 0)
                        {
                            translate(vertex_offset +sphere_center_offset)
                            sphere(r = r);
                        }
                        else
                        {
                            translate(vertex_offset + sphere_center_offset)
                            cube(size = 1e-5, center = true);
                        }
                        
                        cube(size = size, center = center);
                    }
                }
            }
        }
    }
}