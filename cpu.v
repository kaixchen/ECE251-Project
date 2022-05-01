`include "alu.v"
`include "buffer.v"
`include "clk.v"
`include "decoder.v"
`include "mem.v"
`include "memory.v"
`include "mux2t1.v"
`include "mux4t1.v"
`include "regfile.v"
`include "register.v"

//`timescale 1ns/1ps

module CPU();
    wire [15:0] instruc;
    reg clk;
    wire [3:0] opcode, op2;
    wire [1:0] Rs1, Rs2, Re;
    wire [7:0] const;
    reg [7:0] pc;
    reg write, enbuf;

    wire [2:0] flags;
    wire [7:0] regoutA, regoutB, aluB, data, databuf;

    wire [7:0] Q0, Q1, Q2, Q3;

    assign opcode = instruc[15:12];
    assign Rs2 = instruc[5:4];
    assign Rs1 = instruc[3:2];
    assign Re = instruc[1:0];
    assign op2 = instruc[3:0];
    assign const = instruc[11:4];
    assign shamt = instruc[10:8];

    ALU8 alu(.op(opcode), .A(regoutA), .B(aluB), .R(data), .flags(flags));
    BUF8 buffer(.in(data), .enable(enbuf), .out(databuf));
    REGFILE rwreg(.selDin(Re), .selAout(Rs1), .selBout(Rs2), .write(write), .data(databuf), .regoutA(regoutA), .regoutB(regoutB));
    MUX2t1 immMux(.A(const), .B(regoutB), .sel(opcode[3]), .R(aluB));
    MEM16 instrucMem(.A(pc), .instruc(instruc));

    always @(posedge clk) begin
    	case(opcode[3]) 
    	    1'b1 : begin
                enbuf = 1;
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
    	    1'b0 : begin
    		    if ((opcode == 4'b0000) && (op2 == 4'b0000))
    			    $finish;
    		    else if( (opcode != 4'b0000) || (opcode[2:1] != 2'b11) ) begin
                    enbuf = 1;
                    write = 1;
                    #1
                    write = 0;
                    enbuf = 0;
                end
    	    end
        endcase
    end

    always @(negedge clk) begin
        pc = pc + 1;
        #10;
    end

    always #50 clk = ~clk;

    initial begin
        clk <= 0;
        pc <= -1;

        #100
        $dumpfile("out1.vcd");
        $dumpvars(0, clk, Q0, Q1, Q2, Q3);
    end

endmodule