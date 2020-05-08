# AES_ENCODER

## Introduction:
The part of work is related to 128-bit AES encryption algorithm RTL design.  There are three parts to the design-
1. SISO : Single Input and Single output
2. MIMO : Multiple input Multiple output
3. N_CHANNEL : N Channel serial input and N channel serial output. Sometimes it is termed as N-Slowing.

RTL is written in verilog, where as the testbench is written in system verilog.


## Running The Simulation: 
The simulation environment where it is tested is DC compiler. 
In every part (SISO/MIMO/N-CHANNEL), there is a VCS folder. Type command: 'make all' to run the simulation.
The Simulation takes the data from the ref folder. Ref folder keeps the golden data for each round as well. 

## Synthesis Procedure: 
Few points to be noted. The constraint in the syntheis is in the unit of ns for time and fF for capacitance (as governed by our library). 
To run synthesis:
1. Got to syn folder.
2. dc_shell-xg-t -f synthesis.tcl | tee -i syn.log 

To View the Design:
1. Go to syn folder.
2. Invoke Design Design Vision. (Command: design_vision-xg-t)
3. Load AES_top.ddc

## Acknowledgement: 
The part of the test bench is written by Saurabh Jain(User: @srbhjn459)

## Resources
Best way to learn about these concepts is : 
1. VLSI digital signal processing systems: design and implementation by Keshab K Parhi
2. [AES Encryption Algorithm](https://www.youtube.com/watch?v=gP4PqVGudtg) 

