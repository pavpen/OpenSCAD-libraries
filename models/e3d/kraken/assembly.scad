// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

use <cooler_block.scad>
use <../v6/heat_break.scad>
use <../v6/heater_block.scad>
use <../v6/nozzle.scad>

// Demo:
pro_pavpen_e3d_kraken_assembly();
//e3d_kraken_nozzle_assembly();


module pro_pavpen_e3d_kraken_assembly()
{
    union()
    {
        pro_pavpen_e3d_kraken_cooler_block();
        
        pro_pavpen_e3d_kraken_cooler_block_position_as_heat_break_holes(
            mirror_along_y = true)
        translate([
            0,
            0,
            -pro_pavpen_e3d_v6_heat_break_threaded_base_h() -
                pro_pavpen_e3d_v6_heat_break_neck_h()])
        pro_pavpen_e3d_kraken_nozzle_assembly();
    }
}

module pro_pavpen_e3d_kraken_nozzle_assembly()
{
        union()
        {
            // Heat break:
            pro_pavpen_e3d_v6_heat_break();

            // Heater block:
            rotate([0, 0, 90])
            translate([
                0,
                0,
                -pro_pavpen_e3d_v6_heater_block_outer_dimensions()[2] +
                    pro_pavpen_e3d_v6_heat_break_threaded_base_h()])
            scale([-1, -1, -1])
            pro_pavpen_e3d_v6_heater_block_position_as_nozzle_hole()
            scale([-1, -1, -1])
            pro_pavpen_e3d_v6_heater_block();
            
            // Nozzle:
            translate([0, 0, -pro_pavpen_e3d_v6_nozzle_total_h()])
            pro_pavpen_e3d_v6_nozzle();
        }
}
