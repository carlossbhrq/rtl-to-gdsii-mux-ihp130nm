# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.17-s066_1 on Thu Oct 02 15:03:22 -03 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design multiplexor

set_load -pin_load 0.08 [get_ports {mux_out[4]}]
set_load -pin_load 0.08 [get_ports {mux_out[3]}]
set_load -pin_load 0.08 [get_ports {mux_out[2]}]
set_load -pin_load 0.08 [get_ports {mux_out[1]}]
set_load -pin_load 0.08 [get_ports {mux_out[0]}]
set_max_delay 10 -from [list \
  [get_ports {in0[4]}]  \
  [get_ports {in0[3]}]  \
  [get_ports {in0[2]}]  \
  [get_ports {in0[1]}]  \
  [get_ports {in0[0]}]  \
  [get_ports {in1[4]}]  \
  [get_ports {in1[3]}]  \
  [get_ports {in1[2]}]  \
  [get_ports {in1[1]}]  \
  [get_ports {in1[0]}]  \
  [get_ports sel] ] -to [list \
  [get_ports {mux_out[4]}]  \
  [get_ports {mux_out[3]}]  \
  [get_ports {mux_out[2]}]  \
  [get_ports {mux_out[1]}]  \
  [get_ports {mux_out[0]}] ]
set_clock_gating_check -setup 0.0 
set_max_fanout 25.000 [current_design]
set_max_transition 2.0 [current_design]
set_max_capacitance 0.2 [current_design]
set_wire_load_mode "top"
