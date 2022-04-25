module REG8 (
    input clkR,
    input [7:0] D,
    output reg [7:0] Q
);
    always @(posedge clkR) begin
        Q = D;
    end

endmodule