#create a clock with given constrained clock period
create_clock -period 0.5 [get_ports clk]
#create input delay on all inputs except clock
set_input_delay -max 0.1 -clock clk [all_inputs]
remove_input_delay [get_ports clk]
#create output delay on all outputs
set_output_delay -max 0.1 -clock clk [all_outputs]
#set given load capacitance on all output pins
#Library Unit 1fF
set_load 5 [all_outputs]  
#set_fanout_load 4 [all_outputs]
