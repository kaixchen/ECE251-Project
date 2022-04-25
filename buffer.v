module BUF8 (
    input [7:0] in,
    input enable,
    output reg [7:0] out
);
    always@(*) begin
        case(enable)
            1'b0 : out = 8'bzzzzzzzz;
            1'b1 : out = in;
        endcase
    end
    
endmodule