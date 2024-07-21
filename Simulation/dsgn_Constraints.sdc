###############  SDC CONSTRAINTS   ############


##### PARAMETERS #####
set_units -time 1.0ns;
set_units -capacitance  1.0pF;

set CLOCK_PERIOD 5; ######## check this clock_period
set CLOCK_NAME   clk;

set SKEW_setup  [expr $CLOCK_PERIOD*0.025];
set SKEW_hold   [expr $CLOCK_PERIOD*0.025];
set MINRISE     [expr $CLOCK_PERIOD*0.125];
set MAXRISE     [expr $CLOCK_PERIOD*0.2];
set MINFALL     [expr $CLOCK_PERIOD*0.125];
set MAXFALL     [expr $CLOCK_PERIOD*0.2];

set MIN_PORT 1;
set MAX_PORT 2.5;


####### CLOCK CONSTRAINTS #########

create_clock -name "$CLOCK_NAME"			\
	     -period "$CLOCK_PERIOD" 		\
	     -waveform "0 [expr $CLOCK_PERIOD/2]"  \
	      [get_ports "clk_pad"]

## Virtual Clock Constraints 

create_clock   -name   vir_clk_i   -period   15

## clock source latency
set_clock_latency   -source   -max   1.25   -late    [get_clocks  clk]
set_clock_latency   -source   -min   0.75   -late    [get_clocks  clk]
set_clock_latency   -source   -max   1.0    -early   [get_clocks  clk]
set_clock_latency   -source   -min   1.25   -early   [get_clocks  clk]

# clock transition
set_clock_transition   -rise   -min   $MINRISE   [get_clocks  clk]
set_clock_transition   -rise   -max   $MAXRISE   [get_clocks  clk]
set_clock_transition   -fall   -min   $MINRISE   [get_clocks  clk]
set_clock_transition   -fall   -max   $MAXRISE   [get_clocks  clk]

set_input_transition	-max	$MAX_PORT 	[get_ports	x_pad]
set_input_transition	-max	$MAX_PORT 	[get_ports	y_pad]

set_input_transition	-min	$MIN_PORT 	[get_ports	x_pad]
set_input_transition	-min	$MIN_PORT 	[get_ports	y_pad]

# clock uncertainty
set_clock_uncertainty -setup $SKEW_setup  [get_clocks  clk]
set_clock_uncertainty -hold  $SKEW_hold   [get_clocks  clk]

# input port delay

set_input_delay  -add_delay -clock vir_clk_i -max 7.75 [get_ports x_pad] 
set_input_delay  -add_delay -clock vir_clk_i -min 2.25 [get_ports x_pad] 

set_input_delay  -add_delay -clock vir_clk_i -max 7.75 [get_ports y_pad] 
set_input_delay  -add_delay -clock vir_clk_i -min 2.25 [get_ports y_pad] 

#Output port delay
set_output_delay -clock vir_clk_i -max 3.931 [get_ports s_pad] -add_delay
set_output_delay -clock vir_clk_i -max 3.931 [get_ports c_pad] -add_delay

set_output_delay -clock vir_clk_i -min 2.628 [get_ports s_pad] -add_delay
set_output_delay -clock vir_clk_i -min 2.628 [get_ports c_pad] -add_delay

#######   LOAD SPECIFIACATIONS   ########

set_load	5	[get_ports	s_pad]
set_load	5	[get_ports	c_pad]

########## FALSE PATHS ###########



##########  GROUP PATHS  #########

group_path -name   I2R   -from   [all_inputs]      -to   [all_registers]
group_path -name   R2O   -from   [all_registers]   -to   [all_outputs]
group_path -name   R2R   -from   [all_registers]   -to   [all_registers]
group_path -name   I2O   -from   [all_inputs]      -to   [all_outputs]
