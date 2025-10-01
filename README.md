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

## 4. Logic Synthesis 

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

