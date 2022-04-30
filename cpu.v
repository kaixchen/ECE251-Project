module CPU (
    input [15:0] instruc
)

wire [3:0] opcode;
wire [1:0] Rs1, Rs2, Re, op2;

assign opcode = instruc[15:12];
assign Rs2 = [5:4];
assign Rs1 = [3:2];
assign Re = [1:0];

ALU8 alu(.op(opcode), .A(regoutA), .B(regoutB), .R(data), .flags(flag));
REGFILE rwreg(.selDin(Re), .selAout(Rs1), .selBout(Rs2), .write(write), .data(data), .regoutA(regoutA), .regoutB(regoutB));

always @(posedge clk ) begin
    case(opcode)
    
end
    
endmodule