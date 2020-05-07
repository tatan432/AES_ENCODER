#complete this file according to the requirements in Unit 3
read_file -format verilog {/class2/ug20/a213607m/ee4415_part1/prgrm_cnt.v}
set current_design PRGRM_CNT
#source /app11/saed_32.28/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_tt1p05v125c.db
list_lib
report_lib saed32rvt_tt1p05v125c
source constraint.tcl
report_clock -skew -attribute
report_port -verbose
compile
redirect -tee $current_design.rpt {report_constraint -all_violators}
report_timing
report_area
write -hierarchy -format ddc -output /class2/ug20/a213607m/ee4415_part1/$current_design.ddc
exit

