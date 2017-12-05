// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

// Report bugs to <https://www.thingiverse.com/pavpen/about>.

use <../linear_transform.scad>
use <../polygonal_object.scad>
use <liquid_drop_symbol.scad>
use <machine_oil_dispenser_symbol.scad>

// Demo:
machine_oiling_symbol();

echo(str(
    "<strong>Machine oiling symbol bounding box: ",
    pro_pavpen_machine_oiling_symbol_bounding_box(), "</strong>"));



function pro_pavpen_machine_oiling_symbol_polygonal_object() =
    pro_pavpen_polygonal_objects_add(
        // Oil dispenser:
        pro_pavpen_polygonal_object_transform(
            pro_pavpen_machine_oil_dispenser_symbol_polygonal_object(),
            pro_pavpen_rotate_transform([0, 0, 20]) *
            // Move the oil dispenser outlet to the origin:
            pro_pavpen_translate_transform(
                concat(
                    -pro_pavpen_machine_oil_dispenser_symbol_nozzle_tip_xy(),
                    [0]
                )
            )
        ),

        // Oil drop:
        pro_pavpen_polygonal_object_transform(
            pro_pavpen_liquid_drop_symbol_polygonal_object(),
            pro_pavpen_translate_transform([0, -1.5, 0]) *
            // Move the oil drop tip to the origin:
            pro_pavpen_translate_transform(
                concat(
                    -pro_pavpen_liquid_drop_symbol_tip_xy(),
                    [0]
                )
            )
        )
    );

function pro_pavpen_machine_oiling_symbol_bounding_box() =
    pro_pavpen_polygonal_object_additions_bounding_box(
        pro_pavpen_machine_oiling_symbol_polygonal_object()
    );

module machine_oiling_symbol()
{
    pro_pavpen_polygonal_object(
        pro_pavpen_machine_oiling_symbol_polygonal_object()
    );
}
