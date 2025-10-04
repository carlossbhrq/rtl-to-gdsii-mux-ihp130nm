# RTL-to-GDSII Multiplexer (Cadence, IHP 130nm)

This repository documents the complete RTL-to-GDSII flow implementation for a multiplexer (MUX) circuit, utilizing the Cadence tool suite and the IHP PDK 130 nm technology.



## 1. Design Especification
- Multiplexor width is parameterized with the default value of 5;
- If **sel** is **1'b0**, input **in0** is passaed to the output **mux_out**;
- If **sel** is **1'b1**, input **in1** is passed to the output **mux_out**.

![image alt](https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/a29587ea9e168afc3ee6293585b79b7d9e7e3058/images/MUX.png)



## 2. RTL Coding 

At this stage, was written the RTL code in Verilog for describes the behavior of multiplexor. 

```verilog
module multiplexor #(
  parameter WIDTH = 5
)(
  input [WIDTH-1:0] in0,
  input [WIDTH-1:0] in1,
  input sel,
  output reg [WIDTH-1:0] mux_out
);

  always @*
  begin 
    if (sel == 0)
      mux_out = in0;
    else
      mux_out = in1;
    end 
endmodule
```



## 3. Functional Simulation 
In this step we will use Xcelium Simulator for design simulation and testbench.

### Procedures
```bash
# Go to Simulation directory
$ cd IHP-Open-PDK/simulation

# Using xrun in Batch Mode
$ xrun multiplexor.v multiplexor_test.v -access +rwc

# Using xrun in Graphical Mode with the -gui Option (SimVision)
$ xrun multiplexor.v multiplexor_test.v -access +rwc -gui
```

### Screenshots

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/26f5edfd141dd451acca71f2a6c68265d0e469a9/images/Functional_simulation_01.png" style="max-width: 90%; display: block;">
  <figcaption align="center" >
    <b>Figure:</b> Simulation results in batch mode.
  </figcaption>
</figure>

<p>&nbsp;</p>
<p>&nbsp;</p>

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/26f5edfd141dd451acca71f2a6c68265d0e469a9/images/Functional_simulation_02.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Simulation results in Graphical Mode, using SimVision.
  </figcaption>
</figure>



## 4. Logic Synthesis 
In this step, we will perform the synthesis (converting the RTL into a gate-level netlist) using the Genus Synthesis Solution tool. To do this, we will use the script file **genus_script_multiplexor.tcl**, automating the entire synthesis process.


### Procedures 
```bash
# Go to Synthesis Directory
$ cd IHP-Open-PDK/synthesis

# Run the complete flow using a script file
$ genus -f genus_script_multiplexor.tcl

# View the graphical interface
$ gui_show 

# Close the GUI
$ gui_hide

# To close Genus
$ exit 
```

### Outputs 
| File    | Description |
|---------|-------------|
| `multiplexor_netlist.v` | Verilog synthesized netlist |
| `multiplexor_sdc.sdc` | Exported constraints |
| `delays_multiplexor.sdf` | Time delays for simulation |
| `report_timing_MUX.rpt` | Detailed timing analysis |
| `report_area_MUX.rpt` | Area used report |
| `report_power_MUX.rpt` | Power consumption estimate |


### Screenshots 

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/be38158a0f53eddef7567da276f13f5a407cb238/images/Logic_synthesis_01.png" style="max-width: 90%; display: block;">
  <figcaption align="center" >
    <b>Figure:</b> Genus terminal after synthesis.
  </figcaption>
</figure>

<p>&nbsp;</p>
<p>&nbsp;</p>

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/be38158a0f53eddef7567da276f13f5a407cb238/images/Logic_synthesis_02.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Schematic.
  </figcaption>
</figure>



## 5. Digital Implementation 
In this step, we will use the Innovus Implementation System to implement the floorplanning, placement, routing and others for this design. 



### 5.1 Importing the Design 

