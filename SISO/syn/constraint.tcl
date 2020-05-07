#create a clock with given constrained clock period
#Libray Time Unit 1ns
create_clock -period 2 [get_ports clk]
#create input delay on all inputs except clock
set_input_delay -max 0.2 -clock clk [all_inputs]
remove_input_delay [get_ports clk]
#create output delay on all outputs
set_output_delay -max 0.2 -clock clk [all_outputs]
#set given load capacitance on all output pins
#Library Unit 1fF
set_load 15 [all_outputs]  

