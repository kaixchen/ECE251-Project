module ALU8 (
    input [3:0] op,     // opcode
    input [7:0] A,      // A input
    input [7:0] B,      // B input
    output reg [7:0] R,     // Result output
    output wire [2:0] flags  // Flags: negative/zero/overflow
);
    always@(*) begin
        case(op)
            // r-type math
            4'b1000 : R = A + B;                      // A ADD B
            4'b1001 : R = A + (~B + 8'b00000001);     // A SUB B -> A ADD (-B)
            4'b1010 : R = A * B;                      // A MUL B

            // r-type logic
            4'b1011 : R = A & B;      // A AND B
            4'b1100 : R = A | B;      // A OR B
            4'b1101 : R = A << B;     // A LLS B bits
            4'b1111 : R = A >> B;     // A LRS B bits


            // i-type math
            4'b0001 : R = A + B;                      // A ADDI ALU_imm
            4'b0010 : R = A + (~B + 8'b00000001);     // A SUBI AUL_imm

            //i-type logic
            4'b0011 : R = A & B;      // A ANDI B
            4'b0100 : R = A | B;      // A ORI B
            4'b0101 : R = A ^ B;      // A XORI B

            default : R = 8'bZZZZZZZZ;
        endcase
    end

    // Flags
    assign flags[2] = R[7];         // Negative
    assign flags[1] = (R == 8'b0);  // Zero
    assign flags[0] = (~A[7] && ~B[7] && flags[2]) || (A[7] && B[7] && ~flags[2]);  // Overflow

endmodule