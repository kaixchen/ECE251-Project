`include "alu.v"
`include "buffer.v"
`include "regfile.v"
`include "mux2t1.v"
`include "memory.v"

reg [15:0] instruc;
wire [3:0] opcode, op2;
wire [1:0] Rs1, Rs2, Re;
wire [7:0] const;
wire write, enbuf;

always #50 clk = ~clk;

assign opcode = instruc[15:12];
assign Rs2 = instruc[5:4];
assign Rs1 = instruc[3:2];
assign Re = instruc[1:0];
assign op2 = instruct[3:0];
assign const = instruct[11:4];
assign shamt = instruct[10:8];

ALU8 alu(.op(opcode), .A(regoutA), .B(aluB), .R(data), .flags(flag));
BUF8 buffer(.in(data), .enable(enbuf), .out(databuf));
REGFILE rwreg(.selDin(Re), .selAout(Rs1), .selBout(Rs2), .write(write), .data(databu), .regoutA(regoutA), .regoutB(regoutB));
MUX2t1 immMux(.A(const), .B(regoutB), .sel(opcode[3]), .R(aluB));
MEM16 instrucMem(.A(pc), .instruc(instruc));

always @(posedge clk ) begin
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
        #10
end
