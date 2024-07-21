# ####################################################################

#  Created by Genus(TM) Synthesis Solution 20.11-s111_1 on Thu Jul 18 16:49:14 IST 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design up_counter

create_clock -name "clk" -period 15.0 -waveform {0.0 7.0} [get_ports clk_pad]
set_clock_transition -min 1.875 [get_clocks clk]
set_clock_transition -max 3.0 [get_clocks clk]
create_clock -name "vir_clk_i" -period 15.0 -waveform {0.0 7.5} 
set_load -pin_load 5.0 [get_ports {counter_pad[3]}]
set_load -pin_load 5.0 [get_ports {counter_pad[2]}]
set_load -pin_load 5.0 [get_ports {counter_pad[1]}]
set_load -pin_load 5.0 [get_ports {counter_pad[0]}]
group_path -weight 1.000000 -name I2O -from [list \
  [get_ports clk_pad]  \
  [get_ports reset_pad] ] -to [list \
  [get_ports {counter_pad[3]}]  \
  [get_ports {counter_pad[2]}]  \
  [get_ports {counter_pad[1]}]  \
  [get_ports {counter_pad[0]}] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks vir_clk_i] -add_delay -max 7.75 [get_ports reset_pad]
set_input_delay -clock [get_clocks vir_clk_i] -add_delay -min 2.25 [get_ports reset_pad]
set_output_delay -clock [get_clocks vir_clk_i] -add_delay -max 3.931 [get_ports {counter_pad[3]}]
set_output_delay -clock [get_clocks vir_clk_i] -add_delay -max 3.931 [get_ports {counter_pad[2]}]
set_output_delay -clock [get_clocks vir_clk_i] -add_delay -max 3.931 [get_ports {counter_pad[1]}]
set_output_delay -clock [get_clocks vir_clk_i] -add_delay -max 3.931 [get_ports {counter_pad[0]}]
set_output_delay -clock [get_clocks vir_clk_i] -add_delay -min 2.628 [get_ports {counter_pad[3]}]
set_output_delay -clock [get_clocks vir_clk_i] -add_delay -min 2.628 [get_ports {counter_pad[2]}]
set_output_delay -clock [get_clocks vir_clk_i] -add_delay -min 2.628 [get_ports {counter_pad[1]}]
set_output_delay -clock [get_clocks vir_clk_i] -add_delay -min 2.628 [get_ports {counter_pad[0]}]
set_input_transition -min 1.0 [get_ports reset_pad]
set_input_transition -max 2.5 [get_ports reset_pad]
set_wire_load_mode "enclosed"
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb2]
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb1]
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb4]
set_clock_latency -source -max -late 1.25 [get_clocks clk]
set_clock_latency -source -max -early 1.0 [get_clocks clk]
set_clock_latency -source -min -early 1.25 [get_clocks clk]
set_clock_latency -source -min -late 0.75 [get_clocks clk]
set_clock_uncertainty -setup 0.375 [get_clocks clk]
set_clock_uncertainty -hold 0.375 [get_clocks clk]
