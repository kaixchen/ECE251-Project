# Kai Xian Chen & Edward Chen ECE251-Project

## Instuction Set Architecture
The Instuction Set Architecture (ISA) for this 8-bit computer will consist of 8-bit constants, hence the name 8-bit CPU, and 16-bit instructions. This computer will be able to run three different types of intructions: R-Type (register), I-Type (immediate), and J-Type (jump). Starting from the left most significant bit, the first 4-bits of the instruction will be set as the operation code (opcode) and will define the operation being performed by the instruction. Within the opcodes, a distinction is made for the R-Type instructions by labeling the first bit of the opcode as 1. This distiction leaves 0 as the first bit for both the I and J-Type instructions. Therefore, to separate these two instructions, a second set of opcodes are defined for the J-Type instructions, allowing for its first set of opcodes to be all 0's. As a result, even if the first bit of the opcode is 0, unless the first 4-bits of the opcode are all 0's, the operation will be an I-Type instruction.

------------------------------------------------------------------------------------------------------------------
<p align="center">
  <img src="https://user-images.githubusercontent.com/100326494/167231907-9534406f-9d62-4a8a-af28-0d73c3382195.jpg">
</p>

------------------------------------------------------------------------------------------------------------------

## Memory
This 8-bit computer will consist of two types of memories, the instruction memory and the data memory. The instruction memory (imem) is defined as read only memory (ROM) and has a size of (256-lines x 16-bit) and the data memory (dmem) is defined as synchronous single-port random access memory (RAM) and has a size of (256-lines x 8-bit). As a result, the imem will be word addressed (16-bits), and the dmem will be byte addressed (8-bits). At initialization, both the imem and dmem will have their contents zeroed-out. The memory structure of both memories will be visualized in a way such that larger addresses will be located at the top of the memory structure, and the zero-address at the very bottom. When writing instructions to the imem, we start by writing instructions at the zero-address, and work our way up.

## Controller
The Controller consists of one of the most important functions in a computer; namely, it is the module in the computer that controls the timing sequences of other modules, and their access to the correct data to be operated on. When the Program Counter (PC) is updated, a new 16-bit instruction is loaded in and then decoded. For any type of instruction, R-type, I-type, and J-type, they each utilize different modules and require data to be routed to the correct places, and need the correct switches to be enabled or disabled. In the case of R-type and I-type instructions, for example, the controller effectively controls the register file output multiplexers to choose the correct operands to output. For the pure ALU operations such as math or logic opcodes, the Controller also turn on or off the register file input buffer and the regfileWrite signal when needed to store results into the registers. In the case of memory reference commands, the Controller has access to the memWrite, and memMuxSel in addition to the register file signals to facilitate proper timing when using memory reference operations. In the case of J-type instructions, the Controller has access to the enjump signal, which allows the PC to be changed to a custom memory address for conditional/unconditional branching.

## ALU 
The Arithmetic Logic Unit (ALU) is a combinational digital circuit in our computer that performs arithmetic/logic operations based on the instructions ran by the computer. After the ALU receives the contents from the registers through the controller, the ALU decoder will be able to recognize different operations to perform through the opcodes from the instructions.

