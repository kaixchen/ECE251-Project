module REG8 (
    input [7:0] D,
    output reg [7:0] Q,
    input clkR
);
    always @(posedge clkR) begin
        Q = D;
    end

endmodule