# Overview of the Project

This is small collection of symbols implemented in Open SCAD that I've needed
for various projects.

Currently it contains symbols, such as:
* an arrow,
* a drop of liquid (e.g. water drop),
* maichine oil dispenser,
* 3D printer nozzle.


# License

You can use it under Creative Commons Attribution-ShareAlike 4.0 International
(CC BY-SA 4.0): https://creativecommons.org/licenses/by-sa/4.0/

If you need to use it under another license, send me a message:
https://www.thingiverse.com/pavpen/about


# Installation

You can install the pro.pavpen.OpenSCAD-libraries collection by copying the
`pro.pavpen` directory under you OpenSCAD installation's libraries directory.

E.g., on Ubuntu:

```bash
sudo su
cd /usr/share/openscad/libraries
git clone https://github.com/pavpen/pro.pavpen.openscad.git
```


# Using Symbols

Here's an example of using a symbol:

```OpenSCAD
use <pro.pavpen/Symbols/machine_oiling_symbol.scad>

symbol_h = 1;
symbol_border_width = 0.75;
symbol_offset = [-11.25, 0];


translate([
    symbol_offset[0],
    symbol_offset[1],
    9 - symbol_h])
linear_extrude(symbol_h)
offset(delta = symbol_border_width, r = symbol_border_width)
machine_oiling_symbol();
```


## Importing a Symbol

You can import each symbol with the `use` command.  E.g.:

```OpenSCAD
use <pro.pavpen/Symbols/arrow_symbol.scad>
```


## Symbol Characteristics

Each symbol has the following characteristics:

* Symbols are usually parametric.  I.e., you can customize their shape and size
by specifying parameter values when rendering.

* Symbols may have hotspots (e.g., the tip of an arrow symbol, or the outlet
point of a nozzle symbol).  Symbols may provide functions for calculating the
coordinates of each hotspot relevant to the symbol.  (E.g., this allows you to
calculate where a hotspot will end up after performing a transformation on the
symbol, and position other objects relative to that hotspot point.)

* Symbol are unions and differences of 2D polygons, which you can extrude to a
desired height.


## Data Structures

### Polygonal Object

A polygonal object is anything that can result from unions and differences of
2D polygons.

Have a look at `polygonal_object.scad` for data structure definition and
functions for working with it.


### Bounding Box

A 2D bounding box.  Have a look at `bounding_box.scad`.


## Symbol Functions and Modules

### A module that renders the symbol polygons

```OpenSCAD
<name>_symbol(<symbol parameters>);
```

Symbol parameters have default values, so a demo symbol can be rendered
without specifying any.

E.g.:

```OpenSCAD
arrow_symbol(
    tip_angle = 45,
    tip_line_width = 0.5
    tip_h = 2,
    total_length = 5,
    shaft_line_width = 0.5,
    centered_x = true,
    centered_y = false
);
```


### A function that returns the polygonal object of the symbol

```OpenSCAD
<name>_symbol_polygonal_object(<symbol parameters>)
```

Symbol parameters have default values, so a demo symbol can be rendered
without specifying any.

E.g.:

```OpenSCAD

polygonal_object =
    arrow_symbol_polygonal_object(
        tip_angle = tip_angle,
        tip_line_width = tip_line_width,
        tip_h = tip_h,
        total_length = total_length,
        shaft_line_width = shaft_line_width
    );
```


### Functions for calculating hotspot coordinates

Each symbol can provide any number of functions for calculating coordinates of
hotspot points.


```OpenSCAD
<name>_symbol_<hotspot_name>_xy(<symbol parameters>)
```

Symbol parameters have default values, so the coordinates of a hotspot can be
calculated without specifying any.

E.g.:

```OpenSCAD
echo(
    arrow_symbol_tip_xy(
        tip_angle = tip_angle,
        tip_line_width = tip_line_width,
        tip_h = tip_h,
        total_length = total_length,
        shaft_line_width = shaft_line_width
    );
);
```


### Functions for calculating a symbol bounding box

```OpenSCAD
// Returns a symbol's bounding box:
<name>_symbol_bounding_box(<symbol parameters>)
```
