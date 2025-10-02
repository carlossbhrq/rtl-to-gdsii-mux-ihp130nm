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

### 5.1 Importing the Design 
### 5.2 Floorplanning the Design 
### 5.3 Pin Assignment 
### 5.4 Power Planning (Rings + Stripes)
### 5.5 Power Rails (Sroute)
### 5.6 Placement Optimization 
### 5.7 Clock Tree Synthesis 
### 5.8 Routing the Nets 
### 5.9 Extraction and Timing Analysis 
### 5.10 Physical Verification 
### 5.11 Power Analysis
### 5.12 Filler Cell Placement 
### 5.13 Generating a Stream File (GDSII) 

