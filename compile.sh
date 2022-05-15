#!/bin/bash

iverilog cpu.v -o cpu.vvp   # creates cpu.vvp simulation file
vvp cpu.vvp                 # runs cpu.vvp and then outputs results into out.vcd
gtkwave out.vcd             # use GTKwave to obtain waveforms created during simulation