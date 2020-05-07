#enter the files to be analyzed
read_file -format sverilog {../src/aes_sbox.v ../src/subBytes_top.v ../src/shiftRows_top.v ../src/matrix_mult.v ../src/MixCol_top.v ../src/AddRndKey_top.v ../src/KeySchedule_top.v ../src/AESCore.v ../src/AEScntx.v ../src/AES_top.v}
#elaborate top
set current_design AES_top
#source constraint file
source constraint.tcl
#Report Port
report_port -verbose
#compile the top module
compile
#report critical path
report_timing
#retime the design
optimize_registers
#report critical path after retiming
report_timing
#report area
report_area

redirect -tee $current_design.rpt {report_constraint -all_violators}
write -hierarchy -format ddc -output /class2/ug20/a213607m/ee4415_part2/part3/syn/$current_design.ddc


exit







