module MUX2t1 (
    input [7:0] A,
    input [7:0] B,
    input sel,
    output reg [7:0] R
);
    always@(*) begin
        case(sel)
            1'b0 : R = A;   // 0 -> aluIMM
            1'b1 : R = B;   // 1 -> Rs
        endcase
    end

endmodule