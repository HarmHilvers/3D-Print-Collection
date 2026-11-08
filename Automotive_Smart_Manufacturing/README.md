# Automotive & Smart Manufacturing: 3D-printed building miniatures

A set of 12 small building miniatures for board games, representing vehicle assembly, batteries, industrial robotics, logistics and technical training. Each piece is a single solid model with recessed facade details and a flat back for printing. The buildings can stand on their bottom edges during play.

![Overview of the 12 building models](03_Images/model_overview.png)

The overview labels were edited with AI; use the STL files and dimensions below as the definitive model reference.

## Models

| No. | Building | Width × height × depth |
|---|---|---|
| 01 | Vehicle Assembly Plant | 20 × 36 × 15 mm |
| 02 | Battery Cell Factory | 19 × 38 × 15 mm |
| 03 | Battery Materials Refinery | 19 × 42 × 15 mm |
| 04 | Steel and Aluminum Foundry | 20 × 40 × 15 mm |
| 05 | Precision Components Factory | 19 × 30 × 15 mm |
| 06 | Industrial Robot Factory | 19 × 34 × 15 mm |
| 07 | Automotive Design Center | 20 × 32 × 15 mm |
| 08 | Vehicle Testing and Certification Center | 19 × 28 × 15 mm |
| 09 | Hydrogen and Fuel Cell Factory | 19 × 40 × 15 mm |
| 10 | Battery Recycling Plant | 19 × 34 × 15 mm |
| 11 | Industrial Logistics Center | 20 × 30 × 15 mm |
| 12 | Technical Training Center | 19 × 35 × 15 mm |

## Download and print

- [Individual STL files](01_Print_Models/STL/): download and slice the buildings you want.
- [Bambu Studio project](01_Print_Models/3MF/Bambu_A1_PLA_0.16mm.3mf): all 12 buildings on one plate, with a Bambu Lab A1 print setup.
- [Additional 3MF print profile](01_Print_Models/3MF/): the folder also contains a separate sector-specific 3MF file.

Units are millimetres. Place the flat back on the build plate with the detailed facade facing up. A suggested starting point is PLA, a 0.4 mm nozzle, 0.16 mm layers and three walls. The supplied Bambu A1 project uses 15% gyroid infill and no supports. Check and adjust the settings for your own printer, filament and build plate.

The slicer estimated **2 hours 43 minutes** and **61.7 g of PLA** for the full plate. Actual results will vary.

## Images

- [Model covers](03_Images/Covers/): landscape 4:3 and portrait 3:4.
- [Photos](03_Images/Photos/): photographs of printed models. Most have been edited with AI to remove background distractions or adjust the composition; fine details may differ from the original photographs.
- [Streetscape renders](03_Images/Renders/): AI-generated illustrative images, not photographs of printed models.

## Source and validation

[OpenSCAD sources and manifest](02_Source_Files/) contain the editable models and their dimensions. Paths in the manifest are relative to that folder. The [print checks](04_Print_Checks/) include geometry and slicing results and printer settings. The G-code formerly stored separately is included in the Bambu Studio project.

The recorded checks report closed geometry and successful slicing of all 12 models. Inspect the models and verify settings in your slicer before printing.

## License

This project is licensed under the European Union Public Licence, version 1.2 (EUPL-1.2). See [LICENSE](LICENSE) for the full text.
