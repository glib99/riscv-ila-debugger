open_project BOARD_NAME_HERE_rocketchip_CHISEL_CONFIG_HERE/BOARD_NAME_HERE_rocketchip_CHISEL_CONFIG_HERE.xpr

reset_run synth_1

reset_run impl_1

launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name synth_1

set_property mark_debug true [get_nets {NET0_NAME_HERE[*]}]
#NET1?set_property mark_debug true [get_nets {NET1_NAME_HERE[*]}]
#NET2?set_property mark_debug true [get_nets {NET2_NAME_HERE[*]}]
#NET3?set_property mark_debug true [get_nets {NET3_NAME_HERE[*]}]

create_debug_core u_ila_0 ila
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]

startgroup 
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0 ]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0 ]
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0 ]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0 ]
endgroup

set ila_nets [get_nets -hier -filter {MARK_DEBUG==1}]
set num_ila_nets [llength [get_nets [list $ila_nets]]]

set_property port_width 1 [get_debug_ports u_ila_0/clk]
set_property port_width $num_ila_nets [get_debug_ports u_ila_0/probe0]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]

connect_debug_port u_ila_0/clk [get_nets [list host_clk ]]
connect_debug_port u_ila_0/probe0 [lsort -dictionary [get_nets [list $ila_nets ]]]

save_constraints

launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

exit