## Architecture Diagram
![CPU - CPU](https://user-images.githubusercontent.com/100326494/168493699-6ffb9ec1-86c1-43c4-9e1e-199ebb7211b7.jpg)
### R-Type
![R-Type](https://user-images.githubusercontent.com/100326494/168494389-e0894666-74fb-4cdb-8c1b-708c4a8f6d12.gif)
### I-Type Immediate
![I-Type](https://user-images.githubusercontent.com/100326494/168496319-234483b1-e98a-4507-8bf9-5b7d6f8c6589.gif)
### I-Type Register To Memory
![I-TypeRTM](https://user-images.githubusercontent.com/100326494/168496331-d8a3ea75-2356-433e-9923-d2b0bb73c146.gif)
### I-Type Memory To Register
![I-TypeMTR](https://user-images.githubusercontent.com/100326494/168496338-913f53be-d877-49a4-9544-3e7a7bc558ad.gif)
### J-Type
![J-Type](https://user-images.githubusercontent.com/100326494/168496397-bbb41a00-84d3-4b95-8b96-01a98e22320c.gif)

## Timing Diagram (GTKWave)
Instructions ran for timing diagram
```
Assembly            Machine Code
NULL                0000000000001111  (address 0)
ADDI	x0,x0,#2    0001000000100000
ADDI	x1,x1,#5    0001000001010101
SUBI	x3,x3,#8    0010000010001111
ADD	x2,x0,x1    1000111111010010
MTR	x3,x3,#0    0111000000000011
SUB	x2,x2,x3    1001111111111010
BGT	#12         0000000011000111
...                 0000000000000000  (addresses 8-11)
RTM	x2,x2,#10   0110000010101010  (address 12)
```
------------------------------------------------------------------------------------------------------------------
<p align="center">
   <img src="https://user-images.githubusercontent.com/100326494/168485067-aa46588b-30b2-4aca-bd34-b3abf57695cf.png">
</p>

------------------------------------------------------------------------------------------------------------------

For the 1st clock cycle there is a null operation which allows the computer to start. This is represented through the "00" shown for the pc variable, showing that the computer is currently on the 0th address of the instruction memory. 

------------------------------------------------------------------------------------------------------------------
<p align="center">
   <img src="https://user-images.githubusercontent.com/100326494/168485079-4a789ef7-f81f-4559-be8f-8d906f6907de.png">
</p>

------------------------------------------------------------------------------------------------------------------

Then, two **I-type** ADDI instructions are ran during the 2nd and 3rd clock cycles. This can be seen from the opcode variable where a single waveform spans for two clock cycles. From the variable regoutA, it can be seen that the immediate values 2 and 5 are added to registers X0 and X1. Follwoing that, An additional I-Type SUBI instruction is then ran during the 4th clock cycle, subtracting 8 from an empty register, X3.

------------------------------------------------------------------------------------------------------------------
<p align="center">
   <img src="https://user-images.githubusercontent.com/100326494/168485092-92014ef3-c9e1-4cb7-9b96-7a60428e3313.png">
</p>

------------------------------------------------------------------------------------------------------------------

Next, a **R-Type** ADD instruction is ran during the 5th clock cycle. This can be seen from the data variable, where the result of the add operation between X0 (2) and X1 (5) is written to X2 (7).

------------------------------------------------------------------------------------------------------------------
<p align="center">
   <img src="https://user-images.githubusercontent.com/100326494/168485101-e24bcd41-89f5-4005-9d64-91e3f628b3cd.png">
</p>

------------------------------------------------------------------------------------------------------------------

Following that, an I-type memory to register (MTR) instruction is ran during the 6th clock cycle in order to write over the -8 in register X3 with a 0 from memory. Then, on the 7th clock cycle, a R-Type SUB instruction is ran to set up the conditional branching that checks if the sum of 12 is greater than the 0 that was just loaded from memory. 

------------------------------------------------------------------------------------------------------------------
<p align="center">
   <img src="https://user-images.githubusercontent.com/100326494/168485115-8f9a46d5-2e11-480e-bb43-58e89c8a805e.png">
   <img src="https://user-images.githubusercontent.com/100326494/168485141-e3bef29e-cbd8-4776-b973-85b1fa5597fa.png">
</p>

------------------------------------------------------------------------------------------------------------------

After that, on the 8th clock cycle, the **J-Type** branch if great than (BGT) instruction jumps the program counter to the 12th memory address and this can be seen from the waveform that forms for the enjump varible.

------------------------------------------------------------------------------------------------------------------
<p align="center">
   <img src="https://user-images.githubusercontent.com/100326494/168485156-87572195-999a-4cbb-91d3-7e603e42b3c1.png">
</p>

------------------------------------------------------------------------------------------------------------------

Lastly, on the 9th clock cycle the last I-Type register to memor (RTM) instruction stores X2 (12) into memory, and you can tell the conditional branch worked because the program counter (pc) variable goes from "07", the 7th address, to "0C", the 12th address.

------------------------------------------------------------------------------------------------------------------
<p align="center">
   <img src="https://user-images.githubusercontent.com/100326494/168485166-51de3cab-314f-44d3-9c8d-9a05440b4743.png">
</p>

------------------------------------------------------------------------------------------------------------------