#### Procedures 
```bash
# Go to physical_design Directory
$ cd IHP-Open-PDK/physical_design

# Start the Innovus
$ innovus -stylus

# Importing the Design
$ set_db init_netlist_files ../physical_design/multiplexor_netlist.v
$ set_db init_lef_files {../ihp-sg13g2/libs.ref/sg13g2_stdcell/lef/sg13g2_tech.lef ../ihp-sg13g2/libs.ref/sg13g2_stdcell/lef/sg13g2_stdcell.lef}
$ set_db init_power_nets VDD
$ set_db init_ground_nets VSS
$ set_db init_mmmc_files  multiplexor.view
$ read_mmmc multiplexor.view
$ read_physical -lef {../ihp-sg13g2/libs.ref/sg13g2_stdcell/lef/sg13g2_tech.lef ../ihp-sg13g2/libs.ref/sg13g2_stdcell/lef/sg13g2_stdcell.lef}
$ read_netlist ../physical_design/multiplexor_netlist.v -top multiplexor
$ init_design

# Connect Global Nets (VDD and VSS)
$ connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name *
$ connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name *
``` 

#### Screenshots 

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Importing_the_Design.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Design Import Results.
  </figcaption>
</figure>



### 5.2 Floorplanning the Design 

#### Procedures 
```bash
# Create Floorplan
$ create_floorplan -core_margins_by die -site CoreSite -core_density_size 1 0.4 3.5 3.5 3.5 3.5
```

#### Screenshots 

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Floorplanning_the_Design.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> The Floorplan.
  </figcaption>
</figure>


### 5.3 Pin Assignment 

#### Procedures 
```bash
# Pin Assigment 
$ read_io_file mux_pins.io
```

#### Screenshots 

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Pin_Assignment.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Pin Placement.
  </figcaption>
</figure>



### 5.4 Power Planning (Rings + Stripes)

#### Procedures 
```bash
# Power Planning
$ set_db add_rings_skip_shared_inner_ring none ; set_db add_rings_avoid_short 1 ; set_db add_rings_ignore_rows 0 ; set_db add_rings_extend_over_row 0

# Add Rings
$ add_rings -type core_rings -jog_distance 0.6 -threshold 0.6 -nets {VDD VSS} -follow core -layer {bottom Metal5 top Metal5 right Metal4 left Metal4} -width 0.7 -spacing .4 -offset 0.6

# Add Stripes
$ add_stripes -block_ring_top_layer_limit Metal5 -max_same_layer_jog_length 0.44 -pad_core_ring_bottom_layer_limit Metal4 -set_to_set_distance 5 -pad_core_ring_top_layer_limit Metal5 -spacing 0.4 -merge_stripes_value 0.6 -layer Metal4 -block_ring_bottom_layer_limit Metal4 -width 0.3 -nets {VDD VSS} 
```

#### Screenshots 

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Power_Planning_01.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Power Rings.
  </figcaption>
</figure>

<p>&nbsp;</p>
<p>&nbsp;</p>

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Power_Planning_02.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Power Stripes.
  </figcaption>
</figure>



### 5.5 Power Rails (Sroute)

#### Procedures

```bash
# Create Power Rails with Special Route
$ route_special -connect core_pin -layer_change_range { Metal1(1) Metal5(5) } -block_pin_target nearest_target -core_pin_target first_after_row_end -allow_jogging 1 -crossover_via_layer_range { Metal1(1) Metal5(5) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { Metal1(1) Metal5(5) }
```

#### Screenshots 

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Power_Rails.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Power routes have been connected to the power planned targets with relevant vias.
  </figcaption>
</figure>



### 5.6 Placement Optimization 

#### Procedures

```bash
# Run placement optimization 
$ place_opt_design

# Save the Database
$ write_db placeOpt 
```

#### Screenshots 

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Placement_Optimization_01.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Timing Summary.
  </figcaption>
</figure>

<p>&nbsp;</p>
<p>&nbsp;</p>

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Placement_Optimization_02.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Standard cell placements.
  </figcaption>
