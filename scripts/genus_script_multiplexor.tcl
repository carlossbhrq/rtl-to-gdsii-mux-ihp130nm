# genus_script_multiplexor.tcl
set_db init_lib_search_path ../ihp-sg13g2/libs.ref/sg13g2_stdcell/lib/
set_db init_hdl_search_path ../rtl/

read_libs sg13g2_stdcell_slow_1p08V_125C.lib

read_hdl multiplexor.v
elaborate

read_sdc ../constraints/constraints_multiplexor.sdc

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic
syn_map
syn_opt

# Reports
report_timing > reports/report_timing_MUX.rpt
report_power  > reports/report_power_MUX.rpt
report_area   > reports/report_area_MUX.rpt

# Outputs
write_hdl > outputs/multiplexor_netlist.v
write_sdc > outputs/multiplexor_sdc.sdc
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge -setuphold split > outputs/delays_multiplexor.sdf
