# IMEM Basics and Compilation

This ```.md``` file wll cover an introduction on how to properly load instructions into the imem, and how to compile and view the resulting waveforms through the use of ```iverilog```, ```vvp```, and ```GTKwave```.

## IMEM Structure and Conventions
The memory structure of imem contains the dimensions of ```256 x 16-bits``` where there will be 256 unique memory locations (ranging from 0-255, or remapped to 1-256 on text editors) and each memory location can store 16-bits of data. Because each instruction in this ISA is 16-bits wide, each instruction will take up exactly one line on the memory ladder and each memory location will point to exactly one instruction to run. The machine code of the instructions to be ran will be placed inside ```instruc.txt```. ***Please note that this document will refer to the 0-255 indexing style for the imem contents unless stated otherwise.*** 

Given that the memory structure for imem is ```256 x 16-bits```, ```instruc.txt``` will be formatted in a similar way such that it will be ```256-lines x 16-bits``` in dimension. ***Please note that the dimensions required for the ```instruc.txt``` file is strict; there must be exactly 256 lines and 16-bits per line in order for ```iverilog``` to compile properly.***

The program counter (PC) is setup in a way such that in normal operation (excluding J-type branching instructions), the PC will start on memory address 0, the CPU will execute the instruction located there, and then the PC will increment by 1, and then the CPU will execute the instruction located at memory address 1. This means that when hand compiling the assembly into machine code, we would place our machine code at the very top of the ```instruc.txt``` (index 1 of the text file) and then work its way down to the very bottom (index 256 of the text file).

In order to ensure proper operation of the CPU, there are some guidelines to filling ```instruc.txt``` that should be noted. ***Please note that the hex equivalent of the commands below are used in order to save space. When writing machine code, each line must be written in binary.***
- The first instruction to be ran must be a NULL operation ```0x000F```, in order to properly setup the CPU.
- In order to have a finite CPU operation time, the PC must eventually end on a memory location that contains the HALT operation ```0x0000```, otherwise the simulation will have to be manually stopped when running ```vvp```.
- All unused memory locations in imem must contain either a NULL ```0x000F``` or a HALT ```0x0000``` operation to preserve the strict dimensions of the ```instruc.txt``` file.

## Compilation
Once the machine code has been properly transfered over to ```instruc.txt```, next begins the compilation using ```iverilog``` to run a simulation via ```vvp``` and then display the waveforms on ```GTKwave```. This section assumes that the ```iverilog``` and ```gtkwave``` packages have been already installed prior to running the commands below. ***When trying to compile using ```iverilog```, please make sure that all necessary files are included in the same directory as the ```cpu.v``` file.***

In order to run a simulation of the current imem instructions, the block of code below will guide the user to compile, simulate and then plot the resulting waveforms in a bash shell. A ```compile.sh``` bash script containing the below commands will be also provided if applicable. 
```
iverilog cpu.v -o cpu.vvp   // creates cpu.vvp simulation file
vvp cpu.vvp                 // runs cpu.vvp and then outputs results into out.vcd
gtkwave out.vcd             // use GTKwave to obtain waveforms created during simulation
```