</figure>



### 5.7 Clock Tree Synthesis 

Clock Tree Synthesis (CTS) is the process of distributing the clock signal to all sequential elements (flip-flops, registers, latches) on the chip, ensuring temporal synchronization and skew balancing.

Since this design implements a purely combinational multiplexer, it relies on the absence of sequential elements in the synthesized netlist. Therefore, it was decided to skip the CTS step and proceed directly to routing. 


For sequential circuits (with flip-flops, registers or clock elements), the following steps must be followed:

#### Procedures
```bash
# Create a Clock Tree Spec and run CTS
# Option 1: Modern flow (preferred)
$ ccopt_design

# Option 2: Legacy flow (if modern fails)  
$ create_clock_tree_spec
$ create_clock_tree
$ clock_opt_design

# Save the database
$ write_db postCTSopt
```



### 5.8 Routing the Nets 

#### Procedures 
```bash
# Run Detail Routing
$ set_db route_design_with_timing_driven 1
$ set_db route_design_with_si_driven 1
$ set_db design_top_routing_layer Metal5
$ set_db design_bottom_routing_layer Metal1
$ set_db route_design_detail_end_iteration 0
$ set_db route_design_with_timing_driven true
$ set_db route_design_with_si_driven true
$ route_design -global_detail
```

#### Screenshots 
<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Routing_the_Nets_01.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Route Global Detail Statistics.
  </figcaption>
</figure>

<p>&nbsp;</p>
<p>&nbsp;</p>

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Routing_the_Nets_02.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Post routing layout.
  </figcaption>
</figure>



### 5.9 Extraction and Timing Analysis 

#### Procedures
```bash
# Run RC Extraction
$ extract_rc

# Export SPEF
$ write_parasitics -spef_file multiplexor.spef

# Configure OCV
$ set_db timing_analysis_type ocv

# Keep MMMC configuration for corners
$ set_db timing_analysis_cppr both

# Perform Setup and Hold Analysis
$ time_design -post_route
$ time_design -post_route -hold
```

#### Screenshots 
<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Extraction_and_Timing_Analysis.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Setup and Hold views.
  </figcaption>
</figure>



### 5.10 Physical Verification 

#### Procedures 
```bash
# Verifying Geometry and Connectivity
$ check_drc
$ check_connectivity
```

#### Screenshots 
<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Physical_Verification%20_01.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Results for DRC  verification.
  </figcaption>
</figure>

<p>&nbsp;</p>
<p>&nbsp;</p>

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Physical_Verification%20_02.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Results for Connectivity verification.
  </figcaption>
</figure>



### 5.11 Power Analysis

#### Procedures
```bash
# Running Power Analysis
$ report_power
```

#### Screenshots
<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Power_Analysis_01.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Power Analysis Results.
  </figcaption>
</figure>

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Power_Analysis_02.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Rail Analysis Results.
  </figcaption>
</figure>



### 5.12 Filler Cell Placement 

#### Procedures
```bash
# To add fillers cell
$ add_fillers -base_cells {sg13g2_fill_8 sg13g2_fill_4 sg13g2_fill_2 sg13g2_fill_1 sg13g2_decap_8 sg13g2_decap_4} -prefix FILLER
```

#### Screenshots

<figure style="margin: 0 auto; display: table;">
  <img src="https://github.com/carlossbhrq/rtl-to-gdsii-mux-ihp130nm/blob/6ef4b65cb8889c737dd33f1861fbf3377bd26999/images/Filler_Cell_Placement.png" style="max-width: 90%; display: block;">
  <figcaption align="center">
    <b>Figure:</b> Post Placement of Filler Cells.
  </figcaption>
</figure>



### 5.13 Generating a Stream File (GDSII)

#### Procedures 
```bash
# Generating GDS file
$ write_stream multiplexor.gds -lib_name DesignLib -format stream
# Close the Innovus
$ exit 
```


