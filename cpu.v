`include "alu8.v"
`include "buffer8.v"
`include "decoder.v"
`include "mem16.v"
`include "mux2t1.v"
`include "mux4t1.v"
`include "ram.v"
`include "reg2.v"
`include "reg8.v"
`include "regfile.v"

`timescale 1ns/1ns

module CPU();
    wire [15:0] instruc;
    reg clk;
    wire [3:0] opcode, op2;
    wire [1:0] Rs1, Rs2, Re;
    wire [7:0] const;
    reg [7:0] pc, nextpc;
    reg write, enbuf, enjump;

    wire [1:0] flagsALU, flagsStored;
    wire [7:0] regoutA, regoutB, aluB, data, databuf;

    wire [7:0] Q0, Q1, Q2, Q3;

    assign opcode = instruc[15:12];
    assign Rs2 = instruc[5:4];
    assign Rs1 = instruc[3:2];
    assign Re = instruc[1:0];
    assign op2 = instruc[3:0];
    assign const = instruc[11:4];

    ALU8 alu(.op(opcode), .A(regoutA), .B(aluB), .R(data), .flags(flagsALU));
    BUF8 buffer(.in(data), .enable(enbuf), .out(databuf));
    REGFILE rwreg(.selDin(Re), .selAout(Rs1), .selBout(Rs2), .flagsIn(flagsALU), .write(write), .data(databuf), .regoutA(regoutA), .regoutB(regoutB), .flagsOut(flagsStored));
    MUX2t1 immMux(.A(const), .B(regoutB), .sel(opcode[3]), .R(aluB));
    MEM16 instrucMem(.A(pc), .instruc(instruc));

    always @(*) begin
        #1;
        if (instruc == 16'b0000000000000000)
    		$finish;

    	case(opcode)            // r-type
    	    4'b1000 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b1001 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b1010 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b1011 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b1100 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b1101 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b1110 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b1111 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
                                // c-type
    	    4'b0001 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b0010 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b0011 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b0100 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
            4'b0101 : begin
                enbuf = 1;
                #1
                write = 1;
                #1
                write = 0;
    		    enbuf = 0;
            end
                                // memory reference
            4'b0110 : begin     

            end
            4'b0111 : begin

            end
                                // branching
            4'b0000 : begin     
                case(op2)
                    4'b1000 : begin
                        enjump = 1;
                    end
                    4'b0100 : begin
                        if(flagsStored[0] == 1) enjump = 1;
                    end
                    4'b0101 : begin
                        if(flagsStored[0] == 0) enjump = 1;
                    end
                    4'b0110 : begin
                        if(flagsStored[1] == 1) enjump = 1;
                    end
                    4'b0111 : begin
                        if(flagsStored[1] == 0) enjump = 1;
                    end
                endcase
            end

            default : begin
                enbuf <= 0;
                write <= 0;
            end
        endcase

    end

    always @(negedge clk) begin
        if(enjump == 0) pc = pc + 1;
        if(enjump == 1) begin 
            pc = const;
            enjump = 0;
        end
    
        #20;
    end

    always begin
        #10 clk <= ~clk;
    end

    initial begin
        clk <= 0;
        pc <= -1;
        enbuf <= 0;
        write <= 0;
        enjump <= 0;

        #10;
        $dumpfile("out.vcd");
        $dumpvars(0, clk, instruc, pc, opcode, write, enbuf, enjump, regoutA, aluB, data, flagsStored);
    end

endmodule