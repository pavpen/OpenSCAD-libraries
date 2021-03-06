pro.pavpen.openscad Libraries
=============================

A collection of re-usable OpenSCAD code.

# Contents

## Parametric Symbols

See `pro.pavpen/symbols` for more details.  The symbols include:

* 3D Printer Nozzle: ![3D Printer Nozzle Symbol](documentation/images/3d_printer_nozzle_symbol.svg)
* Arrow: ![Arrow Symbol](documentation/images/arrow_symbol.svg)
* Liquid (e.g. Water) Drop: ![Liquid Drop Symbol](documentation/images/liquid_drop_symbol.svg)
* Machine Oil Dispenser: ![Machine Oil Dispenser Symbol](documentation/images/machine_oil_dispenser_symbol.svg)
* Machine Oiling: ![Machine Oiling Symbol](documentation/images/machine_oiling_symbol.svg)


## Geometric Constructs

* Cube with rounded corners: ![Cube with rounded corners demo](documentation/images/rounded_corner_cube-demo-01.png)


## Models

* Kraken extruder assembly (each component):
![E3D Kraken assembly demo](documentation/images/kraken_assembly-demo-01.png)
![E3D Kraken assembly demo](documentation/images/kraken_assembly-demo-02.png)
* Chimera / Cyclops radiator:
![Chimera / Cyclops radiator demo](documentation/images/chimera_cyclops_radiator-demo-01.png)
* Extrudite radial cooling fan:
![Radial cooling fan demo](documentation/images/radial_cooling_fan-demo-01.png)
* Linear bearing:
![RJ260 linear bearing demo](documentation/images/rj260_linear_bearing-demo-01.png)
* Linear bearing bracket:
![Linear bearing bracket demo](documentation/images/linear_bearing_bracket-demo-01.png)


## Basic List Functions

* Sum all elements.
* Element-by-element product of two lists.
* Drop the last `n` elements.


## Basic 2D and 3D Linear Transformation Matrices

Transforms include:

* Rotation
* Translation
* Scaling


## 2D Polygonal Objects

2D objects composed of polygon unions and differences.

The polygons are represented as lists so that they can be combined,
transformed and used in other libraries, e.g., for skinning and lofting
between polygons.

The can be rendered as OpenSCAD polygons and linearly extruded.


# Installation

Clone this repository under your OpenSCAD installation's libraries directory.

E.g., on Ubuntu:

```bash
sudo su
cd /usr/share/openscad/libraries
git clone https://github.com/pavpen/pro.pavpen.openscad.git
```


# License

You can use this code either under GPL v.3, or Creative Commons 
Attribution-ShareAlike 4.0 International at your option.

If you need to use it under another license, open an issue.
