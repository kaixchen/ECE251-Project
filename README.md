# Kai Chen & Edward Chen ECE251-Project

## Instuction Set Architecture
The Instuction Set Architecture (ISA) for this 8-bit computer will consist of 8-bit constants, hence the name 8-bit CPU, and 16-bit instructions. This computer will be able to run three different types of intructions: R-Type (register), I-Type (immediate), and J-Type (jump). Starting from the left most significant bit, the first 4-bits of the instruction will be set as the operation code (opcode) and will define the operation being performed by the instruction. Within the opcodes, a distinction is made for the R-Type instructions by labeling the first bit of the opcode as 1. This distiction leaves 0 as the first bit for both the I and J-Type instructions. Therefore, to separate these two instructions, a second set of opcodes are defined for the J-Type instructions, allowing for its first set of opcodes to be all 0's. As a result, even if the first bit of the opcode is 0, unless the first 4-bits of the opcode are all 0's, the operation will be an I-Type instruction.

------------------------------------------------------------------------------------------------------------------

![ISA](https://user-images.githubusercontent.com/100326494/167231907-9534406f-9d62-4a8a-af28-0d73c3382195.jpg)

[ISA.xlsx](https://github.com/kaixchen/ECE251-Project/files/8644165/ISA.xlsx)

------------------------------------------------------------------------------------------------------------------

## Memory
This 8-bit computer will consist of two types of memories, the instruction memory and the data memory. The instruction memory (imem) is defined as read only memory (ROM) and has a size of (256-lines x 16-bit) and the data memory (dmem) is defined as synchronous single-port random access memory (RAM) and has a size of (256-lines x 8-bit). As a result, the imem will be word addressed (16-bits), and the dmem will be byte addressed (8-bits). At initialization, both the imem and dmem will have their contents zeroed-out. The memory structure of both memories will be visualized in a way such that larger addresses will be located at the top of the memory structure, and the zero-address at the very bottom. When writing instructions to the imem, we start by writing instructions at the zero-address, and work our way up.

## Controller

## ALU



![CPU Diagram](https://user-images.githubusercontent.com/100326494/167231818-e31fc44e-cb1d-4098-b2cf-cd4210ad092f.jpg)
![GTKwave](https://user-images.githubusercontent.com/100326494/167231974-8d3d9ad5-fa30-48c4-8d5c-f4775b8b93b5.png)
