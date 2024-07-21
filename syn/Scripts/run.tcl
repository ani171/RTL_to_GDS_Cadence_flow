set DESIGN up_counter
set GEN_EFF medium
set MAP_OPT_EFF high
set clockname clk
set DATE [clock format [clock seconds] -format "%b%d-%T"] 
set _OUTPUTS_PATH output_files
set _REPORTS_PATH report_files

set _LOG_PATH /home/CHIPS/Desktop/pd_flow/syn

set_db / .init_lib_search_path { /home/installs/SCL180/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ss ./home/installs/SCL180/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ff}
set_db / .script_search_path {. ./Scripts} 
set_db / .init_hdl_search_path {. ./RTL_source}
set_db auto_ungroup none
set_db / .information_level 7 

set_db / .library { /home/installs/SCL180/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib /home/installs/SCL180/scl180/iopad/cio150/4M1L/liberty/tsl18cio150_max.lib /home/installs/SCL180/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ff/tsl18fs120_scl_ff.lib /home/installs/SCL180/scl180/iopad/cio150/4M1L/liberty/tsl18cio150_min.lib}

read_libs -max_libs { /home/installs/SCL180/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib /home/installs/SCL180/scl180/iopad/cio150/4M1L/liberty/tsl18cio150_max.lib} \
-min_libs { /home/installs/SCL180/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ff/tsl18fs120_scl_ff.lib /home/installs/SCL180/scl180/iopad/cio150/4M1L/liberty/tsl18cio150_min.lib}
 
puts "load RTL"
set FILE_LIST  {up_counter.v}
read_hdl $FILE_LIST

puts "elobrate design"
elaborate $DESIGN
puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration
check_design -unresolved

read_sdc ./Constraints/Counter_Constraints.sdc
path_adjust -from [all_inputs] -to [all_outputs] -delay -1300 -name PA_I2O 
report_timing -lint -verbose 

puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"
if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
    puts "Creating directory ${_OUTPUTS_PATH}"
    }

    if {![file exists ${_REPORTS_PATH}]} {
file mkdir ${_REPORTS_PATH}
 puts "Creating directory ${_REPORTS_PATH}"
 }

set_db lp_power_analysis_effort high

set_db / .syn_generic_effort $GEN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH
write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_generic.v
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_generic.sdc

set_db / .syn_map_effort $MAP_OPT_EFF
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -directory $_REPORTS_PATH
report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt
write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_map.v
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_map.sdc

write_do_lec -revised_design fv_map -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do

set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after 'syn_opt'"
time_info OPT

write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -directory $_REPORTS_PATH
write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_incremental.v 
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_incremental.sdc

write_sdf -version 2.1 -recrem split -setuphold merge_when_paired -edges check_edge > ${_OUTPUTS_PATH}/dsgn_synth.sdf

write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/${DESIGN}_incremental.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"

puts "Synthesis Finished ........."
puts "============================"

